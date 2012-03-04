From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 4 Mar 2012 19:03:59 +0100
Subject: [PATCH 2/6] ARM: S3C24XX: claim spi channels for hsspi in dma-s3c2443
In-Reply-To: <201203041902.38318.heiko@sntech.de>
References: <201203041902.38318.heiko@sntech.de>
Message-ID: <201203041903.59525.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SoCs starting with the S3C2443 contain SPI controllers compatible with the
spi-s3c64xx driver and therefore need separate dma channels for rx and tx.

This patch introduces dma channel declarations for these and changes the
dma-s3c2443.c accordingly.

None of the older SoCs use the spi-dma at all. Most boards bitbang their
spi use and the spi-s3c24xx driver also does not use the dma system.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/dma-s3c2443.c      |   16 ++++++++++++----
 arch/arm/mach-s3c24xx/include/mach/dma.h |    4 ++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/dma-s3c2443.c b/arch/arm/mach-s3c24xx/dma-s3c2443.c
index e227c47..2d94228 100644
--- a/arch/arm/mach-s3c24xx/dma-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/dma-s3c2443.c
@@ -55,12 +55,20 @@ static struct s3c24xx_dma_map __initdata s3c2443_dma_mappings[] = {
 		.name		= "sdi",
 		.channels	= MAP(S3C2443_DMAREQSEL_SDI),
 	},
-	[DMACH_SPI0] = {
-		.name		= "spi0",
+	[DMACH_SPI0_RX] = {
+		.name		= "spi0-rx",
+		.channels	= MAP(S3C2443_DMAREQSEL_SPI0RX),
+	},
+	[DMACH_SPI0_TX] = {
+		.name		= "spi0-tx",
 		.channels	= MAP(S3C2443_DMAREQSEL_SPI0TX),
 	},
-	[DMACH_SPI1] = { /* only on S3C2443/S3C2450 */
-		.name		= "spi1",
+	[DMACH_SPI1_RX] = { /* only on S3C2443/S3C2450 */
+		.name		= "spi1-rx",
+		.channels	= MAP(S3C2443_DMAREQSEL_SPI1RX),
+	},
+	[DMACH_SPI1_TX] = { /* only on S3C2443/S3C2450 */
+		.name		= "spi1-tx",
 		.channels	= MAP(S3C2443_DMAREQSEL_SPI1TX),
 	},
 	[DMACH_UART0] = {
diff --git a/arch/arm/mach-s3c24xx/include/mach/dma.h b/arch/arm/mach-s3c24xx/include/mach/dma.h
index acbdfec..454831b 100644
--- a/arch/arm/mach-s3c24xx/include/mach/dma.h
+++ b/arch/arm/mach-s3c24xx/include/mach/dma.h
@@ -47,6 +47,10 @@ enum dma_ch {
 	DMACH_UART2_SRC2,
 	DMACH_UART3,		/* s3c2443 has extra uart */
 	DMACH_UART3_SRC2,
+	DMACH_SPI0_TX,		/* s3c2443/2416/2450 hsspi0 */
+	DMACH_SPI0_RX,		/* s3c2443/2416/2450 hsspi0 */
+	DMACH_SPI1_TX,		/* s3c2443/2450 hsspi1 */
+	DMACH_SPI1_RX,		/* s3c2443/2450 hsspi1 */
 	DMACH_MAX,		/* the end entry */
 };
 
-- 
1.7.2.3
