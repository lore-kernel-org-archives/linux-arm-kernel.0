From: labbott@redhat.com (Laura Abbott)
Date: Tue, 19 Jul 2016 15:00:04 -0700
Subject: [PATCH] mm: Add is_migrate_cma_page
In-Reply-To: <CAGXu5j+nHpHcYT8FyHNe6AFQCdakoSMW=UWDatyxhRK7CB7_=g@mail.gmail.com>
Message-ID: <1468965604-25023-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code such as hardened user copy[1] needs a way to tell if a
page is CMA or not. Add is_migrate_cma_page in a similar way
to is_migrate_isolate_page.

[1]http://article.gmane.org/gmane.linux.kernel.mm/155238

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
Here's an explicit patch, slightly different than what I posted before. It can
be kept separate or folded in as needed.
---
 include/linux/mmzone.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 02069c2..c8478b2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -68,8 +68,10 @@ extern char * const migratetype_names[MIGRATE_TYPES];
 
 #ifdef CONFIG_CMA
 #  define is_migrate_cma(migratetype) unlikely((migratetype) == MIGRATE_CMA)
+#  define is_migrate_cma_page(_page) (get_pageblock_migratetype(_page) == MIGRATE_CMA)
 #else
 #  define is_migrate_cma(migratetype) false
+#  define is_migrate_cma_page(_page) false
 #endif
 
 #define for_each_migratetype_order(order, type) \
-- 
2.7.4
