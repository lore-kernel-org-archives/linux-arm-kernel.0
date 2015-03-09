From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 9 Mar 2015 11:57:52 +0800
Subject: [PATCH v2.0 2/2] pm: at91: add support to disable/enable the DDR clock
In-Reply-To: <1425873378-8253-1-git-send-email-wenyou.yang@atmel.com>
References: <1425873378-8253-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1425873472-8327-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To get the lower power consumption, disable the MPDDR controller's clock
and the DDR system clock before going to suspend, enable these clocks
after resuming.

For the SAM5D4, postpone disabling the clocks, instead of the DDR entering
the self-fresh mode immediately.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/mach-at91/pm.c         |    4 ++
 arch/arm/mach-at91/pm.h         |    9 +++++
 arch/arm/mach-at91/pm_suspend.S |   83 +++++++++++++++++++++++++++++++++++++++
 include/linux/clk/at91_pmc.h    |    1 +
 4 files changed, 97 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index e162bdf..0b15ede 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -136,6 +136,10 @@ static void at91_pm_suspend(suspend_state_t state)
 	pm_data |= (state == PM_SUSPEND_MEM) ?
 				AT91_PM_MODE(AT91_PM_SLOW_CLOCK) : 0;
 
+	pm_data |= AT91_PM_DDRC_PID(at91_pm_data.ddrc_pid);
+	pm_data |= at91_pm_data.is_sama5d4 ?
+			AT91_PM_IS_SAMA5D4(AT91_PM_SAMA5D4_BIT) : 0;
+
 	flush_cache_all();
 	outer_disable();
 
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index dcacfa1..b9183e3 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -23,6 +23,15 @@
 
 #define	AT91_PM_SLOW_CLOCK	0x01
 
+#define	AT91_PM_DDRC_PID_MASK	0xff
+#define	AT91_PM_DDRC_PID_OFFSET	8
+#define	AT91_PM_DDRC_PID(x)	(((x) & AT91_PM_DDRC_PID_MASK) << AT91_PM_DDRC_PID_OFFSET)
+
+#define	AT91_PM_SAMA5D4_MASK	0x01
+#define	AT91_PM_SAMA5D4_OFFSET	24
+#define	AT91_PM_IS_SAMA5D4(x)	(((x) & AT91_PM_SAMA5D4_MASK) << AT91_PM_SAMA5D4_OFFSET)
+#define	AT91_PM_SAMA5D4_BIT	0x01
+
 /*
  * The AT91RM9200 goes into self-refresh mode with this command, and will
  * terminate self-refresh automatically on the next SDRAM access.
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 95c3404..6c3e533 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -20,6 +20,9 @@
 #define	SRAMC_SELF_FRESH_ACTIVE		0x01
 #define	SRAMC_SELF_FRESH_EXIT		0x00
 
+#define	DDR_CLOCK_ENABLE		0x01
+#define	DDR_CLOCK_DISABLE		0x00
+
 pmc	.req	r0
 tmp1	.req	r4
 tmp2	.req	r5
@@ -108,10 +111,28 @@ ENTRY(at91_pm_suspend_in_sram)
 	and	r0, r0, #AT91_PM_MODE_MASK
 	str	r0, .pm_mode
 
+	lsr	r0, r3, #AT91_PM_DDRC_PID_OFFSET
+	and	r0, r0, #AT91_PM_DDRC_PID_MASK
+	str	r0, .ddrc_pid
+
+	lsr	r0, r3, #AT91_PM_SAMA5D4_MASK
+	and	r0, r0, #AT91_PM_SAMA5D4_OFFSET
+	str	r0, .sama5d4_bit
+
 	/* Active the self-refresh mode */
 	mov	r0, #SRAMC_SELF_FRESH_ACTIVE
 	bl	at91_sramc_self_refresh
 
+	/* If the cpu isn't sama5d4, disable the ddr clock here */
+	ldr	r0, .sama5d4_bit
+	tst	r0, #AT91_PM_SAMA5D4_BIT
+	bne	skip_ddr_clock
+
+	/* Disable DDR clock */
+	mov	r0, #DDR_CLOCK_DISABLE
+	bl	at91_ddr_clock
+
+skip_ddr_clock:
 	ldr	r0, .pm_mode
 	tst	r0, #AT91_PM_SLOW_CLOCK
 	beq	skip_disable_main_clock
