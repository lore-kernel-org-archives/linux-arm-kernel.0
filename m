From: code@mmayer.net (Markus Mayer)
Date: Mon,  2 Oct 2017 16:13:47 -0700
Subject: [PATCH 2/2] memory: brcmstb: dpfe: skip downloading firmware when
 possible
In-Reply-To: <20171002231347.8671-1-code@mmayer.net>
References: <20171002231347.8671-1-code@mmayer.net>
Message-ID: <20171002231347.8671-3-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

We want to skip downloading the DPFE firmware from Linux if it was
already downloaded by the boot loader.

The driver now checks if the DCPU is already running and, if so,
whether it can process commands. If the DCPU processes commands
successfully, the driver skips the firmware download step.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 3516ee8..0a7bdbe 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -431,13 +431,25 @@ static int brcmstb_dpfe_download_firmware(struct platform_device *pdev,
 	const void *fw_blob;
 	int ret;
 
+	priv = platform_get_drvdata(pdev);
+
+	/*
+	 * Skip downloading the firmware if the DCPU is already running and
+	 * responding to commands.
+	 */
+	if (is_dcpu_enabled(priv->regs)) {
+		u32 response[MSG_FIELD_MAX];
+
+		ret = __send_command(priv, DPFE_CMD_GET_INFO, response);
+		if (!ret)
+			return 0;
+	}
+
 	ret = request_firmware(&fw, FIRMWARE_NAME, dev);
 	/* request_firmware() prints its own error messages. */
 	if (ret)
 		return ret;
 
-	priv = platform_get_drvdata(pdev);
-
 	ret = __verify_firmware(init, fw);
 	if (ret)
 		return -EFAULT;
-- 
2.7.4
