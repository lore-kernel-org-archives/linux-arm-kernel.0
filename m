From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 12 Jun 2014 12:48:10 -0400
Subject: [RFC v2 1/3] Mailbox: Add support for ACPI
In-Reply-To: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <1402591692-7736-2-git-send-email-ashwin.chaugule@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current mailbox framework only supports DT based bindings.
Add another mechanism for mailbox clients to register with mailbox
controllers and request for specific mailbox channels. This enables
usage of the mailbox framework on kernels with ACPI support.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/mailbox/mailbox.c          | 155 ++++++++++++++++++++++++-------------
 include/linux/mailbox_client.h     |   3 +
 include/linux/mailbox_controller.h |   6 ++
 3 files changed, 112 insertions(+), 52 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index d83d12c..c7d17f8 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -273,100 +273,143 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 }
 EXPORT_SYMBOL_GPL(mbox_send_message);
 
-/**
- * mbox_request_channel - Request a mailbox channel.
- * @cl: Identity of the client requesting the channel.
- *
- * The Client specifies its requirements and capabilities while asking for
- * a mailbox channel by name. It can't be called from atomic context.
- * The channel is exclusively allocated and can't be used by another
- * client before the owner calls mbox_free_channel.
- * After assignment, any packet received on this channel will be
- * handed over to the client via the 'rx_callback'.
- *
- * Return: Pointer to the channel assigned to the client if successful.
- *		ERR_PTR for request failure.
- */
-struct mbox_chan *mbox_request_channel(struct mbox_client *cl)
+static int init_channel(struct mbox_chan *chan,
+		struct mbox_client *cl)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&chan->lock, flags);
+	chan->msg_free = 0;
+	chan->msg_count = 0;
+	chan->active_req = NULL;
+	chan->cl = cl;
+
+	if (!cl->tx_tout) /* wait for ever */
+		cl->tx_tout = msecs_to_jiffies(3600000);
+	else
+		cl->tx_tout = msecs_to_jiffies(cl->tx_tout);
+	if (chan->txdone_method	== TXDONE_BY_POLL
+			&& cl->knows_txdone)
+		chan->txdone_method |= TXDONE_BY_ACK;
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	ret = chan->mbox->ops->startup(chan);
+	if (ret) {
+		pr_err("Unable to startup the chan\n");
+		mbox_free_channel(chan);
+		chan = ERR_PTR(ret);
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_ACPI
+static int get_acpi_mbox_chan(struct mbox_client *cl,
+		struct mbox_chan **chan)
+{
+	struct mbox_controller *mbox;
+	int i;
+
+	list_for_each_entry(mbox, &mbox_cons, node) {
+		if (!strcmp(cl->ctrl_name, mbox->name)) {
+			for (i = 0; i < mbox->num_chans; i++) {
+				*chan = &mbox->chans[i];
+				if (!strcmp(cl->chan_name, (*chan)->name))
+					return init_channel(*chan, cl);
+			}
+		}
+	}
+
+	return -ENODEV;
+}
+#endif
+
+static int get_of_mbox_chan(struct mbox_client *cl,
+		struct mbox_chan **chan)
 {
 	struct device *dev = cl->dev;
 	struct mbox_controller *mbox;
 	struct of_phandle_args spec;
-	struct mbox_chan *chan;
-	unsigned long flags;
 	int count, i, ret;
 
 	if (!dev || !dev->of_node) {
 		pr_err("%s: No owner device node\n", __func__);
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 	}
 
 	count = of_property_count_strings(dev->of_node, "mbox-names");
 	if (count < 0) {
 		pr_err("%s: mbox-names property of node '%s' missing\n",
 			__func__, dev->of_node->full_name);
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 	}
-
-	mutex_lock(&con_mutex);
-
-	ret = -ENODEV;
 	for (i = 0; i < count; i++) {
 		const char *s;
 
 		if (of_property_read_string_index(dev->of_node,
-						"mbox-names", i, &s))
+					"mbox-names", i, &s))
 			continue;
 
 		if (strcmp(cl->chan_name, s))
 			continue;
 
 		if (of_parse_phandle_with_args(dev->of_node,
-					 "mbox", "#mbox-cells",	i, &spec))
+					"mbox", "#mbox-cells",	i, &spec))
 			continue;
 
-		chan = NULL;
 		list_for_each_entry(mbox, &mbox_cons, node)
 			if (mbox->dev->of_node == spec.np) {
-				chan = mbox->of_xlate(mbox, &spec);
+				*chan = mbox->of_xlate(mbox, &spec);
 				break;
 			}
 
 		of_node_put(spec.np);
 
-		if (!chan)
+		if (!(*chan))
 			continue;
 
 		ret = -EBUSY;
-		if (!chan->cl && try_module_get(mbox->dev->driver->owner))
+		if (!(*chan)->cl && try_module_get(mbox->dev->driver->owner))
 			break;
 	}
 
 	if (i == count) {
 		mutex_unlock(&con_mutex);
-		return ERR_PTR(ret);
+		return ret;
 	}
 
