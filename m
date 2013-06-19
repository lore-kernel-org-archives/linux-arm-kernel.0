From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 19 Jun 2013 11:57:51 +0100
Subject: [PATCH] atags_to_fdt: take into account root's #size and #cells
In-Reply-To: <1371639471-14144-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1371639471-14144-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1371639471-14144-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When creating entries for /memory, the root #size and #cells must be taken
into account otherwise the node will not be recongnized when the OF code
scans the nodes.

On some systems, the default is now to be 2 for each of #size and #cells
which means that appending a kernrel and having it update from ATAGS does
not work properly.
---
 arch/arm/boot/compressed/atags_to_fdt.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index 74e193e..da36840 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -1,5 +1,6 @@
 #include <asm/setup.h>
 #include <libfdt.h>
+#include <linux/of.h>
 
 #if defined(CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND)
 #define do_extend_cmdline 1
@@ -95,9 +96,12 @@ static void merge_fdt_bootargs(void *fdt, const char *fdt_cmdline)
 int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 {
 	struct tag *atag = atag_list;
-	uint32_t mem_reg_property[2 * NR_BANKS];
+	uint32_t mem_reg_property[2 * 2 * NR_BANKS];
+	const __be32 *prop;
 	int memcount = 0;
 	int ret;
+	u32 dt_root_size_cells;
+	u32 dt_root_addr_cells;
 
 	/* make sure we've got an aligned pointer */
 	if ((u32)atag_list & 0x3)
@@ -118,6 +122,17 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 	if (ret < 0)
 		return ret;
 
+	dt_root_size_cells = OF_ROOT_NODE_SIZE_CELLS_DEFAULT;
+	dt_root_addr_cells = OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
+
+	prop = getprop(fdt, "/", "#size-cells", NULL);
+	if (prop)
+		dt_root_size_cells = be32_to_cpup(prop);
+
+	prop = getprop(fdt, "/", "#address-cells", NULL);
+	if (prop)
+		dt_root_addr_cells = be32_to_cpup(prop);
+
 	for_each_tag(atag, atag_list) {
 		if (atag->hdr.tag == cpu_to_atag32(ATAG_CMDLINE)) {
 			/* Append the ATAGS command line to the device tree
@@ -137,7 +152,12 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 				continue;
 			if (!atag32_to_cpu(atag->u.mem.size))
 				continue;
+
+			for (ret = 0; ret < dt_root_addr_cells - 1; ret++)
+				mem_reg_property[memcount++] = cpu_to_fdt32(0);
 			mem_reg_property[memcount++] = cpu_to_fdt32(atag32_to_cpu(atag->u.mem.start));
+			for (ret = 0; ret < dt_root_size_cells - 1; ret++)
+				mem_reg_property[memcount++] = cpu_to_fdt32(0);
 			mem_reg_property[memcount++] = cpu_to_fdt32(atag32_to_cpu(atag->u.mem.size));
 		} else if (atag->hdr.tag == cpu_to_atag32(ATAG_INITRD2)) {
 			uint32_t initrd_start, initrd_size;
-- 
1.7.10.4
