From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 Mar 2011 19:00:26 +0100
Subject: [PATCH] ARM: imx: move selection between i.MX21 and i.MX27 to
	CPU family choice
In-Reply-To: <20110303162513.GS22310@pengutronix.de>
References: <20110302112559.GC22310@pengutronix.de>
	<1299086585-22707-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110303121153.GJ29521@pengutronix.de>
	<20110303162513.GS22310@pengutronix.de>
Message-ID: <20110303180026.GC18351@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 05:25:13PM +0100, Uwe Kleine-K?nig wrote:
> Hello Sascha,
> 
> On Thu, Mar 03, 2011 at 01:11:53PM +0100, Sascha Hauer wrote:
> >  config SOC_IMX27
> >  	bool
> > +	select ARCH_MX2
> > +	select MACH_MX27
> I'd let MACH_MX27 select ARCH_MX2, but that's just a minor detail.
> 
> >  	select CPU_ARM926T
> >  	select ARCH_MXC_AUDMUX_V1
> >  	select IMX_HAVE_DMA_V1
> >  	select IMX_HAVE_IOMUX_V1
> >  	select MXC_AVIC
> >  
> > -if ARCH_MX1
> > +config IMX_MULTI_ARCHITECTURE
> > +	bool "i.MX multi architecture support"
> > +	depends on ARM_PATCH_PHYS_VIRT
> > +	depends on AUTO_ZRELADDR
> depends on EXPERIMENTAL?

ARM_PATCH_PHYS_VIRT depends on EXPERIMENTAL already. I think once
ARM_PATCH_PHYS_VIRT is considered stable, we can consider i.MX
multiarchitecture support stable aswell.

> 
> > +
> > +if IMX_MULTI_ARCHITECTURE
> > +config ARCH_IMX_MULTI_MX1
> > +	select SOC_IMX1
> > +	bool "i.MX1 support"
> > +
> > +config ARCH_IMX_MULTI_MX21
> > +	select SOC_IMX21
> > +	bool "i.MX21 support"
> > +
> > +config ARCH_IMX_MULTI_MX25
> > +	select SOC_IMX25
> > +	bool "i.MX25 support"
> > +
> > +config ARCH_IMX_MULTI_MX27
> > +	select SOC_IMX27
> > +	bool "i.MX27 support"
> I'm not sure it's a good idea to use SOC_IMX21 et al for both, Kconfig
> logic to select machines and to signal there are machines selected with
> the correspondig soc.
> 
> On reason is that selecting ARCH_IMX_MULTI_MX21 and ARCH_IMX_MULTI_MX27
> but no i.MX21 based machine currently makes cpu_is_mx27() more (runtime)
> complicated than necessary.

Then there's no reason to select IMX_MULTI_ARCHITECTURE in the first
place. What are the other reasons?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
