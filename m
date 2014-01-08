From: Guangyu.Chen@freescale.com (Nicolin Chen)
Date: Wed, 8 Jan 2014 16:45:56 +0800
Subject: [PATCH 2/2] dma: imx-sdma: Assign a default script number for ROM
 firmware cases
In-Reply-To: <1389170756-22351-1-git-send-email-Guangyu.Chen@freescale.com>
References: <1389170756-22351-1-git-send-email-Guangyu.Chen@freescale.com>
Message-ID: <1389170756-22351-3-git-send-email-Guangyu.Chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX series have inner firmware in its ROM code: when SDMA isn't provided
any firmware from Kernel or rootfs, the default inner ROM firmware will be
activated. However the current driver doesn't assign any script number to
this situation, and those platform running in this case would be broken.

Thus this patch adds a default script number when no external firmware being
loaded so that people would continue to be able to use basic scripts to run
their platform without any firmware.

Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 drivers/dma/imx-sdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 1522476..4e79183 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1252,6 +1252,10 @@ static void sdma_add_scripts(struct sdma_engine *sdma,
 	s32 *saddr_arr = (u32 *)sdma->script_addrs;
 	int i;
 
+	/* use the default firmware in ROM if missing external firmware */
+	if (!sdma->script_number)
+		sdma->script_number = SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1;
+
 	for (i = 0; i < sdma->script_number; i++)
 		if (addr_arr[i] > 0)
 			saddr_arr[i] = addr_arr[i];
-- 
1.8.4
