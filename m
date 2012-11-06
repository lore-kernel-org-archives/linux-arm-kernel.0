From: nicolas@eukrea.com (Nicolas Royer)
Date: Tue,  6 Nov 2012 17:32:24 +0100
Subject: [PATCH 2/5] ARM: AT91SAM9G45: same platform data structure for all
 crypto peripherals
Message-ID: <1352219544-30416-1-git-send-email-nicolas@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only AES use DMA in AT91SAM9G45 (TDES and SHA use PDC).

However latest Atmel TDES and SHA IP releases use DMA instead of PDC.
  --> Atmel TDES and SHA drivers need DMA platform data for those IP releases.

Goal of this patch is to use the same platform data structure for all Atmel
crypto peripherals. This structure contains information about DMA interface.

Signed-off-by: Nicolas Royer <nicolas@eukrea.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Eric B?nard <eric@eukrea.com>
Tested-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-at91/at91sam9g45_devices.c   |    8 ++++----
 include/linux/platform_data/atmel-aes.h    |   22 ----------------------
 include/linux/platform_data/crypto-atmel.h |   22 ++++++++++++++++++++++
 3 files changed, 26 insertions(+), 26 deletions(-)
 delete mode 100644 include/linux/platform_data/atmel-aes.h
 create mode 100644 include/linux/platform_data/crypto-atmel.h

diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index fcd233c..a48dcb4 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -18,7 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c-gpio.h>
 #include <linux/atmel-mci.h>
-#include <linux/platform_data/atmel-aes.h>
+#include <linux/platform_data/crypto-atmel.h>
 
 #include <linux/platform_data/at91_adc.h>
 
@@ -1900,7 +1900,7 @@ static void __init at91_add_device_tdes(void) {}
  * -------------------------------------------------------------------- */
 
 #if defined(CONFIG_CRYPTO_DEV_ATMEL_AES) || defined(CONFIG_CRYPTO_DEV_ATMEL_AES_MODULE)
-static struct aes_platform_data aes_data;
+static struct crypto_platform_data aes_data;
 static u64 aes_dmamask = DMA_BIT_MASK(32);
 
 static struct resource aes_resources[] = {
@@ -1931,9 +1931,9 @@ static struct platform_device at91sam9g45_aes_device = {
 static void __init at91_add_device_aes(void)
 {
 	struct at_dma_slave	*atslave;
-	struct aes_dma_data	*alt_atslave;
+	struct crypto_dma_data	*alt_atslave;
 
-	alt_atslave = kzalloc(sizeof(struct aes_dma_data), GFP_KERNEL);
+	alt_atslave = kzalloc(sizeof(struct crypto_dma_data), GFP_KERNEL);
 
 	/* DMA TX slave channel configuration */
 	atslave = &alt_atslave->txdata;
diff --git a/include/linux/platform_data/atmel-aes.h b/include/linux/platform_data/atmel-aes.h
deleted file mode 100644
index ab68082..0000000
--- a/include/linux/platform_data/atmel-aes.h
+++ /dev/null
@@ -1,22 +0,0 @@
-#ifndef __LINUX_ATMEL_AES_H
-#define __LINUX_ATMEL_AES_H
-
-#include <linux/platform_data/dma-atmel.h>
-
-/**
- * struct aes_dma_data - DMA data for AES
- */
-struct aes_dma_data {
-	struct at_dma_slave	txdata;
-	struct at_dma_slave	rxdata;
-};
-
-/**
- * struct aes_platform_data - board-specific AES configuration
- * @dma_slave: DMA slave interface to use in data transfers.
- */
-struct aes_platform_data {
-	struct aes_dma_data	*dma_slave;
-};
-
-#endif /* __LINUX_ATMEL_AES_H */
diff --git a/include/linux/platform_data/crypto-atmel.h b/include/linux/platform_data/crypto-atmel.h
new file mode 100644
index 0000000..b46e0d9
--- /dev/null
+++ b/include/linux/platform_data/crypto-atmel.h
@@ -0,0 +1,22 @@
+#ifndef __LINUX_CRYPTO_ATMEL_H
+#define __LINUX_CRYPTO_ATMEL_H
+
+#include <linux/platform_data/dma-atmel.h>
+
+/**
+ * struct crypto_dma_data - DMA data for AES/TDES/SHA
+ */
+struct crypto_dma_data {
+	struct at_dma_slave	txdata;
+	struct at_dma_slave	rxdata;
+};
+
+/**
+ * struct crypto_platform_data - board-specific AES/TDES/SHA configuration
+ * @dma_slave: DMA slave interface to use in data transfers.
+ */
+struct crypto_platform_data {
+	struct crypto_dma_data	*dma_slave;
+};
+
+#endif /* __LINUX_CRYPTO_ATMEL_H */
-- 
1.7.6.5
