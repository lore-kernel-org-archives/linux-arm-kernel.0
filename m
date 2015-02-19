From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Feb 2015 16:38:19 +0100
Subject: [PATCH v2] crypto: atmel: fix bogus select
Message-ID: <6741924.K1MvntTk7u@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Atmel at91 crypto driver unconditionally selects AT_HDMAC,
which results in a Kconfig warning if that driver is not enabled:

warning: (CRYPTO_DEV_ATMEL_AES) selects AT_HDMAC which has unmet direct dependencies (DMADEVICES && ARCH_AT91)

The crypty driver itself does not actually have a dependency
on a particular dma engine, other than this being the one that
is used in at91.

Removing the 'select' gets rid of the warning, but can cause
the driver to be unusable if the HDMAC is not enabled at the
same time. To work around that, this patch clarifies the runtime
dependency to be '(ARCH_AT91 && AT_XDMAC)', but adds an alternative
for COMPILE_TEST, which lets the driver get build on all systems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: as a result of the discussion with Ludovic, clarify the
dependency.

Please apply for 3.21 if there are no further comments.

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 2fb0fdfc87df..562125183690 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -342,13 +342,12 @@ config CRYPTO_DEV_BFIN_CRC
 
 config CRYPTO_DEV_ATMEL_AES
 	tristate "Support for Atmel AES hw accelerator"
-	depends on ARCH_AT91
+	depends on (ARCH_AT91 && AT_XDMAC) || COMPILE_TEST
 	select CRYPTO_CBC
 	select CRYPTO_ECB
 	select CRYPTO_AES
 	select CRYPTO_ALGAPI
 	select CRYPTO_BLKCIPHER
-	select AT_HDMAC
 	help
 	  Some Atmel processors have AES hw accelerator.
 	  Select this if you want to use the Atmel module for
