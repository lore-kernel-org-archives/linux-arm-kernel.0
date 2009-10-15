From: mike@compulab.co.il (Mike Rapoport)
Date: Thu, 15 Oct 2009 10:06:36 +0200
Subject: >From d91f4e6f60747fd0c04bce6274326618217540b4 Mon Sep 17 00:00:00
	2001
Message-ID: <1255593996-5545-1-git-send-email-mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric,
It would be really nice if it can go to 2.6.32

---
CM-X300 has libertas on mmc2 and  SD card slot on mmc1.
This patch fixes wrong MMC ports assignment.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 52f6ad7..e6fbb0a 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -53,10 +53,10 @@
 
 #define CM_X300_ETH_PHYS	0x08000010
 
-#define GPIO82_MMC2_IRQ		(82)
-#define GPIO85_MMC2_WP		(85)
+#define GPIO82_MMC_IRQ		(82)
+#define GPIO85_MMC_WP		(85)
 
-#define	CM_X300_MMC2_IRQ	IRQ_GPIO(GPIO82_MMC2_IRQ)
+#define	CM_X300_MMC_IRQ		IRQ_GPIO(GPIO82_MMC_IRQ)
 
 #define GPIO95_RTC_CS		(95)
 #define GPIO96_RTC_WR		(96)
@@ -430,37 +430,37 @@ static inline void cm_x300_init_nand(void) {}
 #endif
 
 #if defined(CONFIG_MMC) || defined(CONFIG_MMC_MODULE)
-/* The first MMC slot of CM-X300 is hardwired to Libertas card and has
+static struct pxamci_platform_data cm_x300_mci_platform_data = {
+	.detect_delay		= 20,
+	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
+	.gpio_card_detect	= GPIO82_MMC_IRQ,
+	.gpio_card_ro		= GPIO85_MMC_WP,
+	.gpio_power		= -1,
+};
+
+/* The second MMC slot of CM-X300 is hardwired to Libertas card and has
    no detection/ro pins */
-static int cm_x300_mci_init(struct device *dev,
-			    irq_handler_t cm_x300_detect_int,
-			    void *data)
+static int cm_x300_mci2_init(struct device *dev,
+			     irq_handler_t cm_x300_detect_int,
+	void *data)
 {
 	return 0;
 }
 
-static void cm_x300_mci_exit(struct device *dev, void *data)
+static void cm_x300_mci2_exit(struct device *dev, void *data)
 {
 }
 
-static struct pxamci_platform_data cm_x300_mci_platform_data = {
+static struct pxamci_platform_data cm_x300_mci2_platform_data = {
 	.detect_delay		= 20,
 	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
-	.init 			= cm_x300_mci_init,
-	.exit			= cm_x300_mci_exit,
+	.init 			= cm_x300_mci2_init,
+	.exit			= cm_x300_mci2_exit,
 	.gpio_card_detect	= -1,
 	.gpio_card_ro		= -1,
 	.gpio_power		= -1,
 };
 
-static struct pxamci_platform_data cm_x300_mci2_platform_data = {
-	.detect_delay		= 20,
-	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
-	.gpio_card_detect	= GPIO82_MMC2_IRQ,
-	.gpio_card_ro		= GPIO85_MMC2_WP,
-	.gpio_power		= -1,
-};
-
 static void __init cm_x300_init_mmc(void)
 {
 	pxa_set_mci_info(&cm_x300_mci_platform_data);
-- 
1.6.0.6
