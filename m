From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 24 Nov 2010 12:13:23 +0100
Subject: [PATCH 5/9] spi/pxa2xx: Add CE4100 support
In-Reply-To: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1290597207-29838-6-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sodaville's SPI controller is very much the same as in PXA25x. The
difference:
- The RX/TX FIFO is only 4 words deep instead of 16
- No DMA support
- The SPI controller offers a CS functionality

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 arch/x86/include/asm/pxa2xx_spi_ce4100.h |   99 +++++++++++++++
 drivers/spi/Kconfig                      |   15 ++-
 drivers/spi/Makefile                     |    1 +
 drivers/spi/pxa2xx_spi.c                 |    1 -
 drivers/spi/pxa2xx_spi_pci.c             |  201 ++++++++++++++++++++++++++++++
 include/linux/spi/pxa2xx_spi.h           |   10 ++-
 6 files changed, 320 insertions(+), 7 deletions(-)
 create mode 100644 arch/x86/include/asm/pxa2xx_spi_ce4100.h
 create mode 100644 drivers/spi/pxa2xx_spi_pci.c

diff --git a/arch/x86/include/asm/pxa2xx_spi_ce4100.h b/arch/x86/include/asm/pxa2xx_spi_ce4100.h
new file mode 100644
index 0000000..d86690c
--- /dev/null
+++ b/arch/x86/include/asm/pxa2xx_spi_ce4100.h
@@ -0,0 +1,99 @@
+#ifndef __asm_pxa2xx_spi_ce4100_h
+#define __asm_pxa2xx_spi_ce4100_h
+
+/*
+ * The CE4100 does not provide DMA support. This bits are here to let the driver
+ * compile and will never be used. Maybe we get DMA support at a later point in
+ * time.
+ */
+
+#define DCSR(n)         (n)
+#define DSADR(n)        (n)
+#define DTADR(n)        (n)
+#define DCMD(n)         (n)
+#define DRCMR(n)        (n)
+
+#define DCSR_RUN	(1 << 31)	/* Run Bit */
+#define DCSR_NODESC	(1 << 30)	/* No-Descriptor Fetch */
+#define DCSR_STOPIRQEN	(1 << 29)	/* Stop Interrupt Enable */
+#define DCSR_REQPEND	(1 << 8)	/* Request Pending (read-only) */
+#define DCSR_STOPSTATE	(1 << 3)	/* Stop State (read-only) */
+#define DCSR_ENDINTR	(1 << 2)	/* End Interrupt */
+#define DCSR_STARTINTR	(1 << 1)	/* Start Interrupt */
+#define DCSR_BUSERR	(1 << 0)	/* Bus Error Interrupt */
+
+#define DCSR_EORIRQEN	(1 << 28)	/* End of Receive Interrupt Enable */
+#define DCSR_EORJMPEN	(1 << 27)	/* Jump to next descriptor on EOR */
+#define DCSR_EORSTOPEN	(1 << 26)	/* STOP on an EOR */
+#define DCSR_SETCMPST	(1 << 25)	/* Set Descriptor Compare Status */
+#define DCSR_CLRCMPST	(1 << 24)	/* Clear Descriptor Compare Status */
+#define DCSR_CMPST	(1 << 10)	/* The Descriptor Compare Status */
+#define DCSR_EORINTR	(1 << 9)	/* The end of Receive */
+
+#define DRCMR_MAPVLD	(1 << 7)	/* Map Valid */
+#define DRCMR_CHLNUM	0x1f		/* mask for Channel Number */
+
+#define DDADR_DESCADDR	0xfffffff0	/* Address of next descriptor */
+#define DDADR_STOP	(1 << 0)	/* Stop */
+
+#define DCMD_INCSRCADDR	(1 << 31)	/* Source Address Increment Setting. */
+#define DCMD_INCTRGADDR	(1 << 30)	/* Target Address Increment Setting. */
+#define DCMD_FLOWSRC	(1 << 29)	/* Flow Control by the source. */
+#define DCMD_FLOWTRG	(1 << 28)	/* Flow Control by the target. */
+#define DCMD_STARTIRQEN	(1 << 22)	/* Start Interrupt Enable */
+#define DCMD_ENDIRQEN	(1 << 21)	/* End Interrupt Enable */
+#define DCMD_ENDIAN	(1 << 18)	/* Device Endian-ness. */
+#define DCMD_BURST8	(1 << 16)	/* 8 byte burst */
+#define DCMD_BURST16	(2 << 16)	/* 16 byte burst */
+#define DCMD_BURST32	(3 << 16)	/* 32 byte burst */
+#define DCMD_WIDTH1	(1 << 14)	/* 1 byte width */
+#define DCMD_WIDTH2	(2 << 14)	/* 2 byte width (HalfWord) */
+#define DCMD_WIDTH4	(3 << 14)	/* 4 byte width (Word) */
+#define DCMD_LENGTH	0x01fff		/* length mask (max = 8K - 1) */
+
+/*
+ * Descriptor structure for PXA's DMA engine
+ * Note: this structure must always be aligned to a 16-byte boundary.
+ */
+
+typedef enum {
+	DMA_PRIO_HIGH = 0,
+	DMA_PRIO_MEDIUM = 1,
+	DMA_PRIO_LOW = 2
+} pxa_dma_prio;
+
+/*
+ * DMA registration
+ */
+
+static inline int pxa_request_dma(char *name,
+		pxa_dma_prio prio,
+		void (*irq_handler)(int, void *),
+		void *data)
+{
+	return -ENODEV;
+}
+
+static inline void pxa_free_dma(int dma_ch)
+{
+}
+
+/*
+ * The CE4100 does not have the clk framework implemented and SPI clock can
+ * not be switched on/off or the divider changed.
+ */
+static inline void clk_disable(struct clk *clk)
+{
+}
+
+static inline int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+
+static inline unsigned long clk_get_rate(struct clk *clk)
+{
+	return 3686400;
+}
+
+#endif
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 78f9fd0..e43cb30 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -267,12 +267,17 @@ config SPI_PPC4xx
 
 config SPI_PXA2XX
 	tristate "PXA2xx SSP SPI master"
