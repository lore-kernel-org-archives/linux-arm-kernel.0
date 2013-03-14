From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 14 Mar 2013 21:10:47 +0100
Subject: [PATCH RFC] ARM: implement "uncompressed zImage"
Message-ID: <1363291847-5624-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
Hello

I didn't do any evaluation about image size and boot speed. You might
like it if currently LZO is your preferred choice because this method
compresses even worse but both compression and decompression are
supposed to be super fast. :-)

Actually the motivation to develop this patch is a different one though.
It's about in-field update and the expectation that transfering a diff
of an uncompressed kernel is cheaper than a complete compressed zImage
(or a diff of a compressed zImage). I won't implement the update
mechanism so I don't have numbers handy about how big the actual
savings are (or if there are savings at all).
Compared to just booting an Image an uncompressed zImage has the upside
of being pic and implementing AUTO_ZRELADDR, ARM_APPENDED_DTB and
ARM_ATAG_DTB_COMPAT.

I don't really expect that this patch makes it into mainline[1], but
maybe it's still helpful for you.

Best regards
Uwe

[1] If you don't agree, probably the help text for KERNEL_CAT needs to
be made more verbose. In the expectation that the patch isn't taken
anyhow I was lazy here. Also the uncat function doesn't use fill and
flush yet.

---
 arch/arm/boot/compressed/Makefile     |  3 ++-
 arch/arm/boot/compressed/decompress.c |  4 ++++
 arch/arm/boot/compressed/piggy.cat.S  |  6 ++++++
 init/Kconfig                          | 12 +++++++++---
 lib/decompress_uncat.c                | 11 +++++++++++
 scripts/Makefile.lib                  |  7 +++++++
 6 files changed, 39 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/compressed/piggy.cat.S
 create mode 100644 lib/decompress_uncat.c

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index afed28e..897e98f 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -88,6 +88,7 @@ suffix_$(CONFIG_KERNEL_GZIP) = gzip
 suffix_$(CONFIG_KERNEL_LZO)  = lzo
 suffix_$(CONFIG_KERNEL_LZMA) = lzma
 suffix_$(CONFIG_KERNEL_XZ)   = xzkern
+suffix_$(CONFIG_KERNEL_CAT)  = cat
 
 # Borrowed libfdt files for the ATAG compatibility mode
 
@@ -112,7 +113,7 @@ targets       := vmlinux vmlinux.lds \
 		 font.o font.c head.o misc.o $(OBJS)
 
 # Make sure files are removed during clean
-extra-y       += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern \
+extra-y       += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern piggy.cat \
 		 lib1funcs.S ashldi3.S $(libfdt) $(libfdt_hdrs)
 
 ifeq ($(CONFIG_FUNCTION_TRACER),y)
diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
index 24b0475..8ecb7f4 100644
--- a/arch/arm/boot/compressed/decompress.c
+++ b/arch/arm/boot/compressed/decompress.c
@@ -51,6 +51,10 @@ extern char * strstr(const char * s1, const char *s2);
 #include "../../../../lib/decompress_unxz.c"
 #endif
 
+#ifdef CONFIG_KERNEL_CAT
+#include "../../../../lib/decompress_uncat.c"
+#endif
+
 int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x))
 {
 	return decompress(input, len, NULL, NULL, output, NULL, error);
diff --git a/arch/arm/boot/compressed/piggy.cat.S b/arch/arm/boot/compressed/piggy.cat.S
new file mode 100644
index 0000000..bda133a
--- /dev/null
+++ b/arch/arm/boot/compressed/piggy.cat.S
@@ -0,0 +1,6 @@
+	.section .piggydata,#alloc
+	.globl	input_data
+input_data:
+	.incbin	"arch/arm/boot/compressed/piggy.cat"
+	.globl	input_data_end
+input_data_end:
diff --git a/init/Kconfig b/init/Kconfig
index 22616cd..b34e480 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -168,9 +168,15 @@ config KERNEL_LZO
 	bool "LZO"
 	depends on HAVE_KERNEL_LZO
 	help
-	  Its compression ratio is the poorest among the choices. The kernel
-	  size is about 10% bigger than gzip; however its speed
-	  (both compression and decompression) is the fastest.
+	  Its compression ratio is the poorest among the choices (apart from
+	  uncompressed below). The kernel size is about 10% bigger than gzip;
+	  however its speed (both compression and decompression) is the
+	  fastest.
+
+config KERNEL_CAT
+	bool "uncompressed"
+	help
+	  Don't use compression at all.
 
 endchoice
 
diff --git a/lib/decompress_uncat.c b/lib/decompress_uncat.c
new file mode 100644
index 0000000..e8b2ad4
--- /dev/null
+++ b/lib/decompress_uncat.c
@@ -0,0 +1,11 @@
+STATIC int uncat(unsigned char *in, int in_size,
+		int (*fill)(void *dest, unsigned int size),
+		int (*flush)(void *src, unsigned int size),
+		unsigned char *out, int *in_used,
+		void (*error)(char *x))
+{
+	memmove(out, in, in_size);
+	return 0;
+}
+
+#define decompress uncat
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 07125e6..00537f5 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -321,6 +321,13 @@ cmd_lzo = (cat $(filter-out FORCE,$^) | \
 	lzop -9 && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
 	(rm -f $@ ; false)
 
+# uncompressed
+# ---------------------------------------------------------------------------
+quiet_cmd_cat = CAT     $@
+cmd_cat = (cat $(filter-out FORCE,$^) \
+	&& $(call size_append, $(filter-out FORCE,$^))) > $@ || \
+	(rm -f $@ ; false)
+
 # U-Boot mkimage
 # ---------------------------------------------------------------------------
 
-- 
1.8.2.rc2
