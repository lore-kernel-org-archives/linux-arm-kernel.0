From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Mon, 27 Aug 2012 18:56:42 +0530
Subject: [PATCH V2 4/6] ASoC: Davinci: McASP: add device tree support for McASP
In-Reply-To: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
References: <1346074004-22172-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1346074004-22172-5-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree probe for McASP driver.

Note:
DMA parameters are not populated from DT and will be done later.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
Changes from V1:
	- add more explanation to DT parameters
	- Dont return err if some DT parameters are missing. They will be
	  treated as 0.
	- Through Error warning if num-serializer != "serial-dir" array size

:000000 100644 0000000... e6148ec... A	Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
:100644 100644 34ee2f1... c3eae1d... M	sound/soc/davinci/davinci-mcasp.c
 .../bindings/sound/davinci-mcasp-audio.txt         |   44 +++++++
 sound/soc/davinci/davinci-mcasp.c                  |  124 +++++++++++++++++++-
 2 files changed, 167 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
new file mode 100644
index 0000000..e6148ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -0,0 +1,44 @@
+Texas Instruments McASP controller
+
+Required properties:
+- compatible :
+	"ti,dm646x-mcasp-audio"	: for DM646x platforms
+	"ti,da830-mcasp-audio"	: for both DA830 & DA850 platforms
+
+- reg : Should contain McASP registers offset and length
+- interrupts : Interrupt number for McASP
+- op-mode : I2S/DIT ops mode.
+- tdm-slots : Slots for TDM operation.
+- num-serializer : Serializers used by McASP.
+- serial-dir : A list of serializer pin mode. The list number should be equal
+		to "num-serializer" parameter. Each entry is a number indication
+		serializer pin direction. (0 - INACTIVE, 1 - TX, 2 - RX)
+
+
+Optional properties:
+
+- ti,hwmods : Must be "mcasp<n>", n is controller instance starting 0
+- tx-num-evt : FIFO levels.
+- rx-num-evt : FIFO levels.
+- sram-size-playback : size of sram to be allocated during playback
+- sram-size-capture  : size of sram to be allocated during capture
+
+Example:
+
+mcasp0: mcasp0 at 1d00000 {
+	compatible = "ti,da830-mcasp-audio";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x100000 0x3000>;
+	interrupts = <82 83>;
+	op-mode = <0>;		/* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	num-serializer = <16>;
+	serial-dir = <
+			0 0 0 0	/* 0: INACTIVE, 1: TX, 2: RX */
+			0 0 0 0
+			0 0 0 1
+			2 0 0 0 >;
+	tx-num-evt = <1>;
+	rx-num-evt = <1>;
+};
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 34ee2f1..c3eae1d 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -22,6 +22,9 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -862,6 +865,114 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 
 };
 
+static const struct of_device_id mcasp_dt_ids[] = {
+	{
+		.compatible = "ti,dm646x-mcasp-audio",
+		.data = (void *)MCASP_VERSION_1,
+	},
+	{
+		.compatible = "ti,da830-mcasp-audio",
+		.data = (void *)MCASP_VERSION_2,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mcasp_dt_ids);
+
+static struct snd_platform_data *davinci_mcasp_set_pdata_from_of(
+						struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct snd_platform_data *pdata = NULL;
+	const struct of_device_id *match =
+			of_match_device(of_match_ptr(mcasp_dt_ids), &pdev->dev);
+
+	const u32 *of_serial_dir32;
+	u8 *of_serial_dir;
+	u32 val;
+	int i, ret = 0;
+
+	if (pdev->dev.platform_data) {
+		pdata = pdev->dev.platform_data;
+		return pdata;
+	} else if (match) {
+		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata) {
+			ret = -ENOMEM;
+			goto nodata;
+		}
+	} else {
+		/* control shouldn't reach here. something is wrong */
+		ret = -EINVAL;
+		goto nodata;
+	}
+
+	if (match->data)
+		pdata->version = (u8)((int)match->data);
+
+	ret = of_property_read_u32(np, "op-mode", &val);
+	if (ret >= 0)
+		pdata->op_mode = val;
+
+	ret = of_property_read_u32(np, "tdm-slots", &val);
+	if (ret >= 0)
+		pdata->tdm_slots = val;
+
+	ret = of_property_read_u32(np, "num-serializer", &val);
+	if (ret >= 0)
+		pdata->num_serializer = val;
+
+	of_serial_dir32 = of_get_property(np, "serial-dir", &val);
+	val /= sizeof(u32);
+	if (val != pdata->num_serializer) {
+		dev_err(&pdev->dev,
+				"num-serializer(%d) != serial-dir size(%d)\n",
+				pdata->num_serializer, val);
+		ret = -EINVAL;
+		goto nodata;
+	}
+
+	if (of_serial_dir32) {
+		of_serial_dir = devm_kzalloc(&pdev->dev,
+						(sizeof(*of_serial_dir) * val),
+						GFP_KERNEL);
+		if (!of_serial_dir) {
+			ret = -ENOMEM;
+			goto nodata;
+		}
+
+		for (i = 0; i < pdata->num_serializer; i++)
+			of_serial_dir[i] = be32_to_cpup(&of_serial_dir32[i]);
+
+		pdata->serial_dir = of_serial_dir;
+	}
+
+	ret = of_property_read_u32(np, "tx-num-evt", &val);
+	if (ret >= 0)
+		pdata->txnumevt = val;
+
+	ret = of_property_read_u32(np, "rx-num-evt", &val);
+	if (ret >= 0)
+		pdata->rxnumevt = val;
+
+	ret = of_property_read_u32(np, "sram-size-playback", &val);
+	if (ret >= 0)
+		pdata->sram_size_playback = val;
+
+	ret = of_property_read_u32(np, "sram-size-capture", &val);
+	if (ret >= 0)
+		pdata->sram_size_capture = val;
+
+	return  pdata;
+
+nodata:
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Error populating platform data, err %d\n",
+			ret);
+		pdata = NULL;
+	}
+	return  pdata;
+}
+
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct davinci_pcm_dma_params *dma_data;
@@ -870,11 +981,22 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	struct davinci_audio_dev *dev;
 	int ret;
 
+	if (!pdev->dev.platform_data && !pdev->dev.of_node) {
+		dev_err(&pdev->dev, "No platform data supplied\n");
+		return -EINVAL;
+	}
+
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct davinci_audio_dev),
 			   GFP_KERNEL);
 	if (!dev)
 		return	-ENOMEM;
 
+	pdata = davinci_mcasp_set_pdata_from_of(pdev);
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data\n");
+		return -EINVAL;
+	}
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&pdev->dev, "no mem resource?\n");
@@ -888,7 +1010,6 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	pdata = pdev->dev.platform_data;
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
@@ -986,6 +1107,7 @@ static struct platform_driver davinci_mcasp_driver = {
 	.driver		= {
 		.name	= "davinci-mcasp",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(mcasp_dt_ids),
 	},
 };
 
-- 
1.7.1
