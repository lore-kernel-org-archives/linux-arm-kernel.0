From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Jan 2015 07:37:48 -0800
Subject: Regression with legacy IRQ numbers caused by 9a1091ef0017
In-Reply-To: <87wq4ogl48.fsf@approximate.cambridge.arm.com>
References: <20150114221407.GS2419@atomide.com>
 <8761c8i2hq.fsf@approximate.cambridge.arm.com>
 <2776397.iNGHcrIBZz@wuerfel>
 <87wq4ogl48.fsf@approximate.cambridge.arm.com>
Message-ID: <20150115153746.GC18552@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [150115 06:46]:
> On Thu, Jan 15 2015 at  2:27:56 pm GMT, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 15 January 2015 13:42:57 Marc Zyngier wrote:
> >> Of course, this is in no way a proper fix, but I suppose the OMAP DT is
> >> still missing a few bits...
> >
> > I must be missing something here, but all the interrupts are listed
> > correctly in the DT, so what is the omap_hwmod_irq_info actually
> > achieving on omap4 and omap5?
> >
> > Would it work if we just remove the incorrect copy of the resource
> > and use the one that comes from DT?
> 
> By the look of it, omap_hwmod_irq_info serves multiple purposes:
> - low level configuration (pads, probably more stuff)

The muxing is only done for omap3 in legacy booting mode.

> - interrupt description for some drivers, using resources.

That's still used to create legacy platform_device entries on omap4
for legacy DMA, DSS, PRM. The twl6040 entries are already unused
and I have a patch queued to remove them.
 
> It should be fairly easy to do the latter, but the former looks more
> tricky (it would push the pad configuration down to the drivers, which
> is avoided at the moment).

The pad configuration is already done with pinctrl-single.
 
> Probably there is a workable strategy, but my knowledge about OMAP is
> close to *nothing*...

I have a feeling this might bite other platforms too and we just have
not noticed it yet..

Regards,

Tony
