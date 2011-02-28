From: bones@secretlab.ca (John Bonesio)
Date: Mon, 28 Feb 2011 15:33:56 -0800
Subject: [PATCH 4/4] ARM:boot:device tree: Allow multiple device trees to be
	appended to zImage
In-Reply-To: <20110228233153.24836.24176.stgit@riker>
References: <20110228233153.24836.24176.stgit@riker>
Message-ID: <20110228233355.24836.7740.stgit@riker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows mutliple device tree binaries to be appended to zImage. A
device tree binary is selected when the 'machine_type' property in the root
node in the dtb matches the machine type passed in by the boot loader.

If the device tree binary does not have the 'machine_type' property, the device
tree is assumed to match the machine type. If no device tree binary matches,
the kernel attempts to boot with out a device tree.

Signed-off-by: John Bonesio <bones@secretlab.ca>
---

 arch/arm/boot/compressed/head.S |   30 ++++++++++++++++++++++-
 arch/arm/boot/compressed/misc.c |   51 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index c2cdc5f..f743431 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -229,7 +229,7 @@ restart:	adr	r0, LC0
  * if there are device trees (dtb) appended to zImage, advance r10 so that the
  * dtb data will get relocated along with the kernel if necessary.
  */
-
+1:
 		ldr	r12, [r6, #0]
 		ldr	r1, =0xedfe0dd0		@ sig is 0xdoodfeed big endian
 		cmp	r12, r1
@@ -248,6 +248,7 @@ restart:	adr	r0, LC0
 
 		add	r10, r10, r12
 		add	r6, r6, r12
+		b	1b
 
 dtb_check_done:
 		adr	r1, LC0
@@ -396,11 +397,34 @@ wont_overwrite:
  *
  * if there is a device tree (dtb) appended to zImage, set up to use this dtb.
  */
+		mvn	r9, #0			@ r9 dtb search result
+		   	      			@ ... -1 = no appended dtb
+dt_search:
 		ldr	r0, [r6, #0]
 		ldr	r1, =0xedfe0dd0		@ sig is 0xdoodfeed big endian
 		cmp	r0, r1
 		bne	keep_atags
 
+		/* Get the dtb's size */
+		ldr	r5, [r6, #4]		@ device tree size
+
+		/* convert dtb size to little endian */
+		eor	r1, r5, r5, ror #16
+		bic	r1, r1, #0x00ff0000
+		mov	r5, r5, ror #8
+		eor	r5, r5, r1, lsr #8
+
+		mov	r0, r6
+		mov	r1, r7
+		bl	match_dt_machine_type
+		mov	r9, r0			@ save result
+		cmp	r0, #0
+		bne	dt_found
+
+		add	r6, r5
+		b	dt_search
+
+dt_found:
 #ifndef CONFIG_ZBOOT_ROM
 		ldr	r0, [r6, #4]
 		add	r0, r0, #MERGE_SPACE	
@@ -413,6 +437,10 @@ wont_overwrite:
 #endif
 		mov	r8, r6			@ use the appended device tree
 keep_atags:
+
+		mov	r0, r9
+		mov	r1, r7
+		bl	put_dt_match_str
 #endif
 /*
  * Set up some pointers, and start decompressing.
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 9af05ed..f16ca6a 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -25,6 +25,8 @@ unsigned int __machine_arch_type;
 #include <linux/stddef.h>	/* for NULL */
 #include <linux/linkage.h>
 #include <asm/string.h>
+#include <fdt.h>
+#include <libfdt.h>
 
 #include <asm/unaligned.h>
 
@@ -227,6 +229,55 @@ void *memcpy(void *__dest, __const void *__src, size_t __n)
 	return __dest;
 }
 
+int match_dt_machine_type(void *fdt, unsigned int mach_type)
+{
+	int offset;
+	unsigned dt_mach_type;
+	unsigned *prop;
+	int match;
+
+	offset = fdt_path_offset(fdt, "/");
+	if (offset < 0)
+		return offset;
+
+	prop = fdt_getprop(fdt, offset, "machine-type", NULL);
+
+	if (! prop)
+		return 2;
+
+	dt_mach_type = fdt32_to_cpu(*prop);
+
+	return mach_type == dt_mach_type;
+}
+
+void put_dt_match_str(int match, unsigned int mach_type)
+{
+	switch (match) {
+	case 2:
+		putstr("'machine-type' property not found.");
+		putstr(" Device tree matched by default\n");
+		break;
+	case 1:
+		putstr("Device tree matched (machine type: ");
+		puthex(mach_type);
+		putstr(")\n");
+		break;
+	case 0:
+		putstr("Device tree not matched (machine type: ");
+		puthex(mach_type);
+		putstr(")\n");
+		break;
+	case -1:
+		/*
+		 * -1 means 'no device tree appended' so don't display any
+		 * message
+		 */
+		break;
+	default:
+		putstr("Unknown device tree match type.\n");
+	}
+}
+
 /*
  * gzip delarations
  */
