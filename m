From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Feb 2013 23:17:40 +0000
Subject: [PATCH 10/17] ARM: update atag-to-fdt code to be endian agnostic
In-Reply-To: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360365467-25056-11-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The atag-to-fdt code can now use the conversion function we introduced
previously to avoid it having to know about the endian-ness of the
environment which booted the processor.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/compressed/atags_to_fdt.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index aabc02a..a64ec71 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -108,9 +108,9 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 	       return 0;
 
 	/* validate the ATAG */
-	if (atag->hdr.tag != ATAG_CORE ||
-	    (atag->hdr.size != tag_size(tag_core) &&
-	     atag->hdr.size != 2))
+	if (atag->hdr.tag != atag32_to_cpu(ATAG_CORE) ||
+	    (atag->hdr.size != atag32_to_cpu(tag_size(tag_core)) &&
+	     atag->hdr.size != atag32_to_cpu(2)))
 		return 1;
 
 	/* let's give it all the room it could need */
@@ -132,17 +132,17 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 			else
 				setprop_string(fdt, "/chosen", "bootargs",
 					       atag->u.cmdline.cmdline);
-		} else if (atag->hdr.tag == ATAG_MEM) {
+		} else if (atag->hdr.tag == atag32_to_cpu(ATAG_MEM)) {
 			if (memcount >= sizeof(mem_reg_property)/4)
 				continue;
-			if (!atag->u.mem.size)
+			if (!atag32_to_cpu(atag->u.mem.size))
 				continue;
-			mem_reg_property[memcount++] = cpu_to_fdt32(atag->u.mem.start);
-			mem_reg_property[memcount++] = cpu_to_fdt32(atag->u.mem.size);
-		} else if (atag->hdr.tag == ATAG_INITRD2) {
+			mem_reg_property[memcount++] = cpu_to_fdt32(atag32_to_cpu(atag->u.mem.start));
+			mem_reg_property[memcount++] = cpu_to_fdt32(atag32_to_cpu(atag->u.mem.size));
+		} else if (atag->hdr.tag == atag32_to_cpu(ATAG_INITRD2)) {
 			uint32_t initrd_start, initrd_size;
-			initrd_start = atag->u.initrd.start;
-			initrd_size = atag->u.initrd.size;
+			initrd_start = atag32_to_cpu(atag->u.initrd.start);
+			initrd_size = atag32_to_cpu(____atag->u.initrd.size);
 			setprop_cell(fdt, "/chosen", "linux,initrd-start",
 					initrd_start);
 			setprop_cell(fdt, "/chosen", "linux,initrd-end",
-- 
1.7.10.4
