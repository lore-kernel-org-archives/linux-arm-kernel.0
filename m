From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 23:24 +0200
Subject: [PATCH] dma: imx-sdma: fix another incorrect __init annotation
Message-ID: <38530464.3ymIRX74DK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In e34b731faa7d1 ("dma: imx-sdma: Remove spurious __init annotation on
sdma_probe()"), Mark found an extraneous __init label and fixed it.

However, he missed another one, because now we get this other warning:

WARNING: drivers/dma/imx-sdma.o(.text+0x3bb4): Section mismatch in reference from the function sdma_probe() to the function .init.text:sdma_get_firmware()
The function sdma_probe() references
the function __init sdma_get_firmware().

Same reasoning as the last time, the function may get called at
runtime, so it can't be __init.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 52ce1d21154c..88afc48c2ca7 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1334,7 +1334,7 @@ err_firmware:
 	release_firmware(fw);
 }
 
-static int __init sdma_get_firmware(struct sdma_engine *sdma,
+static int sdma_get_firmware(struct sdma_engine *sdma,
 		const char *fw_name)
 {
 	int ret;
