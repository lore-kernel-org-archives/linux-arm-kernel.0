From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 06 Mar 2014 14:32:03 +0100
Subject: [PATCH v5 06/11] imx-drm: imx-tve: Fix DDC I2C bus property
In-Reply-To: <20140306130320.GA21483@n2100.arm.linux.org.uk>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
 <1394011262-16849-7-git-send-email-p.zabel@pengutronix.de>
 <20140306130320.GA21483@n2100.arm.linux.org.uk>
Message-ID: <1394112723.3622.7.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Am Donnerstag, den 06.03.2014, 13:03 +0000 schrieb Russell King - ARM
Linux:
> On Wed, Mar 05, 2014 at 10:20:57AM +0100, Philipp Zabel wrote:
> > This patch fixes the TV Encoder DDC I2C bus property to use the common
> > 'ddc-i2c-bus' property name instead of 'ddc'.
> 
> Looking at both hdmi and tve, the ddc part is very similar.  The difference
> is how the probe is handled:
> 
> imx-hdmi:
>         ddc_node = of_parse_phandle(np, "ddc", 0);
>         if (ddc_node) {
>                 hdmi->ddc = of_find_i2c_adapter_by_node(ddc_node);
>                 if (!hdmi->ddc)
>                         dev_dbg(hdmi->dev, "failed to read ddc node\n");
> 
>                 of_node_put(ddc_node);
>         } else {
>                 dev_dbg(hdmi->dev, "no ddc property found\n");
>         }
> 
> imx-tve:
>         ddc_node = of_parse_phandle(np, "ddc", 0);
>         if (ddc_node) {
>                 tve->ddc = of_find_i2c_adapter_by_node(ddc_node);
>                 of_node_put(ddc_node);
>         }

panel-simple.c
        ddc = of_parse_phandle(dev->of_node, "ddc-i2c-bus", 0);
        if (ddc) {
                panel->ddc = of_find_i2c_adapter_by_node(ddc);
                of_node_put(ddc);

                if (!panel->ddc) {
                        err = -EPROBE_DEFER;
                        goto free_backlight;
                }
        }

>It appears to differ only by debug prints - is there any reason we
> couldn't unify the DDC backend part?  I've tinkered with this idea,
> and already have a patch, though it needs a little rework.
> 
> Any thoughts?

there should be a generic helper for obtaining the DDC I2C adapter from
the device tree. I'd prefer not to stall the imx-drm-dt series on this,
though.

regards
Philipp
