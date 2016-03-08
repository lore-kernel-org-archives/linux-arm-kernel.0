From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 8 Mar 2016 09:41:59 +0800
Subject: [PATCH v4 2/5] ARM: at91: pm: add ULP1 mode support
In-Reply-To: <1457401322-29120-1-git-send-email-wenyou.yang@atmel.com>
References: <1457401322-29120-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1457401322-29120-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ULP1 (Ultra Low-power mode 1) is introduced by SAMA5D2.

In the ULP1 mode, all the clocks are shut off, inclusive the embedded
12MHz RC oscillator, so as to achieve the lowest power consumption
with the system in retention mode and able to resume on the wake up
events. As soon as the wake up event is asserted, the embedded 12MHz
RC oscillator restarts automatically.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
 - fix label pm_exit to ulp_exit.

 arch/arm/mach-at91/pm.c         |   16 ++++++-
 arch/arm/mach-at91/pm.h         |    7 +++
 arch/arm/mach-at91/pm_suspend.S |   97 +++++++++++++++++++++++++++++++++++++++
 include/linux/clk/at91_pmc.h    |    4 ++
 4 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index f062701..5c2db34 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -36,6 +36,11 @@
 #include "generic.h"
 #include "pm.h"
 
+#define ULP0_MODE	0x00
+#define ULP1_MODE	0x11
+
+#define SAMA5D2_PMC_VERSION	0x20540
+
 static void __iomem *pmc;
 
 /*
@@ -52,6 +57,7 @@ extern void at91_pinctrl_gpio_resume(void);
 static struct {
 	unsigned long uhp_udp_mask;
 	int memctrl;
+	u32 ulp_mode;
 } at91_pm_data;
 
 void __iomem *at91_ramc_base[2];
@@ -141,8 +147,11 @@ static void at91_pm_suspend(suspend_state_t state)
 {
 	unsigned int pm_data = at91_pm_data.memctrl;
 
-	pm_data |= (state == PM_SUSPEND_MEM) ?
-				AT91_PM_MODE(AT91_PM_SLOW_CLOCK) : 0;
+	if (state == PM_SUSPEND_MEM) {
+		pm_data |= AT91_PM_MODE(AT91_PM_SLOW_CLOCK);
+		if (at91_pm_data.ulp_mode == ULP1_MODE)
+			pm_data |= AT91_PM_ULP(AT91_PM_ULP1_MODE);
+	}
 
 	flush_cache_all();
 	outer_disable();
@@ -497,4 +506,7 @@ void __init sama5_pm_init(void)
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
 	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
 	at91_pm_init(NULL);
+
+	if (readl(pmc + AT91_PMC_VERSION) >= SAMA5D2_PMC_VERSION)
+		at91_pm_data.ulp_mode = ULP1_MODE;
 }
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 3fcf881..2e76745 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -39,4 +39,11 @@ extern void __iomem *at91_ramc_base[];
 
 #define	AT91_PM_SLOW_CLOCK	0x01
 
+#define AT91_PM_ULP_OFFSET	5
+#define AT91_PM_ULP_MASK	0x03
+#define AT91_PM_ULP(x)		(((x) & AT91_PM_ULP_MASK) << AT91_PM_ULP_OFFSET)
+
+#define AT91_PM_ULP0_MODE	0x00
+#define AT91_PM_ULP1_MODE	0x01
+
 #endif
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 5fcffdc..f2a5c4b 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -41,6 +41,15 @@ tmp2	.req	r5
 	.endm
 
 /*
+ * Wait for main oscillator selection is done
+ */
+	.macro wait_moscsels
+1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
+	tst	tmp1, #AT91_PMC_MOSCSELS
+	beq	1b
+	.endm
+
+/*
  * Wait until PLLA has locked.
  */
 	.macro wait_pllalock
@@ -101,6 +110,10 @@ ENTRY(at91_pm_suspend_in_sram)
 	and	r0, r0, #AT91_PM_MODE_MASK
 	str	r0, .pm_mode
 
+	lsr	r0, r3, #AT91_PM_ULP_OFFSET
+	and	r0, r0, #AT91_PM_ULP_MASK
+	str	r0, .ulp_mode
+
 	/* Active the self-refresh mode */
 	mov	r0, #SRAMC_SELF_FRESH_ACTIVE
 	bl	at91_sramc_self_refresh
@@ -131,6 +144,13 @@ ENTRY(at91_pm_suspend_in_sram)
 	orr	tmp1, tmp1, #(1 << 29)		/* bit 29 always set */
 	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
 
