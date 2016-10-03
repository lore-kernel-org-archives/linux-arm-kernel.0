From: eric@anholt.net (Eric Anholt)
Date: Mon,  3 Oct 2016 11:52:06 -0700
Subject: [PATCH 1/4] staging/vchi: Convert to current get_user_pages()
 arguments.
In-Reply-To: <20161003185209.27733-1-eric@anholt.net>
References: <20161003185209.27733-1-eric@anholt.net>
Message-ID: <20161003185209.27733-2-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 2 +-
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index c29040fdf9a7..18f268ee6d4b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -420,7 +420,7 @@ create_pagelist(char __user *buf, size_t count, unsigned short type,
 		*need_release = 0; /* do not try and release vmalloc pages */
 	} else {
 		down_read(&task->mm->mmap_sem);
-		actual_pages = get_user_pages(task, task->mm,
+		actual_pages = get_user_pages(
 				          (unsigned long)buf & ~(PAGE_SIZE - 1),
 					  num_pages,
 					  (type == PAGELIST_READ) /*Write */ ,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index e11c0e07471b..56c2c48f6801 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1473,8 +1473,7 @@ dump_phys_mem(void *virt_addr, uint32_t num_bytes)
 	}
 
 	down_read(&current->mm->mmap_sem);
-	rc = get_user_pages(current,      /* task */
-		current->mm,              /* mm */
+	rc = get_user_pages(
 		(unsigned long)virt_addr, /* start */
 		num_pages,                /* len */
 		0,                        /* write */
-- 
2.9.3
