From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 15 Oct 2015 11:41:07 +0800
Subject: [PATCH 2/2] ARM: at91/pm: add ultra Low-power mode 1(ULP1) support
In-Reply-To: <1444880467-18598-1-git-send-email-wenyou.yang@atmel.com>
References: <1444880467-18598-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1444880467-18598-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ultra Low-power mode 1(ULP1) is introduced by SAMA5D2.

In the ULP1 mode, all the clocks are shut off, inclusive the embedded
12MHz RC oscillator, so as to achieve the lowest power consumption
with the system in retention mode and able to resume on the wake up
events. As soon as the wake up event is asserted, the embedded 12MHz
RC oscillator restarts automatically.

The number of wake up sources for the ULP1 mode is limited, the wake
up sources should be configured via the PMC_FSMR and PMC_FSPR
registers.

In this patch, the following wake up sources are enabled,
 - WKUP0 pin
 - WKUP1 pin to WKUP8 pin (shared with PIOBU0 to PIOBU7)
 - RTC alarm

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 arch/arm/mach-at91/pm.c         |   29 ++++++++++
 arch/arm/mach-at91/pm.h         |    7 +++
 arch/arm/mach-at91/pm_suspend.S |  111 +++++++++++++++++++++++++++++++++++++++
 include/linux/clk/at91_pmc.h    |   36 +++++++++++++
 4 files changed, 183 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 80e277c..49443d9 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -35,6 +35,11 @@
 #include "generic.h"
 #include "pm.h"
 
+#define ULP0_MODE	0x00
+#define ULP1_MODE	0x11
+
+#define SAMA5D2_PMC_VERSION	0x20540
+
 /*
  * FIXME: this is needed to communicate between the pinctrl driver and
  * the PM implementation in the machine. Possibly part of the PM
@@ -64,6 +69,23 @@ static int at91_pm_valid_state(suspend_state_t state)
 	}
 }
 
+static void at91_config_ulp1_wkup_source(void)
+{
+	if (at91_pmc_read(AT91_PMC_VERSION) >= SAMA5D2_PMC_VERSION) {
+		at91_pmc_write(AT91_PMC_FSMR, AT91_PMC_RTCAL |
+					      AT91_PMC_FSTT9 |
+					      AT91_PMC_FSTT8 |
+					      AT91_PMC_FSTT7 |
+					      AT91_PMC_FSTT6 |
+					      AT91_PMC_FSTT5 |
+					      AT91_PMC_FSTT4 |
+					      AT91_PMC_FSTT3 |
+					      AT91_PMC_FSTT2 |
+					      AT91_PMC_FSTT0);
+
+		at91_pmc_write(AT91_PMC_FSPR, 0);
+	}
+}
 
 static suspend_state_t target_state;
 
@@ -73,6 +95,9 @@ static suspend_state_t target_state;
 static int at91_pm_begin(suspend_state_t state)
 {
 	target_state = state;
+
+	at91_config_ulp1_wkup_source();
+
 	return 0;
 }
 
@@ -140,6 +165,10 @@ static void at91_pm_suspend(suspend_state_t state)
 	pm_data |= (state == PM_SUSPEND_MEM) ?
 				AT91_PM_MODE(AT91_PM_SLOW_CLOCK) : 0;
 
+	pm_data |= ((state == PM_SUSPEND_MEM) &&
+		    (at91_pmc_read(AT91_PMC_VERSION) >= SAMA5D2_PMC_VERSION)) ?
+		    AT91_PM_ULP(AT91_PM_ULP1_MODE) : 0;
+
 	flush_cache_all();
 	outer_disable();
 
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
index 825347b..543c430 100644
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
@@ -99,6 +108,10 @@ ENTRY(at91_pm_suspend_in_sram)
 	and	r0, r0, #AT91_PM_MODE_MASK
 	str	r0, .pm_mode
 
+	lsr	r0, r3, #AT91_PM_ULP_OFFSET
+	and	r0, r0, #AT91_PM_ULP_MASK
+	str	r0, .ulp_mode
+
 	/* Active the self-refresh mode */
 	mov	r0, #SRAMC_SELF_FRESH_ACTIVE
 	bl	at91_sramc_self_refresh
