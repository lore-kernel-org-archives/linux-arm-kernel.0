From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 6 Mar 2012 13:35:07 +0000
Subject: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <20120306133416.GQ16232@S2101-09.ap.freescale.net>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
 <20120305144601.GQ3224@opensource.wolfsonmicro.com>
 <20120306073900.GP16232@S2101-09.ap.freescale.net>
 <20120306120247.GF19635@opensource.wolfsonmicro.com>
 <20120306133416.GQ16232@S2101-09.ap.freescale.net>
Message-ID: <20120306133506.GU19635@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 09:34:18PM +0800, Shawn Guo wrote:
> On Tue, Mar 06, 2012 at 12:02:47PM +0000, Mark Brown wrote:

> > No, we should fix the core to work better in this case - not having a
> > DAI operation is perfectly normal and should be supported.

> So something like this?

> @@ -1536,12 +1536,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)

> -                       if (ret != 0)
> -                               dev_warn(card->rtd[i].cpu_dai->dev,
> -                                        "Failed to set DAI format: %d\n",
> -                                        ret);

It should still complain but it should check to see if there was an
actual set_fmt op and only complain then, probably we should change all
the noop error codes for the accessor functions to be -ENOTSUPP or
something and then change the check here to look for ret != 0 && ret !=
ENOTSUPP.

> > There's nothing generic about this device, it only applies to a specific
> > combination of things and in so far as it applies to those the
> > properties are generic - any board combining i.MX and this CODEC is
> > going to have an audmux.

> Since you agreed it's not really a problem, I would like to do what
> everyone else is doing.

Well, "everyone else" in this context is only Tegra right now so there's
a case for nipping this in the bud too :)

> > In that case the audmux code should be validating the arguments.

> What we can check is only where the number starts and probably where
> it ends.  That requires audmux driver have the ranges of internal port
> and external port for each i.MX SoC encoded.  For DT case, we may have
> the ranges defined in device tree, while for non-DT case, we then need
> to introduce platform_data to pass that piece of data.  In the end,
> this check does not guarantee the correctness, and developers have to
> give the correct port number.  So is it really worth it?

It does seem concerning and error prone that there's two different
numbering schemes for the audmux APIs.

> > OTOH the in kernel API uses a different numbering and if the user is
> > porting their existing code over to device tree...

> Whoever is porting the code will need to look at the audmux binding
> document, where we have a big note regarding this.

If there's one universal truth about system integrators it's that they
always read the documentation and don't ever just copy things from an
example and tweak it till it works.  :)

> > It's not actually fixed anything in the APIs though

> I'm not fixing the APIs.  Instead, I'm adding device tree support for
> audmux driver, while converting it to platform driver make that easy.

I know, that's kind of the problem.  You've moved the device
registration to the device model but not done anything on the top level
to ensure that we actually managed to do so.

> > and we've now also got a race in the driver probes 
> > since the audmux now need to come up via
> > the device model instead of just being there

> The race is solved by having audmux device registered in a
> subsys_initcall.

And hoping that it does actually get registered and successfully
loads and that it doesn't get built as a module which could get set up
in a different order, plus the edge cases where users actively unbind
the driver from the device.

> > - we could try to configure
> > the audmux with no platform driver bound.

> Before this series, the audmux is configured with no platform driver
> bound.  I'm confused here.  Are you saying we are moving to a wrong
> direction?

Previously just building the code was enough, it'd unconditionally
initialise itself in early init and we were fine.  Now there's a bunch
of different ways in which someone could break things since we're using
the device model so we need to make sure we work with those.

> > We should really have the
> > audmux as at least an aux_dev in the card to make sure it's there.

> I do not understand how aux_dev can help here.  Being a device encoded
> in device tree, audmux device should have been created by DT core, and
> all we need to do is registering the audmux driver to get it bound to
> audmux device.

None of that stuff does anything to ensure that the audmux is present
before the card comes up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120306/f135ee2b/attachment.sig>
