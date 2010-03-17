From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 17 Mar 2010 15:42:53 -0400
Subject: [PATCH] [ARM] mmp: support ssp in pxa168
Message-ID: <mailman.249.1269014005.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support ssp devices in PXA168. PXA168 could reuse the code of PXA SSP.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/irqs.h      |   10 +++---
 arch/arm/mach-mmp/include/mach/pxa168.h    |   21 ++++++++++++
 arch/arm/mach-mmp/include/mach/regs-apbc.h |   10 +++---
 arch/arm/mach-mmp/include/mach/regs-mpmu.h |   48 ++++++++++++++++++++++++++++
 arch/arm/mach-mmp/pxa168.c                 |   15 +++++++++
 arch/arm/plat-pxa/include/plat/ssp.h       |    1 +
 arch/arm/plat-pxa/ssp.c                    |    1 +
 7 files changed, 96 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/regs-mpmu.h

diff --git a/arch/arm/mach-mmp/include/mach/irqs.h
b/arch/arm/mach-mmp/include/mach/irqs.h
index 0270119..b379cde 100644
--- a/arch/arm/mach-mmp/include/mach/irqs.h
+++ b/arch/arm/mach-mmp/include/mach/irqs.h
@@ -5,10 +5,10 @@
  * Interrupt numbers for PXA168
  */
 #define IRQ_PXA168_NONE			(-1)
-#define IRQ_PXA168_SSP3			0
-#define IRQ_PXA168_SSP2			1
-#define IRQ_PXA168_SSP1			2
-#define IRQ_PXA168_SSP0			3
+#define IRQ_PXA168_SSP4			0
+#define IRQ_PXA168_SSP3			1
+#define IRQ_PXA168_SSP2			2
+#define IRQ_PXA168_SSP1			3
 #define IRQ_PXA168_PMIC_INT		4
 #define IRQ_PXA168_RTC_INT		5
 #define IRQ_PXA168_RTC_ALARM		6
@@ -20,7 +20,7 @@
 #define IRQ_PXA168_TIMER2		14
 #define IRQ_PXA168_TIMER3		15
 #define IRQ_PXA168_CMU			16
-#define IRQ_PXA168_SSP4			17
+#define IRQ_PXA168_SSP5			17
 #define IRQ_PXA168_MSP_WAKEUP		19
 #define IRQ_PXA168_CF_WAKEUP		20
 #define IRQ_PXA168_XD_WAKEUP		21
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h
b/arch/arm/mach-mmp/include/mach/pxa168.h
index 3ad612c..3b2bd5d 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -14,6 +14,11 @@ extern struct pxa_device_desc pxa168_device_pwm1;
 extern struct pxa_device_desc pxa168_device_pwm2;
 extern struct pxa_device_desc pxa168_device_pwm3;
 extern struct pxa_device_desc pxa168_device_pwm4;
+extern struct pxa_device_desc pxa168_device_ssp1;
+extern struct pxa_device_desc pxa168_device_ssp2;
+extern struct pxa_device_desc pxa168_device_ssp3;
+extern struct pxa_device_desc pxa168_device_ssp4;
+extern struct pxa_device_desc pxa168_device_ssp5;
 extern struct pxa_device_desc pxa168_device_nand;

 static inline int pxa168_add_uart(int id)
@@ -67,6 +72,22 @@ static inline int pxa168_add_pwm(int id)
 	return pxa_register_device(d, NULL, 0);
 }

