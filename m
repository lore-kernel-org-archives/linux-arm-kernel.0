From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 10 Mar 2010 18:08:43 +0000
Subject: [PATCH] ARM: Fix Samsung build after "ARM: Eliminate decompressor
	-Dstatic= PIC hack"
In-Reply-To: <20100310175611.GA5403@rakim.wolfsonmicro.main>
References: <20100310175611.GA5403@rakim.wolfsonmicro.main>
Message-ID: <1268244523-17668-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
/home/broonie/git/linux-2.6/arch/arm/boot/compressed/../../../../lib/decompress_
+inflate.c:68: undefined reference to `error'

and so on. Fix this by moving the declaration into uncompress/misc.c
where it is shared with the rest of the code, correcting the definition
as we go.
---

OK, that seemed to be a lot easier than I'd been expecting - I'd been
looking for a header file to place this in when I originally ran into
this.

 arch/arm/boot/compressed/misc.c             |    1 +
 arch/arm/plat-s3c/include/plat/uncompress.h |    2 --
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index d32bc71..d2b2ef4 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -33,6 +33,7 @@ unsigned int __machine_arch_type;
 #else
 
 static void putstr(const char *ptr);
+extern void error(char *x);
 
 #include <mach/uncompress.h>
 
diff --git a/arch/arm/plat-s3c/include/plat/uncompress.h b/arch/arm/plat-s3c/include/plat/uncompress.h
index dc66a47..975eec9 100644
--- a/arch/arm/plat-s3c/include/plat/uncompress.h
+++ b/arch/arm/plat-s3c/include/plat/uncompress.h
@@ -140,8 +140,6 @@ static void arch_decomp_error(const char *x)
 #define arch_error arch_decomp_error
 #endif
 
-static void error(char *err);
-
 #ifdef CONFIG_S3C_BOOT_UART_FORCE_FIFO
 static inline void arch_enable_uart_fifo(void)
 {
-- 
1.7.0
