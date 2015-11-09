From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Nov 2015 11:43:00 +0000
Subject: [RFC PATCH v3 1/4] drm: Introduce generic probe function for
 component based masters.
In-Reply-To: <564069CD.2070102@rock-chips.com>
References: <1445267270-23126-1-git-send-email-Liviu.Dudau@arm.com>
 <1445267270-23126-2-git-send-email-Liviu.Dudau@arm.com>
 <564069CD.2070102@rock-chips.com>
Message-ID: <20151109114259.GX8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 05:39:25PM +0800, Mark yao wrote:
> Hi Liviu
>       Rockchip drm can't work with drm_of_component_probe function now,
> 
>       At drm_of_component_probe:
>             component_match_add(dev, &match, compare_of, port);
>       And original rockchip drm use:
>             component_match_add(dev, &match, compare_of, port->parent);
> 
>      That different "port" and "port->parent" cause crtc device node always
> mis-match.
> 
>      I'm confused that rockchip use same dts node map as imx drm driver, but
> it works
> for imx drm, not work on rockchip drm.

iMX is rather confusing because the whole device is rather complex.  It's
a complete image processor unit, which has multiple functions within a
single device.  It's a less than perfect example of how to deal with
these issues (each time I look at it, I find more stuff it shouldn't be
doing... like what I've found today.)

Basically, the device is declared in DT as:

                ipu1: ipu at 02400000 {
                        compatible = "fsl,imx6q-ipu";
                        ipu1_csi0: port at 0 {
...
                        };
                        ipu1_csi1: port at 1 {
...
                        };
                        ipu1_di0: port at 2 {
...
                        };
                        ipu1_di1: port at 3 {
...
                        };
                };

ipu1 is the platform device, which is the _entire_ IPU device, containing
multiple sub-devices - eg, two camera interfaces (csi) and two "CRTCs"
(di).

The ipuv3 code creates platform devices for these, calling the CSI
devices "imx-ipuv3-camera" and the DI devices "imx-ipuv3-crtc".
Initially, these have no of_node attached (yuck!) but later have an
of_node attached when the device is probed (yuck yuck yuck!) by
ipu_drm_probe() - the of_node being the ipu1_di0 or ipu1_di1 node.

The display-subsystem property references these ipu1_di0/ipu1_di1 nodes:

        display-subsystem {
                compatible = "fsl,imx-display-subsystem";
                ports = <&ipu1_di0>, <&ipu1_di1>, <&ipu2_di0>, <&ipu2_di1>;
        };

and so finds the "imx-ipuv3-crtc" platform devices rather than the
parent ipu1 device.

It's not nice - I'd like to see this:

        if (!dev->of_node) {
                /* Associate crtc device with the corresponding DI port node */
                dev->of_node = ipu_drm_get_port_by_id(dev->parent->of_node,
                                                      pdata->di + 2);
                if (!dev->of_node) {
                        dev_err(dev, "missing port@%d node in %s\n",
                                pdata->di + 2, dev->parent->of_node->full_name);                        return -ENODEV;
                }
        }

moved out of drivers/gpu/drm/imx/ipuv3-crtc.c and into
drivers/gpu/ipu-v3/ipu-common.c where the platform devices are created
so that we're only setting device of_node pointers at device creation
time and not randomly during the probe sequence, even though the above
is "safe" as far as the component helper's concerned.  There's no reason
why it can't be done at the device creation time.

Now, as to how to handle the differences here, I think a solution would
be to pass in two compare_of function pointers: one for CRTCs and one
for the encoders, since the two will need to be handled separately
depending on the implementation.  Where you have one "parent" device of
the CRTC node containing exactly one CRTC, then the "rockchip" method
makes sense - though comparing the parent of the port node in
CRTC compare_of would be where I'd put it.  If you have multiple
CRTCs within one parent device, then something more complex like the
iMX solution would be required.

In any case, passing port->parent is a data loss in the generic case:
you lose the information in the compare_of function about exactly which
port is required, so that must go into the CRTC compare_of.

So...

rockchip's CRTC compare_of() should be:

static int crtc_compare_of(struct device *dev, void *data)
{
        struct device_node *np = data;

        return dev->of_node == np->parent;
}

and it should have an encoder_compare_of() which is its existing
compare_of() renamed as such.

Then, we need drm_of_component_probe() to take _two_ comparison
functions, one for the CRTCs and one for the encoders.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
