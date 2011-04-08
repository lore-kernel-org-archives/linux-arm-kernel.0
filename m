From: will.deacon@arm.com (Will Deacon)
Date: Fri,  8 Apr 2011 14:02:06 +0100
Subject: [RESEND][PATCH] ARM: memmap: only free allocated memmap entries when
	using SPARSEMEM
Message-ID: <1302267726-18521-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPARSEMEM code allocates memmap entries only for sections which are
present (i.e. those which contain some valid memory). The membank checks
in free_unused_memmap do not take this into account and can incorrectly
attempt to free memory which is not allocated, resulting in a BUG() in
the bootmem code.

However, if memory is configured as follows:

    |<----section---->|<----hole---->|<----section---->|
    +--------+--------+--------------+--------+--------+
    | bank 0 | unused |              | bank 1 | unused |
    +--------+--------+--------------+--------+--------+

where a bank only occupies part of a section, the memmap allocated for
the remainder of the section *can* be freed.

This patch modifies the checks in free_unused_memmap so that only valid
memmap entries are considered for removal.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Resending this patch now that we're out of -rc1.

 arch/arm/mm/init.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index e3ebcc2..b9c0135 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -399,7 +399,7 @@ free_memmap(unsigned long start_pfn, unsigned long end_pfn)
 	 * Convert start_pfn/end_pfn to a struct page pointer.
 	 */
 	start_pg = pfn_to_page(start_pfn - 1) + 1;
-	end_pg = pfn_to_page(end_pfn);
+	end_pg = pfn_to_page(end_pfn - 1) + 1;
 
 	/*
 	 * Convert to physical addresses, and
@@ -433,6 +433,14 @@ static void __init free_unused_memmap(struct meminfo *mi)
 
 		bank_start = bank_pfn_start(bank);
 
+#ifdef CONFIG_SPARSEMEM
+		/*
+		 * Take care not to free memmap entries that don't exist
+		 * due to SPARSEMEM sections which aren't present.
+		 */
+		bank_start = min(bank_start,
+				 ALIGN(prev_bank_end, PAGES_PER_SECTION));
+#endif
 		/*
 		 * If we had a previous bank, and there is a space
 		 * between the current bank and the previous, free it.
@@ -447,6 +455,12 @@ static void __init free_unused_memmap(struct meminfo *mi)
 		 */
 		prev_bank_end = ALIGN(bank_pfn_end(bank), MAX_ORDER_NR_PAGES);
 	}
+
+#ifdef CONFIG_SPARSEMEM
+	if (!IS_ALIGNED(prev_bank_end, PAGES_PER_SECTION))
+		free_memmap(prev_bank_end,
+			    ALIGN(prev_bank_end, PAGES_PER_SECTION));
+#endif
 }
 
 static void __init free_highpages(void)
-- 
1.7.0.4
