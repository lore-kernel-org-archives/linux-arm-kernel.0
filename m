From: digetx@gmail.com (Dmitry Osipenko)
Date: Thu, 30 Aug 2018 21:04:21 +0300
Subject: [PATCH v3 8/8] ARM: tegra: Add firmware calls required for
 suspend-resume
In-Reply-To: <20180830180421.6415-1-digetx@gmail.com>
References: <20180830180421.6415-1-digetx@gmail.com>
Message-ID: <20180830180421.6415-9-digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to resume CPU from suspend via trusted Foundations firmware,
the LP1/LP2 boot vectors shall be specified using the firmware calls.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c            |  7 ++++++
 arch/arm/mach-tegra/reset-handler.S | 33 +++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 66c8cd63dd86..12341ffabb99 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -33,6 +33,7 @@
 #include <soc/tegra/pmc.h>
 
 #include <asm/cacheflush.h>
+#include <asm/firmware.h>
 #include <asm/idmap.h>
 #include <asm/proc-fns.h>
 #include <asm/smp_plat.h>
@@ -150,6 +151,10 @@ bool tegra_set_cpu_in_lp2(void)
 		tegra20_cpu_set_resettable_soon();
 
 	spin_unlock(&tegra_lp2_lock);
+
+	if (last_cpu)
+		call_firmware_op(prepare_idle, TF_PM_MODE_LP2);
+
 	return last_cpu;
 }
 
@@ -316,6 +321,8 @@ static void tegra_suspend_enter_lp1(void)
 		tegra_lp1_iram.start_addr, iram_save_size);
 
 	*((u32 *)tegra_cpu_lp1_mask) = 1;
+
+	call_firmware_op(prepare_idle, TF_PM_MODE_LP1);
 }
 
 static void tegra_suspend_exit_lp1(void)
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 4973ea053bd7..0e208b2e246e 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -69,7 +69,7 @@ ENTRY(tegra_resume)
 
 	mov32	r9, 0xc09
 	cmp	r8, r9
-	bne	end_ca9_scu_resume
+	bne	end_ca9_scu_l2_resume
 #ifdef CONFIG_HAVE_ARM_SCU
 	/* enable SCU */
 	mov32	r0, TEGRA_ARM_PERIF_BASE
@@ -77,14 +77,43 @@ ENTRY(tegra_resume)
 	orr	r1, r1, #1
 	str	r1, [r0]
 #endif
+	bl	tegra_resume_trusted_foundations
 
-end_ca9_scu_resume:
+#ifdef CONFIG_CACHE_L2X0
+	/* L2 cache resume & re-enable */
+	bleq	l2c310_early_resume		@ No, resume cache early
+#endif
+end_ca9_scu_l2_resume:
 	mov32	r9, 0xc0f
 	cmp	r8, r9
 	bleq	tegra_init_l2_for_a15
 
 	b	cpu_resume
 ENDPROC(tegra_resume)
+
+/*
+ *	tegra_resume_trusted_foundations
+ *
+ *	  Trusted Foundations firmware initialization.
+ *
+ *	Doesn't return if firmware presents.
+ *	Corrupted registers: r1, r2
+ */
+ENTRY(tegra_resume_trusted_foundations)
+	/* Check whether Trusted Foundations firmware presents. */
+	mov32	r2, TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET
+	ldr	r1, =__tegra_cpu_reset_handler_data_offset + \
+							RESET_DATA(TF_PRESENT)
+	ldr	r1, [r2, r1]
+	cmp	r1, #0
+	reteq	lr
+
+ .arch_extension sec
+	/* First call after suspend wakes firmware. No arguments required. */
+	smc	#0
+
+	b	cpu_resume
+ENDPROC(tegra_resume_trusted_foundations)
 #endif
 
 	.align L1_CACHE_SHIFT
-- 
2.18.0
