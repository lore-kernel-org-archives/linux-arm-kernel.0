From: miles.chen@mediatek.com (miles.chen at mediatek.com)
Date: Wed, 21 Nov 2018 16:11:13 +0800
Subject: [RFC PATCH] of: make MAX_RESERVED_REGIONS configurable
Message-ID: <1542787873-8429-1-git-send-email-miles.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Miles Chen <miles.chen@mediatek.com>

When we use more than 32 entries in /resered-memory,
there will be an error message: "not enough space all defined regions.".
We can increase MAX_RESERVED_REGIONS to fix this.

commit 22f8cc6e3373 ("drivers: of: increase MAX_RESERVED_REGIONS to 32")
increased MAX_RESERVED_REGIONS to 32 but I'm not sure if increasing
MAX_RESERVED_REGIONS to 64 is suitable for everyone.

In this RFC patch, CONFIG_MAX_OF_RESERVED_REGIONS is added and used as
MAX_RESERVED_REGIONS. Add a sanity test to make sure that
MAX_RESERVED_REGIONS is less than INIT_MEMBLOCK_REGIONS.
Users can configure CONFIG_MAX_OF_RESERVED_REGIONS according to their
need.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/of/Kconfig           | 9 +++++++++
 drivers/of/of_reserved_mem.c | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index ad3fcad..63fff2e 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -86,6 +86,15 @@ config OF_RESERVED_MEM
 	help
 	  Helpers to allow for reservation of memory regions
 
+config MAX_OF_RESERVED_REGIONS
+	int "the max number of devicetree reserved memory regions"
+	depends on OF_RESERVED_MEM
+	default 32
+	help
+	  Setup the max number of devicetree reserved memory regions
+	  If unsure, leave the default value "32".
+
+
 config OF_RESOLVE
 	bool
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1977ee0..18a7729 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -22,7 +22,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 
-#define MAX_RESERVED_REGIONS	32
+#define MAX_RESERVED_REGIONS	CONFIG_MAX_OF_RESERVED_REGIONS
 static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
 static int reserved_mem_count;
 
@@ -246,6 +246,9 @@ void __init fdt_init_reserved_mem(void)
 {
 	int i;
 
+	/* MAX_RESERVED_REGIONS should be bounded by INIT_MEMBLOCK_REGIONS */
+	BUILD_BUG_ON(MAX_RESERVED_REGIONS > INIT_MEMBLOCK_REGIONS);
+
 	/* check for overlapping reserved regions */
 	__rmem_check_for_overlap();
 
-- 
1.9.1
