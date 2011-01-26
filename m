From: bones@secretlab.ca (John Bonesio)
Date: Wed, 26 Jan 2011 13:23:34 -0800
Subject: [RFC 2/2] ARM:boot:device tree: Merge specific atags into the device
	tree
In-Reply-To: <20110126212220.6723.28773.stgit@riker>
References: <20110126212220.6723.28773.stgit@riker>
Message-ID: <20110126212324.6723.25307.stgit@riker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to merge in key atags into the appended device tree.  An appended
device tree is where the zImage has a dtb binary appended at the end of it. The
boot code looks for an appended device tree, then looks for a few key atags
passed in by the bootloader.

The bootargs and memory size settings, if they exist, override existing values
in the appended device tree. If these values don't currently exist in the
appended device tree, they are added.

Signed-off-by: John Bonesio <bones@secretlab.ca>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/arm/boot/compressed/Makefile |   31 +++++++++++++++++---
 arch/arm/boot/compressed/atags.c  |   50 ++++++++++++++++++++++++++++++++
 arch/arm/boot/compressed/head.S   |    7 ++++
 arch/arm/boot/compressed/misc.c   |   58 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 139 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/compressed/atags.c

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 0a8f748..7978a39 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -49,6 +49,10 @@ ifeq ($(CONFIG_ARCH_SHMOBILE),y)
 OBJS		+= head-shmobile.o
 endif
 
+ifeq ($(CONFIG_ARM_APPENDED_DTB),y)
+OBJS		+= atags.o libfdt.a 
+endif
+
 #
 # We now have a PIC decompressor implementation.  Decompressors running
 # from RAM should not define ZTEXTADDR.  Decompressors running directly
@@ -80,7 +84,9 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
 
-EXTRA_CFLAGS  := -fpic -fno-builtin
+fdttree      := $(srctree)/scripts/dtc/libfdt
+
+EXTRA_CFLAGS  := -fpic -fno-builtin -I$(fdttree) -I$(obj)
 EXTRA_AFLAGS  := -Wa,-march=all
 
 # Supply ZRELADDR to the decompressor via a linker symbol.
@@ -100,13 +106,28 @@ LDFLAGS_vmlinux += -X
 LDFLAGS_vmlinux += -T
 
 # For __aeabi_uidivmod
-lib1funcs = $(obj)/lib1funcs.o
+libfuncs = $(obj)/lib1funcs.o
 
-$(obj)/lib1funcs.S: $(srctree)/arch/$(SRCARCH)/lib/lib1funcs.S FORCE
-	$(call cmd,shipped)
+ifeq ($(CONFIG_ARM_APPENDED_DTB),y)
+# For memchr, memmove, etc
+libfuncs += $(obj)/memchr.o $(obj)/strchr.o $(obj)/memmove.o $(obj)/memzero.o
+endif
+
+
+libfdtheader := $(fdttree)/fdt.h $(fdttree)/libfdt.h $(fdttree)/libfdt_internal.h
+libfdtobj    := $(obj)/fdt.o $(obj)/fdt_ro.o $(obj)/fdt_wip.o $(obj)/fdt_sw.o $(obj)/fdt_rw.o $(obj)/fdt_strerror.o
+
+$(libfdtobj): $(obj)/%.o: $(srctree)/scripts/dtc/libfdt/%.c $(libfdtheader)
+	$(call cmd_cc_o_c)
+
+$(obj)/libfdt.a: $(libfdtobj)
+	$(AR) rcs $@ $^
+
+$(libfuncs): $(obj)/%.o: $(srctree)/arch/$(SRCARCH)/lib/%.S
+	$(call cmd_as_o_S)
 
 $(obj)/vmlinux: $(obj)/vmlinux.lds $(obj)/$(HEAD) $(obj)/piggy.$(suffix_y).o \
-	 	$(addprefix $(obj)/, $(OBJS)) $(lib1funcs) FORCE
+	 	$(addprefix $(obj)/, $(OBJS)) $(libfuncs) FORCE
 	$(call if_changed,ld)
 	@:
 
