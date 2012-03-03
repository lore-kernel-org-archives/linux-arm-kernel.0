From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat,  3 Mar 2012 12:40:03 +0100
Subject: [PATCH 3/4] ARM i.MX pcm037: register a dummy regulator for the
 smsc911x device
In-Reply-To: <1330774804-7310-1-git-send-email-s.hauer@pengutronix.de>
References: <1330774804-7310-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1330774804-7310-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mach-pcm037.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index e48854b..5fddf94 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -32,6 +32,8 @@
 #include <linux/usb/ulpi.h>
 #include <linux/gfp.h>
 #include <linux/memblock.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 
 #include <media/soc_camera.h>
 
@@ -570,6 +572,11 @@ static int __init pcm037_otg_mode(char *options)
 }
 __setup("otg_mode=", pcm037_otg_mode);
 
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+};
+
 /*
  * Board specific initialization.
  */
@@ -579,6 +586,8 @@ static void __init pcm037_init(void)
 
 	imx31_soc_init();
 
+	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+
 	mxc_iomux_set_gpr(MUX_PGP_UH2, 1);
 
 	mxc_iomux_setup_multiple_pins(pcm037_pins, ARRAY_SIZE(pcm037_pins),
-- 
1.7.9.1
