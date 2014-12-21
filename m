From: will.deacon@arm.com (Will Deacon)
Date: Sun, 21 Dec 2014 10:50:43 +0000
Subject: [PATCH] arm64: kernel: fix __cpu_suspend mm switch on warm-boot
In-Reply-To: <1419008627-1918-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1419008627-1918-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20141221105042.GI23242@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 19, 2014 at 05:03:47PM +0000, Lorenzo Pieralisi wrote:
> On arm64 the TTBR0_EL1 register is set to either the reserved TTBR0
> page tables on boot or to the active_mm mappings belonging to user space
> processes, it must never be set to swapper_pg_dir page tables mappings.
> 
> When a CPU is booted its active_mm is set to init_mm even though its
> TTBR0_EL1 points at the reserved TTBR0 page mappings. This implies
> that when __cpu_suspend is triggered the active_mm can point at
> init_mm even if the current TTBR0_EL1 register contains the reserved
> TTBR0_EL1 mappings.

In reality, this is only an issue on the ASID rollover path, right? I
had grand plans to remove the use of a reserved ttbr value from that
code entirely. Obviously that shouldn't hold up this fix, but it would be
nice to understand the relationship (i.e. whether or not I can revert this
patch if/when I improve the ASID allocator).

Will
