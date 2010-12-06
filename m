From: will.deacon@arm.com (Will Deacon)
Date: Mon, 6 Dec 2010 16:38:15 -0000
Subject: [PATCH v3] ARM: vexpress: add support for multiple core tiles
In-Reply-To: <20101206155310.GG31777@n2100.arm.linux.org.uk>
References: <1291052921-30695-1-git-send-email-will.deacon@arm.com>
	<20101206155310.GG31777@n2100.arm.linux.org.uk>
Message-ID: <006f01cb9563$faf32210$f0d96630$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> On Mon, Nov 29, 2010 at 05:48:41PM +0000, Will Deacon wrote:
> > The current Versatile Express BSP defines the MACHINE_START macro
> > in the core tile code.
> >
> > This patch moves this into the generic board code and introduces
> > a method for determining the current tile at runtime, allowing
> > the Kernel to have support for multiple tiles compiled in.
> > Tile-specific functions are executed via a descriptor struct containing
> > the correct implementations for the current tile.
> 
> Obviously, this has been broken by the changes to the SMP and GIC code...

Yup, I posted the patch to your patch system before the SMP and GIC
changes had hit the list, so I'll mark it as discarded for now.
 
> The SMP code is now down to the following:
> 
> void __init smp_init_cpus(void)

[...]
 
> void __init platform_smp_prepare_cpus(unsigned int max_cpus)

[...]

Ok, that looks easy enough to incorporate into the multi-tile stuff.

> The secondary startup addresses could be moved into boot_secondary(),
> leaving smp_init_cpus() and platform_smp_prepare_cpus() with the task
> of initializing the possible/present bitmaps, and enabling the SCU.
> 
> I'm in two minds about that - one is that we know that the SCU on an
> A9 or MPCore is going to tell us that CPUs 0..N are present, so we
> can move that logic into smp_scu.c.
> 
> However, just because there's CPUs 0..N doesn't mean that a platform
> would want to use all those CPUs for SMP, so it should be a platform
> choice which CPUs get populated into the maps.

I agree, working out the set of CPUs that we want to bring up shouldn't
have anything to do with the SCU. This becomes even more important for
SMP platforms where the SCU doesn't have a memory-mapped interface, like
A15.

> The other complication here is that the possible/present bitmaps use
> logical CPU numbers, which depending on the platform may or may not
> be the same as physical CPU numbers, even though it may be an A9 based
> platform.

Eek. What sort of mapping do you get between logical and physical CPU
numbers for these platforms? Are the logical numbers offset from the
physical ones or is there just a random mapping between the two?

> I think what we want is to not only move the count of cores and scu
> enable into the core tile code, but also the bitmap population too.
> That may ultimately be the sensible thing if we're eventually going
> to indirect smp_init_cpus()/platform_smp_prepare_cpus() in the longer
> term.

Ok, I'll have a crack at incorporating that into v4 of this patch, which
I'll base against -next.

Thanks,

Will
