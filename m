From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Dec 2014 11:07:19 +0000
Subject: [PATCH] arm64: kernel: fix __cpu_suspend mm switch on warm-boot
In-Reply-To: <20141221154846.GA24545@arm.com>
References: <1419008627-1918-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20141221105042.GI23242@arm.com>
 <20141221115636.GA15288@e104818-lin.cambridge.arm.com>
 <20141221154846.GA24545@arm.com>
Message-ID: <20141222110719.GB20269@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 21, 2014 at 03:48:48PM +0000, Will Deacon wrote:
> On Sun, Dec 21, 2014 at 11:56:36AM +0000, Catalin Marinas wrote:
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

It's only if there has been no other switch to a user thread since boot.
Kernel threads don't have an mm, so the active_mm is inherited from the
previous thread. The only time when we have active_mm == &init_mm is for
the idle thread after (secondary) boot and subsequent kernel threads
until the first switch to a user one.

-- 
Catalin
