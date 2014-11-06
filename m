From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu,  6 Nov 2014 17:20:12 +0000
Subject: [PATCH] DMA: Fix allocation size for PL330 data buffer depth.
Message-ID: <1415294412-13818-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The datasheet for PL330 says that the data buffer value in the CRD
register is 10bits wide. However, the value stored is "minus one",
which the driver corrects for. Maximum value that the data buffer
depth can have is 1024 lines, which requires 11 bits for storage.

While making updates I found printing the peripheral ID as a hex
value to be more useful as the datasheet shows the values that way.

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/dma/pl330.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 4839bfa..7f62b73 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -271,7 +271,7 @@ struct pl330_config {
 #define DMAC_MODE_NS	(1 << 0)
 	unsigned int	mode;
 	unsigned int	data_bus_width:10; /* In number of bits */
-	unsigned int	data_buf_dep:10;
+	unsigned int	data_buf_dep:11;
 	unsigned int	num_chan:4;
 	unsigned int	num_peri:6;
 	u32		peri_ns;
@@ -2732,7 +2732,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 
 
 	dev_info(&adev->dev,
-		"Loaded driver for PL330 DMAC-%d\n", adev->periphid);
+		"Loaded driver for PL330 DMAC-%x\n", adev->periphid);
 	dev_info(&adev->dev,
 		"\tDBUFF-%ux%ubytes Num_Chans-%u Num_Peri-%u Num_Events-%u\n",
 		pcfg->data_buf_dep, pcfg->data_bus_width / 8, pcfg->num_chan,
-- 
2.1.3