+static inline int pxa168_add_ssp(int id)
+{
+	struct pxa_device_desc *d = NULL;
+
+	switch (id) {
+	case 1: d = &pxa168_device_ssp1; break;
+	case 2: d = &pxa168_device_ssp2; break;
+	case 3: d = &pxa168_device_ssp3; break;
+	case 4: d = &pxa168_device_ssp4; break;
+	case 5: d = &pxa168_device_ssp5; break;
+	default:
+		return -EINVAL;
+	}
+	return pxa_register_device(d, NULL, 0);
+}
+
 static inline int pxa168_add_nand(struct pxa3xx_nand_platform_data *info)
 {
 	return pxa_register_device(&pxa168_device_nand, info, sizeof(*info));
diff --git a/arch/arm/mach-mmp/include/mach/regs-apbc.h
b/arch/arm/mach-mmp/include/mach/regs-apbc.h
index 712af03..1a96585 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apbc.h
+++ b/arch/arm/mach-mmp/include/mach/regs-apbc.h
@@ -26,8 +26,6 @@
 #define APBC_PXA168_PWM2	APBC_REG(0x010)
 #define APBC_PXA168_PWM3	APBC_REG(0x014)
 #define APBC_PXA168_PWM4	APBC_REG(0x018)
-#define APBC_PXA168_SSP1	APBC_REG(0x01c)
-#define APBC_PXA168_SSP2	APBC_REG(0x020)
 #define APBC_PXA168_RTC		APBC_REG(0x028)
 #define APBC_PXA168_TWSI0	APBC_REG(0x02c)
 #define APBC_PXA168_KPC		APBC_REG(0x030)
@@ -35,14 +33,16 @@
 #define APBC_PXA168_AIB		APBC_REG(0x03c)
 #define APBC_PXA168_SW_JTAG	APBC_REG(0x040)
 #define APBC_PXA168_ONEWIRE	APBC_REG(0x048)
-#define APBC_PXA168_SSP3	APBC_REG(0x04c)
 #define APBC_PXA168_ASFAR	APBC_REG(0x050)
 #define APBC_PXA168_ASSAR	APBC_REG(0x054)
-#define APBC_PXA168_SSP4	APBC_REG(0x058)
-#define APBC_PXA168_SSP5	APBC_REG(0x05c)
 #define APBC_PXA168_TWSI1	APBC_REG(0x06c)
 #define APBC_PXA168_UART3	APBC_REG(0x070)
 #define APBC_PXA168_AC97	APBC_REG(0x084)
+#define APBC_PXA168_SSP1	APBC_REG(0x81c)
+#define APBC_PXA168_SSP2	APBC_REG(0x820)
+#define APBC_PXA168_SSP3	APBC_REG(0x84c)
+#define APBC_PXA168_SSP4	APBC_REG(0x858)
+#define APBC_PXA168_SSP5	APBC_REG(0x85c)

 /*
  * APB Clock register offsets for PXA910
diff --git a/arch/arm/mach-mmp/include/mach/regs-mpmu.h
b/arch/arm/mach-mmp/include/mach/regs-mpmu.h
new file mode 100644
index 0000000..0d57236
--- /dev/null
+++ b/arch/arm/mach-mmp/include/mach/regs-mpmu.h
@@ -0,0 +1,48 @@
+/*
+ * linux/arch/arm/mach-mmp/include/mach/regs-mpmu.h
+ *
+ *   Main Power Management Unit
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_MACH_REGS_MPMU_H
+#define __ASM_MACH_REGS_MPMU_H
+
+#include <mach/addr-map.h>
+
+#define MPMU_VIRT_BASE	(APB_VIRT_BASE + 0x50000)
+#define MPMU_REG(off)	(MPMU_VIRT_BASE + (off))
+
+#define MPMU_CPCR	MPMU_REG(0x0000)
+#define MPMU_FCCR	MPMU_REG(0x0008)
+#define MPMU_POCR	MPMU_REG(0x000c)
+#define MPMU_POSR	MPMU_REG(0x0010)
+#define MPMU_SUCCR	MPMU_REG(0x0014)
+#define MPMU_VRCR	MPMU_REG(0x0018)
+#define MPMU_OHCR	MPMU_REG(0x001c)
+#define MPMU_GPCR	MPMU_REG(0x0030)
+#define MPMU_PLL2CR	MPMU_REG(0x0034)
+#define MPMU_SCCR	MPMU_REG(0x0038)
+#define MPMU_CWUCRM	MPMU_REG(0x004c)
+#define MPMU_PLL1_REG1	MPMU_REG(0x0050)
+#define MPMU_PLL1_REG2	MPMU_REG(0x0054)
+#define MPMU_PLL1_SSC	MPMU_REG(0x0058)
+#define MPMU_PLL2_REG1	MPMU_REG(0x0060)
+#define MPMU_PLL2_REG2	MPMU_REG(0x0064)
+#define MPMU_PLL2_SSC	MPMU_REG(0x0068)
+#define MPMU_TS		MPMU_REG(0x0080)
+#define MPMU_WDTPCR	MPMU_REG(0x0200)
+#define MPMU_APCR	MPMU_REG(0x1000)
+#define MPMU_APSR	MPMU_REG(0x1004)
+#define MPMU_APRR	MPMU_REG(0x1020)
+#define MPMU_ACGR	MPMU_REG(0x1024)
+#define MPMU_ARSR	MPMU_REG(0x1028)
+#define MPMU_AWUCRS	MPMU_REG(0x1048)
+#define MPMU_AWUCRM	MPMU_REG(0x104c)
+#define MPMU_ASYSDR	MPMU_REG(0x1050)
+#define MPMU_ASSPDR	MPMU_REG(0x1054)
+
+#endif /* __ASM_MACH_REGS_APMU_H */
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 1873c82..652ae66 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -72,6 +72,11 @@ static APBC_CLK(pwm1, PXA168_PWM1, 1, 13000000);
 static APBC_CLK(pwm2, PXA168_PWM2, 1, 13000000);
 static APBC_CLK(pwm3, PXA168_PWM3, 1, 13000000);
 static APBC_CLK(pwm4, PXA168_PWM4, 1, 13000000);
+static APBC_CLK(ssp1, PXA168_SSP1, 4, 0);
+static APBC_CLK(ssp2, PXA168_SSP2, 4, 0);
+static APBC_CLK(ssp3, PXA168_SSP3, 4, 0);
+static APBC_CLK(ssp4, PXA168_SSP4, 4, 0);
+static APBC_CLK(ssp5, PXA168_SSP5, 4, 0);

 static APMU_CLK(nand, NAND, 0x01db, 208000000);

@@ -85,6 +90,11 @@ static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_pwm2, "pxa168-pwm.1", NULL),
 	INIT_CLKREG(&clk_pwm3, "pxa168-pwm.2", NULL),
 	INIT_CLKREG(&clk_pwm4, "pxa168-pwm.3", NULL),
