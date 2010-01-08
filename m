From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jan 2010 17:17:32 +0100
Subject: [PATCH 25/25] imx: define functions to configure chip selects in the
	WEIM
In-Reply-To: <1262967452-24353-24-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100108161551.GA19007@pengutronix.de>
	<1262967452-24353-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-17-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-18-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-19-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-20-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-21-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-22-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-23-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-24-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1262967452-24353-25-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This has the addional effect that the macros CSCR_U, CSCR_L and CSCR_A
are not used anymore in mach-pcm038.c and mach-qong.c.  These still use
the deprecated IO_ADDRESS macro and shouldn't be used in new code.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Holger Schurig <hs4233@mail.mn-solutions.de>
Cc: Dmitriy Taychenachev <dimichxp@gmail.com>
---
 arch/arm/mach-mx2/mach-pcm038.c       |    4 +---
 arch/arm/mach-mx3/mach-qong.c         |    4 +---
 arch/arm/plat-mxc/include/mach/mx27.h |   19 +++++++++++++++++++
 arch/arm/plat-mxc/include/mach/mx31.h |   19 +++++++++++++++++++
 arch/arm/plat-mxc/include/mach/mxc.h  |    1 +
 5 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mx2/mach-pcm038.c b/arch/arm/mach-mx2/mach-pcm038.c
