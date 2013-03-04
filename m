From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Mon,  4 Mar 2013 13:51:07 +0900
Subject: [RFC PATCH] ARM: mm: disable kmap_high_get() for SMP
Message-ID: <1362372667-953-1-git-send-email-iamjoonsoo.kim@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With SMP and enabling kmap_high_get(), it makes users of kmap_atomic()
sequential ordered, because kmap_high_get() use global kmap_lock().
It is not welcome situation, so turn off this optimization for SMP.

Cc: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index 8c5e828..82fea0f 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -26,15 +26,13 @@ extern void kunmap_high(struct page *page);
  * The reason for kmap_high_get() is to ensure that the currently kmap'd
  * page usage count does not decrease to zero while we're using its
  * existing virtual mapping in an atomic context.  With a VIVT cache this
- * is essential to do, but with a VIPT cache this is only an optimization
- * so not to pay the price of establishing a second mapping if an existing
- * one can be used.  However, on platforms without hardware TLB maintenance
- * broadcast, we simply cannot use ARCH_NEEDS_KMAP_HIGH_GET at all since
- * the locking involved must also disable IRQs which is incompatible with
- * the IPI mechanism used by global TLB operations.
+ * is essential to do, but with a VIPT cache this is only an optimization.
+ * With SMP and enabling kmap_high_get(), it makes users of kmap_atomic()
+ * sequential ordered, because kmap_high_get() use global kmap_lock().
+ * It is not welcome situation, so turn off this optimization for SMP.
  */
 #define ARCH_NEEDS_KMAP_HIGH_GET
-#if defined(CONFIG_SMP) && defined(CONFIG_CPU_TLB_V6)
+#if defined(CONFIG_SMP)
 #undef ARCH_NEEDS_KMAP_HIGH_GET
 #if defined(CONFIG_HIGHMEM) && defined(CONFIG_CPU_CACHE_VIVT)
 #error "The sum of features in your kernel config cannot be supported together"
-- 
1.7.9.5
