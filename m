From: zoss@devai.org (Zoltan Devai)
Date: Sun, 23 Oct 2011 23:10:44 +0200
Subject: [RFC PATCH 14/15] ARM: uncompress: Get decompress UART info from DT
In-Reply-To: <1319404245-12740-1-git-send-email-zoss@devai.org>
References: <1319404245-12740-1-git-send-email-zoss@devai.org>
Message-ID: <1319404245-12740-14-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the static decompress UART setup in uncompress.h
files to be overridden with an ucuart description in DT.

At a later stage, this may also allow to skip the
inclusion of uncompress.h files on arches which are DT-only,
to get rid of these files completely.

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/Kconfig                  |    9 +++++++
 arch/arm/boot/compressed/Makefile |    7 +++++
 arch/arm/boot/compressed/head.S   |    8 ++++++
 arch/arm/boot/compressed/print.c  |   45 +++++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7a011f4..edfd4b7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1866,6 +1866,15 @@ config ZBOOT_ROM_SH_MOBILE_SDHI
 
 endchoice
 
+config UCUART_DT
+	bool "Configure the decompress UART port from DT"
+	depends on OF
+	help
+	  With this option, the decompressor will use the UART port set up
+	  via the device tree.
+	  This configuration will override the hardcoded settings in any
+	  uncompress.h files.
+
 config ARM_APPENDED_DTB
 	bool "Use appended device tree blob to zImage (EXPERIMENTAL)"
 	depends on OF && !ZBOOT_ROM && EXPERIMENTAL
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index d955d4f..a4a1b8b 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -110,6 +110,13 @@ ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
 OBJS	+= $(libfdt_objs) atags_to_fdt.o
 endif
 
+$(addprefix $(obj)/,$(libfdt_objs) print.o): \
+	$(addprefix $(obj)/,$(libfdt_hdrs))
+
+ifeq ($(CONFIG_UCUART_DT),y)
+OBJS	+= $(libfdt_objs)
+endif
+
 targets       := vmlinux vmlinux.lds \
 		 piggy.$(suffix_y) piggy.$(suffix_y).o \
 		 lib1funcs.o lib1funcs.S font.o font.c head.o misc.o $(OBJS)
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 9f5ac11..b80e5df 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -443,6 +443,14 @@ not_relocated:	mov	r0, #0
 		cmp	r2, r3
 		blo	1b
 
+#ifdef CONFIG_UCUART_DT
+/* Set up the uncompress UART port from DT data */
+		stmfd	sp!, {r0-r3, ip, lr}
+		mov	r0, r6			@ ATAG / DT pointer
+		bl	ucuart_init_dt
+		ldmfd	sp!, {r0-r3, ip, lr}
+#endif /* CONFIG_UCUART_DT */
+
 /*
  * The C runtime environment should now be setup sufficiently.
  * Set up some pointers, and start decompressing.
diff --git a/arch/arm/boot/compressed/print.c b/arch/arm/boot/compressed/print.c
index 1529d15..cbb0dbf 100644
--- a/arch/arm/boot/compressed/print.c
+++ b/arch/arm/boot/compressed/print.c
@@ -49,9 +49,54 @@ void ucuart_init(int base, int regshift, enum ucuart_iotypes iotype,
 		 int flush_val);
 
 void ucuart_init_8250(int base, int regshift, enum ucuart_iotypes iotype);
+void ucuart_init_amba01x(int base);
 
 struct uncompress_uart ucuart;
 
+#ifdef CONFIG_UCUART_DT
+#include <libfdt.h>
+
+/* Just a concept sketch... */
+void ucuart_init_dt(void *fdt)
+{
+	int ret, offset;
+	const void *prop;
+	const int *uart_base, *uart_regshift;
+	enum ucuart_iotypes iotype = UCUART_IO_MEM8;
+
+	ret = fdt_check_header(fdt);
+	if (ret < 0)
+		return;
+
+	offset = fdt_path_offset(fdt, "/chosen");
+	if (offset == -FDT_ERR_NOTFOUND)
+		return;
+
+	prop = fdt_getprop(fdt, offset, "linux,ucuart-8250", NULL);
+	if (!prop) {
+		putstr("non-8250 uart\n");
+		return;
+	}
+
+	prop = fdt_getprop(fdt, offset, "linux,ucuart-io-32", NULL);
+	if (prop)
+		iotype = UCUART_IO_MEM32;
+
+	uart_base = fdt_getprop(fdt, offset, "linux,ucuart-base", NULL);
+	uart_regshift = fdt_getprop(fdt, offset, "linux,ucuart-regshift", NULL);
+
+	prop = fdt_getprop(fdt, offset, "linux,ucuart-8250", NULL);
+	if (prop)
+		ucuart_init_8250(*uart_base, *uart_regshift, iotype);
+
+	prop = fdt_getprop(fdt, offset, "linux,ucuart-amba01x", NULL);
+	if (prop)
+		ucuart_init_amba01x(*uart_base);
+
+	fdt_pack(fdt);
+}
+#endif
+
 #include <mach/uncompress.h>
 
 #ifndef ARCH_UCUART_NONGENERIC
-- 
1.7.4.1