diff --git a/arch/arm/boot/compressed/atags.c b/arch/arm/boot/compressed/atags.c
new file mode 100644
index 0000000..e37d8de
--- /dev/null
+++ b/arch/arm/boot/compressed/atags.c
@@ -0,0 +1,50 @@
+#include <stddef.h>
+#include <asm/byteorder.h>
+#include <asm/setup.h>
+#include <fdt.h>
+#include <libfdt.h>
+
+
+int dt_setprop(void *fdt, const char *node_path, const char *property,
+               uint32_t *val_array, int size)
+{
+	int offset;
+
+	offset = fdt_path_offset(fdt, node_path);
+	if (offset < 0)
+		return offset;
+
+	return fdt_setprop(fdt, offset, property, val_array, size);
+}
+
+int dt_setprop_string(void *fdt, const char *node_path,
+                      const char *property, const char *string)
+{
+	int offset;
+		
+	offset = fdt_path_offset(fdt, node_path);
+	if (offset < 0)
+		return offset;
+			
+	return fdt_setprop_string(fdt, offset, property, string);
+}
+
+void dt_merge_atags(void *dt,  void *ataglist)
+{
+	struct tag *atag = ataglist;
+	uint32_t mem_reg_property[2];
+
+	while (atag && atag->hdr.tag != 0) {
+		if (atag->hdr.tag == ATAG_CMDLINE) {
+			dt_setprop_string(dt, "/chosen", "bootargs",
+			                  atag->u.cmdline.cmdline);
+		} else if (atag->hdr.tag == ATAG_MEM) {
+			mem_reg_property[0] = cpu_to_fdt32(atag->u.mem.start);
+			mem_reg_property[1] = cpu_to_fdt32(atag->u.mem.size);
+			dt_setprop(dt, "/memory", "reg", mem_reg_property,
+			           sizeof(mem_reg_property));
+		}
+		atag = tag_next(atag);
+	}
+}
+
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index db860b3..09e659d 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -257,6 +257,13 @@ not_relocated:
 		cmp	r1, r9
 		bne	keep_atags
 
+		/* Merge some of the atags into the device tree */
+		push	{r2, r3, r10, r11}
+		mov	r0, r2
+		mov	r1, r8
+		bl	dt_merge_atags
+		pop	{r2, r3, r10, r11}
+
 		/* copy the device tree binary to 0x0 */
 		ldr	r9, [r10, #4]	@ device tree size
 
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index e653a6d..2d4da4c 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -29,7 +29,7 @@ unsigned int __machine_arch_type;
 #include <asm/unaligned.h>
 
 
-static void putstr(const char *ptr);
+void putstr(const char *ptr);
 extern void error(char *x);
 
 #include <mach/uncompress.h>
@@ -100,7 +100,7 @@ static void icedcc_putc(int ch)
 #define putc(ch)	icedcc_putc(ch)
 #endif
 
-static void putstr(const char *ptr)
+void putstr(const char *ptr)
 {
 	char c;
 
@@ -114,6 +114,60 @@ static void putstr(const char *ptr)
 }
 
 
+#ifdef CONFIG_ARM_APPENDED_DTB
+/**
+ * strlen - Find the length of a string
+ * @s: The string to be sized
+ */
+size_t strlen(const char *s)
+{
+        const char *sc;
+
+        for (sc = s; *sc != '\0'; ++sc)
+                /* nothing */;
+        return sc - s;
+}
+
+/**
+ * strcmp - Compare two strings
+ * @cs: One string
+ * @ct: Another string
+ */
+#undef strcmp
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
+/**
+ * memcmp - Compare two areas of memory
+ * @cs: One area of memory
+ * @ct: Another area of memory
+ * @count: The size of the area.
+ */
+#undef memcmp
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
+#endif
+
 void *memcpy(void *__dest, __const void *__src, size_t __n)
 {
 	int i = 0;
