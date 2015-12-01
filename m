From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Tue,  1 Dec 2015 11:14:59 +0200
Subject: [PATCH 4/4] dmaengine: qcom_bam_dma: add controlled remotely dt
 property
In-Reply-To: <1448961299-15161-1-git-send-email-stanimir.varbanov@linaro.org>
References: <1448961299-15161-1-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <1448961299-15161-5-git-send-email-stanimir.varbanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the peripherals has bam which is controlled by remote
processor, thus the bam dma driver must avoid register writes
which initialise bam hw block. Those registers are protected
from xPU block and any writes to them will lead to secure
violation and system reboot.

Adding the contolled_remotely flag in bam driver to avoid
not permitted register writes in bam_init function.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../devicetree/bindings/dma/qcom_bam_dma.txt       |    2 ++
 drivers/dma/qcom_bam_dma.c                         |    7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
index 1c9d48ea4914..87b6b2bf5e1e 100644
--- a/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
+++ b/Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
@@ -13,6 +13,8 @@ Required properties:
 - clock-names: must contain "bam_clk" entry
 - qcom,ee : indicates the active Execution Environment identifier (0-7) used in
   the secure world.
+- qcom,controlled-remotely : optional, indicates that the bam is controled by
+  remote proccessor i.e. execution enviroment.
 
 Example:
 
diff --git a/drivers/dma/qcom_bam_dma.c b/drivers/dma/qcom_bam_dma.c
index 6d290de9ab2b..5dedab77180a 100644
--- a/drivers/dma/qcom_bam_dma.c
+++ b/drivers/dma/qcom_bam_dma.c
@@ -387,6 +387,7 @@ struct bam_device {
 
 	/* execution environment ID, from DT */
 	u32 ee;
+	bool controlled_remotely;
 
 	const struct reg_offset_data *layout;
 
@@ -1039,6 +1040,9 @@ static int bam_init(struct bam_device *bdev)
 	val = readl_relaxed(bam_addr(bdev, 0, BAM_NUM_PIPES));
 	bdev->num_channels = val & BAM_NUM_PIPES_MASK;
 
+	if (bdev->controlled_remotely)
+		return 0;
+
 	/* s/w reset bam */
 	/* after reset all pipes are disabled and idle */
 	val = readl_relaxed(bam_addr(bdev, 0, BAM_CTRL));
@@ -1126,6 +1130,9 @@ static int bam_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	bdev->controlled_remotely = of_property_read_bool(pdev->dev.of_node,
+						"qcom,controlled-remotely");
+
 	bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
 	if (IS_ERR(bdev->bamclk))
 		return PTR_ERR(bdev->bamclk);
-- 
1.7.9.5
