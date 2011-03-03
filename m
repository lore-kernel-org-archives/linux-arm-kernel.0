From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 3 Mar 2011 21:10:09 +0100
Subject: [PATCH] ARM: imx: move selection between i.MX21 and i.MX27 to
	CPU family choice
In-Reply-To: <20110303180026.GC18351@pengutronix.de>
References: <20110302112559.GC22310@pengutronix.de>
	<1299086585-22707-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110303121153.GJ29521@pengutronix.de>
	<20110303162513.GS22310@pengutronix.de>
	<20110303180026.GC18351@pengutronix.de>
Message-ID: <20110303201009.GT22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[I dropped freescale at lists.linaro.org from Cc: because that's a
members-only list.]

Hello Sascha,

On Thu, Mar 03, 2011 at 07:00:26PM +0100, Sascha Hauer wrote:
> On Thu, Mar 03, 2011 at 05:25:13PM +0100, Uwe Kleine-K?nig wrote:
> > On Thu, Mar 03, 2011 at 01:11:53PM +0100, Sascha Hauer wrote:
> > > +config IMX_MULTI_ARCHITECTURE
> > > +	bool "i.MX multi architecture support"
> > > +	depends on ARM_PATCH_PHYS_VIRT
> > > +	depends on AUTO_ZRELADDR
> > depends on EXPERIMENTAL?
> 
> ARM_PATCH_PHYS_VIRT depends on EXPERIMENTAL already. I think once
> ARM_PATCH_PHYS_VIRT is considered stable, we can consider i.MX
> multiarchitecture support stable aswell.
right.

> > > +
> > > +if IMX_MULTI_ARCHITECTURE
> > > +config ARCH_IMX_MULTI_MX1
> > > +	select SOC_IMX1
> > > +	bool "i.MX1 support"
> > > +
> > > +config ARCH_IMX_MULTI_MX21
> > > +	select SOC_IMX21
> > > +	bool "i.MX21 support"
> > > +
> > > +config ARCH_IMX_MULTI_MX25
> > > +	select SOC_IMX25
> > > +	bool "i.MX25 support"
> > > +
> > > +config ARCH_IMX_MULTI_MX27
> > > +	select SOC_IMX27
> > > +	bool "i.MX27 support"
> > I'm not sure it's a good idea to use SOC_IMX21 et al for both, Kconfig
> > logic to select machines and to signal there are machines selected with
> > the correspondig soc.
> > 
> > On reason is that selecting ARCH_IMX_MULTI_MX21 and ARCH_IMX_MULTI_MX27
> > but no i.MX21 based machine currently makes cpu_is_mx27() more (runtime)
> > complicated than necessary.
> 
> Then there's no reason to select IMX_MULTI_ARCHITECTURE in the first
> place. What are the other reasons?
Right, it's not sensible to do this selection, but the fact that it is
possible makes me feel it's ugly. I thought a bit more about that I and
another reason for not using SOC_IMXxy for Kconfig is that it might be
natural to group i.MX50 and i.MX53 together because they share the same
PHYS_OFFSET. So there are three possibilities:

 1) group them using a symbol named SOC_IMX50_IMX53
 2) select both SOC_IMX50 and SOC_IMX53 independant of the machines
    enabled.
 3) don't allow to build both SoCs into a single image without
    IMX_MULTI_ARCHITECTURE

2) is similar to my first suggestion---it might make things more
complicated than necessary at runtime. 3) is a limitation that shouldn't
be needed. So 1) is the best? Then I prefer to have a completly
different naming scheme for the grouping.

Does this make sense?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
