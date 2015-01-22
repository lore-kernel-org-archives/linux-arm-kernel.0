From: s.dyasly@samsung.com (Sergey Dyasly)
Date: Thu, 22 Jan 2015 10:17:55 +0300
Subject: [PATCH] ARM: use default ioremap alignment for SMP or LPAE
Message-ID: <1421911075-8814-1-git-send-email-s.dyasly@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

16MB alignment for ioremap mappings was added by commit a069c896d0d6 ("[ARM]
3705/1: add supersection support to ioremap()") in order to support supersection
mappings. But __arm_ioremap_pfn_caller uses section and supersection mappings
only in !SMP && !LPAE case. There is no need for such big alignment if either
SMP or LPAE is enabled.

After this change, ioremap will use default maximum alignment of 128 pages.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: James Bottomley <JBottomley@parallels.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd.bergmann@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Safonov <d.safonov@partner.samsung.com>
Link: https://lkml.kernel.org/g/1419328813-2211-1-git-send-email-d.safonov at partner.samsung.com
Signed-off-by: Sergey Dyasly <s.dyasly@samsung.com>
---
 arch/arm/include/asm/memory.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 184def0..c3ef139 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -78,10 +78,12 @@
  */
 #define XIP_VIRT_ADDR(physaddr)  (MODULES_VADDR + ((physaddr) & 0x000fffff))
 
+#if !defined(CONFIG_SMP) && !defined(CONFIG_ARM_LPAE)
 /*
  * Allow 16MB-aligned ioremap pages
  */
 #define IOREMAP_MAX_ORDER	24
+#endif
 
 #else /* CONFIG_MMU */
 
-- 
1.7.9.5
