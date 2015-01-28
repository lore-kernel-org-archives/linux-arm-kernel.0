From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 21:09:16 +0100
Subject: [PATCH] crypto: atmel: remove bogus select
Message-ID: <1780191.gdgDmCPaN0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Atmel at91 crypto driver unconditionally selects AT_HDMAC,
which results in a Kconfig warning if that driver is not enabled:

warning: (CRYPTO_DEV_ATMEL_AES) selects AT_HDMAC which has unmet direct dependencies (DMADEVICES && ARCH_AT91)

The crypty driver itself does not actually have a dependency
on a particular dma engine, other than this being the one that
is used in at91.

Removing the 'select' gets rid of the warning, with no apparent
downsides.
We should probably enable AT_HDMAC in sama5_defconfig, because
it no longers gets enabled implicitly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 2fb0fdfc87df..0c411c0aae99 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -348,7 +348,6 @@ config CRYPTO_DEV_ATMEL_AES
 	select CRYPTO_AES
 	select CRYPTO_ALGAPI
 	select CRYPTO_BLKCIPHER
-	select AT_HDMAC
 	help
 	  Some Atmel processors have AES hw accelerator.
 	  Select this if you want to use the Atmel module for
