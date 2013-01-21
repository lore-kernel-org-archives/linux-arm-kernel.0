From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 21 Jan 2013 11:02:43 -0600
Subject: [PATCH] crypto: fix FTBFS with ARM SHA1-asm and THUMB2_KERNEL
Message-ID: <1358787763-1226-1-git-send-email-matt@genesi-usa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The optimized assembler SHA1 code for ARM does not conform to Thumb2
register usage requirements, so it cannot be built when the kernel is
configured with THUMB2_KERNEL.

Fix the FTBFS for now by preventing misconfigurations of the kernel.

Signed-off-by: Matt Sealey <matt@genesi-usa.com>
---
 crypto/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 4641d95..304d60b 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -472,7 +472,7 @@ config CRYPTO_SHA1_SPARC64
 
 config CRYPTO_SHA1_ARM
 	tristate "SHA1 digest algorithm (ARM-asm)"
-	depends on ARM
+	depends on ARM && !THUMB2_KERNEL
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
-- 
1.7.10.4
