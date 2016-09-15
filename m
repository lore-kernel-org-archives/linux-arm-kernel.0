From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2016 11:26:22 +0200
Subject: [PATCH] ARM: s3c24xx: Add dma_slave_map for s3c2440 devices
In-Reply-To: <1473877775-7537-1-git-send-email-sam.van.den.berge@telenet.be>
References: <1473877775-7537-1-git-send-email-sam.van.den.berge@telenet.be>
Message-ID: <9078781.4yTPDTPaPN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 14, 2016 8:29:35 PM CEST Sam Van Den Berge wrote:
> This patch updates the s3c24xx dma driver to be able to pass a
> dma_slave_map array via the platform data. This is needed to
> be able to use the new, simpler dmaengine API [1].
> I used the virtual DMA channels as a parameter for the dma_filter
> function. By doing that, I could reuse the existing filter function in
> drivers/dma/s3c24xx-dma.c.
> 
> I have tested this on my mini2440 board with the audio driver.
> (I first applied the audio fixes from Sylwester Nawrocki [2])
> According to my observations, dma_request_slave_channel in the
> function dmaengine_pcm_new in the file
> sound/soc/soc-generic-dmaengine-pcm.c now returns a valid DMA channel
> whereas before no DMA channel was returned at that point.
> 
> Entries for DMACH_XD0, DMACH_XD1 and DMACH_TIMER are missing because I
> don't realy know which driver to use for these.
> 
> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/393635.html
> [2] http://www.spinics.net/lists/arm-kernel/msg521918.html
> 
> Signed-off-by: Sam Van Den Berge <sam.van.den.berge@telenet.be>
> 

Thanks for doing this, once this is merged we should be able to
change all the drivers that currently use this DMA support
(I think just spi, mmc and audio) over to the new dma_request_chan
function.

The logical follow-up after that would be to unify the slave_map
with the s3c24xx_dma_channel tables, along the lines of

--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -475,28 +475,14 @@ static struct resource s3c2443_dma_resource[] = {
 	[6] = DEFINE_RES_IRQ(IRQ_S3C2443_DMA5),
 };
 
-static struct s3c24xx_dma_channel s3c2443_dma_channels[DMACH_MAX] = {
+static struct dma_slave_map s3c2443_dma_channels[] = {
-	[DMACH_XD0] = { S3C24XX_DMA_AHB, true, 17 },
-	[DMACH_XD1] = { S3C24XX_DMA_AHB, true, 18 },
-	[DMACH_SDI] = { S3C24XX_DMA_APB, false, 10 },
-	[DMACH_SPI0_RX] = { S3C24XX_DMA_APB, true, 1 },
-	[DMACH_SPI0_TX] = { S3C24XX_DMA_APB, true, 0 },
-	[DMACH_SPI1_RX] = { S3C24XX_DMA_APB, true, 3 },
-	[DMACH_SPI1_TX] = { S3C24XX_DMA_APB, true, 2 },
+	{ "xd0",	"data",	 S3C_DMA_SLAVE(S3C24XX_DMA_AHB, true,  17) },
+	{ "xd1",	"data",	 S3C_DMA_SLAVE(S3C24XX_DMA_AHB, true,  18) },
+	{ "3c2440-sdi", "data",	 S3C_DMA_SLAVE(S3C24XX_DMA_APB, false, 10) },
+	{ "s3c2410-spi.0", "rx", S3C_DMA_SLAVE(S3C24XX_DMA_APB, true,   1) },
+	{ "s3c2410-spi.0", "tx", S3C_DMA_SLAVE(S3C24XX_DMA_APB, true,   0) },
+	{ "s3c2410-spi.1", "rx", S3C_DMA_SLAVE(S3C24XX_DMA_APB, true,   3) },
+	{ "s3c2410-spi.1", "tx", S3C_DMA_SLAVE(S3C24XX_DMA_APB, true,   2) },
...
 };
 
 static struct s3c24xx_dma_platdata s3c2443_dma_platdata = {

For this patch:

Acked-by: Arnd Bergmann <arnd@arndb.de>
