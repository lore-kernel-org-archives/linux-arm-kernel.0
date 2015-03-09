From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 9 Mar 2015 11:48:26 +0800
Subject: [PATCH v2.0 1/6] pm: at91: pm_slowclock: create the procedure to
 handle the sdram self-refresh
In-Reply-To: <1425872857-7772-1-git-send-email-wenyou.yang@atmel.com>
References: <1425872857-7772-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1425872906-7835-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To decrease the duplicated code, create the procedure
to contain both activing and exiting the sdram self-refresh mode.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/mach-at91/pm_slowclock.S |  240 +++++++++++++++++++++----------------
 1 file changed, 137 insertions(+), 103 deletions(-)

diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
index ae86fca..517e344 100644
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -16,10 +16,10 @@
 #include <mach/hardware.h>
 #include <mach/at91_ramc.h>
 
+#define	SRAMC_SELF_FRESH_ACTIVE		0x01
+#define	SRAMC_SELF_FRESH_EXIT		0x00
+
 pmc	.req	r0
-sdramc	.req	r1
-ramc1	.req	r2
-memctrl	.req	r3
 tmp1	.req	r4
 tmp2	.req	r5
 
@@ -82,78 +82,17 @@ ENTRY(at91_slow_clock)
 	mov	tmp1, #0
 	mcr	p15, 0, tmp1, c7, c10, 4
 
-	cmp	memctrl, #AT91_MEMCTRL_MC
-	bne	ddr_sr_enable
+	str	r0, .pmc_base
+	str	r1, .sramc_base
+	str	r2, .sramc1_base
+	str	r3, .memtype
 
