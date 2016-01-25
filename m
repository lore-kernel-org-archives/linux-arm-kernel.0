From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 17:50:34 +0100
Subject: [PATCH 1/2] crypto: jitterentropy - always select CRYPTO_RNG
Message-ID: <1453740644-1980309-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building the jitterentropy driver by itself, we get a link error
when CRYPTO_RNG is not enabled as well:

crypto/built-in.o: In function `jent_mod_init':
jitterentropy-kcapi.c:(.init.text+0x98): undefined reference to `crypto_register_rng'
crypto/built-in.o: In function `jent_mod_exit':
jitterentropy-kcapi.c:(.exit.text+0x60): undefined reference to `crypto_unregister_rng'

This moves the 'select CRYPTO_RNG' from CRYPTO_DRBG to CRYPTO_JITTERENTROPY
to ensure the API is always there when it's used, not just when DRBG is
also enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 7240821137fd..99109b93604a 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1586,13 +1586,13 @@ config CRYPTO_DRBG_CTR
 config CRYPTO_DRBG
 	tristate
 	default CRYPTO_DRBG_MENU
-	select CRYPTO_RNG
 	select CRYPTO_JITTERENTROPY
 
 endif	# if CRYPTO_DRBG_MENU
 
 config CRYPTO_JITTERENTROPY
 	tristate "Jitterentropy Non-Deterministic Random Number Generator"
+	select CRYPTO_RNG
 	help
 	  The Jitterentropy RNG is a noise that is intended
 	  to provide seed to another RNG. The RNG does not
-- 
2.7.0
