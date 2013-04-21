From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 21 Apr 2013 20:03:18 +0200
Subject: [PATCH 1/3] ARM: S3C24XX: split s3c2412 spi dma channels
In-Reply-To: <201304212002.31082.heiko@sntech.de>
References: <201304212002.31082.heiko@sntech.de>
Message-ID: <201304212003.19031.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While s3c24xx before s3c2412 (2410, 2440, 2442) use one dma channel
for both sending and receiving spi data, all later s3c24xx socs use
separate channels.

To keep with the structure of "one spi channel" s3c2412 introduced
a channel_rx attribute to the map and selects the correct request
channel depending on the dma direction, hiding the underlying
separation from view.

The s3c24xx-spi driver, which would need this, currently does not
use dma at all, but as s3c2443 has both highspeed (spi0) and regular
(spi1) controllers and also uses the split scheme a future dma support
for s3c24xx-spi would in any case need to differentiate between
old-style and new-style spi channel structure.

Thus we can swtch to the split channel structure like in later socs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/dma-s3c2412.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/dma-s3c2412.c b/arch/arm/mach-s3c24xx/dma-s3c2412.c
index c0e8c3f..8d8a679 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2412.c
@@ -49,16 +49,26 @@ static struct s3c24xx_dma_map __initdata s3c2412_dma_mappings[] = {
 		.channels	= MAP(S3C2412_DMAREQSEL_SDI),
 		.channels_rx	= MAP(S3C2412_DMAREQSEL_SDI),
 	},
-	[DMACH_SPI0] = {
-		.name		= "spi0",
-		.channels	= MAP(S3C2412_DMAREQSEL_SPI0TX),
+	[DMACH_SPI0_RX] = {
+		.name		= "spi0-rx",
+		.channels	= MAP(S3C2412_DMAREQSEL_SPI0RX),
 		.channels_rx	= MAP(S3C2412_DMAREQSEL_SPI0RX),
 	},
-	[DMACH_SPI1] = {
-		.name		= "spi1",
-		.channels	= MAP(S3C2412_DMAREQSEL_SPI1TX),
+	[DMACH_SPI0_TX] = {
+		.name		= "spi0-tx",
+		.channels	= MAP(S3C2412_DMAREQSEL_SPI0TX),
+		.channels_rx	= MAP(S3C2412_DMAREQSEL_SPI0TX),
+	},
+	[DMACH_SPI1_RX] = {
+		.name		= "spi1-rx",
+		.channels	= MAP(S3C2412_DMAREQSEL_SPI1RX),
 		.channels_rx	= MAP(S3C2412_DMAREQSEL_SPI1RX),
 	},
+	[DMACH_SPI1_TX] = {
+		.name		= "spi1-tx",
+		.channels	= MAP(S3C2412_DMAREQSEL_SPI1TX),
+		.channels_rx	= MAP(S3C2412_DMAREQSEL_SPI1TX),
+	},
 	[DMACH_UART0] = {
 		.name		= "uart0",
 		.channels	= MAP(S3C2412_DMAREQSEL_UART0_0),
-- 
1.7.2.3
