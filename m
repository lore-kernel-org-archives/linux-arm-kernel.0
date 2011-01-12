From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 12 Jan 2011 11:18:14 +0100
Subject: [PATCH] dmaengine i.MX SDMA: Fix firmware loading
In-Reply-To: <1294827494-15092-1-git-send-email-s.hauer@pengutronix.de>
References: <1294827494-15092-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1294827494-15092-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When loading the microcode to the SDMA engine we have to use
the ram_code_start_addr found in the firmware image. The copy
in the sdma engine is not initialized correctly. This is broken
since:
5b28aa3 dmaengine i.MX SDMA: Allow to run without firmware

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/dma/imx-sdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d5a5d4d..75df8b9 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1135,7 +1135,7 @@ static int __init sdma_get_firmware(struct sdma_engine *sdma,
 	/* download the RAM image for SDMA */
 	sdma_load_script(sdma, ram_code,
 			header->ram_code_size,
-			sdma->script_addrs->ram_code_start_addr);
+			addr->ram_code_start_addr);
 	clk_disable(sdma->clk);
 
 	sdma_add_scripts(sdma, addr);
-- 
1.7.2.3
