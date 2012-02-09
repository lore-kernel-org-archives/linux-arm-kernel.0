From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  9 Feb 2012 17:14:35 +0100
Subject: [PATCH 1/3] spi: move master of_node init to spi_alloc_master
Message-ID: <1328804077-6121-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: spi-devel-general at lists.sourceforge.net
---
 drivers/spi/spi-altera.c      |    3 ---
 drivers/spi/spi-fsl-lib.c     |    1 -
 drivers/spi/spi-imx.c         |    1 -
 drivers/spi/spi-mpc512x-psc.c |    1 -
 drivers/spi/spi-mpc52xx-psc.c |    1 -
 drivers/spi/spi-mpc52xx.c     |    1 -
 drivers/spi/spi-oc-tiny.c     |    1 -
 drivers/spi/spi-ppc4xx.c      |    1 -
 drivers/spi/spi-pxa2xx-pci.c  |    1 -
 drivers/spi/spi-pxa2xx.c      |    1 -
 drivers/spi/spi-tegra.c       |    1 -
 drivers/spi/spi-xilinx.c      |    1 -
 drivers/spi/spi.c             |    1 +
 13 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index c00d00e..ac6badc 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -270,9 +270,6 @@ static int __devinit altera_spi_probe(struct platform_device *pdev)
 		if (err)
 			goto exit;
 	}
-	/* find platform data */
-	if (!platp)
-		hw->bitbang.master->dev.of_node = pdev->dev.of_node;
 
 	/* register our spi controller */
 	err = spi_bitbang_start(&hw->bitbang);
diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index 2674fad..810aa01 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -133,7 +133,6 @@ int mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 
 	master->transfer = mpc8xxx_spi_transfer;
 	master->cleanup = mpc8xxx_spi_cleanup;
-	master->dev.of_node = dev->of_node;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 	mpc8xxx_spi->dev = dev;
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index c6e697f..bebcd01 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -860,7 +860,6 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
 
 	spi_imx->devtype_data->intctrl(spi_imx, 0);
 
-	master->dev.of_node = pdev->dev.of_node;
 	ret = spi_bitbang_start(&spi_imx->bitbang);
 	if (ret) {
 		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 4c63f77..583d0c5 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -441,7 +441,6 @@ static int __devinit mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	master->setup = mpc512x_psc_spi_setup;
 	master->transfer = mpc512x_psc_spi_transfer;
 	master->cleanup = mpc512x_psc_spi_cleanup;
-	master->dev.of_node = dev->of_node;
 
 	tempp = ioremap(regaddr, size);
 	if (!tempp) {
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 6604715..502c953 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -398,7 +398,6 @@ static int __devinit mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	master->setup = mpc52xx_psc_spi_setup;
 	master->transfer = mpc52xx_psc_spi_transfer;
 	master->cleanup = mpc52xx_psc_spi_cleanup;
-	master->dev.of_node = dev->of_node;
 
 	mps->psc = ioremap(regaddr, size);
 	if (!mps->psc) {
diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 57633d9..1a099f8 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -437,7 +437,6 @@ static int __devinit mpc52xx_spi_probe(struct platform_device *op)
 	master->setup = mpc52xx_spi_setup;
 	master->transfer = mpc52xx_spi_transfer;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
-	master->dev.of_node = op->dev.of_node;
 
 	dev_set_drvdata(&op->dev, master);
 
diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 698018f..d030857 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -266,7 +266,6 @@ static int __devinit tiny_spi_of_probe(struct platform_device *pdev)
 		if (hw->gpio_cs[i] < 0)
 			return -ENODEV;
 	}
-	hw->bitbang.master->dev.of_node = pdev->dev.of_node;
 	val = of_get_property(pdev->dev.of_node,
 			      "clock-frequency", &len);
 	if (val && len >= sizeof(__be32))
diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 98ec532..1aa8b33 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -406,7 +406,6 @@ static int __init spi_ppc4xx_of_probe(struct platform_device *op)
 	master = spi_alloc_master(dev, sizeof *hw);
 	if (master == NULL)
 		return -ENOMEM;
-	master->dev.of_node = np;
 	dev_set_drvdata(dev, master);
 	hw = spi_master_get_devdata(master);
 	hw->master = spi_master_get(master);
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 8caa07d..5012979 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -90,7 +90,6 @@ static int __devinit ce4100_spi_probe(struct pci_dev *dev,
 		goto err_nomem;
 
 	pdev->dev.parent = &dev->dev;
-	pdev->dev.of_node = dev->dev.of_node;
 	ssp = &spi_info->ssp;
 	ssp->phys_base = pci_resource_start(dev, 0);
 	ssp->mmio_base = ioremap(phys_beg, phys_len);
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index dc25bee..7546f49 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1557,7 +1557,6 @@ static int __devinit pxa2xx_spi_probe(struct platform_device *pdev)
 	drv_data->ssp = ssp;
 
 	master->dev.parent = &pdev->dev;
-	master->dev.of_node = pdev->dev.of_node;
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
diff --git a/drivers/spi/spi-tegra.c b/drivers/spi/spi-tegra.c
index ae6d78a..65561be 100644
--- a/drivers/spi/spi-tegra.c
+++ b/drivers/spi/spi-tegra.c
@@ -547,7 +547,6 @@ static int __devinit spi_tegra_probe(struct platform_device *pdev)
 	tspi->rx_dma_req.req_sel = spi_tegra_req_sels[pdev->id];
 	tspi->rx_dma_req.dev = tspi;
 
-	master->dev.of_node = pdev->dev.of_node;
 	ret = spi_register_master(master);
 
 	if (ret < 0)
diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 4c5a663..a7ce78f 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -392,7 +392,6 @@ struct spi_master *xilinx_spi_init(struct device *dev, struct resource *mem,
 
 	master->bus_num = bus_num;
 	master->num_chipselect = num_cs;
-	master->dev.of_node = dev->of_node;
 
 	xspi->mem = *mem;
 	xspi->irq = irq;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b2ccdea..e2f4ca0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -556,6 +556,7 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
 	master->dev.class = &spi_master_class;
 	master->dev.parent = get_device(dev);
 	spi_master_set_devdata(master, &master[1]);
+	master->dev.of_node = dev->of_node;
 
 	return master;
 }
-- 
1.7.7
