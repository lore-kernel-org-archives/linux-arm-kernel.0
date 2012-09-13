From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 13 Sep 2012 11:20:48 +0100
Subject: [RFC PATCH 3/6] ARM: mm: add v7 dcache level API
In-Reply-To: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1347531651-28218-4-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

On ARMv7 based SOC with an integrated L2 cache, there is a need
to have a flush API to operate on each cache level. In few low
power modes, L2 cache is retained whereas L1 is lost. The current
v7_flush_dcache_all(), flushes all the levels and it would be quite
expensive in cases where only one of the level needs to be flushed.

So this patch introduces v7_flush_dcache_level() API which takes a
parameter (cache level), and flush only that level.
This API is useful for the power management code where depending on CPU
and CPU cluster low power state, a specific cache level can be cleaned
instead of cleaning all the cache levels with existing flush_dcache_all().

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/mm/cache-v7.S | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 74aec79..d0fbe5c 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -51,6 +51,26 @@ ENTRY(v7_flush_dcache_louis)
 	b	__flush_level
 ENDPROC(v7_flush_dcache_louis)
 
+ /*
+ *     v7_flush_dcache_level(level)
+ *
+ *     Flush the D-cache the specified level passed as input parameter.
+ *
+ *     r0 - cache level
+ *
+ *     Corrupted registers: r0-r7, r9-r11 (r6 only in Thumb mode)
+ */
+
+ENTRY(v7_flush_dcache_level)
+	dmb					@ ensure ordering with previous memory accesses
+	sub	r10, r0, #1
+	mov	r10, r10, lsl #1
+	movs	r3, r0, lsl #1			@ level * 2
+	mrc	p15, 1, r0, c0, c0, 1		@ read clidr
+	moveq	pc, lr				@ return if level == 0
+	b	__flush_level
+ENDPROC(v7_flush_dcache_level)
+
 /*
  *	v7_flush_dcache_all()
  *
-- 
1.7.12
