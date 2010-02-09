From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 9 Feb 2010 20:18:06 +0100
Subject: [PATCH 05/14] ARM: LPC32XX: System suspend support
In-Reply-To: <20100209170318.GB11113@pengutronix.de>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
	<1265674295-23996-6-git-send-email-wellsk40@gmail.com>
	<20100209170318.GB11113@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F805C8C7550D@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +++ b/arch/arm/mach-lpc32xx/pm.c
> > @@ -0,0 +1,155 @@
> > +/*
> > + * arch/arm/mach-lpc32xx/pm.c
> > + *
> > + * Author: Kevin Wells <kevin.wells@nxp.com>
> > + * Based in part on PNX4008 power management code
> ... which has 2005 (c) MontaVista Software, Inc. and only allows GPLv2.
> 
> IMHO you should mention the copyright of the work this is based on and I
> think you cannot allow GPLv2+ then (but INAL).

Thanks for bringing this up! Both pm.c and suspend.S are based on the
PNX4008 code with modifications. I've attempted to keep original
copyrights and references where needed, but this one slipped by. I'm
glad I at least had the source comment in there. For these files and the
few other files copied directly over from the pnx4008 platform (ie,
i2c.h), is this going to be a problem? We had intended to release our
files under GPL, but now have a few GPLv2 files mixed in. For the
changed files, can we safely add our copyright tag to the file along
with Montavistas?

> +#define EMC_CTRL_REG io_p2v(LPC32XX_EMC_BASE + EMC_DYN_MEM_CTRL_OFS) 
> +static int __init lpc32xx_pm_init(void) {
> +	/*
> +	 * Setup SDRAM self-refresh clock to automatically
> +	 * disable on start of self-refresh
> +	 */
> +	__raw_writel(__raw_readl(EMC_CTRL_REG) | EMC_SRMMC, EMC_CTRL_REG);
Hmmm, is it correct to do this here?  Or should that go to the enter function?  The thing is that this is a register setting that depends on CONFIG_PM and not on having put the machine in a sleeping state.

This is actually safe to do for configurations with or without PM
support, but is an absolute requirement for suspend to work. I would
prefer the bootloader handle this and always set this, but different
boards loaders do not always set this up the same (including ours,
which turns it off). Its ok to turn this on with CONFIG_PM support.
