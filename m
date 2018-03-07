From: eric@anholt.net (Eric Anholt)
Date: Wed,  7 Mar 2018 10:57:12 -0800
Subject: [PATCH v2 2/6] staging: vc04_services: Add comments describing
 g_cache_line_size.
In-Reply-To: <20180307185716.17449-1-eric@anholt.net>
References: <20180307185716.17449-1-eric@anholt.net>
Message-ID: <20180307185716.17449-2-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's been tempting to replace this with (L1) cache_line_size(), but
that's really not what the value is about.  It's about coordinating
the condition for the pagelist fragment behavior between the two
sides.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: new patch to replace the cache_line_size() patch.

 .../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 10 +++++++++-
 .../staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h |  1 -
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index b59ef14890aa..3aeffa189f64 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -77,7 +77,11 @@ struct vchiq_pagelist_info {
 };
 
 static void __iomem *g_regs;
-static unsigned int g_cache_line_size = sizeof(CACHE_LINE_SIZE);
+/* This value is the size of the L2 cache lines as understood by the
+ * VPU firmware, which determines the required alignment of the
+ * offsets/sizes in pagelists.
+ */
+static unsigned int g_cache_line_size = 32;
 static unsigned int g_fragments_size;
 static char *g_fragments_base;
 static char *g_free_fragments;
@@ -117,6 +121,10 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
 	if (err < 0)
 		return err;
 
+	/* Get the L2 cache-line-size as set by the VPU.  If the
+	 * property is missing, then the firmware assumes an older
+	 * kernel using a 32-byte cache line size for compatibility.
+	 */
 	err = of_property_read_u32(dev->of_node, "cache-line-size",
 				   &g_cache_line_size);
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
index a6c5f7cc78f0..bec411061554 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h
@@ -34,7 +34,6 @@
 #ifndef VCHIQ_PAGELIST_H
 #define VCHIQ_PAGELIST_H
 
-#define CACHE_LINE_SIZE 32
 #define PAGELIST_WRITE 0
 #define PAGELIST_READ 1
 #define PAGELIST_READ_WITH_FRAGMENTS 2
-- 
2.16.2