-	/*
-	 * at91rm9200 Memory controller
-	 */
-	/* Put SDRAM in self-refresh mode */
-	mov	tmp1, #1
-	str	tmp1, [sdramc, #AT91RM9200_SDRAMC_SRR]
-	b	sdr_sr_done
+	/* Active the self-refresh mode */
+	mov	r0, #SRAMC_SELF_FRESH_ACTIVE
+	bl	at91_sramc_self_refresh
 
-	/*
-	 * DDRSDR Memory controller
-	 */
-ddr_sr_enable:
-	cmp	memctrl, #AT91_MEMCTRL_DDRSDR
-	bne	sdr_sr_enable
+	ldr	pmc, .pmc_base
 
-	/* LPDDR1 --> force DDR2 mode during self-refresh */
-	ldr	tmp1, [sdramc, #AT91_DDRSDRC_MDR]
-	str	tmp1, .saved_sam9_mdr
-	bic	tmp1, tmp1, #~AT91_DDRSDRC_MD
-	cmp	tmp1, #AT91_DDRSDRC_MD_LOW_POWER_DDR
-	ldreq	tmp1, [sdramc, #AT91_DDRSDRC_MDR]
-	biceq	tmp1, tmp1, #AT91_DDRSDRC_MD
-	orreq	tmp1, tmp1, #AT91_DDRSDRC_MD_DDR2
-	streq	tmp1, [sdramc, #AT91_DDRSDRC_MDR]
-
-	/* prepare for DDRAM self-refresh mode */
-	ldr	tmp1, [sdramc, #AT91_DDRSDRC_LPR]
-	str	tmp1, .saved_sam9_lpr
-	bic	tmp1, #AT91_DDRSDRC_LPCB
-	orr	tmp1, #AT91_DDRSDRC_LPCB_SELF_REFRESH
-
-	/* figure out if we use the second ram controller */
-	cmp	ramc1, #0
-	beq	ddr_no_2nd_ctrl
-
-	ldr	tmp2, [ramc1, #AT91_DDRSDRC_MDR]
-	str	tmp2, .saved_sam9_mdr1
-	bic	tmp2, tmp2, #~AT91_DDRSDRC_MD
-	cmp	tmp2, #AT91_DDRSDRC_MD_LOW_POWER_DDR
-	ldreq	tmp2, [ramc1, #AT91_DDRSDRC_MDR]
-	biceq	tmp2, tmp2, #AT91_DDRSDRC_MD
-	orreq	tmp2, tmp2, #AT91_DDRSDRC_MD_DDR2
-	streq	tmp2, [ramc1, #AT91_DDRSDRC_MDR]
-
-	ldr	tmp2, [ramc1, #AT91_DDRSDRC_LPR]
-	str	tmp2, .saved_sam9_lpr1
-	bic	tmp2, #AT91_DDRSDRC_LPCB
-	orr	tmp2, #AT91_DDRSDRC_LPCB_SELF_REFRESH
-
-	/* Enable DDRAM self-refresh mode */
-	str	tmp2, [ramc1, #AT91_DDRSDRC_LPR]
-ddr_no_2nd_ctrl:
-	str	tmp1, [sdramc, #AT91_DDRSDRC_LPR]
-
-	b	sdr_sr_done
-
-	/*
-	 * SDRAMC Memory controller
-	 */
-sdr_sr_enable:
-	/* Enable SDRAM self-refresh mode */
-	ldr	tmp1, [sdramc, #AT91_SDRAMC_LPR]
-	str	tmp1, .saved_sam9_lpr
-
-	bic	tmp1, #AT91_SDRAMC_LPCB
-	orr	tmp1, #AT91_SDRAMC_LPCB_SELF_REFRESH
-	str	tmp1, [sdramc, #AT91_SDRAMC_LPR]
-
-sdr_sr_done:
 	/* Save Master clock setting */
 	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
 	str	tmp1, .saved_mckr
@@ -225,70 +164,165 @@ sdr_sr_done:
 	/*
 	 * Restore master clock setting
 	 */
-2:	ldr	tmp1, .saved_mckr
+	ldr	tmp1, .saved_mckr
 	str	tmp1, [pmc, #AT91_PMC_MCKR]
 
 	wait_mckrdy
 
+	/* Exit the self-refresh mode */
+	mov	r0, #SRAMC_SELF_FRESH_EXIT
+	bl	at91_sramc_self_refresh
+
+	/* Restore registers, and return */
+	ldmfd	sp!, {r4 - r12, pc}
+ENDPROC(at91_slow_clock)
+
+/*
+ * void at91_sramc_self_refresh(unsigned int is_active)
+ *
+ * @input param:
+ *	@r0: 1 - active self-refresh mode
+ *	     0 - exit self-refresh mode
+ * register usage:
+ * 	@r1: memory type
+ *	@r2: base address of the sram controller
+ */
+
+ENTRY(at91_sramc_self_refresh)
+	ldr	r1, .memtype
+	ldr	r2, .sramc_base
+
+	cmp	r1, #AT91_MEMCTRL_MC
+	bne	ddrc_sf
+
 	/*
 	 * at91rm9200 Memory controller
-	 * Do nothing - self-refresh is automatically disabled.
 	 */
-	cmp	memctrl, #AT91_MEMCTRL_MC
-	beq	ram_restored
+
+	 /*
+	  * For exiting the self-refresh mode, do nothing,
+	  * automatically exit the self-refresh mode.
+	  */
+	tst	r0, #SRAMC_SELF_FRESH_ACTIVE
+	beq	exit_sramc_sf
+
+	/* Active SDRAM self-refresh mode */
+	mov	r3, #1
+	str	r3, [r2, #AT91RM9200_SDRAMC_SRR]
+	b	exit_sramc_sf
+
+ddrc_sf:
+	cmp	r1, #AT91_MEMCTRL_DDRSDR
+	bne	sdramc_sf
 
 	/*
-	 * DDRSDR Memory controller
+	 * DDR Memory controller
 	 */
-	cmp	memctrl, #AT91_MEMCTRL_DDRSDR
-	bne	sdr_en_restore
+	tst	r0, #SRAMC_SELF_FRESH_ACTIVE
+	beq	ddrc_exit_sf
+
+	/* LPDDR1 --> force DDR2 mode during self-refresh */
+	ldr	r3, [r2, #AT91_DDRSDRC_MDR]
+	str	r3, .saved_sam9_mdr
+	bic	r3, r3, #~AT91_DDRSDRC_MD
+	cmp	r3, #AT91_DDRSDRC_MD_LOW_POWER_DDR
+	ldreq	r3, [r2, #AT91_DDRSDRC_MDR]
+	biceq	r3, r3, #AT91_DDRSDRC_MD
+	orreq	r3, r3, #AT91_DDRSDRC_MD_DDR2
+	streq	r3, [r2, #AT91_DDRSDRC_MDR]
+
+	/* Active DDRC self-refresh mode */
+	ldr	r3, [r2, #AT91_DDRSDRC_LPR]
+	str	r3, .saved_sam9_lpr
+	bic	r3, r3, #AT91_DDRSDRC_LPCB
+	orr	r3, r3, #AT91_DDRSDRC_LPCB_SELF_REFRESH
+	str	r3, [r2, #AT91_DDRSDRC_LPR]
+
+	/* If using the 2nd ddr controller */
+	ldr	r2, .sramc1_base
+	cmp	r2, #0
+	beq	no_2nd_ddrc
+
+	ldr	r3, [r2, #AT91_DDRSDRC_MDR]
+	str	r3, .saved_sam9_mdr1
+	bic	r3, r3, #~AT91_DDRSDRC_MD
+	cmp	r3, #AT91_DDRSDRC_MD_LOW_POWER_DDR
+	ldreq	r3, [r2, #AT91_DDRSDRC_MDR]
+	biceq	r3, r3, #AT91_DDRSDRC_MD
+	orreq	r3, r3, #AT91_DDRSDRC_MD_DDR2
+	streq	r3, [r2, #AT91_DDRSDRC_MDR]
+
+	ldr	r3, [r2, #AT91_DDRSDRC_LPR]
+	str	r3, .saved_sam9_lpr1
+	bic	r3, r3, #AT91_DDRSDRC_LPCB
+	orr	r3, r3, #AT91_DDRSDRC_LPCB_SELF_REFRESH
+
+	/* Active DDRC self-refresh mode */
+	str	r3, [r2, #AT91_DDRSDRC_LPR]
+no_2nd_ddrc:
+	b	exit_sramc_sf
+
+ddrc_exit_sf:
 	/* Restore MDR in case of LPDDR1 */
-	ldr	tmp1, .saved_sam9_mdr
-	str	tmp1, [sdramc, #AT91_DDRSDRC_MDR]
+	ldr	r3, .saved_sam9_mdr
+	str	r3, [r2, #AT91_DDRSDRC_MDR]
 	/* Restore LPR on AT91 with DDRAM */
-	ldr	tmp1, .saved_sam9_lpr
-	str	tmp1, [sdramc, #AT91_DDRSDRC_LPR]
+	ldr	r3, .saved_sam9_lpr
+	str	r3, [r2, #AT91_DDRSDRC_LPR]
 
-	/* if we use the second ram controller */
-	cmp	ramc1, #0
-	ldrne	tmp2, .saved_sam9_mdr1
-	strne	tmp2, [ramc1, #AT91_DDRSDRC_MDR]
-	ldrne	tmp2, .saved_sam9_lpr1
-	strne	tmp2, [ramc1, #AT91_DDRSDRC_LPR]
+	/* If using the 2nd ddr controller */
+	ldr	r2, .sramc1_base
+	cmp	r2, #0
+	ldrne	r3, .saved_sam9_mdr1
+	strne	r3, [r2, #AT91_DDRSDRC_MDR]
+	ldrne	r3, .saved_sam9_lpr1
+	strne	r3, [r2, #AT91_DDRSDRC_LPR]
 
-	b	ram_restored
+	b	exit_sramc_sf
 
 	/*
 	 * SDRAMC Memory controller
 	 */
-sdr_en_restore:
-	/* Restore LPR on AT91 with SDRAM */
-	ldr	tmp1, .saved_sam9_lpr
-	str	tmp1, [sdramc, #AT91_SDRAMC_LPR]
+sdramc_sf:
+	tst	r0, #SRAMC_SELF_FRESH_ACTIVE
+	beq	sdramc_exit_sf
 
-ram_restored:
-	/* Restore registers, and return */
-	ldmfd	sp!, {r4 - r12, pc}
+	/* Active SDRAMC self-refresh mode */
+	ldr	r3, [r2, #AT91_SDRAMC_LPR]
+	str	r3, .saved_sam9_lpr
+
+	bic	r3, r3, #AT91_SDRAMC_LPCB
+	orr	r3, r3, #AT91_SDRAMC_LPCB_SELF_REFRESH
+	str	r3, [r2, #AT91_SDRAMC_LPR]
+
+sdramc_exit_sf:
+	ldr	r3, .saved_sam9_lpr
+	str	r3, [r2, #AT91_SDRAMC_LPR]
 
+exit_sramc_sf:
+	mov	pc, lr
+ENDPROC(at91_sramc_self_refresh)
 
+.pmc_base:
+	.word 0
+.sramc_base:
+	.word 0
+.sramc1_base:
+	.word 0
+.memtype:
+	.word 0
 .saved_mckr:
 	.word 0
-
 .saved_pllar:
 	.word 0
-
 .saved_pllbr:
 	.word 0
-
 .saved_sam9_lpr:
 	.word 0
-
 .saved_sam9_lpr1:
 	.word 0
-
 .saved_sam9_mdr:
 	.word 0
-
 .saved_sam9_mdr1:
 	.word 0
 
-- 
1.7.9.5
