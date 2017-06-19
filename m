From: joe@perches.com (Joe Perches)
Date: Mon, 19 Jun 2017 12:42:18 -0700
Subject: [PATCH v2] spi/bcm63xx: Fix checkpatch warnings
In-Reply-To: <1497896268-5613-1-git-send-email-aravind.thk@gmail.com>
References: <1497896268-5613-1-git-send-email-aravind.thk@gmail.com>
Message-ID: <1497901338.8495.50.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-06-19 at 23:47 +0530, Aravind Thokala wrote:
> This patch fixes the checkpatch.pl warnings on the driver
> file.
[]
> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
[]
> @@ -191,7 +191,7 @@ static inline void bcm_spi_writew(struct bcm63xx_spi *bs,
>  #endif
>  }
>  
> -static const unsigned bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
> +static const unsigned int bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
>  	{ 20000000, SPI_CLK_20MHZ },
>  	{ 12500000, SPI_CLK_12_50MHZ },
>  	{  6250000, SPI_CLK_6_250MHZ },

It's probably better to change this array into a struct
to make the indexing more obvious.

Also the SPI_CLK_MASK uses are a bit obscure.

Perhaps:
---
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 247f71b02235..3cb8d92ee870 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -191,7 +191,10 @@ static inline void bcm_spi_writew(struct bcm63xx_spi *bs,
?#endif
?}
?
-static const unsigned bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
+static const struct {
+	unsigned int speed;
+	unsigned int index;
+} bcm63xx_spi_freq_table[] = {
?	{ 20000000, SPI_CLK_20MHZ },
?	{ 12500000, SPI_CLK_12_50MHZ },
?	{??6250000, SPI_CLK_6_250MHZ },
@@ -213,8 +216,8 @@ static void bcm63xx_spi_setup_transfer(struct spi_device *spi,
?
?	/* Find the closest clock configuration */
?	for (i = 0; i < SPI_CLK_MASK; i++) {
-		if (t->speed_hz >= bcm63xx_spi_freq_table[i][0]) {
-			clk_cfg = bcm63xx_spi_freq_table[i][1];
+		if (t->speed_hz >= bcm63xx_spi_freq_table[i].speed) {
+			clk_cfg = bcm63xx_spi_freq_table[i].index;
?			break;
?		}
?	}
