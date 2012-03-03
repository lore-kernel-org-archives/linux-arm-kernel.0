From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat,  3 Mar 2012 12:40:04 +0100
Subject: [PATCH 4/4] ARM i.MX 3ds debugboard: register a dummy regulator for
 the smsc911x device
In-Reply-To: <1330774804-7310-1-git-send-email-s.hauer@pengutronix.de>
References: <1330774804-7310-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1330774804-7310-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/3ds_debugboard.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/3ds_debugboard.c b/arch/arm/plat-mxc/3ds_debugboard.c
index f0ba072..d1e31fa 100644
--- a/arch/arm/plat-mxc/3ds_debugboard.c
+++ b/arch/arm/plat-mxc/3ds_debugboard.c
@@ -16,6 +16,8 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/smsc911x.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 
 #include <mach/hardware.h>
 
@@ -148,6 +150,11 @@ static struct irq_chip expio_irq_chip = {
 	.irq_unmask = expio_unmask_irq,
 };
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+};
+
 int __init mxc_expio_init(u32 base, u32 p_irq)
 {
 	int i;
@@ -188,6 +195,8 @@ int __init mxc_expio_init(u32 base, u32 p_irq)
 	irq_set_chained_handler(p_irq, mxc_expio_irq_handler);
 
 	/* Register Lan device on the debugboard */
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	smsc911x_resources[0].start = LAN9217_BASE_ADDR(base);
 	smsc911x_resources[0].end = LAN9217_BASE_ADDR(base) + 0x100 - 1;
 	platform_device_register(&smsc_lan9217_device);
-- 
1.7.9.1
