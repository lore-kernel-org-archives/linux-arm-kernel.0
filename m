From: matthew@mattleach.net (Matthew Leach)
Date: Sat, 11 Jun 2016 18:54:59 +0100
Subject: [PATCH] ARM: zImage: fix ATAG DTB conversion on big-endian
Message-ID: <20160611175459.5080-1-matthew@mattleach.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ATAGs are written out by the boot-loader before branching to the
kernel, they will be written as little-endian; if the kernel has been
built for big-endian, parsing of the ATAGs will fail.

When reading from the ATAGs structure, swap the endianness (when
required), allowing the DTB to be supplemented by the ATAG data.

Signed-off-by: Matthew Leach <matthew@mattleach.net>
---
 arch/arm/boot/compressed/atags_to_fdt.c | 30 +++++++++++++++++-------------
 arch/arm/include/uapi/asm/setup.h       |  6 ++++--
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index 9448aa0..c7d3e74 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -123,9 +123,9 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 	       return 0;
 
 	/* validate the ATAG */
-	if (atag->hdr.tag != ATAG_CORE ||
-	    (atag->hdr.size != tag_size(tag_core) &&
-	     atag->hdr.size != 2))
+	if (le32_to_cpu(atag->hdr.tag) != ATAG_CORE ||
+	    (le32_to_cpu(atag->hdr.size) != tag_size(tag_core) &&
+	     le32_to_cpu(atag->hdr.size) != 2))
 		return 1;
 
 	/* let's give it all the room it could need */
@@ -134,7 +134,7 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 		return ret;
 
 	for_each_tag(atag, atag_list) {
-		if (atag->hdr.tag == ATAG_CMDLINE) {
+		if (le32_to_cpu(atag->hdr.tag) == ATAG_CMDLINE) {
 			/* Append the ATAGS command line to the device tree
 			 * command line.
 			 * NB: This means that if the same parameter is set in
@@ -147,10 +147,10 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 			else
 				setprop_string(fdt, "/chosen", "bootargs",
 					       atag->u.cmdline.cmdline);
-		} else if (atag->hdr.tag == ATAG_MEM) {
+		} else if (le32_to_cpu(atag->hdr.tag) == ATAG_MEM) {
 			if (memcount >= sizeof(mem_reg_property)/4)
 				continue;
-			if (!atag->u.mem.size)
+			if (!le32_to_cpu(atag->u.mem.size))
 				continue;
 			memsize = get_cell_size(fdt);
 
@@ -161,20 +161,24 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 				uint64_t *mem_reg_prop64 =
 					(uint64_t *)mem_reg_property;
 				mem_reg_prop64[memcount++] =
-					cpu_to_fdt64(atag->u.mem.start);
+					cpu_to_fdt64(
+						le32_to_cpu(atag->u.mem.start));
 				mem_reg_prop64[memcount++] =
-					cpu_to_fdt64(atag->u.mem.size);
+					cpu_to_fdt64(
+						le32_to_cpu(atag->u.mem.size));
 			} else {
 				mem_reg_property[memcount++] =
-					cpu_to_fdt32(atag->u.mem.start);
+					cpu_to_fdt32(
+						le32_to_cpu(atag->u.mem.start));
 				mem_reg_property[memcount++] =
-					cpu_to_fdt32(atag->u.mem.size);
+					cpu_to_fdt32(
+						le32_to_cpu(atag->u.mem.size));
 			}
 
-		} else if (atag->hdr.tag == ATAG_INITRD2) {
+		} else if (le32_to_cpu(atag->hdr.tag) == ATAG_INITRD2) {
 			uint32_t initrd_start, initrd_size;
-			initrd_start = atag->u.initrd.start;
-			initrd_size = atag->u.initrd.size;
+			initrd_start = le32_to_cpu(atag->u.initrd.start);
+			initrd_size = le32_to_cpu(atag->u.initrd.size);
 			setprop_cell(fdt, "/chosen", "linux,initrd-start",
 					initrd_start);
 			setprop_cell(fdt, "/chosen", "linux,initrd-end",
diff --git a/arch/arm/include/uapi/asm/setup.h b/arch/arm/include/uapi/asm/setup.h
index 979ff40..00df12a 100644
--- a/arch/arm/include/uapi/asm/setup.h
+++ b/arch/arm/include/uapi/asm/setup.h
@@ -177,11 +177,13 @@ struct tagtable {
 	((unsigned long)(&((struct tag *)0L)->member + 1)	\
 		<= (tag)->hdr.size * 4)
 
-#define tag_next(t)	((struct tag *)((__u32 *)(t) + (t)->hdr.size))
+#define tag_next(t)	((struct tag *)((__u32 *)(t) +		\
+					le32_to_cpu((t)->hdr.size)))
+
 #define tag_size(type)	((sizeof(struct tag_header) + sizeof(struct type)) >> 2)
 
 #define for_each_tag(t,base)		\
-	for (t = base; t->hdr.size; t = tag_next(t))
+	for (t = base; le32_to_cpu(t->hdr.size); t = tag_next(t))
 
 
 #endif /* _UAPI__ASMARM_SETUP_H */
-- 
2.8.3