@@ -151,6 +172,15 @@ ENTRY(at91_pm_suspend_in_sram)
 	orr	tmp1, tmp1, #AT91_PMC_KEY
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
 
+	/* If the cpu is the sama5d4, disable the ddr clock here */
+	ldr	r0, .sama5d4_bit
+	tst	r0, #AT91_PM_SAMA5D4_BIT
+	beq	skip_disable_main_clock
+
+	/* Disable DDR clock */
+	mov	r0, #DDR_CLOCK_DISABLE
+	bl	at91_ddr_clock
+
 skip_disable_main_clock:
 	ldr	pmc, .pmc_base
 
@@ -204,6 +234,10 @@ skip_disable_main_clock:
 	wait_mckrdy
 
 skip_enable_main_clock:
+	/* Enable DDR clock */
+	mov	r0, #DDR_CLOCK_ENABLE
+	bl	at91_ddr_clock
+
 	/* Exit the self-refresh mode */
 	mov	r0, #SRAMC_SELF_FRESH_EXIT
 	bl	at91_sramc_self_refresh
@@ -338,6 +372,51 @@ exit_sramc_sf:
 	mov	pc, lr
 ENDPROC(at91_sramc_self_refresh)
 
+/*
+ * void at91_ddr_clock(unsigned char is_enable)
+ *
+ * @input param
+ *	@r0: 0x01 - enable DDR clock
+ *	     0x00 - disable DDR clock
+ * register usage:
+ * 	@r1: ddrc peripheral id
+ *	@r2: base address of the pmc
+ */
+ENTRY(at91_ddr_clock)
+	ldr	r1, .ddrc_pid
+	ldr	r2, .pmc_base
+
+	/* DDRC peripheral clock */
+	cmp	r1, #0
+	beq	ddr_sys_clk
+
+	and	r1, r1, #AT91_PMC_PCR_PID
+	orr	r1, r1, #AT91_PMC_PCR_CMD
+
+	tst	r0, #DDR_CLOCK_ENABLE
+	beq	ddrc_clk
+	orr	r1, r1, #AT91_PMC_PCR_EN
+
+ddrc_clk:
+	str	r1, [r2, #AT91_PMC_PCR]
+
+ddr_sys_clk:
+	/* DDR system clock */
+	mov 	r3, #AT91_PMC_SYS_DDR
+
+	tst	r0, #DDR_CLOCK_ENABLE
+	beq	disable_sys_clk
+
+	str	r3, [r2, #AT91_PMC_SCER]
+	b	exit_ddr_clock
+
+disable_sys_clk:
+	str	r3, [r2, #AT91_PMC_SCDR]
+
+exit_ddr_clock:
+	mov	pc, lr
+ENDPROC(at91_ddr_clock)
+
 .pmc_base:
 	.word 0
 .sramc_base:
@@ -348,6 +427,10 @@ ENDPROC(at91_sramc_self_refresh)
 	.word 0
 .pm_mode:
 	.word 0
+.ddrc_pid:
+	.word 0
+.sama5d4_bit:
+	.word 0
 .saved_mckr:
 	.word 0
 .saved_pllar:
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index c8e3b3d..10d2913 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -36,6 +36,7 @@ extern void __iomem *at91_pmc_base;
 #define		AT91RM9200_PMC_UDP	(1 <<  1)		/* USB Devcice Port Clock [AT91RM9200 only] */
 #define		AT91RM9200_PMC_MCKUDP	(1 <<  2)		/* USB Device Port Master Clock Automatic Disable on Suspend [AT91RM9200 only] */
 #define		AT91RM9200_PMC_UHP	(1 <<  4)		/* USB Host Port Clock [AT91RM9200 only] */
+#define		AT91_PMC_SYS_DDR	(1 <<  2)		/* DDR clock[some SAM9 and SAMA5D only] */
 #define		AT91SAM926x_PMC_UHP	(1 <<  6)		/* USB Host Port Clock [AT91SAM926x only] */
 #define		AT91SAM926x_PMC_UDP	(1 <<  7)		/* USB Devcice Port Clock [AT91SAM926x only] */
 #define		AT91_PMC_PCK0		(1 <<  8)		/* Programmable Clock 0 */
-- 
1.7.9.5
