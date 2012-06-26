From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Jun 2012 16:38:57 +0800
Subject: [PATCH] mmc: mxs-mmc: enable regulator for mmc slot
Message-ID: <1340699937-8163-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If bootloader or platform initialization code does not enable the
power supply to mmc slot, we need to do it in mmc driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/mxs-mmc.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 34a9026..1a29668 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -707,6 +707,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	struct pinctrl *pinctrl;
 	int ret = 0, irq_err, irq_dma;
 	dma_cap_mask_t mask;
+	struct regulator *reg_vmmc;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
@@ -747,6 +748,16 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	host->mmc = mmc;
 	host->sdio_irq_en = 0;
 
+	reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
+	if (!IS_ERR(reg_vmmc)) {
+		ret = regulator_enable(reg_vmmc);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to enable vmmc regulator: %d\n", ret);
+			goto out_mmc_free;
+		}
+	}
+
 	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 	if (IS_ERR(pinctrl)) {
 		ret = PTR_ERR(pinctrl);
-- 
1.7.5.4
