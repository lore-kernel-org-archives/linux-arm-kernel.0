From: mzoran@crowfest.net (Michael Zoran)
Date: Fri, 28 Oct 2016 10:58:13 -0700
Subject: [PATCH] staging: vc04_services: call sg_init_table to init scatterlist
Message-ID: <20161028175813.28022-1-mzoran@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call the sg_init_table function to correctly initialze
the DMA scatterlist.  This function is required to completely
initialize the list and is mandatory if DMA debugging is
enabled in the build configuration.

One of the purposes of sg_init_table is to set
the magic "cookie" on each list element and ensure
the chain end is marked.

Signed-off-by: Michael Zoran <mzoran@crowfest.net>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 6fa2b5a..21b26e5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -464,6 +464,12 @@ create_pagelist(char __user *buf, size_t count, unsigned short type,
 	pagelist->type = type;
 	pagelist->offset = offset;
 
+	/*
+	 * Initialize the scatterlist so that the magic cookie
+	 *  is filled if debugging is enabled
+	 */
+	sg_init_table(scatterlist, num_pages);
+	/* Now set the pages for each scatterlist */
 	for (i = 0; i < num_pages; i++)
 		sg_set_page(scatterlist + i, pages[i], PAGE_SIZE, 0);
 
-- 
2.10.1
