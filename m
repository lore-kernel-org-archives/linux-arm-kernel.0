From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Jan 2016 14:47:10 +0100
Subject: [PATCH v2 2/2] crypto: jitterentropy - always select CRYPTO_RNG
In-Reply-To: <1453815902-3070323-1-git-send-email-arnd@arndb.de>
References: <1453815902-3070323-1-git-send-email-arnd@arndb.de>
Message-ID: <1453816035-3070440-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building the jitterentropy driver by itself, we get a link error
when CRYPTO_RNG is not enabled as well:

crypto/built-in.o: In function `jent_mod_init':
jitterentropy-kcapi.c:(.init.text+0x98): undefined reference to `crypto_register_rng'
crypto/built-in.o: In function `jent_mod_exit':
jitterentropy-kcapi.c:(.exit.text+0x60): undefined reference to `crypto_unregister_rng'

This adds a 'select CRYPTO_RNG' to CRYPTO_JITTERENTROPY to ensure the API
is always there when it's used, not just when DRBG is also enabled.
CRYPTO_DRBG would set it implicitly through CRYPTO_JITTERENTROPY now,
but this leaves it in place to make it explicit what the driver does.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 3be07ad1d80d..88248821af82 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1595,6 +1595,7 @@ endif	# if CRYPTO_DRBG_MENU
 
 config CRYPTO_JITTERENTROPY
 	tristate "Jitterentropy Non-Deterministic Random Number Generator"
+	select CRYPTO_RNG
 	help
 	  The Jitterentropy RNG is a noise that is intended
 	  to provide seed to another RNG. The RNG does not
-- 
2.7.0