+	ldr	r0, .ulp_mode
+	tst	r0, #AT91_PM_ULP1_MODE
+	beq	ulp0_mode
+
+	bl	at91_pm_ulp1_mode
+	b	ulp_exit
+
 ulp0_mode:
 	bl	at91_pm_ulp0_mode
 	b	ulp_exit
@@ -326,6 +346,81 @@ ENTRY(at91_pm_ulp0_mode)
 	mov	pc, lr
 ENDPROC(at91_pm_ulp0_mode)
 
+/*
+ * void at91_pm_ulp1_mode(void)
+ */
+ENTRY(at91_pm_ulp1_mode)
+	ldr	pmc, .pmc_base
+
+	/* Switch the main clock source to 12-MHz RC oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	bic	tmp1, tmp1, #AT91_PMC_MOSCSEL
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	wait_moscsels
+
+	/* Disable the crystal oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	/* Switch the master clock source to main clock */
+	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
+	bic	tmp1, tmp1, #AT91_PMC_CSS
+	orr	tmp1, tmp1, #AT91_PMC_CSS_MAIN
+	str	tmp1, [pmc, #AT91_PMC_MCKR]
+
+	wait_mckrdy
+
+	/* Enter the ULP1 mode by set WAITMODE bit in CKGR_MOR */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	orr	tmp1, tmp1, #AT91_PMC_WAITMODE
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	wait_mckrdy
+
+	/* Enable the crystal oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	wait_moscrdy
+
+	/* Switch the master clock source to slow clock */
+	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
+	bic	tmp1, tmp1, #AT91_PMC_CSS
+	str	tmp1, [pmc, #AT91_PMC_MCKR]
+
+	wait_mckrdy
+
+	/* Switch main clock source to crystal oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	orr	tmp1, tmp1, #AT91_PMC_MOSCSEL
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	wait_moscsels
+
+	/* Switch the master clock source to main clock */
+	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
+	bic	tmp1, tmp1, #AT91_PMC_CSS
+	orr	tmp1, tmp1, #AT91_PMC_CSS_MAIN
+	str	tmp1, [pmc, #AT91_PMC_MCKR]
+
+	wait_mckrdy
+
+	mov	pc, lr
+ENDPROC(at91_pm_ulp1_mode)
+
 .pmc_base:
 	.word 0
 .sramc_base:
@@ -336,6 +431,8 @@ ENDPROC(at91_pm_ulp0_mode)
 	.word 0
 .pm_mode:
 	.word 0
+.ulp_mode:
+	.word 0
 .saved_mckr:
 	.word 0
 .saved_pllar:
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 17f413b..4afd891 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -47,8 +47,10 @@
 #define	AT91_CKGR_MOR		0x20			/* Main Oscillator Register [not on SAM9RL] */
 #define		AT91_PMC_MOSCEN		(1    <<  0)		/* Main Oscillator Enable */
 #define		AT91_PMC_OSCBYPASS	(1    <<  1)		/* Oscillator Bypass */
+#define		AT91_PMC_WAITMODE	(1    <<  2)		/* Wait Mode Command */
 #define		AT91_PMC_MOSCRCEN	(1    <<  3)		/* Main On-Chip RC Oscillator Enable [some SAM9] */
 #define		AT91_PMC_OSCOUNT	(0xff <<  8)		/* Main Oscillator Start-up Time */
+#define		AT91_PMC_KEY_MASK	(0xff << 16)
 #define		AT91_PMC_KEY		(0x37 << 16)		/* MOR Writing Key */
 #define		AT91_PMC_MOSCSEL	(1    << 24)		/* Main Oscillator Selection [some SAM9] */
 #define		AT91_PMC_CFDEN		(1    << 25)		/* Clock Failure Detector Enable [some SAM9] */
@@ -166,6 +168,8 @@
 #define		AT91_PMC_WPVS		(0x1  <<  0)		/* Write Protect Violation Status */
 #define		AT91_PMC_WPVSRC		(0xffff  <<  8)		/* Write Protect Violation Source */
 
+#define AT91_PMC_VERSION	0xfc
+
 #define AT91_PMC_PCER1		0x100			/* Peripheral Clock Enable Register 1 [SAMA5 only]*/
 #define AT91_PMC_PCDR1		0x104			/* Peripheral Clock Enable Register 1 */
 #define AT91_PMC_PCSR1		0x108			/* Peripheral Clock Enable Register 1 */
-- 
1.7.9.5
