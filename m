From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 18 May 2012 15:03:33 +0530
Subject: [PATCH v2 6/6] spi: s3c64xx: add device tree support
In-Reply-To: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1337333613-6216-7-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for device based discovery.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Jaswinder Singh <jaswinder.singh@linaro.org>
---
 .../devicetree/bindings/spi/spi-samsung.txt        |  113 ++++++++
 drivers/spi/spi-s3c64xx.c                          |  277 +++++++++++++++++---
 2 files changed, 358 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
new file mode 100644
index 0000000..59bfc4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -0,0 +1,113 @@
+* Samsung SPI Controller
+
+The Samsung SPI controller is used to interface with various devices such as flash
+and display controllers using the SPI communication interface.
+
+Required SoC Specific Properties:
+
+- compatible: should be one of the following.
+    - samsung,s3c2443-spi: for s3c2443, s3c2416 and s3c2450 platforms
+    - samsung,s3c6410-spi: for s3c6410 platforms
+    - samsung,s5p6440-spi: for s5p6440 and s5p6450 platforms
+    - samsung,s5pv210-spi: for s5pv210 and s5pc110 platforms
+    - samsung,exynos4210-spi: for exynos4 and exynos5 platforms
+
+- reg: physical base address of the controller and length of memory mapped
+  region.
+
+- interrupts: The interrupt number to the cpu. The interrupt specifier format
+  depends on the interrupt controller.
+
+- tx-dma-channel: The dma channel specifier for tx operations. The format of
+  the dma specifier depends on the dma controller.
+
+- rx-dma-channel: The dma channel specifier for rx operations. The format of
+  the dma specifier depends on the dma controller.
+
+Required Board Specific Properties:
+
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+- gpios: The gpio specifier for clock, mosi and miso interface lines (in the
+  order specified). The format of the gpio specifier depends on the gpio
+  controller.
+
+Optional Board Specific Properties:
+
+- samsung,spi-src-clk: If the spi controller includes a internal clock mux to
+  select the clock source for the spi bus clock, this property can be used to
+  indicate the clock to be used for driving the spi bus clock. If not specified,
+  the clock number 0 is used as default.
+
+- num-cs: Specifies the number of chip select lines supported. If
+  not specified, the default number of chip select lines is set to 1.
+
+SPI Controller specific data in SPI slave nodes:
+
+- The spi slave nodes should provide the following information which is required
+  by the spi controller.
+
+  - cs-gpio: A gpio specifier that specifies the gpio line used as
+    the slave select line by the spi controller. The format of the gpio
+    specifier depends on the gpio controller.
+
+  - samsung,spi-feedback-delay: The sampling phase shift to be applied on the
+    miso line (to account for any lag in the miso line). The following are the
+    valid values.
+
+      - 0: No phase shift.
+      - 1: 90 degree phase shift sampling.
+      - 2: 180 degree phase shift sampling.
+      - 3: 270 degree phase shift sampling.
+
+Aliases:
+
+- All the SPI controller nodes should be represented in the aliases node using
+  the following format 'spi{n}' where n is a unique number for the alias.
+
+
+Example:
+
+- SoC Specific Portion:
+
+	spi_0: spi at 12d20000 {
+		compatible = "samsung,exynos4210-spi";
+		reg = <0x12d20000 0x100>;
+		interrupts = <0 66 0>;
+		tx-dma-channel = <&pdma0 5>;
+		rx-dma-channel = <&pdma0 4>;
+	};
+
+- Board Specific Portion:
+
+	spi_0: spi at 12d20000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpios = <&gpa2 4 2 3 0>,
+			<&gpa2 6 2 3 0>,
+			<&gpa2 7 2 3 0>;
+
+		w25q80bw at 0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "w25x80";
+			reg = <0>;
+			spi-max-frequency = <10000>;
+
+			controller-data {
+				cs-gpio = <&gpa2 5 1 0 3>;
+				samsung,spi-feedback-delay = <0>;
+			};
+
+			partition at 0 {
+				label = "U-Boot";
+				reg = <0x0 0x40000>;
+				read-only;
+			};
+
+			partition at 40000 {
+				label = "Kernel";
+				reg = <0x40000 0xc0000>;
+			};
+		};
+	};
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index d84ce7f..95d503f 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -27,6 +27,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 
 #include <mach/dma.h>
 #include <plat/s3c64xx-spi.h>
