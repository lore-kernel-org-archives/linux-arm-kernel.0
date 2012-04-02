From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 2 Apr 2012 10:39:44 -0300
Subject: [PATCH 2/5] ARM: mx31lite: Fix smsc911x driver probe
In-Reply-To: <1333373987-30459-1-git-send-email-fabio.estevam@freescale.com>
References: <1333373987-30459-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1333373987-30459-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix smsc911x driver probe by adding a fixed dummy regulator.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-mx31lite.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index ef80751..0abef5f 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -29,6 +29,8 @@
 #include <linux/usb/ulpi.h>
 #include <linux/mtd/physmap.h>
 #include <linux/delay.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -226,6 +228,11 @@ void __init mx31lite_map_io(void)
 static int mx31lite_baseboard;
 core_param(mx31lite_baseboard, mx31lite_baseboard, int, 0444);
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+};
+
 static void __init mx31lite_init(void)
 {
 	int ret;
@@ -259,6 +266,8 @@ static void __init mx31lite_init(void)
 	if (usbh2_pdata.otg)
 		imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
 
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	/* SMSC9117 IRQ pin */
 	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_SFS6), "sms9117-irq");
 	if (ret)
-- 
1.7.1
