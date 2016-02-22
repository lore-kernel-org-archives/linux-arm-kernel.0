From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Feb 2016 22:51:13 +0100
Subject: [PATCH] fs: crypto: add CONFIG_BLOCK dependency
Message-ID: <1456177885-1571303-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added generic crypto abstraction for file systems operates
on 'struct bio' objects, which do not exist when CONFIG_BLOCK is
disabled:

fs/crypto/crypto.c: In function 'fscrypt_zeroout_range':
fs/crypto/crypto.c:308:9: error: implicit declaration of function 'bio_alloc' [-Werror=implicit-function-declaration]

This adds a Kconfig dependency that prevents FS_ENCRYPTION from being
enabled without BLOCK.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 846c506fadf7 ("fs crypto: add Makefile and Kconfig")
---
 fs/crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
index fc5a4f94c87d..9bea124e274b 100644
--- a/fs/crypto/Kconfig
+++ b/fs/crypto/Kconfig
@@ -1,5 +1,6 @@
 config FS_ENCRYPTION
 	bool "FS Encryption (Per-file encryption)"
+	depends on BLOCK
 	select CRYPTO_AES
 	select CRYPTO_CBC
 	select CRYPTO_ECB
-- 
2.7.0
