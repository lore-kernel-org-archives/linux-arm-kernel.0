From: hock.leong.kweh@intel.com (Kweh Hock Leong)
Date: Thu, 24 Jul 2014 18:01:51 +0800
Subject: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
Message-ID: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Chew, Chiau Ee" <chiau.ee.chew@intel.com>

Intel LPSS Baytrail supports two DMA controllers and SPI is only
using one of the DMA controller. During DMA channel request,
we need to ensure the requested Tx and Rx channels are from the correct
DMA controller. Thus, we add extra checking in filter callback funtion
by matching against the DMA controller device name.

Signed-off-by: Chew, Chiau Ee <chiau.ee.chew@intel.com>
Signed-off-by: Kweh, Hock Leong <hock.leong.kweh@intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c   | 5 +++++
 drivers/spi/spi-pxa2xx-pci.c   | 3 +++
 include/linux/spi/pxa2xx_spi.h | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index c41ff14..4c4e918 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -214,6 +214,11 @@ static bool pxa2xx_spi_dma_filter(struct dma_chan *chan, void *param)
 {
 	const struct pxa2xx_spi_master *pdata = param;
 
+	if (pdata->dma_devname) {
+		if (strcmp(dev_name(chan->device->dev), pdata->dma_devname))
+			return false;
+	}
+
 	return chan->chan_id == pdata->tx_chan_id ||
 	       chan->chan_id == pdata->rx_chan_id;
 }
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index c1865c9..7a21bce 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -21,6 +21,7 @@ struct pxa_spi_info {
 	int tx_chan_id;
 	int rx_slave_id;
 	int rx_chan_id;
+	char *dma_devname;
 };
 
 static struct pxa_spi_info spi_info_configs[] = {
@@ -41,6 +42,7 @@ static struct pxa_spi_info spi_info_configs[] = {
 		.tx_chan_id = 0,
 		.rx_slave_id = 1,
 		.rx_chan_id = 1,
+		.dma_devname = "0000:00:1e.0"
 	},
 };
 
@@ -72,6 +74,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	spi_pdata.rx_slave_id = c->rx_slave_id;
 	spi_pdata.rx_chan_id = c->rx_chan_id;
 	spi_pdata.enable_dma = c->rx_slave_id >= 0 && c->tx_slave_id >= 0;
+	spi_pdata.dma_devname = c->dma_devname;
 
 	ssp = &spi_pdata.ssp;
 	ssp->phys_base = pci_resource_start(dev, 0);
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 82d5111..264c3cb 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -34,6 +34,7 @@ struct pxa2xx_spi_master {
 	int tx_chan_id;
 	int rx_slave_id;
 	int tx_slave_id;
+	char *dma_devname;
 
 	/* For non-PXA arches */
 	struct ssp_device ssp;
-- 
1.9.1
