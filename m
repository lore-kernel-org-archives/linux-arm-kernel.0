From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon,  4 May 2015 10:36:36 -0700
Subject: [PATCH v8 3/9] mailbox: Fix up error handling in
 mbox_request_channel()
In-Reply-To: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
Message-ID: <1430761002-9327-4-git-send-email-abrestic@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benson Leung <bleung@chromium.org>

mbox_request_channel() currently returns EBUSY in the event the controller
is not present or if of_xlate() fails, but in neither case is EBUSY really
appropriate.  Return EPROBE_DEFER if the controller is not yet present
and change of_xlate() to return an ERR_PTR instead of NULL so that the
error can be propagated back to the caller of mbox_request_channel().

Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Acked-by: Suman Anna <s-anna@ti.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
---
No changes from v7.
Changes from v6:
 - Update omap-mailbox's xlate() to return error codes.
No changes from v5.
New for v5.
---
 drivers/mailbox/mailbox.c      | 11 ++++++++---
 drivers/mailbox/omap-mailbox.c |  6 +++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 19b491d..c3c42d4 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -318,7 +318,7 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 		return ERR_PTR(-ENODEV);
 	}
 
-	chan = NULL;
+	chan = ERR_PTR(-EPROBE_DEFER);
 	list_for_each_entry(mbox, &mbox_cons, node)
 		if (mbox->dev->of_node == spec.np) {
 			chan = mbox->of_xlate(mbox, &spec);
@@ -327,7 +327,12 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 
 	of_node_put(spec.np);
 
-	if (!chan || chan->cl || !try_module_get(mbox->dev->driver->owner)) {
+	if (IS_ERR(chan)) {
+		mutex_unlock(&con_mutex);
+		return chan;
+	}
+
+	if (chan->cl || !try_module_get(mbox->dev->driver->owner)) {
 		dev_dbg(dev, "%s: mailbox not free\n", __func__);
 		mutex_unlock(&con_mutex);
 		return ERR_PTR(-EBUSY);
@@ -390,7 +395,7 @@ of_mbox_index_xlate(struct mbox_controller *mbox,
 	int ind = sp->args[0];
 
 	if (ind >= mbox->num_chans)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	return &mbox->chans[ind];
 }
diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 03f8545..a3dbfd9 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -639,18 +639,18 @@ static struct mbox_chan *omap_mbox_of_xlate(struct mbox_controller *controller,
 
 	mdev = container_of(controller, struct omap_mbox_device, controller);
 	if (WARN_ON(!mdev))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	node = of_find_node_by_phandle(phandle);
 	if (!node) {
 		pr_err("%s: could not find node phandle 0x%x\n",
 		       __func__, phandle);
-		return NULL;
+		return ERR_PTR(-ENODEV);
 	}
 
 	mbox = omap_mbox_device_find(mdev, node->name);
 	of_node_put(node);
-	return mbox ? mbox->chan : NULL;
+	return mbox ? mbox->chan : ERR_PTR(-ENOENT);
 }
 
 static int omap_mbox_probe(struct platform_device *pdev)
-- 
2.2.0.rc0.207.ga3a616c
