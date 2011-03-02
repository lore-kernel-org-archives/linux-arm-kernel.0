From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 2 Mar 2011 17:33:26 +0100
Subject: [RFC PATCH 1/1] ARM: imx5x: clean up ARCH_MX5X
In-Reply-To: <20110302160605.GA2994@richard-laptop>
References: <1299036526-15674-1-git-send-email-richard.zhao@freescale.com>
	<20110302112559.GC22310@pengutronix.de>
	<20110302160605.GA2994@richard-laptop>
Message-ID: <20110302163326.GG22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 12:06:05AM +0800, Richard Zhao wrote:
> Hi Uwe,
> 
> Thanks for your detailed explanation!
> On Wed, Mar 02, 2011 at 12:25:59PM +0100, Uwe Kleine-K?nig wrote:
> > Hello Richard,
> > 
> > On Wed, Mar 02, 2011 at 11:28:46AM +0800, Richard Zhao wrote:
> > > Remove legacy support of ARCH_MX5X. Move to SOC_SOC_IMX5X.
> > > 
> > > My understanding is ARCH_MX5 selects Kconfig in arch/arm/mach-mx5,
> > > and every board can be selected/unselected, and SOC_XXX be selected
> > > by the board config. MACH_XXXX/SOC_XXXX then select those HAVE_XXXX.
> > My intended goal with these ARCH_MX.., MACH_MX.. and SOC_IMX.. symbols is:
> > 
> >  - ARCH_MX.. should be only a helper to group all machines together that
> >    can be built in a single image. In the far future it hopefully dies
> >    because we can compile everything together. These IMHO should not be
> >    used in Makefiles or source files at all as the grouping can change
> >    over time. I'm not sure the name ARCH_MX.. is that good. Didn't think
> >    about a better naming scheme, so if you have suggestions don't
> >    hesitate to tell them.
> Would it make sense to go straight forward? 
> ARCH_MX.. for SoC series. eg. ARCH_MX1/2/3/5. It groups SoCs.
This doesn't work. Where do you want to put i.MX25? Conceptually the
easy groups are { i.MX21, i.MX27 } and { i.MX25, i.MX31, i.MX35 }
because these share PHYS_OFFSETs. And note that i.MX31 has a different
iomuxer than i.MX25 and i.MX35. As soon as we have support for runtime
PHYS_OFFSET the remaining groups are:

	ARMv4 + ARMv5 vs. ARMv6 + ARMv7

(I think) which doesn't match the ARCH_MX1/2/3/5 approach anymore.

> SOC_IMX.. for single SoC. eg. SOC_IMX31/35/50/51/53. It groups Machines.
> MACH_.. for single machine. eg. MACH_MX51_BABBAGE.
> 
> They can be used in Makefiles to help include source files, but idealy not be
> used in source files. For multi-soc in single image, it's more easy to select
> build targets. It can also help transit to single image step by step.
Here I'd prefer things like:

	config SOC_IMX21
		bool
		select IMX_HAVE_IOMUX_V1

	obj-$(IMX_HAVE_IOMUX_V1) += tralala.o

> >  - MACH_MX.. actually are misnomers becauce they clash with the name
> >    space of the machine db. So they should be substituted by SOC_IMX...
> >    (maybe a few by ARCH_MX..)  (affected: MACH_MX21 and MACH_MX27)
> >  - SOC_IMX.. are used to differentiate between SoCs.
> > 
> > So a goal is to review all ARCH_MX.. and MACH_MX.. used in .c and .h
> > files and try to use the SOC_IMX variables instead.
> > Here I consider important that SOC_IMX... is really only used with
> > having multi-SoC-kernels in mind. So you can consider ARCH_MX and
> > MACH_MX as todo-markers for that (and this is the main difference IMHO).
> > E.g. the Makefile.boots are such a place that are not multi-soc capable
> > yet as is the selection of PHYS_OFFSET. I'd like to keep them marked
> > somehow.
> The ToDO markers might label itself as markers, Or it cause many people
> confused.
I don't know what you mean here.

> And are you sure we won't need ARCH_MX.. in the final single image solution?
> IMHO, single image needs to select what targetis it builds for too. The ARCH_MX..
> works as categories and help reduce image size. 
Again, I don't understand you here.

> > I don't know if it's sensible to coordinate this effort, it mainly
> > depends on how many people are willing to help. I'll start with ARCH_MX2
> > and MACH_MX2[17] next.
> > 
> > A bit orthogonal to this issue is to clean up mach-mx3 and mach-mx5 to
> > allow them to be merged into mach-imx. I didn't look at all on mxc91231,
> > yet.
> > 
> > Comments and patches are welcome. If you want to help and don't know
> > where to start, here are a few hints:
> > 
> >  - git grep -E 'M?AR?CH_MX' drivers
> >  - convert arch/arm/mach-mx[35]/devices.c to dynamically allocation
> > 
> > Richard, having said that, some of your changes look OK, while I'm not
> > completely happy with the others.
> It seems only PHYS_OFFSET are not ok?
and Makefile.boot

>                                       Maybe the p2v patch can help?
Indeed.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
