From: esmil@mailme.dk (Emil Renner Berthing)
Date: Wed, 31 Oct 2018 11:57:00 +0100
Subject: [PATCH v1 03/14] spi: rockchip: always use SPI mode
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
References: <20181031105711.19575-1-esmil@mailme.dk>
Message-ID: <20181031105711.19575-4-esmil@mailme.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emil Renner Berthing <kernel@esmil.dk>

The hardware supports 3 different variants of SPI
and there were some code around it, but nothing
to actually set it to anything but "Motorola SPI".
Just drop that code and always use that mode.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 87d1b9837d94..7fac4253075e 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -156,12 +156,6 @@
 
 #define ROCKCHIP_SPI_MAX_CS_NUM			2
 
-enum rockchip_ssi_type {
-	SSI_MOTO_SPI = 0,
-	SSI_TI_SSP,
-	SSI_NS_MICROWIRE,
-};
-
 struct rockchip_spi_dma_data {
 	struct dma_chan *ch;
 	dma_addr_t addr;
@@ -179,8 +173,6 @@ struct rockchip_spi {
 	u32 fifo_len;
 	/* max bus freq supported */
 	u32 max_freq;
-	/* supported slave numbers */
-	enum rockchip_ssi_type type;
 
 	u16 mode;
 	u8 tmode;
@@ -525,14 +517,14 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 	u32 dmacr = 0;
 	int rsd = 0;
 
-	u32 cr0 = (CR0_BHT_8BIT << CR0_BHT_OFFSET)
-		| (CR0_SSD_ONE << CR0_SSD_OFFSET)
-		| (CR0_EM_BIG << CR0_EM_OFFSET);
+	u32 cr0 = CR0_FRF_SPI  << CR0_FRF_OFFSET
+	        | CR0_BHT_8BIT << CR0_BHT_OFFSET
+	        | CR0_SSD_ONE  << CR0_SSD_OFFSET
+	        | CR0_EM_BIG   << CR0_EM_OFFSET;
 
 	cr0 |= (rs->n_bytes << CR0_DFS_OFFSET);
 	cr0 |= ((rs->mode & 0x3) << CR0_SCPH_OFFSET);
 	cr0 |= (rs->tmode << CR0_XFM_OFFSET);
-	cr0 |= (rs->type << CR0_FRF_OFFSET);
 
 	if (rs->use_dma) {
 		if (rs->tx)
@@ -709,7 +701,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	spi_enable_chip(rs, false);
 
-	rs->type = SSI_MOTO_SPI;
 	rs->master = master;
 	rs->dev = &pdev->dev;
 	rs->max_freq = clk_get_rate(rs->spiclk);
-- 
2.19.1
