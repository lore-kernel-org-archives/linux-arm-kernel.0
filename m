From: zhenzhang.zhang@huawei.com (Zhang Zhen)
Date: Tue, 8 Sep 2015 10:45:38 +0800
Subject: [PATCH] ARM:mm: define arch-specific IOREMAP_MAX_ORDER only in !SMP
 && !LPAE case
In-Reply-To: <1441680050-50490-1-git-send-email-zhenzhang.zhang@huawei.com>
References: <1441680050-50490-1-git-send-email-zhenzhang.zhang@huawei.com>
Message-ID: <55EE4BD2.3080800@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch-specific IOREMAP_MAX_ORDER is introduced in
commit: ff0daca([ARM] Add section support to ioremap) and
commit: a069c89 ([ARM] 3705/1: add supersection support to ioremap()).
But supersections and sections mappings are only used in !SMP && !LPAE case.
Otherwise, mapping is created using the usual 4K pages.

In most cases without !SMP && !LPAE, the big alignment cause high fragmentation
issue in vmalloc area.
Here we use arch-specific IOREMAP_MAX_ORDER only in !SMP && !LPAE case,
otherwise use generic IOREMAP_MAX_ORDER in include/linux/vmalloc.h.

Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
---
 arch/arm/include/asm/memory.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index b7f6fb4..3209012 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -76,10 +76,12 @@
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
1.9.1


.
