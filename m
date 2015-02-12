From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 12 Feb 2015 10:48:50 +0800
Subject: [PATCH 5/6] pm: at91: rename function name:
 at91_slow_clock()-->at91_pm_suspend_sram_fn
In-Reply-To: <1423709123-8033-1-git-send-email-wenyou.yang@atmel.com>
References: <1423709123-8033-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1423709330-8235-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As renaming file name, rename the file name at91_slow_clock()--> at91_pm_suspend_sram_fn,
rename the function handler's name at the same time.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c         |   27 ++++++++++++++-------------
 arch/arm/mach-at91/pm_suspend.S |   26 +++++++++++---------------
 2 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index d03d6a7..722f921 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -132,13 +132,12 @@ int at91_suspend_entering_slow_clock(void)
 }
 EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
 
-
-static void (*slow_clock)(void __iomem *pmc, void __iomem *ramc0,
+static void (*at91_suspend_sram_fn)(void __iomem *pmc, void __iomem *ramc0,
 			  void __iomem *ramc1, int memctrl);
 
-extern void at91_slow_clock(void __iomem *pmc, void __iomem *ramc0,
+extern void at91_pm_suspend_in_sram(void __iomem *pmc, void __iomem *ramc0,
 			    void __iomem *ramc1, int memctrl);
-extern u32 at91_slow_clock_sz;
+extern u32 at91_pm_suspend_in_sram_sz;
 
 static void at91_pm_suspend(suspend_state_t state)
 {
@@ -147,8 +146,8 @@ static void at91_pm_suspend(suspend_state_t state)
 	pm_data |= (state == PM_SUSPEND_MEM) ?
 				AT91_PM_MODE(AT91_PM_SLOW_CLOCK) : 0;
 
-	slow_clock(at91_pmc_base, at91_ramc_base[0],
-			at91_ramc_base[1], pm_data);
+	at91_suspend_sram_fn(at91_pmc_base, at91_ramc_base[0],
+				at91_ramc_base[1], pm_data);
 }
 
 static int at91_pm_enter(suspend_state_t state)
@@ -289,21 +288,23 @@ static void __init at91_pm_sram_init(void)
 		goto put_node;
 	}
 
-	sram_base = gen_pool_alloc(sram_pool, at91_slow_clock_sz);
+	sram_base = gen_pool_alloc(sram_pool, at91_pm_suspend_in_sram_sz);
 	if (!sram_base) {
-		pr_warn("%s: unable to alloc ocram!\n", __func__);
+		pr_warn("%s: unable to alloc sram!\n", __func__);
 		goto put_node;
 	}
 
 	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
-	slow_clock = __arm_ioremap_exec(sram_pbase, at91_slow_clock_sz, false);
-	if (!slow_clock) {
+	at91_suspend_sram_fn = __arm_ioremap_exec(sram_pbase,
+					at91_pm_suspend_in_sram_sz, false);
+	if (!at91_suspend_sram_fn) {
 		pr_warn("SRAM: Could not map\n");
 		goto put_node;
 	}
 
-	/* Copy the slow_clock handler to SRAM */
-	slow_clock = fncpy(slow_clock, &at91_slow_clock, at91_slow_clock_sz);
+	/* Copy the pm suspend handler to SRAM */
+	at91_suspend_sram_fn = fncpy(at91_suspend_sram_fn,
+			&at91_pm_suspend_in_sram, at91_pm_suspend_in_sram_sz);
 
 put_node:
 	of_node_put(node);
@@ -316,7 +317,7 @@ static void __init at91_pm_init(void)
 	if (at91_cpuidle_device.dev.platform_data)
 		platform_device_register(&at91_cpuidle_device);
 
-	if (slow_clock)
+	if (at91_suspend_sram_fn)
 		suspend_set_ops(&at91_pm_ops);
 	else
 		pr_info("AT91: PM not supported, due to no SRAM allocated\n");
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index f88d04c..bebe3de 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -53,23 +53,19 @@ tmp2	.req	r5
 
 	.text
 
-/* void at91_slow_clock(void __iomem *pmc, void __iomem *sdramc,
+/*
+ * void at91_pm_suspend_in_sram(void __iomem *pmc, void __iomem *sdramc,
  *			void __iomem *ramc1, int memctrl)
+ * @input param:
+ * 	@r0: base address of AT91_PMC
+ *  	@r1: base address of SDRAM Controller (SDRAM, DDRSDR, or AT91_SYS)
+ *	@r2: base address of second SDRAM Controller or 0 if not present
+ *	@r3: pm information
  */
-ENTRY(at91_slow_clock)
+ENTRY(at91_pm_suspend_in_sram)
 	/* Save registers on stack */
 	stmfd	sp!, {r4 - r12, lr}
 
-	/*
-	 * Register usage:
-	 *  R0 = Base address of AT91_PMC
-	 *  R1 = Base address of RAM Controller (SDRAM, DDRSDR, or AT91_SYS)
-	 *  R2 = Base address of second RAM Controller or 0 if not present
-	 *  R3 = Memory controller
-	 *  R4 = temporary register
-	 *  R5 = temporary register
-	 */
-
 	/* Drain write buffer */
 	mov	tmp1, #0
 	mcr	p15, 0, tmp1, c7, c10, 4
@@ -166,7 +162,7 @@ skip_enable_main_clock:
 
 	/* Restore registers, and return */
 	ldmfd	sp!, {r4 - r12, pc}
-ENDPROC(at91_slow_clock)
+ENDPROC(at91_pm_suspend_in_sram)
 
 /*
  * void at91_sramc_self_refresh(unsigned int is_active)
@@ -317,5 +313,5 @@ ENDPROC(at91_sramc_self_refresh)
 .saved_sam9_mdr1:
 	.word 0
 
-ENTRY(at91_slow_clock_sz)
-	.word .-at91_slow_clock
+ENTRY(at91_pm_suspend_in_sram_sz)
+	.word .-at91_pm_suspend_in_sram
-- 
1.7.9.5
