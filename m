From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 24 Jun 2013 10:48:04 +0100
Subject: [PATCH] ARM: mm: Remove do_sect_fault from LPAE code
Message-ID: <1372067284-13389-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For LPAE, do_sect_fault used to be invoked as the second level access
flag handler. When transparent huge pages were introduced for LPAE,
do_page_fault was used instead.

Unfortunately, do_sect_fault remains defined but not used for LPAE code
resulting in a compile warning.

This patch surrounds do_sect_fault with #ifndef CONFIG_ARM_LPAE to fix
this warning.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 5dbf13f..c97f794 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -491,12 +491,14 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
  * Some section permission faults need to be handled gracefully.
  * They can happen due to a __{get,put}_user during an oops.
  */
+#ifndef CONFIG_ARM_LPAE
 static int
 do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
 	do_bad_area(addr, fsr, regs);
 	return 0;
 }
+#endif /* CONFIG_ARM_LPAE */
 
 /*
  * This abort handler always returns "fault".
-- 
1.8.1.4