@@ -136,6 +138,7 @@ struct s3c64xx_spi_dma_data {
 	unsigned		ch;
 	enum dma_data_direction direction;
 	enum dma_ch	dmach;
+	struct property		*dma_prop;
 };
 
 /**
@@ -200,6 +203,7 @@ struct s3c64xx_spi_driver_data {
 	struct samsung_dma_ops		*ops;
 	struct s3c64xx_spi_port_config	*port_conf;
 	unsigned			port_id;
+	unsigned long			gpios[4];
 };
 
 static struct s3c2410_dma_client s3c64xx_spi_dma_client = {
@@ -318,9 +322,11 @@ static int acquire_dma(struct s3c64xx_spi_driver_data *sdd)
 
 	info.direction = sdd->rx_dma.direction;
 	info.fifo = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
+	info.dt_dmach_prop = sdd->rx_dma.dma_prop;
 	sdd->rx_dma.ch = sdd->ops->request(sdd->rx_dma.dmach, &info);
 	info.direction =  sdd->tx_dma.direction;
 	info.fifo = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
+	info.dt_dmach_prop = sdd->tx_dma.dma_prop;
 	sdd->tx_dma.ch = sdd->ops->request(sdd->tx_dma.dmach, &info);
 
 	return 1;
@@ -813,6 +819,50 @@ static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
 	return 0;
 }
 
+static struct s3c64xx_spi_csinfo *s3c64xx_get_slave_ctrldata(
+				struct s3c64xx_spi_driver_data *sdd,
+				struct spi_device *spi)
+{
+	struct s3c64xx_spi_csinfo *cs;
+	struct device_node *slave_np, *data_np;
+	u32 fb_delay = 0;
+
+	slave_np = spi->dev.of_node;
+	if (!slave_np) {
+		dev_err(&spi->dev, "device node not found\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	for_each_child_of_node(slave_np, data_np)
+		if (!strcmp(data_np->name, "controller-data"))
+			break;
+	if (!data_np) {
+		dev_err(&spi->dev, "child node 'controller-data' not found\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	cs = devm_kzalloc(&spi->dev, sizeof(*cs), GFP_KERNEL);
+	if (!cs) {
+		dev_err(&spi->dev, "could not allocate memory for controller"
+					" data\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	cs->line = of_get_named_gpio(data_np, "cs-gpio", 0);
+	if (!gpio_is_valid(cs->line)) {
+		dev_err(&spi->dev, "chip select gpio is invalid\n");
+		return ERR_PTR(-EINVAL);
+	}
+	if (devm_gpio_request(&spi->dev, cs->line, "spi-cs")) {
+		dev_err(&spi->dev, "gpio [%d] request failed\n", cs->line);
+		return ERR_PTR(-EBUSY);
+	}
+
+	of_property_read_u32(data_np, "samsung,spi-feedback-delay", &fb_delay);
+	cs->fb_delay = fb_delay;
+	return cs;
+}
+
 /*
  * Here we only check the validity of requested configuration
  * and save the configuration in a local data-structure.
@@ -828,7 +878,12 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	unsigned long flags;
 	int err = 0;
 
-	if (cs == NULL || cs->set_level == NULL) {
+	if (!cs && spi->dev.of_node) {
+		cs = s3c64xx_get_slave_ctrldata(sdd, spi);
+		spi->controller_data = cs;
+	}
+
+	if (IS_ERR_OR_NULL(cs)) {
 		dev_err(&spi->dev, "No CS for SPI(%d)\n", spi->chip_select);
 		return -ENODEV;
 	}
@@ -964,49 +1019,166 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
 	flush_fifo(sdd);
 }
 
+static int __devinit s3c64xx_spi_get_dmares(
+			struct s3c64xx_spi_driver_data *sdd, bool tx)
+{
+	struct platform_device *pdev = sdd->pdev;
+	struct s3c64xx_spi_dma_data *dma_data;
+	struct property *prop;
+	struct resource *res;
+	char prop_name[15], *chan_str;
+
+	if (tx) {
+		dma_data = &sdd->tx_dma;
+		dma_data->direction = DMA_TO_DEVICE;
+		chan_str = "tx";
+	} else {
+		dma_data = &sdd->rx_dma;
+		dma_data->direction = DMA_FROM_DEVICE;
+		chan_str = "rx";
+	}
+
+	if (!sdd->pdev->dev.of_node) {
+		res = platform_get_resource(pdev, IORESOURCE_DMA, tx ? 0 : 1);
+		if (!res) {
+			dev_err(&pdev->dev, "Unable to get SPI-%s dma "
+					"resource\n", chan_str);
+			return -ENXIO;
+		}
+		dma_data->dmach = res->start;
+		return 0;
+	}
+
+	sprintf(prop_name, "%s-dma-channel", chan_str);
+	prop = of_find_property(pdev->dev.of_node, prop_name, NULL);
+	if (!prop) {
+		dev_err(&pdev->dev, "%s dma channel property not specified\n",
+					chan_str);
+		return -ENXIO;
+	}
+
+	dma_data->dmach = DMACH_DT_PROP;
+	dma_data->dma_prop = prop;
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static int s3c64xx_spi_parse_dt_gpio(struct s3c64xx_spi_driver_data *sdd)
+{
+	struct device *dev = &sdd->pdev->dev;
+	int idx, gpio, ret;
+
+	/* find gpios for mosi, miso and clock lines */
+	for (idx = 0; idx < 3; idx++) {
+		gpio = of_get_gpio(dev->of_node, idx);
+		if (!gpio_is_valid(gpio)) {
+			dev_err(dev, "invalid gpio[%d]: %d\n", idx, gpio);
+			goto free_gpio;
+		}
+
+		ret = gpio_request(gpio, "spi-bus");
+		if (ret) {
+			dev_err(dev, "gpio [%d] request failed\n", gpio);
+			goto free_gpio;
+		}
+	}
+	return 0;
+
+free_gpio:
+	while (--idx >= 0)
+		gpio_free(sdd->gpios[idx]);
+	return -EINVAL;
+}
+
+static void s3c64xx_spi_dt_gpio_free(struct s3c64xx_spi_driver_data *sdd)
+{
+	unsigned int idx;
+	for (idx = 0; idx < 3; idx++)
+		gpio_free(sdd->gpios[idx]);
+}
+
+static struct __devinit s3c64xx_spi_info * s3c64xx_spi_parse_dt(
+						struct device *dev)
+{
+	struct s3c64xx_spi_info *sci;
+	u32 temp;
+
+	sci = devm_kzalloc(dev, sizeof(*sci), GFP_KERNEL);
+	if (!sci) {
+		dev_err(dev, "memory allocation for spi_info failed\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (of_property_read_u32(dev->of_node, "samsung,spi-src-clk", &temp)) {
+		dev_warn(dev, "spi bus clock parent not specified, using "
+				"clock at index 0 as parent\n");
+		sci->src_clk_nr = 0;
+	} else {
+		sci->src_clk_nr = temp;
+	}
+
+	if (of_property_read_u32(dev->of_node, "num-cs", &temp)) {
+		dev_warn(dev, "number of chip select lines not specified, "
+				"assuming 1 chip select line\n");
+		sci->num_cs = 1;
+	} else {
+		sci->num_cs = temp;
+	}
+
+	return sci;
+}
+#else
+static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
+{
+	return dev->platform_data;
+}
+
+static int s3c64xx_spi_parse_dt_gpio(struct s3c64xx_spi_driver_data *sdd)
+{
+	return -EINVAL;
+}
+
+static void s3c64xx_spi_dt_gpio_free(struct s3c64xx_spi_driver_data *sdd)
+{
+}
+#endif
+
+static const struct of_device_id s3c64xx_spi_dt_match[];
+
 static inline struct s3c64xx_spi_port_config *s3c64xx_spi_get_port_config(
 						struct platform_device *pdev)
 {
+#ifdef CONFIG_OF
+	if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+		match = of_match_node(s3c64xx_spi_dt_match, pdev->dev.of_node);
+		return (struct s3c64xx_spi_port_config *)match->data;
+	}
+#endif
 	return (struct s3c64xx_spi_port_config *)
 			 platform_get_device_id(pdev)->driver_data;
 }
 
 static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 {
-	struct resource	*mem_res, *dmatx_res, *dmarx_res;
+	struct resource	*mem_res;
 	struct s3c64xx_spi_driver_data *sdd;
-	struct s3c64xx_spi_info *sci;
+	struct s3c64xx_spi_info *sci = pdev->dev.platform_data;
 	struct spi_master *master;
 	int ret, irq;
 	char clk_name[16];
 
-	if (pdev->id < 0) {
-		dev_err(&pdev->dev,
-				"Invalid platform device id-%d\n", pdev->id);
-		return -ENODEV;
+	if (!sci && pdev->dev.of_node) {
+		sci = s3c64xx_spi_parse_dt(&pdev->dev);
+		if (IS_ERR(sci))
+			return PTR_ERR(sci);
 	}
 
-	if (pdev->dev.platform_data == NULL) {
+	if (!sci) {
 		dev_err(&pdev->dev, "platform_data missing!\n");
 		return -ENODEV;
 	}
 
-	sci = pdev->dev.platform_data;
-
-	/* Check for availability of necessary resource */
-
-	dmatx_res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (dmatx_res == NULL) {
-		dev_err(&pdev->dev, "Unable to get SPI-Tx dma resource\n");
-		return -ENXIO;
-	}
-
-	dmarx_res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (dmarx_res == NULL) {
-		dev_err(&pdev->dev, "Unable to get SPI-Rx dma resource\n");
-		return -ENXIO;
-	}
-
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (mem_res == NULL) {
 		dev_err(&pdev->dev, "Unable to get SPI MEM resource\n");
@@ -1030,18 +1202,34 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 
 	sdd = spi_master_get_devdata(master);
 	sdd->port_conf = s3c64xx_spi_get_port_config(pdev);
+
 	sdd->master = master;
 	sdd->cntrlr_info = sci;
 	sdd->pdev = pdev;
 	sdd->sfr_start = mem_res->start;
-	sdd->tx_dma.dmach = dmatx_res->start;
-	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
-	sdd->rx_dma.dmach = dmarx_res->start;
-	sdd->rx_dma.direction = DMA_DEV_TO_MEM;
-	sdd->port_id = pdev->id;
+	if (pdev->dev.of_node) {
+		ret = of_alias_get_id(pdev->dev.of_node, "spi");
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to get alias id, "
+						"errno %d\n", ret);
+			goto err0;
+		}
+		sdd->port_id = ret;
+	} else {
+		sdd->port_id = pdev->id;
+	}
 
 	sdd->cur_bpw = 8;
 
+	ret = s3c64xx_spi_get_dmares(sdd, true);
+	if (ret)
+		goto err0;
+
+	ret = s3c64xx_spi_get_dmares(sdd, false);
+	if (ret)
+		goto err0;
+
+	master->dev.of_node = pdev->dev.of_node;
 	master->bus_num = sdd->port_id;
 	master->setup = s3c64xx_spi_setup;
 	master->prepare_transfer_hardware = s3c64xx_spi_prepare_transfer;
@@ -1066,7 +1254,10 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	if (sci->cfg_gpio == NULL || sci->cfg_gpio(pdev)) {
+	if (!sci->cfg_gpio && pdev->dev.of_node) {
+		if (s3c64xx_spi_parse_dt_gpio(sdd))
+			return -EBUSY;
+	} else if (sci->cfg_gpio == NULL || sci->cfg_gpio()) {
 		dev_err(&pdev->dev, "Unable to config gpio\n");
 		ret = -EBUSY;
 		goto err2;
@@ -1147,6 +1338,8 @@ err5:
 err4:
 	clk_put(sdd->clk);
 err3:
+	if (!sdd->cntrlr_info->cfg_gpio && pdev->dev.of_node)
+		s3c64xx_spi_dt_gpio_free(sdd);
 err2:
 	iounmap((void *) sdd->regs);
 err1:
@@ -1178,6 +1371,9 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 	clk_disable(sdd->clk);
 	clk_put(sdd->clk);
 
+	if (!sdd->cntrlr_info->cfg_gpio && pdev->dev.of_node)
+		s3c64xx_spi_dt_gpio_free(sdd);
+
 	iounmap((void *) sdd->regs);
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1202,6 +1398,9 @@ static int s3c64xx_spi_suspend(struct device *dev)
 	clk_disable(sdd->src_clk);
 	clk_disable(sdd->clk);
 
+	if (!sdd->cntrlr_info->cfg_gpio && dev->of_node)
+		s3c64xx_spi_dt_gpio_free(sdd);
+
 	sdd->cur_speed = 0; /* Output Clock is stopped */
 
 	return 0;
@@ -1209,12 +1408,15 @@ static int s3c64xx_spi_suspend(struct device *dev)
 
 static int s3c64xx_spi_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 
-	sci->cfg_gpio(pdev);
+	if (!sci->cfg_gpio && dev->of_node)
+		s3c64xx_spi_parse_dt_gpio(sdd);
+	else
+		sci->cfg_gpio();
+
 
 	/* Enable the clock */
 	clk_enable(sdd->src_clk);
@@ -1352,11 +1554,22 @@ static struct platform_device_id s3c64xx_spi_driver_ids[] = {
 	{ },
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id s3c64xx_spi_dt_match[] = {
+	{ .compatible = "samsung,exynos4210-spi",
+			.data = (void *)EXYNOS4_SPI_PORT_CONFIG,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, s3c64xx_spi_dt_match);
+#endif /* CONFIG_OF */
+
 static struct platform_driver s3c64xx_spi_driver = {
 	.driver = {
 		.name	= "s3c64xx-spi",
 		.owner = THIS_MODULE,
 		.pm = &s3c64xx_spi_pm,
+		.of_match_table = of_match_ptr(s3c64xx_spi_dt_match),
 	},
 	.remove = s3c64xx_spi_remove,
 	.id_table = s3c64xx_spi_driver_ids,
-- 
1.6.6.rc2
