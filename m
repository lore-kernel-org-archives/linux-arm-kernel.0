From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 30 Aug 2013 20:18:00 +0100
Subject: [PATCH 4/5] ARM: update atag-to-fdt code to be endian agnostic
In-Reply-To: <1377890281-10757-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1377890281-10757-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1377890281-10757-5-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atag-to-fdt code can now use the conversion function we introduced
previously to avoid it having to know about the endian-ness of the
environment which booted the processor.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/compressed/atags_to_fdt.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index d1153c8..1e094ea 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -121,9 +121,9 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 	       return 0;
 
 	/* validate the ATAG */
-	if (atag->hdr.tag != ATAG_CORE ||
-	    (atag->hdr.size != tag_size(tag_core) &&
-	     atag->hdr.size != 2))
+	if (atag->hdr.tag != cpu_to_atag32(ATAG_CORE) ||
+	    (atag->hdr.size != cpu_to_atag32(tag_size(tag_core)) &&
+	     atag->hdr.size != cpu_to_atag32(2)))
 		return 1;
 
 	/* let's give it all the room it could need */
@@ -132,7 +132,7 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 		return ret;
 
 	for_each_tag(atag, atag_list) {
-		if (atag->hdr.tag == ATAG_CMDLINE) {
+		if (atag->hdr.tag == cpu_to_atag32(ATAG_CMDLINE)) {
 			/* Append the ATAGS command line to the device tree
 			 * command line.
 			 * NB: This means that if the same parameter is set in
@@ -145,11 +145,12 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 			else
 				setprop_string(fdt, "/chosen", "bootargs",
 					       atag->u.cmdline.cmdline);
-		} else if (atag->hdr.tag == ATAG_MEM) {
+		} else if (atag->hdr.tag == cpu_to_atag32(ATAG_MEM)) {
 			if (memcount >= sizeof(mem_reg_property)/4)
 				continue;
-			if (!atag->u.mem.size)
+			if (!atag32_to_cpu(atag->u.mem.size))
 				continue;
+
 			memsize = get_cell_size(fdt);
 
 			if (memsize == 2) {
@@ -159,20 +160,20 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 				uint64_t *mem_reg_prop64 =
 					(uint64_t *)mem_reg_property;
 				mem_reg_prop64[memcount++] =
-					cpu_to_fdt64(atag->u.mem.start);
+					cpu_to_fdt64(atag32_to_cpu(atag->u.mem.start));
 				mem_reg_prop64[memcount++] =
-					cpu_to_fdt64(atag->u.mem.size);
+						     cpu_to_fdt64(atag32_to_cpu(atag->u.mem.size));
 			} else {
 				mem_reg_property[memcount++] =
-					cpu_to_fdt32(atag->u.mem.start);
+					cpu_to_fdt32(atag32_to_cpu(atag->u.mem.start));
 				mem_reg_property[memcount++] =
-					cpu_to_fdt32(atag->u.mem.size);
+					cpu_to_fdt32(atag32_to_cpu(atag->u.mem.size));
 			}
 
-		} else if (atag->hdr.tag == ATAG_INITRD2) {
+		} else if (atag->hdr.tag == cpu_to_atag32(ATAG_INITRD2)) {
 			uint32_t initrd_start, initrd_size;
-			initrd_start = atag->u.initrd.start;
-			initrd_size = atag->u.initrd.size;
+			initrd_start = atag32_to_cpu(atag->u.initrd.start);
+			initrd_size = atag32_to_cpu(atag->u.initrd.size);
 			setprop_cell(fdt, "/chosen", "linux,initrd-start",
 					initrd_start);
 			setprop_cell(fdt, "/chosen", "linux,initrd-end",
-- 
1.7.10.4
