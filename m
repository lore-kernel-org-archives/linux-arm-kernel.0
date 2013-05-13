From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 13 May 2013 01:51:32 -0400
Subject: [PATCh V10 01/12] usb: phy: protect phy init and shutdown for mutiple
 deivces
In-Reply-To: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
References: <1368424303-10629-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1368424303-10629-2-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some USB devices will share same phy, so make the ->init
and ->shutdown to be protected.
Only first device will initialize the phy, and only last device
can shutdown phy.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/usb/phy/phy.c   |    6 ++++++
 include/linux/usb/phy.h |   22 ++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index a9984c7..97dd396 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -329,6 +329,9 @@ int usb_add_phy(struct usb_phy *x, enum usb_phy_type type)
 		return -EINVAL;
 	}
 
+	mutex_init(&x->phy_mutex);
+	x->refcount = 0;
+
 	spin_lock_irqsave(&phy_lock, flags);
 
 	list_for_each_entry(phy, &phy_list, head) {
@@ -367,6 +370,9 @@ int usb_add_phy_dev(struct usb_phy *x)
 		return -EINVAL;
 	}
 
+	mutex_init(&x->phy_mutex);
+	x->refcount = 0;
+
 	spin_lock_irqsave(&phy_lock, flags);
 	list_for_each_entry(phy_bind, &phy_bind_list, list)
 		if (!(strcmp(phy_bind->phy_dev_name, dev_name(x->dev))))
diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index 6b5978f..b645520 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -87,6 +87,14 @@ struct usb_phy {
 	/* to support controllers that have multiple transceivers */
 	struct list_head	head;
 
+	/*
+	 * PHY may be shared by multiple devices.
+	 * Being protected by phy_mutex and refcount, PHY is initialized
+	 * or shut down only once.
+	 */
+	struct mutex		phy_mutex;
+	unsigned int		refcount;
+
 	/* initialize/shutdown the OTG controller */
 	int	(*init)(struct usb_phy *x);
 	void	(*shutdown)(struct usb_phy *x);
@@ -150,17 +158,23 @@ static inline int usb_phy_io_write(struct usb_phy *x, u32 val, u32 reg)
 static inline int
 usb_phy_init(struct usb_phy *x)
 {
-	if (x->init)
-		return x->init(x);
+	int ret = 0;
 
-	return 0;
+	mutex_lock(&x->phy_mutex);
+	if (x->refcount++ == 0 && x->init)
+		ret = x->init(x);
+	mutex_unlock(&x->phy_mutex);
+
+	return ret;
 }
 
 static inline void
 usb_phy_shutdown(struct usb_phy *x)
 {
-	if (x->shutdown)
+	mutex_lock(&x->phy_mutex);
+	if (--x->refcount == 0 && x->shutdown)
 		x->shutdown(x);
+	mutex_unlock(&x->phy_mutex);
 }
 
 static inline int
-- 
1.7.4.1
