From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 2 Apr 2012 10:39:45 -0300
Subject: [PATCH 3/5] ARM: mx31lilly: Fix smsc911x driver probe
In-Reply-To: <1333373987-30459-1-git-send-email-fabio.estevam@freescale.com>
References: <1333373987-30459-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1333373987-30459-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix smsc911x driver probe by adding a fixed dummy regulator.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-mx31lilly.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index 02401bb..83714b0 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -34,6 +34,8 @@
 #include <linux/mfd/mc13783.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -242,6 +244,11 @@ static struct platform_device *devices[] __initdata = {
 static int mx31lilly_baseboard;
 core_param(mx31lilly_baseboard, mx31lilly_baseboard, int, 0444);
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+};
+
 static void __init mx31lilly_board_init(void)
 {
 	imx31_soc_init();
@@ -280,6 +287,8 @@ static void __init mx31lilly_board_init(void)
 	imx31_add_spi_imx1(&spi1_pdata);
 	spi_register_board_info(&mc13783_dev, 1);
 
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	/* USB */
-- 
1.7.1
