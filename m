From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 15:36:17 +0100
Subject: [PATCH] staging: wilc1000: remove extraneous variable
Message-ID: <17929596.uVo1cdZGxo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building wilc1000 with clang currently fails in the staging-next branch:

drivers/staging/wilc1000/wilc_spi.c:123:34: warning: tentative definition of variable with internal linkage has incomplete non-array type 'const struct wilc1000_ops' [-Wtentative-definition-incomplete-type]
static const struct wilc1000_ops wilc1000_spi_ops;

The reason is that wilc1000_ops was left behind after a recent cleanup,
and is completely unused and also uninitialized and const and has an
incomplete type.

Removing the variable is obviously correct, and gets rid of the warning.
No idea why gcc does not complain about it though.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/staging/wilc1000/wilc_spi.c b/drivers/staging/wilc1000/wilc_spi.c
index 86de50c9f7f5..b3d6541b3896 100644
--- a/drivers/staging/wilc1000/wilc_spi.c
+++ b/drivers/staging/wilc1000/wilc_spi.c
@@ -120,8 +120,6 @@ static u8 crc7(u8 crc, const u8 *buffer, u32 len)
 
 #define USE_SPI_DMA     0
 
-static const struct wilc1000_ops wilc1000_spi_ops;
-
 static int wilc_bus_probe(struct spi_device *spi)
 {
 	int ret, gpio;
