From: akurz@blala.de (Alexander Kurz)
Date: Mon, 11 Apr 2016 10:20:46 +0200
Subject: [PATCH] ARM: mach-imx: sdhci-esdhc-imx: initialize DMA mask
Message-ID: <1460362846-2906-1-git-send-email-akurz@blala.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit 7b91369b DMA access got disabled for device drivers with zero
DMA mask property. sdhci-esdhc-imx got blocked from DMA access by this.
Hence: initialize the dma mask to enable access again.

Signed-off-by: Alexander Kurz <akurz@blala.de>
---
 arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c b/arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c
index a5edd7d..3d039ef 100644
--- a/arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c
+++ b/arch/arm/mach-imx/devices/platform-sdhci-esdhc-imx.c
@@ -71,6 +71,7 @@ struct platform_device *__init imx_add_sdhci_esdhc_imx(
 	if (!pdata)
 		pdata = &default_esdhc_pdata;
 
-	return imx_add_platform_device(data->devid, data->id, res,
-			ARRAY_SIZE(res), pdata, sizeof(*pdata));
+	return imx_add_platform_device_dmamask(data->devid, data->id, res,
+			ARRAY_SIZE(res), pdata, sizeof(*pdata),
+			DMA_BIT_MASK(32));
 }
-- 
2.1.4