-	depends on ARCH_PXA && EXPERIMENTAL
-	select PXA_SSP
+	depends on (ARCH_PXA || X86_32) && EXPERIMENTAL
+	select PXA_SSP if ARCH_PXA
+	select SPI_PXA2XX_PCI if !ARCH_PXA
 	help
-	  This enables using a PXA2xx SSP port as a SPI master controller.
-	  The driver can be configured to use any SSP port and additional
-	  documentation can be found a Documentation/spi/pxa2xx.
+	  This enables using a PXA2xx or Sodaville SSP port as a SPI master
+	  controller. The driver can be configured to use any SSP port and
+	  additional documentation can be found a Documentation/spi/pxa2xx.
+
+config SPI_PXA2XX_PCI
+	bool
+	depends on SPI_PXA2XX && PCI
 
 config SPI_S3C24XX
 	tristate "Samsung S3C24XX series SPI"
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 8bc1a5a..bdc4c40 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SPI_GPIO)			+= spi_gpio.o
 obj-$(CONFIG_SPI_IMX)			+= spi_imx.o
 obj-$(CONFIG_SPI_LM70_LLP)		+= spi_lm70llp.o
 obj-$(CONFIG_SPI_PXA2XX)		+= pxa2xx_spi.o
+obj-$(CONFIG_SPI_PXA2XX_PCI)		+= pxa2xx_spi_pci.o
 obj-$(CONFIG_SPI_OMAP_UWIRE)		+= omap_uwire.o
 obj-$(CONFIG_SPI_OMAP24XX)		+= omap2_mcspi.o
 obj-$(CONFIG_SPI_OMAP_100K)		+= omap_spi_100k.o
diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 3802ba6..17c1bfb 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -28,7 +28,6 @@
 #include <linux/spi/spi.h>
 #include <linux/workqueue.h>
 #include <linux/delay.h>
-#include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/slab.h>
 
diff --git a/drivers/spi/pxa2xx_spi_pci.c b/drivers/spi/pxa2xx_spi_pci.c
new file mode 100644
index 0000000..351d8a3
--- /dev/null
+++ b/drivers/spi/pxa2xx_spi_pci.c
@@ -0,0 +1,201 @@
+/*
+ * CE4100's SPI device is more or less the same one as found on PXA
+ *
+ */
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/spi/pxa2xx_spi.h>
+
+struct awesome_struct {
+	struct ssp_device ssp;
+	struct platform_device spi_pdev;
+	struct pxa2xx_spi_master spi_pdata;
+};
+
+static DEFINE_MUTEX(ssp_lock);
+static LIST_HEAD(ssp_list);
+
+struct ssp_device *pxa_ssp_request(int port, const char *label)
+{
+	struct ssp_device *ssp = NULL;
+
+	mutex_lock(&ssp_lock);
+
+	list_for_each_entry(ssp, &ssp_list, node) {
+		if (ssp->port_id == port && ssp->use_count == 0) {
+			ssp->use_count++;
+			ssp->label = label;
+			break;
+		}
+	}
+
+	mutex_unlock(&ssp_lock);
+
+	if (&ssp->node == &ssp_list)
+		return NULL;
+
+	return ssp;
+}
+EXPORT_SYMBOL_GPL(pxa_ssp_request);
+
+void pxa_ssp_free(struct ssp_device *ssp)
+{
+	mutex_lock(&ssp_lock);
+	if (ssp->use_count) {
+		ssp->use_count--;
+		ssp->label = NULL;
+	} else
+		dev_err(&ssp->pdev->dev, "device already free\n");
+	mutex_unlock(&ssp_lock);
+}
+EXPORT_SYMBOL_GPL(pxa_ssp_free);
+
+static void plat_dev_release(struct device *dev)
+{
+	struct awesome_struct *as = container_of(dev,
+			struct awesome_struct, spi_pdev.dev);
+
+	of_device_node_put(&as->spi_pdev.dev);
+}
+
+static int __devinit ce4100_spi_probe(struct pci_dev *dev,
+		const struct pci_device_id *ent)
+{
+	int ret;
+	resource_size_t phys_beg;
+	resource_size_t phys_len;
+	struct awesome_struct *spi_info;
+	struct platform_device *pdev;
+	struct pxa2xx_spi_master *spi_pdata;
+	struct ssp_device *ssp;
+
+	ret = pci_enable_device(dev);
+	if (ret)
+		return ret;
+
+	phys_beg = pci_resource_start(dev, 0);
+	phys_len = pci_resource_len(dev, 0);
+
+	if (!request_mem_region(phys_beg, phys_len,
+				"CE4100 SPI")) {
+		dev_err(&dev->dev, "Can't request register space.\n");
+		ret = -EBUSY;
+		return ret;
+	}
+
+	spi_info = kzalloc(sizeof(*spi_info), GFP_KERNEL);
+	if (!spi_info) {
+		ret = -ENOMEM;
+		goto err_kz;
+	}
+	ssp = &spi_info->ssp;
+	pdev = &spi_info->spi_pdev;
+	spi_pdata =  &spi_info->spi_pdata;
+
+	pdev->name = "pxa2xx-spi";
+	pdev->id = dev->devfn;
+	pdev->dev.parent = &dev->dev;
+	pdev->dev.platform_data = &spi_info->spi_pdata;
+
+#ifdef CONFIG_OF
+	pdev->dev.of_node = dev->dev.of_node;
+#endif
+	pdev->dev.release = plat_dev_release;
+
+	spi_pdata->num_chipselect = dev->devfn;
+
+	ssp->phys_base = pci_resource_start(dev, 0);
+	ssp->mmio_base = ioremap(phys_beg, phys_len);
+	if (!ssp->mmio_base) {
+		dev_err(&pdev->dev, "failed to ioremap() registers\n");
+		ret = -EIO;
+		goto err_remap;
+	}
+	ssp->irq = dev->irq;
+	ssp->port_id = pdev->id;
+	ssp->type = PXA25x_SSP;
+
+	mutex_lock(&ssp_lock);
+	list_add(&ssp->node, &ssp_list);
+	mutex_unlock(&ssp_lock);
+
+	pci_set_drvdata(dev, spi_info);
+
+	ret = platform_device_register(pdev);
+	if (ret)
+		goto err_dev_add;
+
+	return ret;
+
+err_dev_add:
+	pci_set_drvdata(dev, NULL);
+	mutex_lock(&ssp_lock);
+	list_del(&ssp->node);
+	mutex_unlock(&ssp_lock);
+	iounmap(ssp->mmio_base);
+
+err_remap:
+	kfree(spi_info);
+
+err_kz:
+	release_mem_region(phys_beg, phys_len);
+
+	return ret;
+}
+
+static void __devexit ce4100_spi_remove(struct pci_dev *dev)
+{
+	struct awesome_struct *spi_info;
+	struct platform_device *pdev;
+	struct ssp_device *ssp;
+
+	spi_info = pci_get_drvdata(dev);
+
+	ssp = &spi_info->ssp;
+	pdev = &spi_info->spi_pdev;
+
+	platform_device_unregister(pdev);
+
+	iounmap(ssp->mmio_base);
+	release_mem_region(pci_resource_start(dev, 0),
+			pci_resource_len(dev, 0));
+
+	mutex_lock(&ssp_lock);
+	list_del(&ssp->node);
+	mutex_unlock(&ssp_lock);
+
+	pci_set_drvdata(dev, NULL);
+	pci_disable_device(dev);
+	kfree(spi_info);
+}
+
+static struct pci_device_id ce4100_spi_devices[] __devinitdata = {
+
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2e6a) },
+	{ },
+};
+MODULE_DEVICE_TABLE(pci, ce4100_spi_devices);
+
+static struct pci_driver ce4100_spi_driver = {
+	.name           = "ce4100_spi",
+	.id_table       = ce4100_spi_devices,
+	.probe          = ce4100_spi_probe,
+	.remove         = __devexit_p(ce4100_spi_remove),
+};
+
+static int __init ce4100_spi_init(void)
+{
+	return pci_register_driver(&ce4100_spi_driver);
+}
+module_init(ce4100_spi_init);
+
+static void __exit ce4100_spi_exit(void)
+{
+	pci_unregister_driver(&ce4100_spi_driver);
+}
+module_exit(ce4100_spi_exit);
+
+MODULE_DESCRIPTION("CE4100 PCI-SPI glue code for PXA's driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Sebastian Andrzej Siewior <bigeasy@linutronix.de>");
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 471ed68..48b8f6b 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -19,7 +19,6 @@
 #define __linux_pxa2xx_spi_h
 
 #include <linux/pxa2xx_ssp.h>
-#include <mach/dma.h>
 
 #define PXA2XX_CS_ASSERT (0x01)
 #define PXA2XX_CS_DEASSERT (0x02)
@@ -44,6 +43,15 @@ struct pxa2xx_spi_chip {
 	void (*cs_control)(u32 command);
 };
 
+#ifdef CONFIG_ARCH_PXA
+
+#include <linux/clk.h>
+#include <mach/dma.h>
+
 extern void pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_master *info);
 
+#else
+#include <asm/pxa2xx_spi_ce4100.h>
+
+#endif
 #endif
-- 
1.7.3.2
