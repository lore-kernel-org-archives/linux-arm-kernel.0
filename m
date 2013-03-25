From: illia.ragozin@grapecom.com (Elijah Ragozin)
Date: Mon, 25 Mar 2013 21:43:59 +0200
Subject: [PATCH v2 1/1] ARM Feroceon: fix kexec by setting outer_cache.inv_all
Message-ID: <5150A8FF.7010301@grapecom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Feroceon the L2 cache becomes non-coherent with the CPU
when the L1 caches are disabled. Thus the L2 needs to be invalidated
after both L1 caches are disabled.

On kexec before the starting the code for relocation the kernel,
the L1 caches are disabled in cpu_froc_fin (cpu_v7_proc_fin for Feroceon),
but after L2 cache is never invalidated, because inv_all is not set
in cache-feroceon-l2.c.
So kernel relocation and decompression may has (and usually has) errors.
Setting the function enables L2 invalidation and fixes the issue.

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
+    outer_cache.inv_all = l2_inv_all;

      enable_l2();

-- 
1.8.1.4
