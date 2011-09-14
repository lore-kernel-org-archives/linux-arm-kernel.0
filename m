From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 14 Sep 2011 01:41:45 -0400
Subject: [PATCH 5/6] ARM: zImage: allow supplementing appended DTB with
	traditional ATAG data
In-Reply-To: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
References: <1315978906-15829-1-git-send-email-nico@fluxnic.net>
Message-ID: <1315978906-15829-6-git-send-email-nico@fluxnic.net>
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
	ATAG_MEM
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
 arch/arm/boot/compressed/Makefile       |   21 ++++++-
 arch/arm/boot/compressed/atags_to_fdt.c |   97 +++++++++++++++++++++++++++++++
 arch/arm/boot/compressed/head.S         |   32 ++++++++++
 arch/arm/boot/compressed/libfdt_env.h   |   15 +++++
 6 files changed, 183 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/compressed/atags_to_fdt.c
 create mode 100644 arch/arm/boot/compressed/libfdt_env.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 83323c2b1f..4ea9974bc7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1789,6 +1789,17 @@ config ARM_APPENDED_DTB
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
index c6028967d3..e0936a1485 100644
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
index c20ddc69d9..ce2bef536e 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -93,19 +93,36 @@ suffix_$(CONFIG_KERNEL_GZIP) = gzip
 suffix_$(CONFIG_KERNEL_LZO)  = lzo
 suffix_$(CONFIG_KERNEL_LZMA) = lzma
 
+# Borrowed libfdt files for the ATAG compatibility mode
+
+libfdt		:= fdt_rw.c fdt_ro.c fdt_wip.c fdt.c
+libfdt_hdrs	:= fdt.h libfdt.h libfdt_internal.h
+
+libfdt_objs	:= $(addsuffix .o, $(basename $(libfdt)))
+
+$(addprefix $(obj)/,$(libfdt) $(libfdt_hdrs)): $(obj)/%: $(srctree)/scripts/dtc/libfdt/%
+	$(call cmd,shipped)
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
+ccflags-y := -fpic -fno-builtin -I$(obj)
 asflags-y := -Wa,-march=all
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
new file mode 100644
index 0000000000..e0f637d3e8
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
+	uint32_t mem_reg_property[2 * NR_BANKS];
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
+			if (memcount >= sizeof(mem_reg_property)/4)
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
index ba5c552f8c..d79b83c5bd 100644
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
index 0000000000..1f4e71876b
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
-- 
1.7.7-rc0
