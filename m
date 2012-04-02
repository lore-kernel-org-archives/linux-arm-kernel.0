From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 2 Apr 2012 10:39:46 -0300
Subject: [PATCH 4/5] ARM: kzm_arm11_01: Fix smsc911x driver probe
In-Reply-To: <1333373987-30459-1-git-send-email-fabio.estevam@freescale.com>
References: <1333373987-30459-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1333373987-30459-4-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix smsc911x driver probe by adding a fixed dummy regulator.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-kzm_arm11_01.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-kzm_arm11_01.c b/arch/arm/mach-imx/mach-kzm_arm11_01.c
index fc78e80..8d88bb0 100644
--- a/arch/arm/mach-imx/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-imx/mach-kzm_arm11_01.c
@@ -24,6 +24,8 @@
 #include <linux/serial_8250.h>
 #include <linux/smsc911x.h>
 #include <linux/types.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
@@ -166,6 +168,11 @@ static struct platform_device kzm_smsc9118_device = {
 			  },
 };
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+};
+
 static int __init kzm_init_smsc9118(void)
 {
 	/*
@@ -174,6 +181,8 @@ static int __init kzm_init_smsc9118(void)
 	mxc_iomux_mode(IOMUX_MODE(MX31_PIN_GPIO1_2, IOMUX_CONFIG_GPIO));
 	gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2), "smsc9118-int");
 	gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO1_2));
+
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
 	return platform_device_register(&kzm_smsc9118_device);
 }
-- 
1.7.1
