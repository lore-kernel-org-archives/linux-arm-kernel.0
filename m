From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 15 Jul 2011 17:44:25 +0800
Subject: [PATCH v2 2/3] dmaengine: imx-sdma: sdma_get_firmware does not need
	to copy fw_name
In-Reply-To: <1310723066-567-1-git-send-email-shawn.guo@linaro.org>
References: <1310723066-567-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1310723066-567-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It does not need to allocate space and copy fw_name in function
sdma_get_firmware().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 4a7aa72..6b839a2 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1125,22 +1125,14 @@ static int __init sdma_get_firmware(struct sdma_engine *sdma,
 		const char *fw_name)
 {
 	const struct firmware *fw;
-	char *fwname;
 	const struct sdma_firmware_header *header;
 	int ret;
 	const struct sdma_script_start_addrs *addr;
 	unsigned short *ram_code;
 
-	fwname = kasprintf(GFP_KERNEL, "%s", fw_name);
-	if (!fwname)
-		return -ENOMEM;
-
-	ret = request_firmware(&fw, fwname, sdma->dev);
-	if (ret) {
-		kfree(fwname);
+	ret = request_firmware(&fw, fw_name, sdma->dev);
+	if (ret)
 		return ret;
-	}
-	kfree(fwname);
 
 	if (fw->size < sizeof(*header))
 		goto err_firmware;
-- 
1.7.4.1