-	spin_lock_irqsave(&chan->lock, flags);
-	chan->msg_free = 0;
-	chan->msg_count = 0;
-	chan->active_req = NULL;
-	chan->cl = cl;
-	if (!cl->tx_tout) /* wait for ever */
-		cl->tx_tout = msecs_to_jiffies(3600000);
-	else
-		cl->tx_tout = msecs_to_jiffies(cl->tx_tout);
-	if (chan->txdone_method	== TXDONE_BY_POLL
-			&& cl->knows_txdone)
-		chan->txdone_method |= TXDONE_BY_ACK;
-	spin_unlock_irqrestore(&chan->lock, flags);
+	return init_channel(*chan, cl);
+}
 
-	ret = chan->mbox->ops->startup(chan);
-	if (ret) {
-		pr_err("Unable to startup the chan\n");
-		mbox_free_channel(chan);
-		chan = ERR_PTR(ret);
-	}
+/**
+ * mbox_request_channel - Request a mailbox channel.
+ * @cl: Identity of the client requesting the channel.
+ *
+ * The Client specifies its requirements and capabilities while asking for
+ * a mailbox channel by name. It can't be called from atomic context.
+ * The channel is exclusively allocated and can't be used by another
+ * client before the owner calls mbox_free_channel.
+ * After assignment, any packet received on this channel will be
+ * handed over to the client via the 'rx_callback'.
+ *
+ * Return: Pointer to the channel assigned to the client if successful.
+ *		ERR_PTR for request failure.
+ */
+struct mbox_chan *mbox_request_channel(struct mbox_client *cl)
+{
+	struct mbox_chan *chan = NULL;
+	int ret;
+
+	mutex_lock(&con_mutex);
+
+	ret = get_of_mbox_chan(cl, &chan);
+
+#ifdef CONFIG_ACPI
+	ret = get_acpi_mbox_chan(cl, &chan);
+#endif
+	if (ret)
+		pr_err("No mailbox channels found\n");
 
 	mutex_unlock(&con_mutex);
 	return chan;
@@ -394,11 +437,14 @@ void mbox_free_channel(struct mbox_chan *chan)
 	if (chan->txdone_method == (TXDONE_BY_POLL | TXDONE_BY_ACK))
 		chan->txdone_method = TXDONE_BY_POLL;
 
+#ifndef CONFIG_ACPI
 	module_put(chan->mbox->dev->driver->owner);
+#endif
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
 EXPORT_SYMBOL_GPL(mbox_free_channel);
 
+#ifndef CONFIG_ACPI
 static struct mbox_chan *
 of_mbox_index_xlate(struct mbox_controller *mbox,
 				const struct of_phandle_args *sp)
@@ -410,7 +456,7 @@ of_mbox_index_xlate(struct mbox_controller *mbox,
 
 	return &mbox->chans[ind];
 }
-
+#endif
 /**
  * mbox_controller_register - Register the mailbox controller
  * @mbox:	Pointer to the mailbox controller.
@@ -422,9 +468,13 @@ int mbox_controller_register(struct mbox_controller *mbox)
 	int i, txdone;
 
 	/* Sanity check */
-	if (!mbox || !mbox->dev || !mbox->ops || !mbox->num_chans)
+	if (!mbox || !mbox->ops || !mbox->num_chans)
 		return -EINVAL;
 
+#ifndef CONFIG_ACPI
+	if (!mbox->dev)
+		return -EINVAL;
+#endif
 	if (mbox->txdone_irq)
 		txdone = TXDONE_BY_IRQ;
 	else if (mbox->txdone_poll)
@@ -446,9 +496,10 @@ int mbox_controller_register(struct mbox_controller *mbox)
 		spin_lock_init(&chan->lock);
 	}
 
+#ifndef CONFIG_ACPI
 	if (!mbox->of_xlate)
 		mbox->of_xlate = of_mbox_index_xlate;
-
+#endif
 	mutex_lock(&con_mutex);
 	list_add_tail(&mbox->node, &mbox_cons);
 	mutex_unlock(&con_mutex);
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index bbac2d2..21568a1 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -35,6 +35,9 @@ struct mbox_client {
 	bool tx_block;
 	unsigned long tx_tout;
 	bool knows_txdone;
+#ifdef CONFIG_ACPI
+	const char *ctrl_name;
+#endif
 };
 
 struct mbox_chan *mbox_request_channel(struct mbox_client *cl);
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index cf81e80..dc9d290 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -78,6 +78,9 @@ struct mbox_controller {
 	unsigned period;
 	/* Hook to add to the global controller list */
 	struct list_head node;
+#ifdef CONFIG_ACPI
+	char *name;
+#endif
 } __aligned(32);
 
 /*
@@ -111,6 +114,9 @@ struct mbox_chan {
 
 	/* Private data for controller */
 	void *con_priv;
+#ifdef CONFIG_ACPI
+	char *name;
+#endif
 } __aligned(32);
 
 int mbox_controller_register(struct mbox_controller *mbox);
-- 
1.8.3.2
