From: eric@anholt.net (Eric Anholt)
Date: Mon,  3 Oct 2016 11:52:07 -0700
Subject: [PATCH 2/4] staging/vchi: Update for rename of page_cache_release()
 to put_page().
In-Reply-To: <20161003185209.27733-1-eric@anholt.net>
References: <20161003185209.27733-1-eric@anholt.net>
Message-ID: <20161003185209.27733-3-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 4 ++--
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 18f268ee6d4b..4cb5bff23728 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -439,7 +439,7 @@ create_pagelist(char __user *buf, size_t count, unsigned short type,
 			while (actual_pages > 0)
 			{
 				actual_pages--;
-				page_cache_release(pages[actual_pages]);
+				put_page(pages[actual_pages]);
 			}
 			kfree(pagelist);
 			if (actual_pages == 0)
@@ -578,7 +578,7 @@ free_pagelist(PAGELIST_T *pagelist, int actual)
 				offset = 0;
 				set_page_dirty(pg);
 			}
-			page_cache_release(pg);
+			put_page(pg);
 		}
 	}
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 56c2c48f6801..47df1af2219d 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1512,7 +1512,7 @@ dump_phys_mem(void *virt_addr, uint32_t num_bytes)
 		kunmap(page);
 
 	for (page_idx = 0; page_idx < num_pages; page_idx++)
-		page_cache_release(pages[page_idx]);
+		put_page(pages[page_idx]);
 
 	kfree(pages);
 }
-- 
2.9.3
