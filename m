From: illia.ragozin@grapecom.com (Elijah Ragozin)
Date: Sat, 23 Mar 2013 22:15:44 +0200
Subject: [PATCH] [ARM] Feroceon: fix kexec by setting outer_cache.inv_all
Message-ID: <514E0D70.3060202@grapecom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have a simple fix for kexec on Marvell Feroceon SoC.
Originally created and tested on kernel version 2.6.39.2,
but appliable for the 3.9 kernel as well.
Could you pls review. The patch is below.

From: Illia Ragozin <illia.ragozin@grapecom.com>
Subject: [PATCH] [ARM] Feroceon: fix kexec by setting outer_cache.inv_all

Before the calling kexec l2 cache must be invalidated,
this is done by outer_cache.inv_all()
For Feroceon SoC inv_all function does not set in outer_cache structure
and new kernel unpacking failed due to l2 cache still was not invalidated
at this point.

Setting outer_cache.inv_all fixes the issue.

Signed-off-by: Illia Ragozin <illia.ragozin@grapecom.com>
---
  arch/arm/mm/cache-feroceon-l2.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/cache-feroceon-l2.c 
b/arch/arm/mm/cache-feroceon-l2.c
index e0b0e7a..09f8851 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -342,6 +342,7 @@ void __init feroceon_l2_init(int __l2_wt_override)
         outer_cache.inv_range = feroceon_l2_inv_range;
         outer_cache.clean_range = feroceon_l2_clean_range;
         outer_cache.flush_range = feroceon_l2_flush_range;
+       outer_cache.inv_all = l2_inv_all;

         enable_l2();

-- 
1.8.1.4

-- 
Best Regards,
Illia Ragozin.
