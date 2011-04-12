From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 12 Apr 2011 08:38:07 +0200
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51
	and i.MX53
In-Reply-To: <alpine.LFD.2.00.1104110944290.28032@xanadu.home>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.1104102157440.28032@xanadu.home>
	<20110411074041.GF18601@pengutronix.de>
	<alpine.LFD.2.00.1104110944290.28032@xanadu.home>
Message-ID: <20110412063807.GC7771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 10:15:09AM -0400, Nicolas Pitre wrote:
> On Mon, 11 Apr 2011, Uwe Kleine-K?nig wrote:
> 
> > On Sun, Apr 10, 2011 at 10:02:03PM -0400, Nicolas Pitre wrote:
> > > On Sun, 10 Apr 2011, Uwe Kleine-K?nig wrote:
> > > 
> > > > The two SoCs have different PHYS_OFFSETs so it's not (yet) possible to
> > > > compile a single (working) kernel for these.
> > > 
> > > Really?
> > > 
> > > Have a look at CONFIG_ARM_PATCH_PHYS_VIRT.  It's in mainline and fully 
> > > functional.
> > I'm aware of this config item. But still if it's off there must be a
> > distinction that's provided by this patch.
> 
> Sure.  Instead of a compile time expansion of virt_to_phys() and 
> phys_to_virt(), you get a run time patching of the kernel binary 
> according to the runtime deduced PHYS_OFFSET.  See commit logs for "git 
> log 6fc31d54..b511d75" for the details.
I'm well aware of the details, too. I just said that if
ARM_PATCH_PHYS_VIRT is off, i.MX51 and i.MX53 cannot be supported by the
same kernel, so I changed the Kconfig logic to reflect this. You can be
sure I will follow up with a patch that checks for ARM_PATCH_PHYS_VIRT
and will allow more SoCs in a single kernel.
 
> > Currently you can build a
> > kernel for i.MX51 + i.MX53 but IIRC it works on no machine.
> 
> Maybe it should be fixed?
My patch does. :-)

> > When considering ARM_PATCH_PHYS_VIRT there are more SoCs that could be
> > built into a single image and so needs a more complicated logic.
> 
> The ultimate goal is to structure the code so we can build as many SOCs 
> together as possible.
Yeah, and I think we're on a good way for mxc, don't you?

> > And I don't want to depend on ARM_PATCH_PHYS_VIRT (yet), e.g. because
> > it's new and still depends on EXPERIMENTAL.
> 
> When will it be no experimental anymore if no one starts using it?  RMK 
> talked about making it enabled by default, and that could allow for the 
> removal of a bunch of arch/arm/*/include/mach/memory.h files.
I will using it, but I don't want to make the mx5 port depend on it and
so on EXPERIMENTAL. I don't know about you, but I have to satisfy two
worlds: the ARM community with all the new stuff and industrial
customers that want a system that just works. And I don't want to
explain a member of the latter group who has read the help text of
EXPERIMENTAL why this is needed for his fundamentally important system
that has to be reliable 100%.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
