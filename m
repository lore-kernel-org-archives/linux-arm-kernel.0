From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:17 -0700
Subject: [PATCH 22/31] spi: tegra: use reset framework
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-23-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra's clock driver now provides an implementation of the common
reset API (include/linux/reset.h). Use this instead of the old Tegra-
specific API; that will soon be removed.

Cc: treding at nvidia.com
Cc: pdeschrijver at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi at vger.kernel.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.
---
 drivers/spi/Kconfig              |  3 +++
 drivers/spi/spi-tegra114.c       | 18 +++++++++++++-----
 drivers/spi/spi-tegra20-sflash.c | 18 +++++++++++++-----
 drivers/spi/spi-tegra20-slink.c  | 18 +++++++++++++-----
 4 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index eb1f1ef5fa2e..9fc66e83c1a7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -448,6 +448,7 @@ config SPI_MXS
 config SPI_TEGRA114
 	tristate "NVIDIA Tegra114 SPI Controller"
 	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
+	depends on RESET_CONTROLLER
 	help
 	  SPI driver for NVIDIA Tegra114 SPI Controller interface. This controller
 	  is different than the older SoCs SPI controller and also register interface
@@ -456,6 +457,7 @@ config SPI_TEGRA114
 config SPI_TEGRA20_SFLASH
 	tristate "Nvidia Tegra20 Serial flash Controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on RESET_CONTROLLER
 	help
 	  SPI driver for Nvidia Tegra20 Serial flash Controller interface.
 	  The main usecase of this controller is to use spi flash as boot
@@ -464,6 +466,7 @@ config SPI_TEGRA20_SFLASH
 config SPI_TEGRA20_SLINK
 	tristate "Nvidia Tegra20/Tegra30 SLINK Controller"
 	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
+	depends on RESET_CONTROLLER
 	help
 	  SPI driver for Nvidia Tegra20/Tegra30 SLINK Controller interface.
 
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index aaecfb3ebf58..f62e6e5e90e3 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -17,7 +17,6 @@
  */
 
 #include <linux/clk.h>
-#include <linux/clk/tegra.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
@@ -34,6 +33,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/reset.h>
 #include <linux/spi/spi.h>
 
 #define SPI_COMMAND1				0x000
@@ -174,6 +174,7 @@ struct tegra_spi_data {
 	spinlock_t				lock;
 
 	struct clk				*clk;
+	struct reset_control			*rst;
 	void __iomem				*base;
 	phys_addr_t				phys;
 	unsigned				irq;
@@ -918,9 +919,9 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "CpuXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
-		tegra_periph_reset_assert(tspi->clk);
+		reset_control_assert(tspi->rst);
 		udelay(2);
-		tegra_periph_reset_deassert(tspi->clk);
+		reset_control_deassert(tspi->rst);
 		complete(&tspi->xfer_completion);
 		goto exit;
 	}
@@ -990,9 +991,9 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "DmaXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
-		tegra_periph_reset_assert(tspi->clk);
+		reset_control_assert(tspi->rst);
 		udelay(2);
-		tegra_periph_reset_deassert(tspi->clk);
+		reset_control_deassert(tspi->rst);
 		complete(&tspi->xfer_completion);
 		spin_unlock_irqrestore(&tspi->lock, flags);
 		return IRQ_HANDLED;
@@ -1127,6 +1128,13 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		goto exit_free_irq;
 	}
 
+	tspi->rst = devm_reset_control_get(&pdev->dev, "spi");
+	if (IS_ERR(tspi->rst)) {
+		dev_err(&pdev->dev, "can not get reset\n");
+		ret = PTR_ERR(tspi->rst);
+		goto exit_free_irq;
+	}
+
 	tspi->max_buf_size = SPI_FIFO_DEPTH << 2;
 	tspi->dma_buf_size = DEFAULT_SPI_DMA_BUF_LEN;
 
diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 4dc8e8129459..e6f382b33818 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -32,8 +32,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/reset.h>
 #include <linux/spi/spi.h>
-#include <linux/clk/tegra.h>
 
 #define SPI_COMMAND				0x000
 #define SPI_GO					BIT(30)
