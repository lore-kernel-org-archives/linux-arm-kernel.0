From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 May 2015 17:08:50 +0100
Subject: [PATCH 1/2] mailbox: Add ability for clients to request channels by
 name
Message-ID: <1431360531-31337-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supplies a new framework API; mbox_request_channel_byname().

It works by supplying the usual client pointer as the first argument and
a string as the second.  The API will search the client's node for a
'mbox-names' property then request a channel in the normal way using the
requested string's index as the expected second 'index' argument.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mailbox/mailbox.c      | 29 +++++++++++++++++++++++++++++
 include/linux/mailbox_client.h |  2 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 19b491d..c533826 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -357,6 +357,35 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 }
 EXPORT_SYMBOL_GPL(mbox_request_channel);
 
+struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
+					      const char *name)
+{
+	struct device_node *np = cl->dev->of_node;
+	struct property *prop;
+	const char *mbox_name;
+	int index = 0;
+
+	if (!np) {
+		dev_err(cl->dev, "%s() currently only supports DT\n", __func__);
+		return ERR_PTR(-ENOSYS);
+	}
+
+	if (!of_get_property(np, "mbox-names", NULL)) {
+		dev_err(cl->dev,
+			"%s() requires an \"mbox-names\" property\n", __func__);
+		return ERR_PTR(-ENOSYS);
+	}
+
+	of_property_for_each_string(np, "mbox-names", prop, mbox_name) {
+		if (!strncmp(name, mbox_name, strlen(name)))
+			break;
+		index++;
+	}
+
+	return mbox_request_channel(cl, index);
+}
+EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
+
 /**
  * mbox_free_channel - The client relinquishes control of a mailbox
  *			channel by this call.
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index 1726ccb..4434871 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -40,6 +40,8 @@ struct mbox_client {
 	void (*tx_done)(struct mbox_client *cl, void *mssg, int r);
 };
 
+struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
+					      const char *name);
 struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index);
 int mbox_send_message(struct mbox_chan *chan, void *mssg);
 void mbox_client_txdone(struct mbox_chan *chan, int r); /* atomic */
-- 
1.9.1
