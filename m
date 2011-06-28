From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 00:17:11 +0100
Subject: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
In-Reply-To: <CAMbhsRQjMmXrULVmFg9CoM0wzZ29wcHqEaT480NaDhB8hHEKZg@mail.gmail.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
	<CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>
	<20110628225523.GA23312@n2100.arm.linux.org.uk>
	<CAMbhsRQjMmXrULVmFg9CoM0wzZ29wcHqEaT480NaDhB8hHEKZg@mail.gmail.com>
Message-ID: <20110628231711.GC23312@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 03:58:57PM -0700, Colin Cross wrote:
> On Tue, Jun 28, 2011 at 3:55 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Jun 28, 2011 at 03:29:57PM -0700, Colin Cross wrote:
> >> Can't this rewrite the loops_per_jiffy for the other CPU while it is
> >> in a udelay? ?If it has already calculated the number of loops
> >> necessary, and the CPU frequency increases, it could end up returning
> >> too early from udelay.
> >
> > udelay uses the global loops_per_jiffy.
> >
> 
> The problem is still the same - loops_per_jiffy applies to both CPUs,
> and the frequency of the other CPU cannot be changed if it is in a
> udelay.

If you have a SMP system where both CPUs scale together then you will
get both CPUs being impacted, which may result in udelay() terminating
well early or taking much longer than was originally intended.

That's rather unavoidable with software timing loops - we could add a
rw spinlock around udelay, but that would require interrupts to be
disabled and that wouldn't be nice in general to have every udelay
running with IRQs off.

That's why people have proposed hardware-timer based delay loops -
these screw up the bogomips value (it no longer refers to the CPU
but to the timer used for the delays) and the code proposed thus far
probably has a severe negative impact on ARMs running at low clock
rates (the calculation cost of the number of loops to run becomes
significant for CPUs below 100MHz for short delays with the existing
optimized assembler, so moving it into C and introducing function
pointers will only make it worse.)