+	INIT_CLKREG(&clk_ssp1, "pxa168-ssp.0", NULL),
+	INIT_CLKREG(&clk_ssp2, "pxa168-ssp.1", NULL),
+	INIT_CLKREG(&clk_ssp3, "pxa168-ssp.2", NULL),
+	INIT_CLKREG(&clk_ssp4, "pxa168-ssp.3", NULL),
+	INIT_CLKREG(&clk_ssp5, "pxa168-ssp.4", NULL),
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
 };

@@ -132,3 +142,8 @@ PXA168_DEVICE(pwm2, "pxa168-pwm", 1, NONE,
0xd401a400, 0x10);
 PXA168_DEVICE(pwm3, "pxa168-pwm", 2, NONE, 0xd401a800, 0x10);
 PXA168_DEVICE(pwm4, "pxa168-pwm", 3, NONE, 0xd401ac00, 0x10);
 PXA168_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
+PXA168_DEVICE(ssp1, "pxa168-ssp", 0, SSP1, 0xd401b000, 0x40, 52, 53);
+PXA168_DEVICE(ssp2, "pxa168-ssp", 1, SSP2, 0xd401c000, 0x40, 54, 55);
+PXA168_DEVICE(ssp3, "pxa168-ssp", 2, SSP3, 0xd401f000, 0x40, 56, 57);
+PXA168_DEVICE(ssp4, "pxa168-ssp", 3, SSP4, 0xd4020000, 0x40, 58, 59);
+PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
diff --git a/arch/arm/plat-pxa/include/plat/ssp.h
b/arch/arm/plat-pxa/include/plat/ssp.h
index 74f70c7..d16d79a 100644
--- a/arch/arm/plat-pxa/include/plat/ssp.h
+++ b/arch/arm/plat-pxa/include/plat/ssp.h
@@ -138,6 +138,7 @@ enum pxa_ssp_type {
 	PXA25x_SSP,  /* pxa 210, 250, 255, 26x */
 	PXA25x_NSSP, /* pxa 255, 26x (including ASSP) */
 	PXA27x_SSP,
+	PXA168_SSP,
 };

 struct ssp_device {
diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 5fe2301..cfebcd8 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -192,6 +192,7 @@ static const struct platform_device_id ssp_id_table[] = {
 	{ "pxa25x-ssp",		PXA25x_SSP },
 	{ "pxa25x-nssp",	PXA25x_NSSP },
 	{ "pxa27x-ssp",		PXA27x_SSP },
+	{ "pxa168-ssp",		PXA168_SSP },
 	{ },
 };

-- 
1.5.6.5