@@ -107,6 +120,14 @@ ENTRY(at91_pm_suspend_in_sram)
 	tst	r0, #AT91_PM_SLOW_CLOCK
 	beq	standby_mode
 
+	ldr	r0, .ulp_mode
+	tst	r0, #AT91_PM_ULP1_MODE
+	beq	ulp0_mode
+
+ulp1_mode:
+	bl	at91_pm_ulp1_mode
+	b	pm_exit
+
 ulp0_mode:
 	bl	at91_pm_ulp0_mode
 	b	pm_exit
@@ -313,6 +334,94 @@ ENTRY(at91_pm_ulp0_mode)
 	mov	pc, lr
 ENDPROC(at91_pm_ulp0_mode)
 
+/*
+ * void at91_pm_ulp1_mode(void)
+ *
+ */
+ENTRY(at91_pm_ulp1_mode)
+	ldr	pmc, .pmc_base
+
+	/* Save PMC_MCKR config */
+	ldr	tmp1, [pmc, #AT91_PMC_MCKR]
+	str	tmp1, .saved_mckr
+
+	/* Switch the master clock source to main clock */
+	bic	tmp1, tmp1, #AT91_PMC_CSS
+	orr	tmp1, tmp1, #AT91_PMC_CSS_MAIN
+	str	tmp1, [pmc, #AT91_PMC_MCKR]
+
+	wait_mckrdy
+
+	/* Save PLLA config, then and disable PLLA */
+	ldr	tmp1, [pmc, #AT91_CKGR_PLLAR]
+	str	tmp1, .saved_pllar
+
+	bic	tmp1, tmp1, #AT91_PMC3_MUL
+	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
+
+	/* Switch main clock to 12-MHz RC oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	bic	tmp1, tmp1, #AT91_PMC_MOSCSEL
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	bic	tmp1, tmp1, #(7 << 4)
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	wait_moscsels
+
+	/* Disable the main oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	bic	tmp1, tmp1, #(7 << 4)
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	/* Enter the ULP1 mode by setting WAITMODE bit in CKGR_MOR */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	orr	tmp1, tmp1, #AT91_PMC_WAITMODE
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	bic	tmp1, tmp1, #(7 << 4)
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	wait_mckrdy
+
+	/* Enable the main oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	bic	tmp1, tmp1, #(7 << 4)
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	wait_moscrdy
+
+	/* Switch main clock to the main oscillator */
+	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
+	orr	tmp1, tmp1, #AT91_PMC_MOSCSEL
+	bic	tmp1, tmp1, #AT91_PMC_KEY_MASK
+	orr	tmp1, tmp1, #AT91_PMC_KEY
+	bic	tmp1, tmp1, #(7 << 4)
+	str	tmp1, [pmc, #AT91_CKGR_MOR]
+
+	wait_moscsels
+
+	/* Restore PLLA config */
+	ldr	tmp1, .saved_pllar
+	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
+
+	wait_pllalock
+
+	/* Restore PMC_MCKR config */
+	ldr	tmp1, .saved_mckr
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
@@ -323,6 +432,8 @@ ENDPROC(at91_pm_ulp0_mode)
 	.word 0
 .pm_mode:
 	.word 0
+.ulp_mode:
+	.word 0
 .saved_mckr:
 	.word 0
 .saved_pllar:
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 7669f76..3dc4e60 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -59,8 +59,10 @@ extern void __iomem *at91_pmc_base;
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
@@ -166,6 +168,38 @@ extern void __iomem *at91_pmc_base;
 #define		AT91_PMC_CFDEV		(1 << 18)		/* Clock Failure Detector Event [some SAM9] */
 #define	AT91_PMC_IMR		0x6c			/* Interrupt Mask Register */
 
+#define AT91_PMC_FSMR		0x70			/* Fast Startup Mode Register */
+#define		AT91_PMC_FSTT0		(1 << 0)		/* Fast Startup from WKUP Pin Enable */
+#define		AT91_PMC_FSTT1		(1 << 1)		/* Fast Startup from Security Module Enable */
+#define		AT91_PMC_FSTT2		(1 << 2)		/* Fast Startup from PIOBU0 Input Enable */
+#define		AT91_PMC_FSTT3		(1 << 3)		/* Fast Startup from PIOBU1 Input Enable */
+#define		AT91_PMC_FSTT4		(1 << 4)		/* Fast Startup from PIOBU2 Input Enable */
+#define		AT91_PMC_FSTT5		(1 << 5)		/* Fast Startup from PIOBU3 Input Enable */
+#define		AT91_PMC_FSTT6		(1 << 6)		/* Fast Startup from PIOBU4 Input Enable */
+#define		AT91_PMC_FSTT7		(1 << 7)		/* Fast Startup from PIOBU5 Input Enable */
+#define		AT91_PMC_FSTT8		(1 << 8)		/* Fast Startup from PIOBU6 Input Enable */
+#define		AT91_PMC_FSTT9		(1 << 9)		/* Fast Startup from PIOBU7 Input Enable */
+#define		AT91_PMC_FSTT10		(1 << 10)		/* Fast Startup from GMAC Wake-up On LAN Enable */
+#define		AT91_PMC_RTCAL		(1 << 17)		/* Fast Startup from RTC Alarm Enable */
+#define		AT91_PMC_USBAL		(1 << 18)		/* Fast Startup from USB Resume Enable */
+#define		AT91_PMC_SDMMC_CD	(1 << 19)		/* Fast Startup from SDMMC Card Detect Enable */
+#define		AT91_PMC_LPM		(1 << 20)		/* Low-power Mode */
+#define		AT91_PMC_RXLP_MCE	(1 << 24)		/* Fast Startup from Backup UART Receive Match Condition Enable */
+#define		AT91_PMC_ACC_CE		(1 << 25)		/* Fast Startup from Analog Comparator Controller Comparison Enable*/
+
+#define AT91_PMC_FSPR		0x74			/* Fast Startup Polarity Register */
+#define		AT91_PMC_FSTP0		(1 << 0)		/* WKUP Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP1		(1 << 1)		/* Security Module Polarity for Fast Startup */
+#define		AT91_PMC_FSTP2		(1 << 2)		/* PIOBU0 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP3		(1 << 3)		/* PIOBU1 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP4		(1 << 4)		/* PIOBU2 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP5		(1 << 5)		/* PIOBU3 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP6		(1 << 6)		/* PIOBU4 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP7		(1 << 7)		/* PIOBU5 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP8		(1 << 8)		/* PIOBU6 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP9		(1 << 9)		/* PIOBU7 Pin Polarity for Fast Startup */
+#define		AT91_PMC_FSTP10		(1 << 10)		/* GMAC Wake-up On LAN Polarity for Fast Startup */
+
 #define AT91_PMC_PLLICPR	0x80			/* PLL Charge Pump Current Register */
 
 #define AT91_PMC_PROT		0xe4			/* Write Protect Mode Register [some SAM9] */
@@ -177,6 +211,8 @@ extern void __iomem *at91_pmc_base;
 #define		AT91_PMC_WPVS		(0x1  <<  0)		/* Write Protect Violation Status */
 #define		AT91_PMC_WPVSRC		(0xffff  <<  8)		/* Write Protect Violation Source */
 
+#define AT91_PMC_VERSION	0xfc
+
 #define AT91_PMC_PCER1		0x100			/* Peripheral Clock Enable Register 1 [SAMA5 only]*/
 #define AT91_PMC_PCDR1		0x104			/* Peripheral Clock Enable Register 1 */
 #define AT91_PMC_PCSR1		0x108			/* Peripheral Clock Enable Register 1 */
-- 
1.7.9.5
