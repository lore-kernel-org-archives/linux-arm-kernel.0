From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 21:32:55 +0100
Subject: [PATCH 00/16] irqchip: gic: killing gic_arch_extn, slowly
In-Reply-To: <547F2534.6040104@arm.com>
References: <1417539497-20101-1-git-send-email-marc.zyngier@arm.com>
 <2236572.MdjJGoEARl@wuerfel> <547F2534.6040104@arm.com>
Message-ID: <14936022.4dFVyl0YXu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 14:59:00 Marc Zyngier wrote:
> On 03/12/14 14:30, Arnd Bergmann wrote:
> > On Tuesday 02 December 2014 16:58:01 Marc Zyngier wrote:
> >>
> >> - This actively *breaks* existing setups. Once you boot a new kernel
> >>   with an old DT, suspend/resume *will* be broken. Old kernels on a
> >>   new DT won't even boot! You've been warned. This really outline the
> >>   necessity of actually describing the HW in device trees...
> > 
> > I wonder if we should take this as the trigger to come up with a
> > better way of handling incompatible binding changes. The machine_desc
> > has a .dt_fixup callback that we could use to modify the DT passed
> > from a boot loader and warn about it, but no platform does this
> > at the moment.
> > 
> > From what I can tell, the required change to get an old dtb working
> > with a new kernel is to add a particular node and flip a few
> > interrupt-parent properties, which seems doable as a quirk if
> > people agree that it's a good idea.
> 
> That's probably the only way to avoid the breakage introduced by this
> kind of changes. A few questions though:
> - Where do we stop? Eventually, don't we end-up with a full DT in there?
> - When do we retire such fixup? Or do we keep them forever?

Excellent questions. My first reaction to both would be to leave it up
to the individual platform maintainer, but I'd also limit it to working
around regressions and never to add device nodes in order to activate
features that didn't already work with an older kernel.

Also, it would probably be good to control these using a compile-time
option that easily allows building a kernel with no such hacks, possibly
even using a versioning system to annotate how far back you want to
support, though I would not implement that at first.

	Arnd
