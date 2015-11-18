From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 16:33:54 +0100
Subject: [PATCH v3] crypto: atmel: fix bogus select
Message-ID: <12173927.U7ILfy5BBh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 0d53d42a56e9a3769847fd03c703876f2c063fb4 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 27 Jan 2015 22:34:04 +0100
Subject: [PATCH] [SUBMITTED] crypto: atmel: fix bogus select

The Atmel at91 crypto driver unconditionally selects AT_HDMAC,
which results in a Kconfig warning if that driver is not enabled:

warning: (CRYPTO_DEV_ATMEL_AES) selects AT_HDMAC which has unmet direct dependencies (DMADEVICES && ARCH_AT91)

The crypto driver itself does not actually have a dependency
on a particular dma engine, other than this being the one that
is used in at91.

Removing the 'select' gets rid of the warning, but can cause
the driver to be unusable if the HDMAC is not enabled at the
same time. To work around that, this patch clarifies the runtime
dependency to be 'AT_HDMAC || AT_XDMAC', but adds an alternative
for COMPILE_TEST, which lets the driver get build on all systems.

The ARCH_AT91 dependency is implied by AT_XDMAC || AT_HDMAC now
and no longer needs to be listed separately.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I found this one in my backlog, it still seems relevant and I forgot
to send a new version after the last round of comments.

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 2569e043317e..5357bc1f9e4b 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -378,10 +378,9 @@ config CRYPTO_DEV_BFIN_CRC
 
 config CRYPTO_DEV_ATMEL_AES
 	tristate "Support for Atmel AES hw accelerator"
-	depends on ARCH_AT91
+	depends on AT_XDMAC || AT_HDMAC || COMPILE_TEST
 	select CRYPTO_AES
 	select CRYPTO_BLKCIPHER
-	select AT_HDMAC
 	help
 	  Some Atmel processors have AES hw accelerator.
 	  Select this if you want to use the Atmel module for