@@ -118,6 +118,7 @@ struct tegra_sflash_data {
 	spinlock_t				lock;
 
 	struct clk				*clk;
+	struct reset_control			*rst;
 	void __iomem				*base;
 	unsigned				irq;
 	u32					spi_max_frequency;
@@ -389,9 +390,9 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_sflash_data *tsd)
 		dev_err(tsd->dev,
 			"CpuXfer 0x%08x:0x%08x\n", tsd->command_reg,
 				tsd->dma_control_reg);
-		tegra_periph_reset_assert(tsd->clk);
+		reset_control_assert(tsd->rst);
 		udelay(2);
-		tegra_periph_reset_deassert(tsd->clk);
+		reset_control_deassert(tsd->rst);
 		complete(&tsd->xfer_completion);
 		goto exit;
 	}
@@ -505,6 +506,13 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 		goto exit_free_irq;
 	}
 
+	tsd->rst = devm_reset_control_get(&pdev->dev, "spi");
+	if (IS_ERR(tsd->rst)) {
+		dev_err(&pdev->dev, "can not get reset\n");
+		ret = PTR_ERR(tsd->rst);
+		goto exit_free_irq;
+	}
+
 	init_completion(&tsd->xfer_completion);
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
@@ -520,9 +528,9 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	}
 
 	/* Reset controller */
-	tegra_periph_reset_assert(tsd->clk);
+	reset_control_assert(tsd->rst);
 	udelay(2);
-	tegra_periph_reset_deassert(tsd->clk);
+	reset_control_deassert(tsd->rst);
 
 	tsd->def_command_reg  = SPI_M_S | SPI_CS_SW;
 	tegra_sflash_writel(tsd, tsd->def_command_reg, SPI_COMMAND);
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index e66715ba37ed..1305b8f933ba 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -33,8 +33,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/reset.h>
 #include <linux/spi/spi.h>
-#include <linux/clk/tegra.h>
 
 #define SLINK_COMMAND			0x000
 #define SLINK_BIT_LENGTH(x)		(((x) & 0x1f) << 0)
@@ -167,6 +167,7 @@ struct tegra_slink_data {
 	spinlock_t				lock;
 
 	struct clk				*clk;
+	struct reset_control			*rst;
 	void __iomem				*base;
 	phys_addr_t				phys;
 	unsigned				irq;
@@ -884,9 +885,9 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_slink_data *tspi)
 		dev_err(tspi->dev,
 			"CpuXfer 0x%08x:0x%08x:0x%08x\n", tspi->command_reg,
 				tspi->command2_reg, tspi->dma_control_reg);
-		tegra_periph_reset_assert(tspi->clk);
+		reset_control_assert(tspi->rst);
 		udelay(2);
-		tegra_periph_reset_deassert(tspi->clk);
+		reset_control_deassert(tspi->rst);
 		complete(&tspi->xfer_completion);
 		goto exit;
 	}
@@ -957,9 +958,9 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_slink_data *tspi)
 		dev_err(tspi->dev,
 			"DmaXfer 0x%08x:0x%08x:0x%08x\n", tspi->command_reg,
 				tspi->command2_reg, tspi->dma_control_reg);
-		tegra_periph_reset_assert(tspi->clk);
+		reset_control_assert(tspi->rst);
 		udelay(2);
-		tegra_periph_reset_deassert(tspi->clk);
+		reset_control_assert(tspi->rst);
 		complete(&tspi->xfer_completion);
 		spin_unlock_irqrestore(&tspi->lock, flags);
 		return IRQ_HANDLED;
@@ -1118,6 +1119,13 @@ static int tegra_slink_probe(struct platform_device *pdev)
 		goto exit_free_irq;
 	}
 
+	tspi->rst = devm_reset_control_get(&pdev->dev, "spi");
+	if (IS_ERR(tspi->rst)) {
+		dev_err(&pdev->dev, "can not get reset\n");
+		ret = PTR_ERR(tspi->rst);
+		goto exit_free_irq;
+	}
+
 	tspi->max_buf_size = SLINK_FIFO_DEPTH << 2;
 	tspi->dma_buf_size = DEFAULT_SPI_DMA_BUF_LEN;
 
-- 
1.8.1.5
