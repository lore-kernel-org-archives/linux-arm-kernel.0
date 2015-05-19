From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 May 2015 14:18:35 +0200
Subject: [PATCH] mac802154: select CRYPTO when needed
Message-ID: <4189396.LhxDXkIPfr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mac802154 subsystem uses functions from the crypto layer and correctly
selects the individual crypto algorithms, but fails to build when the
crypto layer is disabled altogether:

crypto/built-in.o: In function `crypto_ctr_free':
:(.text+0x80): undefined reference to `crypto_drop_spawn'
crypto/built-in.o: In function `crypto_rfc3686_free':
:(.text+0xac): undefined reference to `crypto_drop_spawn'
crypto/built-in.o: In function `crypto_ctr_crypt':
:(.text+0x2f0): undefined reference to `blkcipher_walk_virt_block'
:(.text+0x2f8): undefined reference to `crypto_inc'

To solve that, this patch also selects the core crypto code,
like all other users of that code do.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Found in ARM randconfig testing

diff --git a/net/mac802154/Kconfig b/net/mac802154/Kconfig
index aa462b480a39..b355989c63b3 100644
--- a/net/mac802154/Kconfig
+++ b/net/mac802154/Kconfig
@@ -1,6 +1,7 @@
 config MAC802154
 	tristate "Generic IEEE 802.15.4 Soft Networking Stack (mac802154)"
 	depends on IEEE802154
+	select CRYPTO
 	select CRC_CCITT
 	select CRYPTO_AUTHENC
 	select CRYPTO_CCM
