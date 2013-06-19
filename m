From: gmbnomis@gmail.com (Simon Baatz)
Date: Wed, 19 Jun 2013 22:15:10 +0200
Subject: [PATCH] ARM: fix missing flush_kernel_dcache_page() for noMMU
Message-ID: <1371672910-9340-1-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 1bc3974 moved the implementation of flush_kernel_dcache_page()
into in mm/flush.c but did not implement it on noMMU ARM.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
Cc: <stable@vger.kernel.org> # 3.2+: 1bc3974: ARM: 7755/1
Cc: <stable@vger.kernel.org> # 3.2+
---

ARM 7755/1 "handle user space mapped pages in flush_kernel_dcache_page"
unfortunately broke the no MMU case.  Compile tested with allnoconfig and
at91x40_defconfig on v3.10-rc6/v3.9.6 + ARM 7755/1.  On older stable kernels
(3.2.47 & 3.4.49) compiled with at91x40_defconfig.

- Simon

 arch/arm/mm/nommu.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index d51225f..eb5293a 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -57,6 +57,12 @@ void flush_dcache_page(struct page *page)
 }
 EXPORT_SYMBOL(flush_dcache_page);
 
+void flush_kernel_dcache_page(struct page *page)
+{
+	__cpuc_flush_dcache_area(page_address(page), PAGE_SIZE);
+}
+EXPORT_SYMBOL(flush_kernel_dcache_page);
+
 void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 		       unsigned long uaddr, void *dst, const void *src,
 		       unsigned long len)
-- 
1.7.9.5
