From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 14 Oct 2009 09:20:21 +0200
Subject: [PATCH 04/10] [ARM] pxa/cm-x300: add Wi2Wi chip (Bluetooth and WiFi)
	initialization
In-Reply-To: <cover.1255504387.git.mike@compulab.co.il>
References: <cover.1255504387.git.mike@compulab.co.il>
Message-ID: <5b144fccd7ec5f675d2ab8ebcc5fefa0399a7a60.1255504387.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Igor Grinberg <grinberg@compulab.co.il>

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index c4b47d8..f721931 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <linux/platform_device.h>
 
 #include <linux/gpio.h>
@@ -513,6 +514,42 @@ static void __init cm_x300_init_rtc(void)
 static inline void cm_x300_init_rtc(void) {}
 #endif
 
+static void __init cm_x300_init_wi2wi(void)
+{
+	int bt_reset, wlan_en;
+	int err;
+
+	if (system_rev < 130) {
+		wlan_en = 77;
+		bt_reset = 78;
+	} else {
+		wlan_en = 71;
+		bt_reset = 70;
+	}
+
+	/* Libertas and CSR reset */
+	err = gpio_request(wlan_en, "wlan en");
+	if (err) {
+		pr_err("CM-X300: failed to request wlan en gpio: %d\n", err);
+	} else {
+		gpio_direction_output(wlan_en, 1);
+		gpio_free(wlan_en);
+	}
+
+	err = gpio_request(bt_reset, "bt reset");
+	if (err) {
+		pr_err("CM-X300: failed to request bt reset gpio: %d\n", err);
+	} else {
+		gpio_direction_output(bt_reset, 1);
+		udelay(10);
+		gpio_set_value(bt_reset, 0);
+		udelay(10);
+		gpio_set_value(bt_reset, 1);
+		gpio_free(bt_reset);
+	}
+}
+
+/* MFP */
 static void __init cm_x300_init_mfp(void)
 {
 	/* board-processor specific GPIO initialization */
@@ -537,6 +574,7 @@ static void __init cm_x300_init(void)
 	cm_x300_init_spi();
 	cm_x300_init_rtc();
 	cm_x300_init_ac97();
+	cm_x300_init_wi2wi();
 }
 
 static void __init cm_x300_fixup(struct machine_desc *mdesc, struct tag *tags,
-- 
1.6.0.6
