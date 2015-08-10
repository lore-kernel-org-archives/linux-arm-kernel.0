From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Aug 2015 16:23:10 +0200
Subject: [PATCH 2/4] USB: host: ohci-at91: depend on OF
In-Reply-To: <1439216592-11381-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439216592-11381-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1439216592-11381-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the driver depend on CONFIG_OF and remove the now useless #ifdef

Also, fix the Kconfig indentation.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/usb/host/Kconfig     | 8 ++++----
 drivers/usb/host/ohci-at91.c | 9 +--------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 8afc3c1efdab..7ef56faf09bb 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -441,10 +441,10 @@ config USB_OHCI_HCD_PXA27X
 	  PXA27x/PXA3xx chips.
 
 config USB_OHCI_HCD_AT91
-        tristate "Support for Atmel on-chip OHCI USB controller"
-        depends on USB_OHCI_HCD && ARCH_AT91
-        default y
-        ---help---
+	tristate "Support for Atmel on-chip OHCI USB controller"
+	depends on USB_OHCI_HCD && ARCH_AT91 && OF
+	default y
+	---help---
           Enables support for the on-chip OHCI controller on
           Atmel chips.
 
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 72dc4f9e2a0f..8e17d5ba26c6 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -442,7 +442,6 @@ static irqreturn_t ohci_hcd_at91_overcurrent_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id at91_ohci_dt_ids[] = {
 	{ .compatible = "atmel,at91rm9200-ohci" },
 	{ /* sentinel */ }
@@ -492,12 +491,6 @@ static int ohci_at91_of_init(struct platform_device *pdev)
 
 	return 0;
 }
-#else
-static int ohci_at91_of_init(struct platform_device *pdev)
-{
-	return 0;
-}
-#endif
 
 /*-------------------------------------------------------------------------*/
 
@@ -684,7 +677,7 @@ static struct platform_driver ohci_hcd_at91_driver = {
 	.driver		= {
 		.name	= "at91_ohci",
 		.pm	= &ohci_hcd_at91_pm_ops,
-		.of_match_table	= of_match_ptr(at91_ohci_dt_ids),
+		.of_match_table	= at91_ohci_dt_ids,
 	},
 };
 
-- 
2.1.4
