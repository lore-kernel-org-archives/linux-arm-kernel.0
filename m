From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 12 Jan 2018 11:42:33 +0100
Subject: [PATCH] spi: orion: Fix clock resource by adding an optional bus clock
Message-ID: <20180112104233.4952-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Armada 7K/8K we need to explicitly enable the bus clock. The bus clock
is optional because not all the SoCs need them but at least for Armada
7K/8K it is actually mandatory.

The binding documentation is updating accordingly as well as mentioning
the mandatory clock which was also missing.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/spi/spi-orion.txt |  9 +++++++++
 drivers/spi/spi-orion.c                             | 14 ++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-orion.txt b/Documentation/devicetree/bindings/spi/spi-orion.txt
index df8ec31f2f07..8434a65fc12a 100644
--- a/Documentation/devicetree/bindings/spi/spi-orion.txt
+++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
@@ -18,8 +18,17 @@ Required properties:
 	The eight register sets following the control registers refer to
 	chip-select lines 0 through 7 respectively.
 - cell-index : Which of multiple SPI controllers is this.
+- clocks : pointers to the reference clocks for this device, the first
+	   one is the one used for the clock on the spi bus, the
+	   second one is optional and is the clock used for the
+	   functional part of the controller
+
 Optional properties:
 - interrupts : Is currently not used.
+- clock-names : names of used clocks, mandatory if the second clock is
+		used, the name must be "core", and "axi" (the latter
+		is only for Armada 7K/8K).
+
 
 Example:
        spi at 10600 {
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 8974bb340b3a..482a0cf3b7aa 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -94,6 +94,7 @@ struct orion_spi {
 	struct spi_master	*master;
 	void __iomem		*base;
 	struct clk              *clk;
+	struct clk              *axi_clk;
 	const struct orion_spi_dev *devdata;
 
 	struct orion_direct_acc	direct_access[ORION_NUM_CHIPSELECTS];
@@ -634,6 +635,14 @@ static int orion_spi_probe(struct platform_device *pdev)
 	if (status)
 		goto out;
 
+	/* The following clock is only used by some SoCs */
+	spi->axi_clk = devm_clk_get(&pdev->dev, "axi");
+	if (IS_ERR(spi->axi_clk) &&
+	    PTR_ERR(spi->axi_clk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (!IS_ERR(spi->axi_clk))
+		clk_prepare_enable(spi->axi_clk);
+
 	tclk_hz = clk_get_rate(spi->clk);
 
 	/*
@@ -725,6 +734,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 out_rel_pm:
 	pm_runtime_disable(&pdev->dev);
 out_rel_clk:
+	clk_disable_unprepare(spi->axi_clk);
 	clk_disable_unprepare(spi->clk);
 out:
 	spi_master_put(master);
@@ -738,6 +748,7 @@ static int orion_spi_remove(struct platform_device *pdev)
 	struct orion_spi *spi = spi_master_get_devdata(master);
 
 	pm_runtime_get_sync(&pdev->dev);
+	clk_disable_unprepare(spi->axi_clk);
 	clk_disable_unprepare(spi->clk);
 
 	spi_unregister_master(master);
@@ -754,6 +765,7 @@ static int orion_spi_runtime_suspend(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct orion_spi *spi = spi_master_get_devdata(master);
 
+	clk_disable_unprepare(spi->axi_clk);
 	clk_disable_unprepare(spi->clk);
 	return 0;
 }
@@ -763,6 +775,8 @@ static int orion_spi_runtime_resume(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct orion_spi *spi = spi_master_get_devdata(master);
 
+	if (!IS_ERR(spi->axi_clk))
+		clk_prepare_enable(spi->axi_clk);
 	return clk_prepare_enable(spi->clk);
 }
 #endif
-- 
2.15.1
