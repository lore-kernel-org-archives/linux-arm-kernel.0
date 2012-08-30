From: hein_tibosch@yahoo.es (Hein Tibosch)
Date: Fri, 31 Aug 2012 00:34:27 +0800
Subject: [PATCH v2 2/2] mmc: atmel-mci: AP700x PDC is not connected to MCI
Message-ID: <503F9613.5060007@yahoo.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Earlier, atmel-mci was adapted to make use of the peripheral DMA
controller (PDC), in case normal DMA wouldn't work.
( http://comments.gmane.org/gmane.linux.kernel.mmc/9403 )
This works OK on ARM platforms (AT91), but it broke the driver
for AVR32, the AP700x.
Although the MCI has PDC support, the connection is not done for
AVR chips

This patch makes the use of PDC depend on CONFIG_AVR32

Signed-off-by: Hein Tibosch <hein_tibosch@yahoo.es>

---
 drivers/mmc/host/atmel-mci-regs.h |    7 +++++++
 drivers/mmc/host/atmel-mci.c      |    2 +-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
index ab56f7d..c97001e 100644
--- a/drivers/mmc/host/atmel-mci-regs.h
+++ b/drivers/mmc/host/atmel-mci-regs.h
@@ -140,6 +140,13 @@
 #define atmci_writel(port,reg,value)			\
 	__raw_writel((value), (port)->regs + reg)
 
+/* On AVR chips the Peripheral DMA Controller is not connected to MCI. */
+#ifdef CONFIG_AVR32
+#	define ATMCI_PDC_CONNECTED	0
+#else
+#	define ATMCI_PDC_CONNECTED	1
+#endif
+
 /*
  * Fix sconfig's burst size according to atmel MCI. We need to convert them as:
  * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index a6a5593..b8de891 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2208,7 +2208,7 @@ static void __init atmci_get_cap(struct atmel_mci *host)
 			"version: 0x%x\n", version);
 
 	host->caps.has_dma_conf_reg = 0;
-	host->caps.has_pdc = 1;
+	host->caps.has_pdc = ATMCI_PDC_CONNECTED;
 	host->caps.has_cfg_reg = 0;
 	host->caps.has_cstor_reg = 0;
 	host->caps.has_highspeed = 0;
-- 
1.7.8.0
