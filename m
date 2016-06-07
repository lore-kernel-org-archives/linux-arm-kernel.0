From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 Jun 2016 17:30:25 +0100
Subject: [PATCH] arm64: Implement ptep_set_access_flags() for hardware
 AF/DBM
In-Reply-To: <4c2b3cff-d4a7-f3b8-ef0d-f6caa21f412e@suse.de>
References: <1460559682-31267-1-git-send-email-catalin.marinas@arm.com>
 <4c2b3cff-d4a7-f3b8-ef0d-f6caa21f412e@suse.de>
Message-ID: <20160607163024.GB20477@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

Thanks for the bug report.

On Tue, Jun 07, 2016 at 04:13:03PM +0200, Alexander Graf wrote:
> On 13.04.16 17:01, Catalin Marinas wrote:
> > When hardware updates of the access and dirty states are enabled, the
> > default ptep_set_access_flags() implementation based on calling
> > set_pte_at() directly is potentially racy. This triggers the "racy dirty
> > state clearing" warning in set_pte_at() because an existing writable PTE
> > is overridden with a clean entry.

[...]

> This patch breaks swapping for me.
> 
> I've hit weird issues where systems stopped working half-way, with the
> kernel still being fine and user space applications just stopping to
> respond.
> 
> After some debugging we found out that it always happens when swapping
> (to anything, backing storage doesn't matter). A quick bisect points to
> this commit as culprit and indeed, if I disable CONFIG_ARM64_HW_AFDBM
> the system works as expected.

[...]

> The back traces indicate that the page fault handler goes through and
> the process just keeps banging on the same page fault over and over
> again. I have not yet figured out what *exactly* is going wrong or why
> this patch would actually give us that effect.
> 
> I was able to fully reproduce the issue with current Linus tree (4.7-rc2+).

It looks like the following happens:

  1. We put down a PTE_WRITE | PTE_DIRTY | PTE_AF pte
  2. Memory pressure -> pte_mkold(pte) -> clear PTE_AF
  3. A read faults due to the missing access flag
  4. ptep_set_access_flags is called with dirty = 0, due to the read fault
  5. pte is then made PTE_WRITE | PTE_DIRTY | PTE_AF | PTE_RDONLY (!)
  6. A write faults, but pte_write is true so we get stuck

Does the diff below fix the issue for you? If so, I'll write a proper
patch.

Cheers,

Will

--->8

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5954881a35ac..ba3fc12bd272 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -109,7 +109,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 	 * PTE_RDONLY is cleared by default in the asm below, so set it in
 	 * back if necessary (read-only or clean PTE).
 	 */
-	if (!pte_write(entry) || !dirty)
+	if (!pte_write(entry) || !pte_sw_dirty(entry))
 		pte_val(entry) |= PTE_RDONLY;
 
 	/*
