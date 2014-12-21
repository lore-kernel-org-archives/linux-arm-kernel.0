From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 21 Dec 2014 11:56:36 +0000
Subject: [PATCH] arm64: kernel: fix __cpu_suspend mm switch on warm-boot
In-Reply-To: <20141221105042.GI23242@arm.com>
References: <1419008627-1918-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20141221105042.GI23242@arm.com>
Message-ID: <20141221115636.GA15288@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 21, 2014 at 10:50:43AM +0000, Will Deacon wrote:
> On Fri, Dec 19, 2014 at 05:03:47PM +0000, Lorenzo Pieralisi wrote:
> > On arm64 the TTBR0_EL1 register is set to either the reserved TTBR0
> > page tables on boot or to the active_mm mappings belonging to user space
> > processes, it must never be set to swapper_pg_dir page tables mappings.
> > 
> > When a CPU is booted its active_mm is set to init_mm even though its
> > TTBR0_EL1 points at the reserved TTBR0 page mappings. This implies
> > that when __cpu_suspend is triggered the active_mm can point at
> > init_mm even if the current TTBR0_EL1 register contains the reserved
> > TTBR0_EL1 mappings.
> 
> In reality, this is only an issue on the ASID rollover path, right?

No.

> I
> had grand plans to remove the use of a reserved ttbr value from that
> code entirely.

I think we still need it (well, you can point it at the zero page, maybe
we do this already), unless you want to disable TTBR0 page table walks
in TCR_EL1 temporarily during (warm) boot. Alternatively, you can make
the idmap_pg_dir non-global with its own reserved ASID.

> Obviously that shouldn't hold up this fix, but it would be
> nice to understand the relationship (i.e. whether or not I can revert this
> patch if/when I improve the ASID allocator).

The problem on arm64 is that swapper_pg_dir only contains kernel
mappings, never user mappings, so it is not meant to be ever written to
TTBR0_EL1 (unlike arm32 where swapper covers the whole 4GB range). Once
you write swapper_pg_dir to TTBR0_EL1 (which is active_mm for the idle
thread after secondary boot, until the first switch to user space), you
end up with global kernel mappings in the user address space that never
go away with an ASID switch.

-- 
Catalin
