From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Sep 2013 19:17:49 -0400
Subject: [PATCH 06/13] ARM: mcpm: add a simple poke mechanism to the early
 entry code
In-Reply-To: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
References: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1379978276-31241-7-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows to poke a predetermined value into a specific address
upon entering the early boot code in bL_head.S.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/mcpm_entry.c | 12 ++++++++++++
 arch/arm/common/mcpm_head.S  | 16 ++++++++++++++--
 arch/arm/include/asm/mcpm.h  |  8 ++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index 370236dd1a..4a2b32fd53 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -27,6 +27,18 @@ void mcpm_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr)
 	sync_cache_w(&mcpm_entry_vectors[cluster][cpu]);
 }
 
+extern unsigned long mcpm_entry_early_pokes[MAX_NR_CLUSTERS][MAX_CPUS_PER_CLUSTER][2];
+
+void mcpm_set_early_poke(unsigned cpu, unsigned cluster,
+			 unsigned long poke_phys_addr, unsigned long poke_val)
+{
+	unsigned long *poke = &mcpm_entry_early_pokes[cluster][cpu][0];
+	poke[0] = poke_phys_addr;
+	poke[1] = poke_val;
+	__cpuc_flush_dcache_area((void *)poke, 8);
+	outer_clean_range(__pa(poke), __pa(poke + 2));
+}
+
 static const struct mcpm_platform_ops *platform_ops;
 
 int __init mcpm_platform_register(const struct mcpm_platform_ops *ops)
diff --git a/arch/arm/common/mcpm_head.S b/arch/arm/common/mcpm_head.S
index 39c96df347..49dd5352fe 100644
--- a/arch/arm/common/mcpm_head.S
+++ b/arch/arm/common/mcpm_head.S
@@ -71,12 +71,19 @@ ENTRY(mcpm_entry_point)
 	 * position independent way.
 	 */
 	adr	r5, 3f
-	ldmia	r5, {r6, r7, r8, r11}
+	ldmia	r5, {r0, r6, r7, r8, r11}
+	add	r0, r5, r0			@ r0 = mcpm_entry_early_pokes
 	add	r6, r5, r6			@ r6 = mcpm_entry_vectors
 	ldr	r7, [r5, r7]			@ r7 = mcpm_power_up_setup_phys
 	add	r8, r5, r8			@ r8 = mcpm_sync
 	add	r11, r5, r11			@ r11 = first_man_locks
 
+	@ Perform an early poke, if any
+	add	r0, r0, r4, lsl #3
+	ldmia	r0, {r0, r1}
+	teq	r0, #0
+	strne	r1, [r0]
+
 	mov	r0, #MCPM_SYNC_CLUSTER_SIZE
 	mla	r8, r0, r10, r8			@ r8 = sync cluster base
 
@@ -195,7 +202,8 @@ mcpm_entry_gated:
 
 	.align	2
 
-3:	.word	mcpm_entry_vectors - .
+3:	.word	mcpm_entry_early_pokes - .
+	.word	mcpm_entry_vectors - 3b
 	.word	mcpm_power_up_setup_phys - 3b
 	.word	mcpm_sync - 3b
 	.word	first_man_locks - 3b
@@ -214,6 +222,10 @@ first_man_locks:
 ENTRY(mcpm_entry_vectors)
 	.space	4 * MAX_NR_CLUSTERS * MAX_CPUS_PER_CLUSTER
 
+	.type	mcpm_entry_early_pokes, #object
+ENTRY(mcpm_entry_early_pokes)
+	.space	8 * MAX_NR_CLUSTERS * MAX_CPUS_PER_CLUSTER
+
 	.type	mcpm_power_up_setup_phys, #object
 ENTRY(mcpm_power_up_setup_phys)
 	.space  4		@ set by mcpm_sync_init()
diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index 0f7b7620e9..7626a7fd49 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -42,6 +42,14 @@ extern void mcpm_entry_point(void);
 void mcpm_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr);
 
 /*
+ * This sets an early poke i.e a value to be poked into some address
+ * from very early assembly code before the CPU is ungated.  The
+ * address must be physical, and if 0 then nothing will happen.
+ */
+void mcpm_set_early_poke(unsigned cpu, unsigned cluster,
+			 unsigned long poke_phys_addr, unsigned long poke_val);
+
+/*
  * CPU/cluster power operations API for higher subsystems to use.
  */
 
-- 
1.8.4.98.gb022869
