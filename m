From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 8 Aug 2012 21:27:07 +0200
Subject: [PATCH 1/2] ARM: build ssi-fiq.S in ARM mode to prevent
 CONFIG_THUMB2_KERNEL build breakage
In-Reply-To: <CAKGA1bmUuSZuWDM4QPTxmNR0+=uQ1RbFhw4u-sb9KaSPYwQiVw@mail.gmail.com>
References: <1344379514-30076-1-git-send-email-matt@genesi-usa.com>
 <1344379514-30076-2-git-send-email-matt@genesi-usa.com>
 <20120808065502.GI1451@pengutronix.de>
 <CAKGA1bmUuSZuWDM4QPTxmNR0+=uQ1RbFhw4u-sb9KaSPYwQiVw@mail.gmail.com>
Message-ID: <20120808192707.GL1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 12:32:39PM -0500, Matt Sealey wrote:
> On Wed, Aug 8, 2012 at 1:55 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >>               .text
> >> +             .arm
> >>               .global imx_ssi_fiq_start
> >>               .global imx_ssi_fiq_end
> >>               .global imx_ssi_fiq_base
> >
> > I think it would be better to add a depends on !THUMB2_KERNEL to
> > SND_IMX_SOC_PCM_FIQ. The above may result in broken code in a thumb2
> > kernel, so I'd rather keep the compile error instead.
> 
> I'm curious as to how/why would it result in broken code? It's not
> possible that the processors relying on
> the imx_ssi_fiq_* stuff cannot run ARM code (unless Freescale shipped
> a weird version) so it should
> magically enter and exit. I wonder if it needs some thumb-interworking
> stuff wrapped around it though.
> You'd know better than me..

Currently I don't know if the code compiled in arm mode on an otherwise
thumb2 kernel does work and I do not have a thumb2 capacle hardware with
sound support to test this.

> 
> I'm a little worried that making it !CONFIG_THUMB2_KERNEL would
> basically make more than
> one of the boards in imx_v6_v7_defconfig suddenly lose audio support
> for no other reason..

Obviously no v6_v7 board does use this code as it is, because it does
not compile. So there's no risk of breaking something if we just disable
FIQ support in thumb2 mode.

Better disable an unused feature than add some untested code.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
