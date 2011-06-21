From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 21 Jun 2011 01:09:15 -0400
Subject: [PATCH 4/4] ARM: zImage: allow supplementing appended DTB with
	traditional ATAG data
In-Reply-To: <1308632955-11070-1-git-send-email-nico@fluxnic.net>
References: <1308632955-11070-1-git-send-email-nico@fluxnic.net>
Message-ID: <1308632955-11070-5-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

Some old bootloaders can't be updated to a device tree capable one,
yet they provide ATAGs with memory configuration, the ramdisk address,
the kernel cmdline string, etc.  To allow a device tree enabled
kernel to be used with such bootloaders, it is necessary to convert those
ATAGs into FDT properties and fold them into the DTB appended to zImage.

Currently the following ATAGs are converted:

	ATAG_CMDLINE
	ATAG_MEM (up to 8 memory regions)
	ATAG_INITRD2

If the corresponding information already exists in the appended DTB, it
is replaced, otherwise the required node is created to hold it.

The code looks for ATAGs at the location pointed by the value of r2 upon
entry into the zImage code.  If no ATAGs are found there, an attempt at
finding ATAGs at the typical 0x100 offset from start of RAM is made.
Otherwise the DTB is left unchanged.

Thisstarted from an older patch from John Bonesio <bones@secretlab.ca>,
with contributions from David Brown <davidb@codeaurora.org>.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                        |   11 ++++
 arch/arm/boot/compressed/.gitignore     |    9 +++
 arch/arm/boot/compressed/Makefile       |   23 ++++++-
 arch/arm/boot/compressed/atags_to_fdt.c |   97 +++++++++++++++++++++++++++++++
 arch/arm/boot/compressed/head.S         |   32 ++++++++++
 arch/arm/boot/compressed/libfdt_env.h   |   15 +++++
 arch/arm/boot/compressed/misc.c         |   52 ++++++++++++++++
 7 files changed, 236 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/compressed/atags_to_fdt.c
 create mode 100644 arch/arm/boot/compressed/libfdt_env.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 66b7d1e..166bd2a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1735,6 +1735,17 @@ config ARM_APPENDED_DTB
 	  (dtb) appended to zImage
 	  (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
 
+config ARM_ATAG_DTB_COMPAT
+	bool "Supplement the appended DTB with traditional ATAG information"
+	depends on ARM_APPENDED_DTB
+	help
+	  Some old bootloaders can't be updated to a DTB capable one, yet
+	  they provide ATAGs with memory configuration, the ramdisk address,
+	  the kernel cmdline string, etc.  To allow a device tree enabled
+	  kernel to be used with such bootloaders, this option allows
+	  zImage to extract the information from the ATAG list and store it
+	  at run time into the appended DTB.
+
 config CMDLINE
 	string "Default kernel command string"
 	default ""
diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
index c602896..e0936a1 100644
--- a/arch/arm/boot/compressed/.gitignore
+++ b/arch/arm/boot/compressed/.gitignore
@@ -5,3 +5,12 @@ piggy.lzo
 piggy.lzma
 vmlinux
 vmlinux.lds
+
+# borrowed libfdt files
+fdt.c
+fdt.h
+fdt_ro.c
+fdt_rw.c
+fdt_wip.c
+libfdt.h
+libfdt_internal.h
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 48bead9..4b94995 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -83,19 +83,36 @@ suffix_$(CONFIG_KERNEL_GZIP) = gzip
 suffix_$(CONFIG_KERNEL_LZO)  = lzo
 suffix_$(CONFIG_KERNEL_LZMA) = lzma
 
+# libfdt files for the ATAG compatibility mode
+
+libfdt		:= fdt_rw.c fdt_ro.c fdt_wip.c fdt.c
+libfdt_hdrs	:= fdt.h libfdt.h libfdt_internal.h
+
+libfdt_objs	:= $(addsuffix .o, $(basename $(libfdt)))
+
+$(addprefix $(obj)/,$(libfdt) $(libfdt_hdrs)): $(obj)/%: $(srctree)/scripts/dtc/libfdt/%
+	$(call if_changed,shipped)
+
+$(addprefix $(obj)/,$(libfdt_objs) atags_to_fdt.o): \
+	$(addprefix $(obj)/,$(libfdt_hdrs))
+
+ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
+OBJS	+= $(libfdt_objs) atags_to_fdt.o 
+endif
+
 targets       := vmlinux vmlinux.lds \
 		 piggy.$(suffix_y) piggy.$(suffix_y).o \
 		 font.o font.c head.o misc.o $(OBJS)
 
 # Make sure files are removed during clean
-extra-y       += piggy.gzip piggy.lzo piggy.lzma lib1funcs.S
+extra-y       += piggy.gzip piggy.lzo piggy.lzma lib1funcs.S $(libfdt) $(libfdt_hdrs)
 
 ifeq ($(CONFIG_FUNCTION_TRACER),y)
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
 
-ccflags-y := -fpic -fno-builtin
+ccflags-y := -fpic -fno-builtin -I$(src)
 asflags-y := -Wa,-march=all
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
@@ -118,7 +135,7 @@ LDFLAGS_vmlinux += -X
 LDFLAGS_vmlinux += -T
 
 # For __aeabi_uidivmod
-lib1funcs = $(obj)/lib1funcs.o
+lib1funcs = $(obj)/lib1funcs.o $(obj)/../../lib/lib.a
 
 $(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S FORCE
 	$(call cmd,shipped)
diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
new file mode 100644
index 0000000..d79afd7
--- /dev/null
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -0,0 +1,97 @@
+#include <asm/setup.h>
+#include <libfdt.h>
+
+static int node_offset(void *fdt, const char *node_path)
+{
+	int offset = fdt_path_offset(fdt, node_path);
+	if (offset == -FDT_ERR_NOTFOUND)
+		offset = fdt_add_subnode(fdt, 0, node_path);
+	return offset;
+}
+
+static int setprop(void *fdt, const char *node_path, const char *property,
+		   uint32_t *val_array, int size)
+{
+	int offset = node_offset(fdt, node_path);
+	if (offset < 0)
+		return offset;
+	return fdt_setprop(fdt, offset, property, val_array, size);
+}
+
+static int setprop_string(void *fdt, const char *node_path,
+			  const char *property, const char *string)
+{
+	int offset = node_offset(fdt, node_path);
+	if (offset < 0)
+		return offset;
+	return fdt_setprop_string(fdt, offset, property, string);
+}
+
+static int setprop_cell(void *fdt, const char *node_path,
+			const char *property, uint32_t val)
+{
+	int offset = node_offset(fdt, node_path);
+	if (offset < 0)
+		return offset;
+	return fdt_setprop_cell(fdt, offset, property, val);
+}
+
+/*
+ * Convert and fold provided ATAGs into the provided FDT.
+ *
+ * REturn values:
+ *    = 0 -> pretend success
+ *    = 1 -> bad ATAG (may retry with another possible ATAG pointer)
+ *    < 0 -> error from libfdt
+ */
+int atags_to_fdt(void *atag_list, void *fdt, int total_space)
+{
+	struct tag *atag = atag_list;
+	uint32_t mem_reg_property[16];
+	int memcount = 0;
+	int ret;
+
+	/* make sure we've got an aligned pointer */
+	if ((u32)atag_list & 0x3)
+		return 1;
+
+	/* if we get a DTB here we're done already */
+	if (*(u32 *)atag_list == fdt32_to_cpu(FDT_MAGIC))
+	       return 0;	
+
+	/* validate the ATAG */
+	if (atag->hdr.tag != ATAG_CORE ||
+	    (atag->hdr.size != tag_size(tag_core) &&
+	     atag->hdr.size != 2))
+		return 1;
+
+	/* let's give it all the room it could need */
+	ret = fdt_open_into(fdt, fdt, total_space);
+	if (ret < 0)
+		return ret;
+
+	for_each_tag(atag, atag_list) {
+		if (atag->hdr.tag == ATAG_CMDLINE) {
+			setprop_string(fdt, "/chosen", "bootargs",
+					atag->u.cmdline.cmdline);
+		} else if (atag->hdr.tag == ATAG_MEM) {
+			if (memcount >= sizeof(mem_reg_property)/sizeof(uint32_t))
+				continue;
+			mem_reg_property[memcount++] = cpu_to_fdt32(atag->u.mem.start);
+			mem_reg_property[memcount++] = cpu_to_fdt32(atag->u.mem.size);
+		} else if (atag->hdr.tag == ATAG_INITRD2) {
+			uint32_t initrd_start, initrd_size;
+			initrd_start = atag->u.initrd.start;
+			initrd_size = atag->u.initrd.size;
+			setprop_cell(fdt, "/chosen", "linux,initrd-start",
+					initrd_start);
+			setprop_cell(fdt, "/chosen", "linux,initrd-end",
+					initrd_start + initrd_size);
+		}
+	}
+
+	if (memcount)
+		setprop(fdt, "/memory", "reg", mem_reg_property, 4*memcount);
+
+	return fdt_pack(fdt);
+}
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index d4f8db2..6ca94d1 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -246,6 +246,38 @@ restart:	adr	r0, LC0
 		cmp	lr, r1
 		bne	dtb_check_done		@ not found
 
+#ifdef CONFIG_ARM_ATAG_DTB_COMPAT
+		/*
+		 * OK... Let's do some funky business here.
+		 * If we do have a DTB appended to zImage, and we do have
+		 * an ATAG list around, we want the later to be translated
+		 * and folded into the former here.  To be on the safe side,
+		 * let's temporarily move  the stack away into the malloc
+		 * area.  No GOT fixup has occurred yet, but none of the
+		 * code we're about to call uses any global variable.
+		*/
+		add	sp, sp, #0x10000
+		stmfd	sp!, {r0-r3, ip, lr}
+		mov	r0, r8
+		mov	r1, r6
+		sub	r2, sp, r6
+		bl	atags_to_fdt
+		
+		/*
+		 * If returned value is 1, there is no ATAG at the location
+		 * pointed by r8.  Try the typical 0x100 offset from start
+		 * of RAM and hope for the best.
+		 */
+		cmp	r0, #1
+		sub	r0, r4, #(TEXT_OFFSET - 0x100)
+		mov	r1, r6
+		sub	r2, sp, r6
+		blne	atags_to_fdt
+
+		ldmfd	sp!, {r0-r3, ip, lr}
+		sub	sp, sp, #0x10000
+#endif
+
 		mov	r8, r6			@ use the appended device tree
 
 		/*
diff --git a/arch/arm/boot/compressed/libfdt_env.h b/arch/arm/boot/compressed/libfdt_env.h
new file mode 100644
index 0000000..1f4e718
--- /dev/null
+++ b/arch/arm/boot/compressed/libfdt_env.h
@@ -0,0 +1,15 @@
+#ifndef _ARM_LIBFDT_ENV_H
+#define _ARM_LIBFDT_ENV_H
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <asm/byteorder.h>
+
+#define fdt16_to_cpu(x)		be16_to_cpu(x)
+#define cpu_to_fdt16(x)		cpu_to_be16(x)
+#define fdt32_to_cpu(x)		be32_to_cpu(x)
+#define cpu_to_fdt32(x)		cpu_to_be32(x)
+#define fdt64_to_cpu(x)		be64_to_cpu(x)
+#define cpu_to_fdt64(x)		cpu_to_be64(x)
+
+#endif
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 832d372..535b14e 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -136,6 +136,58 @@ void *memcpy(void *__dest, __const void *__src, size_t __n)
 	return __dest;
 }
 
+void *memmove(void *__dest, __const void *__src, size_t __n)
+{
+	unsigned char *d = __dest;
+	const unsigned char *s = __src;
+
+	if (__dest == __src)
+		return __dest;
+
+	if (__dest < __src)
+		return memcpy(__dest, __src, __n);
+
+	while (--__n >= 0)
+		d[__n] = s[__n];
+
+	return __dest;
+}
+
+size_t strlen(const char *s)
+{
+	const char *sc;
+
+	for (sc = s; *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
+
+int memcmp(const void *cs, const void *ct, size_t count)
+{
+	const unsigned char *su1, *su2;
+	int res = 0;
+
+	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
+		if ((res = *su1 - *su2) != 0)
+			break;
+	return res;
+}
+
+int strcmp(const char *cs, const char *ct)
+{
+	unsigned char c1, c2;
+
+	while (1) {
+		c1 = *cs++;
+		c2 = *ct++;
+		if (c1 != c2)
+			return c1 < c2 ? -1 : 1;
+		if (!c1)
+			break;
+	}
+	return 0;
+}
+
 /*
  * gzip declarations
  */
-- 
1.7.4
