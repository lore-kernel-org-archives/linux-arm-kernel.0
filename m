From: mike.leach@linaro.org (Mike Leach)
Date: Thu, 15 Nov 2018 01:28:42 +0000
Subject: [RFC PATCH 3/3] amba: coresight: Driver test for new CoreSight UCI
 matching
In-Reply-To: <20181115012842.2353-1-mike.leach@linaro.org>
References: <20181115012842.2353-1-mike.leach@linaro.org>
Message-ID: <20181115012842.2353-4-mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds in logging and modifications to amba driver, etmv4 driver
and DB410C device tree to allow testing of the new UCI component matching
algorithm used for certain class of components on an AMBA bus.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  9 +++++++++
 drivers/amba/bus.c                            | 13 ++++++++++++-
 drivers/hwtracing/coresight/coresight-etm4x.c |  3 ++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index d302d8d639a1..c8b503a63b2c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1368,6 +1368,15 @@
 			};
 		};
 
+		/* add an as yet unsupported CTI for UCI test - CPU-0 */
+		cti at 858000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x858000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+		};
+
 		venus: video-codec at 1d00000 {
 			compatible = "qcom,msm8916-venus";
 			reg = <0x01d00000 0xff000>;
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 6eab977f4314..3a27d655dcc9 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -31,19 +31,30 @@ static int amba_uci_match(const struct amba_id *table, struct amba_device *dev)
 {
 	int ret = 0;
 	struct amba_cs_uci_id *uci;
+	struct device *adev; /* device for test logging */
 
 	uci = table->data;
+	adev = &dev->dev;
 
 	/* no table data - return match on periphid */
-	if (!uci)
+	if (!uci) {
+		dev_info(adev, "uci_match: no UCI, use periphID\n");
 		return 1;
+	}
 
 	if (uci->devarch) {
 		ret = (dev->uci.devtype == uci->devtype) &&
 		       ((dev->uci.devarch & uci->mask) == uci->devarch);
+		dev_info(adev, "device: devtype[%x]; devarch[%x];\n",
+			 dev->uci.devtype, dev->uci.devarch);
+		dev_info(adev, "uci_match: devtype[%x]; devarch[%x]; (%s)\n",
+			 uci->devtype, uci->devarch,
+			 ret ? "match" : "no match");
 	} else {
 		/* devtype only if devarch set to 0 */
 		ret = dev->uci.devtype == uci->devtype;
+		dev_info(adev, "uci_match: devtype-only[%x]; (%s)\n",
+			 uci->devtype, ret ? "match" : "no match");
 	}
 	return ret;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 1dcb7e14ea6b..13d674a02194 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1090,11 +1090,12 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
 	}
 
 static const struct amba_id etm4_ids[] = {
-	ETM4x_AMBA_ID(0x000bb95d),			/* Cortex-A53 */
+	ETM4x_AMBA_UCI_ID(0x000bb95d),	/* C-A53 - UCI optional for test */
 	ETM4x_AMBA_ID(0x000bb95e),			/* Cortex-A57 */
 	ETM4x_AMBA_ID(0x000bb95a),			/* Cortex-A72 */
 	ETM4x_AMBA_ID(0x000bb959),			/* Cortex-A73 */
 	ETM4x_AMBA_UCI_ID(0x000bb9da),			/* Cortex-A35 */
+	ETM4x_AMBA_UCI_ID(0x000bb9a8),	/* CTI PID A53 - test fail UCI match */
 	{},
 };
 
-- 
2.19.1
