From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Apr 2011 11:14:31 +0100
Subject: [PATCH] ARM: S3C64XX: Initial support for Wolfson/Simtec
	Cragganmore/Banff
In-Reply-To: <20110414012406.GA3789@opensource.wolfsonmicro.com>
References: <1302533295-27917-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<01bd01cbfa2e$1afae140$50f0a3c0$%kim@samsung.com>
	<20110414012406.GA3789@opensource.wolfsonmicro.com>
Message-ID: <20110414101431.GC1611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2011 at 06:24:08PM -0700, Mark Brown wrote:
> On Thu, Apr 14, 2011 at 07:56:22AM +0900, Kukjin Kim wrote:
> > But I'm not sure this can be sent to upstream during the next merge window.
> > Because of Linus' complaint, Russell does not want to add new stuff now,
> > maybe you know. Basically my tree was sent to upstream via RMK when merge
> > window.
> 
> Hrm, right.  I had thought that the restriction there applied to the
> trees that Russell manages directly himself (the core ARM code) rather
> than those subtrees which he pulls in for the subarchitectures.

Mark,

People (eg, Ingo) have been saying that the core ARM code is in good
shape and is not a problem.

If you look at what Linus complained about, it was the platform stuff.
It's the platform stuff which has got out of control, and we have common
themes duplicated under different SoC classes.

Eg, why do we have two ways of managing SRAM - one for Davinci and one
for OMAP?  Why can't we have one way of declaring "here is the SRAM,
please allocate X bytes from it" ?  Really it's not about SRAM at all,
but memory regions, so actually we need an allocator like the Davinci
one but can be wrapped up and re-used not only for SRAM but other
similar purposes as well (eg, where you need both the virtual and
physical addresses.)

Thomas found in his IRQ cleanup patches that many of the ARM irqchip
implementations were largely similar - again, why can't we have these
commonalities merged?

Linus also complained about the 30 odd GPIO implementations - again its
a similar question (but I'm thankful to see that some effort is being
put into that.)

It's not the core ARM code which needs consolidating.  It is the platform
stuff which needs attention.

What scares me at the moment is that looking at the diffstat in linux-next,
it looks to me like its business as usual for arch/arm, and we're heading
again for another 60k line insertions for the next merge window.

And just remember this: at the last merge window, I deleted two SoC
platforms and consolidated chunks of code for a bunch of ARM Ltd's
development platforms - all of which got lost in the noise of new
additions to arch/arm.  There is no way that I can sort this out on my
own - the problem is _far_ too big for any one individual to attack
unless we permantly freeze arch/arm for the next few years against
new additions.

At the moment, the only outcome I can see is that Linus is going to have
another rant at the next merge window, and that will be game over for ARM
in mainline.

We need more people taking Linus' concern seriously.