index a2e2ea1..9636bb8 100644
--- a/arch/arm/mach-mx2/mach-pcm038.c
+++ b/arch/arm/mach-mx2/mach-pcm038.c
@@ -173,9 +173,7 @@ static struct platform_device *platform_devices[] __initdata = {
  * setup other stuffs to access the sram. */
 static void __init pcm038_init_sram(void)
 {
-	__raw_writel(0x0000d843, CSCR_U(1));
-	__raw_writel(0x22252521, CSCR_L(1));
-	__raw_writel(0x22220a00, CSCR_A(1));
+	mx27_setup_weimcs(1, 0x0000d843, 0x22252521, 0x22220a00);
 }
 
 static struct imxi2c_platform_data pcm038_i2c_1_data = {
diff --git a/arch/arm/mach-mx3/mach-qong.c b/arch/arm/mach-mx3/mach-qong.c
index 93991f1..fdb819a 100644
--- a/arch/arm/mach-mx3/mach-qong.c
+++ b/arch/arm/mach-mx3/mach-qong.c
@@ -198,9 +198,7 @@ static struct platform_device qong_nand_device = {
 static void __init qong_init_nand_mtd(void)
 {
 	/* init CS */
-	__raw_writel(0x00004f00, CSCR_U(3));
-	__raw_writel(0x20013b31, CSCR_L(3));
-	__raw_writel(0x00020800, CSCR_A(3));
+	mx31_setup_weimcs(3, 0x00004f00, 0x20013b31, 0x00020800);
 	mxc_iomux_set_gpr(MUX_SDCTL_CSD1_SEL, true);
 
 	/* enable pin */
diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index 832b580..bae9cd7 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -24,6 +24,10 @@
 #ifndef __MACH_MX27_H__
 #define __MACH_MX27_H__
 
+#ifndef __ASSEMBLER__
+#include <linux/io.h>
+#endif
+
 #define MX27_AIPI_BASE_ADDR		0x10000000
 #define MX27_AIPI_BASE_ADDR_VIRT	0xf4000000
 #define MX27_AIPI_SIZE			SZ_1M
@@ -109,6 +113,11 @@
 #define MX27_M3IF_BASE_ADDR			(MX27_X_MEMC_BASE_ADDR + 0x3000)
 #define MX27_PCMCIA_CTL_BASE_ADDR		(MX27_X_MEMC_BASE_ADDR + 0x4000)
 
+#define MX27_WEIM_CSCRx_BASE_ADDR(cs)	(MX27_WEIM_BASE_ADDR + (cs) * 0x10)
+#define MX27_WEIM_CSCRxU(cs)			(MX27_WEIM_CSCRx_BASE_ADDR(cs))
+#define MX27_WEIM_CSCRxL(cs)			(MX27_WEIM_CSCRx_BASE_ADDR(cs) + 0x4)
+#define MX27_WEIM_CSCRxA(cs)			(MX27_WEIM_CSCRx_BASE_ADDR(cs) + 0x8)
+
 #define MX27_PCMCIA_MEM_BASE_ADDR	0xdc000000
 
 /* IRAM */
@@ -119,6 +128,16 @@
 	IMX_IO_ADDRESS(x, MX27_SAHB1) ?:				\
 	IMX_IO_ADDRESS(x, MX27_X_MEMC))
 
+#ifndef __ASSEMBLER__
+static inline void mx27_setup_weimcs(size_t cs,
+		unsigned upper, unsigned lower, unsigned addional)
+{
+	__raw_writel(upper, MX27_IO_ADDRESS(MX27_WEIM_CSCRxU(cs)));
+	__raw_writel(lower, MX27_IO_ADDRESS(MX27_WEIM_CSCRxL(cs)));
+	__raw_writel(addional, MX27_IO_ADDRESS(MX27_WEIM_CSCRxA(cs)));
+}
+#endif
+
 /* fixed interrupt numbers */
 #define MX27_INT_I2C2		1
 #define MX27_INT_GPT6		2
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
index 62d26da..fb90e11 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -1,6 +1,10 @@
 #ifndef __MACH_MX31_H__
 #define __MACH_MX31_H__
 
+#ifndef __ASSEMBLER__
+#include <linux/io.h>
+#endif
+
 /*
  * IRAM
  */
@@ -110,6 +114,11 @@
 #define MX31_EMI_CTL_BASE_ADDR			(MX31_X_MEMC_BASE_ADDR + 0x4000)
 #define MX31_PCMCIA_CTL_BASE_ADDR		MX31_EMI_CTL_BASE_ADDR
 
+#define MX31_WEIM_CSCRx_BASE_ADDR(cs)	(MX31_WEIM_BASE_ADDR + (cs) * 0x10)
+#define MX31_WEIM_CSCRxU(cs)			(MX31_WEIM_CSCRx_BASE_ADDR(cs))
+#define MX31_WEIM_CSCRxL(cs)			(MX31_WEIM_CSCRx_BASE_ADDR(cs) + 0x4)
+#define MX31_WEIM_CSCRxA(cs)			(MX31_WEIM_CSCRx_BASE_ADDR(cs) + 0x8)
+
 #define MX31_PCMCIA_MEM_BASE_ADDR	0xbc000000
 
 #define MX31_IO_ADDRESS(x) (						\
@@ -119,6 +128,16 @@
 	IMX_IO_ADDRESS(x, MX31_X_MEMC) ?:				\
 	IMX_IO_ADDRESS(x, MX31_SPBA0))
 
+#ifndef __ASSEMBLER__
+static inline void mx31_setup_weimcs(size_t cs,
+		unsigned upper, unsigned lower, unsigned addional)
+{
+	__raw_writel(upper, MX31_IO_ADDRESS(MX31_WEIM_CSCRxU(cs)));
+	__raw_writel(lower, MX31_IO_ADDRESS(MX31_WEIM_CSCRxL(cs)));
+	__raw_writel(addional, MX31_IO_ADDRESS(MX31_WEIM_CSCRxA(cs)));
+}
+#endif
+
 #define MX31_INT_I2C3		3
 #define MX31_INT_I2C2		4
 #define MX31_INT_MPEG4_ENCODER	5
diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index 2b14126..800ae2a 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -121,6 +121,7 @@ extern unsigned int __mxc_cpu_type;
 #endif
 
 #if defined(CONFIG_ARCH_MX3) || defined(CONFIG_ARCH_MX2)
+/* These are deprecated, use mx[23][157]_setup_weimcs instead. */
 #define CSCR_U(n) (IO_ADDRESS(WEIM_BASE_ADDR + n * 0x10))
 #define CSCR_L(n) (IO_ADDRESS(WEIM_BASE_ADDR + n * 0x10 + 0x4))
 #define CSCR_A(n) (IO_ADDRESS(WEIM_BASE_ADDR + n * 0x10 + 0x8))
-- 
1.6.5.2
