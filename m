From: james.morse@arm.com (James Morse)
Date: Mon,  6 Nov 2017 18:44:27 +0000
Subject: [PATCH 4/4] ACPI / APEI: Remove arch_apei_flush_tlb_one()
In-Reply-To: <20171106184427.31905-1-james.morse@arm.com>
References: <20171106184427.31905-1-james.morse@arm.com>
Message-ID: <20171106184427.31905-5-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing calls arch_apei_flush_tlb_one() anymore, instead relying on
__set_pte_vaddr() to do the invalidation when called from clear_fixmap()
Remove arch_apei_flush_tlb_one().

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/acpi/apei.c | 5 -----
 include/acpi/apei.h         | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
index ea3046e0b0cf..bb8d300fecbd 100644
--- a/arch/x86/kernel/acpi/apei.c
+++ b/arch/x86/kernel/acpi/apei.c
@@ -52,8 +52,3 @@ void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	apei_mce_report_mem_error(sev, mem_err);
 #endif
 }
-
-void arch_apei_flush_tlb_one(unsigned long addr)
-{
-	__flush_tlb_one(addr);
-}
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index c46694abea28..82c451698c98 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -50,7 +50,6 @@ int erst_clear(u64 record_id);
 
 int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
 void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
-void arch_apei_flush_tlb_one(unsigned long addr);
 
 #endif
 #endif
-- 
2.15.0.rc2
