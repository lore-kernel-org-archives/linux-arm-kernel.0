From: keescook@chromium.org (Kees Cook)
Date: Wed, 20 Jul 2016 13:26:56 -0700
Subject: [PATCH v4 01/12] mm: Add is_migrate_cma_page
In-Reply-To: <1469046427-12696-1-git-send-email-keescook@chromium.org>
References: <1469046427-12696-1-git-send-email-keescook@chromium.org>
Message-ID: <1469046427-12696-2-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laura Abbott <labbott@redhat.com>

Code such as hardened user copy[1] needs a way to tell if a
page is CMA or not. Add is_migrate_cma_page in a similar way
to is_migrate_isolate_page.

[1]http://article.gmane.org/gmane.linux.kernel.mm/155238

Signed-off-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mmzone.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 02069c23486d..c8478b29f070 100644
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
