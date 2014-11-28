From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 28 Nov 2014 15:08:04 +0100
Subject: [PATCH v3 2/4] mmc: atmel-mci: remove __init/__exit attributes
In-Reply-To: <1417183686-31481-1-git-send-email-ludovic.desroches@atmel.com>
References: <1417183686-31481-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1417183686-31481-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using __init/__exit attributes can cause several breakages so remove
them.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index f187e75..064358d 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2140,7 +2140,7 @@ static irqreturn_t atmci_detect_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init atmci_init_slot(struct atmel_mci *host,
+static int atmci_init_slot(struct atmel_mci *host,
 		struct mci_slot_pdata *slot_data, unsigned int id,
 		u32 sdc_reg, u32 sdio_irq)
 {
@@ -2302,7 +2302,7 @@ static bool atmci_configure_dma(struct atmel_mci *host)
  * HSMCI provides DMA support and a new config register but no more supports
  * PDC.
  */
-static void __init atmci_get_cap(struct atmel_mci *host)
+static void atmci_get_cap(struct atmel_mci *host)
 {
 	unsigned int version;
 
@@ -2351,7 +2351,7 @@ static void __init atmci_get_cap(struct atmel_mci *host)
 	}
 }
 
-static int __init atmci_probe(struct platform_device *pdev)
+static int atmci_probe(struct platform_device *pdev)
 {
 	struct mci_platform_data	*pdata;
 	struct atmel_mci		*host;
@@ -2502,7 +2502,7 @@ err_init_slot:
 	return ret;
 }
 
-static int __exit atmci_remove(struct platform_device *pdev)
+static int atmci_remove(struct platform_device *pdev)
 {
 	struct atmel_mci	*host = platform_get_drvdata(pdev);
 	unsigned int		i;
@@ -2565,7 +2565,7 @@ static const struct dev_pm_ops atmci_dev_pm_ops = {
 };
 
 static struct platform_driver atmci_driver = {
-	.remove		= __exit_p(atmci_remove),
+	.remove		= atmci_remove,
 	.driver		= {
 		.name		= "atmel_mci",
 		.of_match_table	= of_match_ptr(atmci_dt_ids),
@@ -2573,12 +2573,12 @@ static struct platform_driver atmci_driver = {
 	},
 };
 
-static int __init atmci_init(void)
+static int atmci_init(void)
 {
 	return platform_driver_probe(&atmci_driver, atmci_probe);
 }
 
-static void __exit atmci_exit(void)
+static void atmci_exit(void)
 {
 	platform_driver_unregister(&atmci_driver);
 }
-- 
2.0.3
