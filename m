From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Nov 2013 12:45:19 +0000
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <CAF6AEGuEho9Ms7ifTE-EmBoQ-=_AXgvGcJxi5qEC0vsZ+H9C+A@mail.gmail.com>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020231134.GR25034@n2100.arm.linux.org.uk>
 <20131021083242.GB30088@pengutronix.de>
 <20131021084854.GV25034@n2100.arm.linux.org.uk>
 <20131021092730.GF30088@pengutronix.de>
 <CAF6AEGtt_2sStiZCNBp9btxevWghSwLZZBdN6ir8eUpX1FXrCQ@mail.gmail.com>
 <20131024072811.GS30088@pengutronix.de>
 <CAF6AEGuEho9Ms7ifTE-EmBoQ-=_AXgvGcJxi5qEC0vsZ+H9C+A@mail.gmail.com>
Message-ID: <20131118124518.GA16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 05:21:54PM -0400, Rob Clark wrote:
> ahh, ok.  Yeah, we do need some way to make this easier, as it is a
> too-common pattern.  I do think we do need a way to know if something
> is missing because it isn't there vs it hasn't been probed yet.  Ie.
> late_initcall() is not the awesome solution.

On this topic, I now have a solution to this which is not DRM specific,
nor is it DT specific.

It's a core piece of code which gathers up the struct device pointers,
and a callback for the master device to assemble the components and
indicate when the master is complete.

Here's an example:

        imx-drm {
                compatible = "fsl,drm";
                /* Both CRTCs (can't specify which here) */
                crtcs = <&ipu1>, <&ipu1>;
                connectors = <&hdmi>;
        };

&hdmi {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_carrier1_hdmi>;
        ddc = <&i2c2>;
        status = "okay";
        crtcs = <&ipu1 0>;
};

The HDMI driver's probe and remove functions look like this:

static int imx_hdmi_platform_probe(struct platform_device *pdev)
{
        return component_add(&pdev->dev, &hdmi_ops);
}

static int imx_hdmi_platform_remove(struct platform_device *pdev)
{
        component_del(&pdev->dev, &hdmi_ops);
        return 0;
}

These register the device into the component layer, with a set of
operations for binding and unbinding the device.

The master device (imx-drm) does this:

static const struct component_master_ops imx_drm_ops = {
        .add_components = imx_drm_add_components,
        .bind = imx_drm_bind,
        .unbind = imx_drm_unbind,
};

static int imx_drm_platform_probe(struct platform_device *pdev)
{
        return component_master_add(&pdev->dev, &imx_drm_ops);
}

static int imx_drm_platform_remove(struct platform_device *pdev)
{
        component_master_del(&pdev->dev, &imx_drm_ops);
        return 0;
}

so registering the master device.  imx_drm_add_components() gets called
whenever something gets added, and this function is responsible for
assembling the registered components and indicating when the master is
complete:

static int imx_drm_add_components(struct device *master, struct master *m)
{
        struct device_node *np = master->of_node;
        unsigned i;
        int ret;

        for (i = 0; ; i++) {
                struct device_node *node;

                node = of_parse_phandle(np, "crtcs", i);
                if (!node)
                        break;

                ret = component_master_add_child(m, compare_parent_of, node);
                of_node_put(node);

                if (ret)
                        return ret;
        }

        for (i = 0; ; i++) {
                struct device_node *node;

                node = of_parse_phandle(np, "connectors", i);
                if (!node)
                        break;

                ret = component_master_add_child(m, compare_of, node);
                of_node_put(node);

                if (ret)
                        return ret;
        }
        return 0;
}

When it is complete (iow, this function returns zero), the master is
bound:

static int imx_drm_bind(struct device *dev)
{
        return drm_platform_init(&imx_drm_driver, to_platform_device(dev));
}

This causes DRM to start the construction of a drm_device, and call the
load callback.  In the load callback:

        /* Now try and bind all our sub-components */
        ret = component_bind_all(drm->dev, drm);
        if (ret)
                goto err;

which binds the previously assembled components, with the drm_device
structure as their data - that's drm above:

static int imx_hdmi_bind(struct device *dev, struct device *master, void *data)
{
        struct platform_device *pdev = to_platform_device(dev);
        const struct of_device_id *of_id =
                                of_match_device(imx_hdmi_dt_ids, dev);
        struct drm_device *drm = data;
...
}

This allows the HDMI driver to register with DRM using the passed
struct drm_device pointer.  Other connectors do the same at this moment,
CRTCs also use this same mechanism, but with a higher priority, so CRTCs
get registered before connectors.

Teardown is similar to the above, but it happens in reverse order: when
any bound component or the master goes away, the master DRM device is
unbound, which triggers DRM to call the unload callback.

The unload callback unbinds the components, which triggers an unbind
call to each component in reverse order.

As I say, nothing in the above is specific to DRM; this can be re-used
by any subsystem.  It can also be re-used by non-DT setups as well via
appropriate .add_components callback and appropriate component matching
functions.

This addresses the componentised device problem in a completely generic
way.
