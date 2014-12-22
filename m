From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 22 Dec 2014 09:49:33 +0000
Subject: [PATCH] arm64: kernel: fix __cpu_suspend mm switch on warm-boot
In-Reply-To: <20141221154846.GA24545@arm.com>
References: <1419008627-1918-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20141221105042.GI23242@arm.com>
 <20141221115636.GA15288@e104818-lin.cambridge.arm.com>
 <20141221154846.GA24545@arm.com>
Message-ID: <20141222094933.GA13358@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 21, 2014 at 03:48:48PM +0000, Will Deacon wrote:
> On Sun, Dec 21, 2014 at 11:56:36AM +0000, Catalin Marinas wrote:
> > On Sun, Dec 21, 2014 at 10:50:43AM +0000, Will Deacon wrote:
> > > On Fri, Dec 19, 2014 at 05:03:47PM +0000, Lorenzo Pieralisi wrote:
> > > > On arm64 the TTBR0_EL1 register is set to either the reserved TTBR0
> > > > page tables on boot or to the active_mm mappings belonging to user space
> > > > processes, it must never be set to swapper_pg_dir page tables mappings.
> > > > 
> > > > When a CPU is booted its active_mm is set to init_mm even though its
> > > > TTBR0_EL1 points at the reserved TTBR0 page mappings. This implies
> > > > that when __cpu_suspend is triggered the active_mm can point at
> > > > init_mm even if the current TTBR0_EL1 register contains the reserved
> > > > TTBR0_EL1 mappings.
> > > 
> > > In reality, this is only an issue on the ASID rollover path, right?
> > 
> > No.
> 
> Ahh, I was getting confused with arch/arm/ where we set the reserved ttbr0
> by copying ttbr1 into ttbr0. We use the zero page on arm64, so I'd
> completely missed the point of this patch (i.e. the reserved ttbr value
> is safe).
> 
> > > I
> > > had grand plans to remove the use of a reserved ttbr value from that
> > > code entirely.
> > 
> > I think we still need it (well, you can point it at the zero page, maybe
> > we do this already), unless you want to disable TTBR0 page table walks
> > in TCR_EL1 temporarily during (warm) boot. Alternatively, you can make
> > the idmap_pg_dir non-global with its own reserved ASID.
> 
> Well, I'm only talking about the ASID allocator here. If we use the active
> ASID scheme that we have on arch/arm/, then I don't see why we need to touch
> TTBR0 at all. I appreciate the need for a reserved TTBR0 in other cases.
> For arch/arm/, it's only there for classic MMU iirc.
> 
> > > Obviously that shouldn't hold up this fix, but it would be
> > > nice to understand the relationship (i.e. whether or not I can revert this
> > > patch if/when I improve the ASID allocator).
> > 
> > The problem on arm64 is that swapper_pg_dir only contains kernel
> > mappings, never user mappings, so it is not meant to be ever written to
> > TTBR0_EL1 (unlike arm32 where swapper covers the whole 4GB range). Once
> > you write swapper_pg_dir to TTBR0_EL1 (which is active_mm for the idle
> > thread after secondary boot, until the first switch to user space), you
> > end up with global kernel mappings in the user address space that never
> > go away with an ASID switch.
> 
> Ok, so the problem arises when we go idle from a kernel thread, or something
> like that?

__cpu_suspend() requires saving and restoring of TTBR0_EL1 whenever a
CPU is reset, coming out of low power mode. By the time the CPU returns
to the kernel in __cpu_suspend, coming out of reset from low-power mode
through idmap (to enable the MMU), I must "restore" the current
TTBR0_EL1 register settings to go back to the current thread in the same
conditions as before __cpu_suspend was triggered.

__cpu_suspend can be called from suspend-to-RAM or CPU idle. If it is
triggered from suspend-to-RAM, current->active_mm is a user space
mapping so it is safe (and it *must* be done) to switch back to to
the current->active_mm.

When __cpu_suspend is called from CPU idle, it is always called with
current == idle-thread. If __cpu_suspend is called from the idle thread
before the core switches once to user space, active_mm == init_mm and
__cpu_suspend must not "restore" the active_mm, because it points at
init_mm page tables ie global kernel mappings.

There are multiple ways of fixing this pesky issue, I thought after some
discussions this is the faster and cleaner (we leave code in C).

I have a patch that saves and restores the TTBR0_EL1, which removes
the active_mm handling in __cpu_suspend entirely (but makes assembly
slightly more complicated).

We could even go (as Catalin said) back to the kernel with idmap in
TTBR0_EL1, as long as you can make it nG and reserve an ASID for it.

Once this fix hits mainline, I am more than happy to rework the code to
find a solution (I already have one, see above) that does not get in
the way of the ASID rework.

Thanks,
Lorenzo
