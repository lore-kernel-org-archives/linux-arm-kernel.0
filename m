From: dserrg@gmail.com (Sergey Dyasly)
Date: Thu, 27 Jun 2013 21:24:35 +0400
Subject: [PATCH] ARM: LPAE: don't reject mapping /dev/mem above 4GB
Message-ID: <1372353875-3262-1-git-send-email-dserrg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With LPAE enabled, physical address space is larger than 4GB. Allow mapping any
part of it via /dev/mem by utilizing the same check as in arm64.

Reported-by: Vassili Karpov <av1474@comtv.ru>
Tested-by: Vassili Karpov <av1474@comtv.ru>
Signed-off-by: Sergey Dyasly <dserrg@gmail.com>
---
 arch/arm/mm/mmap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index 10062ce..8f1bbbc 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -203,6 +203,15 @@ int valid_phys_addr_range(phys_addr_t addr, size_t size)
 	return 1;
 }
 
+#ifdef CONFIG_ARM_LPAE
+/*
+ * Do not allow /dev/mem mappings beyond the supported physical range.
+ */
+int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
+{
+	return !(((pfn << PAGE_SHIFT) + size) & ~PHYS_MASK);
+}
+#else
 /*
  * We don't use supersection mappings for mmap() on /dev/mem, which
  * means that we can't map the memory area above the 4G barrier into
@@ -212,6 +221,7 @@ int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 {
 	return !(pfn + (size >> PAGE_SHIFT) > 0x00100000);
 }
+#endif
 
 #ifdef CONFIG_STRICT_DEVMEM
 
-- 
1.8.1.2
