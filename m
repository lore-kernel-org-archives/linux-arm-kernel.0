From: hsinhsien1106@gmail.com (=?Big5?B?p2SrSL3l?=)
Date: Wed, 5 Oct 2011 11:40:44 +0800
Subject: "dma-mapping: fix for speculative prefetching" patch for 2.6.31.2
Message-ID: <CAGvdX9c_xNUCLVSm4nzsH+27rs5mEit8u=z4EXMceQsLmrROYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear experts,

I am implementing USB and SD drivers with kernel 2.6.31.2 on
ARM1176jzf-s (ARMv6 with speculative execution), and also encountered
the cache coherence issue. I found this patch "dma-mapping: fix for
speculative prefetching" on kerneltrap.org, but It seems cannot be
applied on kernel 2.6.31.2.

So, I am looking for a patch for earlier version kernel, and found two
patches which are probably able to be applied on kernel 2.6.31.2.
One is for Cortex A9 posted in this mail list:
    http://lists.arm.linux.org.uk/lurker/message/20091031.172415.7712b229.en.html
The other is similar but less modification:
    http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/003163.html

Does the two patches can work fine with kernel 2.6.31.2 on ARM1176jzf-s?


Moreover, I am wondering why to remove the following code section.
Will there be any side effect I should notice or handle?


diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 295e25d..d1dfd87 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -195,20 +195,7 @@ ENTRY(v6_flush_kern_dcache_page)
  *    - end     - virtual end address of region
  */
 ENTRY(v6_dma_inv_range)
-    tst    r0, #D_CACHE_LINE_SIZE - 1
     bic    r0, r0, #D_CACHE_LINE_SIZE - 1
-#ifdef HARVARD_CACHE
-    mcrne    p15, 0, r0, c7, c10, 1        @ clean D line
-#else
-    mcrne    p15, 0, r0, c7, c11, 1        @ clean unified line
-#endif
-    tst    r1, #D_CACHE_LINE_SIZE - 1
-    bic    r1, r1, #D_CACHE_LINE_SIZE - 1
-#ifdef HARVARD_CACHE
-    mcrne    p15, 0, r1, c7, c14, 1        @ clean & invalidate D line
-#else
-    mcrne    p15, 0, r1, c7, c15, 1        @ clean & invalidate unified line
-#endif
 1:
 #ifdef HARVARD_CACHE
     mcr    p15, 0, r0, c7, c6, 1        @ invalidate D line
