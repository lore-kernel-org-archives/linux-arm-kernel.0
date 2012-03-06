From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 6 Mar 2012 21:34:18 +0800
Subject: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <20120306120247.GF19635@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
 <20120305144601.GQ3224@opensource.wolfsonmicro.com>
 <20120306073900.GP16232@S2101-09.ap.freescale.net>
 <20120306120247.GF19635@opensource.wolfsonmicro.com>
Message-ID: <20120306133416.GQ16232@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 12:02:47PM +0000, Mark Brown wrote:
> On Tue, Mar 06, 2012 at 03:39:02PM +0800, Shawn Guo wrote:
> > On Mon, Mar 05, 2012 at 02:46:01PM +0000, Mark Brown wrote:
> 
> > > This you can just set in the card struct, no need for explicit code at
> > > all.
> 
> > Yes, I just tried.  It also works but a little bit differently.  We
> > only set_fmt for codec_dai here, while ASoC core will set_fmt for both
> > codec_dai and cpu_dai if dai_link->dai_fmt is set.  However, the
> > fsl_ssi does not provide .set_fmt implementation, and consequently we
> > will see error message below, which does not impact functionality
> > though.
> 
> >   fsl-ssi-dai 83fcc000.ssi: Failed to set DAI format: -22
> 
> > I hope we keep the code as it is now and improve later when fsl_ssi
> > gets improved.
> 
> No, we should fix the core to work better in this case - not having a
> DAI operation is perfectly normal and should be supported.
> 
So something like this?

@@ -1536,12 +1536,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
                                         "Failed to set DAI format: %d\n",
                                         ret);

-                       ret = snd_soc_dai_set_fmt(card->rtd[i].cpu_dai,
-                                                 dai_link->dai_fmt);
-                       if (ret != 0)
-                               dev_warn(card->rtd[i].cpu_dai->dev,
-                                        "Failed to set DAI format: %d\n",
-                                        ret);
+                       snd_soc_dai_set_fmt(card->rtd[i].cpu_dai,
+                                           dai_link->dai_fmt);
                }
        }

> > > > +	ret = of_property_read_u32(np, "fsl,mux-int-port", &int_port);
> > > > +	ret = of_property_read_u32(np, "fsl,mux-ext-port", &ext_port);
> 
> > > It seems very odd to have namespacing on the individual property names.
> > > Why are you doing that?  The properties are already defined in terms of
> > > the device binding.  Though everyone else is doing it so not really a
> > > problem.
> 
> > The general device tree binding practice is we'd better have a vendor
> > prefix on the property name, if the property applies on specific vendor
> > drivers instead of common ones across different vendors.
> 
> There's nothing generic about this device, it only applies to a specific
> combination of things and in so far as it applies to those the
> properties are generic - any board combining i.MX and this CODEC is
> going to have an audmux.
> 
Since you agreed it's not really a problem, I would like to do what
everyone else is doing.

> > > > +	/*
> > > > +	 * The port numbering in the hardware manual starts at 1, while
> > > > +	 * the audmux API expects it starts at 0.
> > > > +	 */
> > > > +	int_port--;
> > > > +	ext_port--;
> 
> > > Should have error checking somewhere to make sure that the user
> > > remembered this.
> 
> > Because different i.MX SoC may have different internal and external
> > port number, I do not think of a way to check that.  And I would not
> 
> In that case the audmux code should be validating the arguments.
> 
What we can check is only where the number starts and probably where
it ends.  That requires audmux driver have the ranges of internal port
and external port for each i.MX SoC encoded.  For DT case, we may have
the ranges defined in device tree, while for non-DT case, we then need
to introduce platform_data to pass that piece of data.  In the end,
this check does not guarantee the correctness, and developers have to
give the correct port number.  So is it really worth it?

> > worry about it that much, since all the hardware documents number the
> > port from 1, while device tree user/author will have to look at those
> > documents for the data.
> 
> OTOH the in kernel API uses a different numbering and if the user is
> porting their existing code over to device tree...
> 
Whoever is porting the code will need to look at the audmux binding
document, where we have a big note regarding this.

> > > > +	imx_audmux_v2_configure_port(int_port,
> > > > +			IMX_AUDMUX_V2_PTCR_SYN |
> > > > +			IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
> > > > +			IMX_AUDMUX_V2_PTCR_TCSEL(ext_port) |
> > > > +			IMX_AUDMUX_V2_PTCR_TFSDIR |
> > > > +			IMX_AUDMUX_V2_PTCR_TCLKDIR,
> > > > +			IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port));
> 
> > > I'm not sure we've really gained much from converting to a platform
> > > driver given that the device just registers something globally...
> 
> > Converting audmux to a platform driver does not change anything about
> > that.  It makes device tree support easier, and gets the audmux users
> > (imx machine drivers) stay away from including <mach/audmux.h>.
> 
> It's not actually fixed anything in the APIs though

I'm not fixing the APIs.  Instead, I'm adding device tree support for
audmux driver, while converting it to platform driver make that easy.

> and we've now also got a race in the driver probes 
> since the audmux now need to come up via
> the device model instead of just being there

The race is solved by having audmux device registered in a
subsys_initcall.

> - we could try to configure
> the audmux with no platform driver bound.

Before this series, the audmux is configured with no platform driver
bound.  I'm confused here.  Are you saying we are moving to a wrong
direction?

> We should really have the
> audmux as at least an aux_dev in the card to make sure it's there.

I do not understand how aux_dev can help here.  Being a device encoded
in device tree, audmux device should have been created by DT core, and
all we need to do is registering the audmux driver to get it bound to
audmux device.

-- 
Regards,
Shawn
