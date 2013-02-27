From: kim.phillips@freescale.com (Kim Phillips)
Date: Tue, 26 Feb 2013 19:36:15 -0600
Subject: [PATCH 3/3] ARM: zImage: sparse fixes
In-Reply-To: <1361928975-29395-1-git-send-email-kim.phillips@freescale.com>
References: <1361928975-29395-1-git-send-email-kim.phillips@freescale.com>
Message-ID: <1361928975-29395-3-git-send-email-kim.phillips@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/boot/compressed/atags_to_fdt.c:107:34: warning: cast to restricted __be32
arch/arm/boot/compressed/atags_to_fdt.c:107:34: warning: cast to restricted __be32
arch/arm/boot/compressed/atags_to_fdt.c:107:34: warning: cast to restricted __be32
arch/arm/boot/compressed/atags_to_fdt.c:107:34: warning: cast to restricted __be32
arch/arm/boot/compressed/atags_to_fdt.c:107:34: warning: cast to restricted __be32
arch/arm/boot/compressed/atags_to_fdt.c:107:34: warning: cast to restricted __be32
arch/arm/boot/compressed/atags_to_fdt.c:140:54: warning: incorrect type in assignment (different base types)
arch/arm/boot/compressed/atags_to_fdt.c:140:54:    expected unsigned int [unsigned] <noident>
arch/arm/boot/compressed/atags_to_fdt.c:140:54:    got restricted __be32 [usertype] <noident>
arch/arm/boot/compressed/atags_to_fdt.c:141:54: warning: incorrect type in assignment (different base types)
arch/arm/boot/compressed/atags_to_fdt.c:141:54:    expected unsigned int [unsigned] <noident>
arch/arm/boot/compressed/atags_to_fdt.c:141:54:    got restricted __be32 [usertype] <noident>

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/arm/boot/compressed/atags_to_fdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index aabc02a..b7c4846 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -16,7 +16,7 @@ static int node_offset(void *fdt, const char *node_path)
 }
 
 static int setprop(void *fdt, const char *node_path, const char *property,
-		   uint32_t *val_array, int size)
+		   fdt32_t *val_array, int size)
 {
 	int offset = node_offset(fdt, node_path);
 	if (offset < 0)
@@ -95,7 +95,7 @@ static void merge_fdt_bootargs(void *fdt, const char *fdt_cmdline)
 int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 {
 	struct tag *atag = atag_list;
-	uint32_t mem_reg_property[2 * NR_BANKS];
+	fdt32_t mem_reg_property[2 * NR_BANKS];
 	int memcount = 0;
 	int ret;
 
@@ -104,7 +104,7 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
 		return 1;
 
 	/* if we get a DTB here we're done already */
-	if (*(u32 *)atag_list == fdt32_to_cpu(FDT_MAGIC))
+	if (*(fdt32_t *)atag_list == cpu_to_fdt32(FDT_MAGIC))
 	       return 0;
 
 	/* validate the ATAG */
-- 
1.8.1.4
