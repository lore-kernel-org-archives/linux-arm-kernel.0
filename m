From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Fri,  2 Jul 2010 15:05:03 +0300
Subject: [PATCH 1/3] omap mailbox: extend API to take a callback param
Message-ID: <1278072305-17943-1-git-send-email-Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ext Ohad Ben-Cohen <ohad@wizery.com>

Let mailbox users set the callback pointer via the
omap_mbox_get API, instead of having users directly
manipulating the mailbox structures.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/include/plat/mailbox.h |    2 +-
 arch/arm/plat-omap/mailbox.c              |    4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/plat-omap/include/plat/mailbox.h
index 9976565..0b45664 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -62,7 +62,7 @@ struct omap_mbox {
 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
 void omap_mbox_init_seq(struct omap_mbox *);
 
-struct omap_mbox *omap_mbox_get(const char *);
+struct omap_mbox *omap_mbox_get(const char *name, int (*callback)(void *));
 void omap_mbox_put(struct omap_mbox *);
 
 int omap_mbox_register(struct device *parent, struct omap_mbox **);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index d2fafb8..14b716d 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -305,7 +305,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
 	}
 }
 
-struct omap_mbox *omap_mbox_get(const char *name)
+struct omap_mbox *omap_mbox_get(const char *name, int (*callback)(void *))
 {
 	struct omap_mbox *mbox;
 	int ret;
@@ -324,6 +324,8 @@ struct omap_mbox *omap_mbox_get(const char *name)
 	if (ret)
 		return ERR_PTR(-ENODEV);
 
+	mbox->rxq->callback = callback;
+
 	return mbox;
 }
 EXPORT_SYMBOL(omap_mbox_get);
-- 
1.7.1.rc2
