From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon,  1 Mar 2010 18:52:22 +0000
Subject: [PATCH 2.6.34] ARM: SAMSUNG: Fix build after "ARM: Eliminate
	decompressor -Dstatic= PIC hack"
Message-ID: <1267469542-19633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 5de813b6 (ARM: Eliminate decompressor -Dstatic= PIC hack) among
other things changed the declared type of the error() function to an
extern, conflicting with the forward declartion in the Samsung
plat/uncompress.h which appears to have been relying on the static
being defined away, causing build failures since error() ends up with
a GOT relocation but the linker script discards all GOT relocated
data and functions:

arch/arm/boot/compressed/decompress.o: In function `gunzip':
/home/broonie/git/linux-2.6/arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:68: undefined reference to `error'

and so on. Fix this with minimal invasiveness by fixing the
plat/uncompress.h declaration.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-samsung/include/plat/uncompress.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/uncompress.h b/arch/arm/plat-samsung/include/plat/uncompress.h
index e87ce8f..e41e6d2 100644
--- a/arch/arm/plat-samsung/include/plat/uncompress.h
+++ b/arch/arm/plat-samsung/include/plat/uncompress.h
@@ -140,7 +140,7 @@ static void arch_decomp_error(const char *x)
 #define arch_error arch_decomp_error
 #endif
 
-static void error(char *err);
+extern void error(char *err);
 
 #ifdef CONFIG_S3C_BOOT_UART_FORCE_FIFO
 static inline void arch_enable_uart_fifo(void)
-- 
1.7.0
