From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jan 2010 17:17:27 +0100
Subject: [PATCH 20/25] imx: mangle addresses after adding the offset
In-Reply-To: <1262967452-24353-19-git-send-email-u.kleine-koenig@pengutronix.de>
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
Message-ID: <1262967452-24353-20-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

don't use

	IO_ADDRESS($base) + $offset

but

	IO_ADDRESS($base + $offset)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Holger Schurig <hs4233@mail.mn-solutions.de>
Cc: Rabin Vincent <rabin@rab.in>
Cc: "Agust?n Ferr?n Pozuelo" <gatoguan-os@yahoo.com>
Cc: Javier Martin <javier.martin@vista-silicon.com>
Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>
Cc: Daniel Mack <daniel@caiaq.de>
Cc: Dmitriy Taychenachev <dimichxp@gmail.com>
---
 arch/arm/mach-mx2/clock_imx21.c      |    2 +-
 arch/arm/mach-mx2/clock_imx27.c      |    2 +-
 arch/arm/mach-mx3/cpu.c              |    2 +-
 arch/arm/plat-mxc/include/mach/mxc.h |    6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mx2/clock_imx21.c b/arch/arm/mach-mx2/clock_imx21.c
index 2367b6c..8974faf 100644
--- a/arch/arm/mach-mx2/clock_imx21.c
+++ b/arch/arm/mach-mx2/clock_imx21.c
@@ -28,7 +28,7 @@
 #include <asm/clkdev.h>
 #include <asm/div64.h>
 
-#define IO_ADDR_CCM(off)	(MX21_IO_ADDRESS(MX21_CCM_BASE_ADDR) + (off))
+#define IO_ADDR_CCM(off)	(MX21_IO_ADDRESS(MX21_CCM_BASE_ADDR + (off)))
 
 /* Register offsets */
 #define CCM_CSCR		IO_ADDR_CCM(0x0)
diff --git a/arch/arm/mach-mx2/clock_imx27.c b/arch/arm/mach-mx2/clock_imx27.c
index bb9f603..68bf93e 100644
--- a/arch/arm/mach-mx2/clock_imx27.c
+++ b/arch/arm/mach-mx2/clock_imx27.c
@@ -29,7 +29,7 @@
 #include <mach/common.h>
 #include <mach/hardware.h>
 
-#define IO_ADDR_CCM(off)	(MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR) + (off))
+#define IO_ADDR_CCM(off)	(MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR + (off)))
 
 /* Register offsets */
 #define CCM_CSCR		IO_ADDR_CCM(0x0)
diff --git a/arch/arm/mach-mx3/cpu.c b/arch/arm/mach-mx3/cpu.c
index db82880..861afe0 100644
--- a/arch/arm/mach-mx3/cpu.c
+++ b/arch/arm/mach-mx3/cpu.c
@@ -41,7 +41,7 @@ void __init mx31_read_cpu_rev(void)
 	u32 i, srev;
 
 	/* read SREV register from IIM module */
-	srev = __raw_readl(IO_ADDRESS(IIM_BASE_ADDR) + MXC_IIMSREV);
+	srev = __raw_readl(IO_ADDRESS(IIM_BASE_ADDR + MXC_IIMSREV));
 
 	for (i = 0; i < ARRAY_SIZE(mx31_cpu_type); i++)
 		if (srev == mx31_cpu_type[i].srev) {
diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index 5199053..2b14126 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -121,9 +121,9 @@ extern unsigned int __mxc_cpu_type;
 #endif
 
 #if defined(CONFIG_ARCH_MX3) || defined(CONFIG_ARCH_MX2)
-#define CSCR_U(n) (IO_ADDRESS(WEIM_BASE_ADDR) + n * 0x10)
-#define CSCR_L(n) (IO_ADDRESS(WEIM_BASE_ADDR) + n * 0x10 + 0x4)
-#define CSCR_A(n) (IO_ADDRESS(WEIM_BASE_ADDR) + n * 0x10 + 0x8)
+#define CSCR_U(n) (IO_ADDRESS(WEIM_BASE_ADDR + n * 0x10))
+#define CSCR_L(n) (IO_ADDRESS(WEIM_BASE_ADDR + n * 0x10 + 0x4))
+#define CSCR_A(n) (IO_ADDRESS(WEIM_BASE_ADDR + n * 0x10 + 0x8))
 #endif
 
 #define cpu_is_mx3()	(cpu_is_mx31() || cpu_is_mx35() || cpu_is_mxc91231())
-- 
1.6.5.2
