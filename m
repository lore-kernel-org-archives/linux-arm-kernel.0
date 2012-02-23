From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 19:50:03 +0000
Subject: [PATCH] ARM: LPAE: Invalidate the TLB for module addresses
 during translation fault
In-Reply-To: <1330019981-18743-1-git-send-email-catalin.marinas@arm.com>
References: <1330019981-18743-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20120223195003.GD22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 05:59:41PM +0000, Catalin Marinas wrote:
> During the free_pgtables() call all user and modules/pkmap entries are
> removed.

Err, no.  free_pgtables() should only ever touch up to TASK_SIZE, which
is the maximum size of userspace.  Moreover, because TASK_SIZE does not
cover an entire pud, free_pgtables() should not be removing the pud
table.

> There is a small window between pud_clear() and pmd_free_tlb() in
> free_pmd_range() where the pud entry was cleared but the TLB has not
> been invalidated yet and the CPU may have cached the original (valid)
> pud entry in the TLB. A scenario like below would get stuck in
> continuous prefetch abort:
> 
> 1. Current process exiting. The modules pmd entries not populated
> 2. exit_mmap() -> ... -> pmd_free_tlb()
> 3. pud_clear() for the 1GB pud containing user stack and modules (no TLB
>    invalidation yet)

This is where things are wrong.  Because the request should not be
requesting that the entire pud is being cleared, it should not be
removed from the pgd.

So, there's some debugging to be done here.
