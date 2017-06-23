From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 23 Jun 2017 10:52:23 -0700
Subject: [PATCH v2 3/7] ARM: Hook B15 readahead cache functions based on
 processor
In-Reply-To: <20170623175227.19743-1-f.fainelli@gmail.com>
References: <20170623175227.19743-1-f.fainelli@gmail.com>
Message-ID: <20170623175227.19743-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we detect that we are running on a Broadcom Brahma-B15 CPU, and
CONFIG_CACHE_B15_RAC is enabled, make sure that we pick-up the
b15_cache_fns function operations.

If CONFIG_CACHE_B15_RAC is enabled, but we are not running on a Broadcom
Brahma-B15 CPU, we will fallback to calling into the regular
v7_cache_fns with no cost. If CONFIG_CACHE_B15_RAC is disabled, there is
no cost and we just use the regular v7_cache_fns.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/cache-v7.S | 21 +++++++++++++++++++++
 arch/arm/mm/proc-v7.S  |  2 +-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index de78109d002d..215df435bfb9 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -15,6 +15,7 @@
 #include <asm/assembler.h>
 #include <asm/errno.h>
 #include <asm/unwind.h>
+#include <asm/hardware/cache-b15-rac.h>
 
 #include "proc-macros.S"
 
@@ -446,3 +447,23 @@ ENDPROC(v7_dma_unmap_area)
 
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
 	define_cache_functions v7
+
+	/* The Broadcom Brahma-B15 read-ahead cache requires some modifications
+	 * to the v7_cache_fns, we only override the ones we need
+	 */
+#ifndef CONFIG_CACHE_B15_RAC
+	globl_equ	b15_flush_kern_cache_all,	v7_flush_kern_cache_all
+#endif
+	globl_equ	b15_flush_icache_all,		v7_flush_icache_all
+	globl_equ	b15_flush_kern_cache_louis,	v7_flush_kern_cache_louis
+	globl_equ	b15_flush_user_cache_all,	v7_flush_user_cache_all
+	globl_equ	b15_flush_user_cache_range,	v7_flush_user_cache_range
+	globl_equ	b15_coherent_kern_range,	v7_coherent_kern_range
+	globl_equ	b15_coherent_user_range,	v7_coherent_user_range
+	globl_equ	b15_flush_kern_dcache_area,	v7_flush_kern_dcache_area
+
+	globl_equ	b15_dma_map_area,		v7_dma_map_area
+	globl_equ	b15_dma_unmap_area,		v7_dma_unmap_area
+	globl_equ	b15_dma_flush_range,		v7_dma_flush_range
+
+	define_cache_functions b15
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 812ac861cd23..d55d493f9a1e 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -678,7 +678,7 @@ __v7_ca15mp_proc_info:
 __v7_b15mp_proc_info:
 	.long	0x420f00f0
 	.long	0xff0ffff0
-	__v7_proc __v7_b15mp_proc_info, __v7_b15mp_setup
+	__v7_proc __v7_b15mp_proc_info, __v7_b15mp_setup, cache_fns = b15_cache_fns
 	.size	__v7_b15mp_proc_info, . - __v7_b15mp_proc_info
 
 	/*
-- 
2.9.3
