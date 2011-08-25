From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 25 Aug 2011 11:03:37 +0200
Subject: [PATCH 3/3] dmaengine i.MX SDMA: use request_firmware_nowait
In-Reply-To: <1314263017-18099-1-git-send-email-s.hauer@pengutronix.de>
References: <1314263017-18099-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1314263017-18099-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The firmware blob may not be available when the driver
probes. Instead of blocking the whole kernel use
request_firmware_nowait() and continue without firmware.
The ROM scripts can already be used then if available.
For the devicetree case the ROM scripts are not available,
still the probe function should not block. The driver
will be unusable in this case, but we have no way of
detecting this properly. The configuration of the dma
channels will fail, so nothing bad should happen.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 8abf8c1..b5cc27d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1143,18 +1143,17 @@ static void sdma_add_scripts(struct sdma_engine *sdma,
 			saddr_arr[i] = addr_arr[i];
 }
 
-static int __init sdma_get_firmware(struct sdma_engine *sdma,
-		const char *fw_name)
+static void sdma_load_firmware(const struct firmware *fw, void *context)
 {
-	const struct firmware *fw;
+	struct sdma_engine *sdma = context;
 	const struct sdma_firmware_header *header;
-	int ret;
 	const struct sdma_script_start_addrs *addr;
 	unsigned short *ram_code;
 
-	ret = request_firmware(&fw, fw_name, sdma->dev);
-	if (ret)
-		return ret;
+	if (!fw) {
+		dev_err(sdma->dev, "firmware not found\n");
+		return;
+	}
 
 	if (fw->size < sizeof(*header))
 		goto err_firmware;
@@ -1184,6 +1183,16 @@ static int __init sdma_get_firmware(struct sdma_engine *sdma,
 
 err_firmware:
 	release_firmware(fw);
+}
+
+static int __init sdma_get_firmware(struct sdma_engine *sdma,
+		const char *fw_name)
+{
+	int ret;
+
+	ret = request_firmware_nowait(THIS_MODULE,
+			FW_ACTION_HOTPLUG, fw_name, sdma->dev,
+			GFP_KERNEL, sdma, sdma_load_firmware);
 
 	return ret;
 }
-- 
1.7.5.4
