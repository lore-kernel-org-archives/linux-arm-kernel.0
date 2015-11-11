From: r64343@freescale.com (Jason Liu)
Date: Wed, 11 Nov 2015 17:20:49 +0800
Subject: [PATCH 1/1] dmaengine: imx-sdma: remove __init annotation on
 sdma_event_remap
Message-ID: <1447233649-21464-1-git-send-email-r64343@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdma_probe function will call sdma_event_remap, but sdma_event_remap
marked with the __init annotation which make the kbuild complains as the
following log:

WARNING: drivers/dma/built-in.o(.text+0x56fc): Section mismatch in reference
from the function sdma_probe() to the function .init.text:sdma_event_remap()
The function sdma_probe() references
the function __init sdma_event_remap().
This is often because sdma_probe lacks a __init
annotation or the annotation of sdma_event_remap is wrong.

Remove the __init annotation on sdma_event_remap to kill this build warning

Signed-off-by: Jason Liu <r64343@freescale.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dma/imx-sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 7058d58..0f6fd42 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1462,7 +1462,7 @@ err_firmware:
 
 #define EVENT_REMAP_CELLS 3
 
-static int __init sdma_event_remap(struct sdma_engine *sdma)
+static int sdma_event_remap(struct sdma_engine *sdma)
 {
 	struct device_node *np = sdma->dev->of_node;
 	struct device_node *gpr_np = of_parse_phandle(np, "gpr", 0);
-- 
1.8.3.2
