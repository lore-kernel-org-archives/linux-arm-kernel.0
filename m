From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Fri, 20 Jun 2014 14:55:16 -0400
Subject: [RFC v2 1/3] Mailbox: Add support for ACPI
In-Reply-To: <CAJ5Y-eZ0z-SPSn9oxced2GOAw+OA5rC+uq4pCSXh5H2JujPm1g@mail.gmail.com>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
 <1402591692-7736-2-git-send-email-ashwin.chaugule@linaro.org>
 <4476889.LvjMyVbGZ8@wuerfel>
 <CAJ5Y-eZ0z-SPSn9oxced2GOAw+OA5rC+uq4pCSXh5H2JujPm1g@mail.gmail.com>
Message-ID: <CAJ5Y-ebp1rrRwDWCWSqkSpFg0jr4JktzKpBhWQv9jrwxhqndQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 12 June 2014 13:14, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> On 12 June 2014 13:02, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thursday 12 June 2014 12:48:10 Ashwin Chaugule wrote:
>>>
>>> +#ifndef CONFIG_ACPI
>>>         if (!mbox->of_xlate)
>>>                 mbox->of_xlate = of_mbox_index_xlate;
>>> -
>>> +#endif
>>>         mutex_lock(&con_mutex);
>>>         list_add_tail(&mbox->node, &mbox_cons);
>>>         mutex_unlock(&con_mutex);
>>>
>>
>> You can't do #ifndef here, the driver must still work if
>> both OF and ACPI are enabled.
>
> Ok. Here we could skip the macro altogether, since of_xlate wont be
> called with ACPI anyway.
>
> Will need to look into using/faking mbox->dev to remove the other ifndefs.


So, in order to get an mbox->dev for ACPI platforms, we'd need an
entry in the DSDT table. That seems rather pointless, since the DSDT
is reserved for devices and is supposed to be OS agnostic. Since the
mailbox controller itself is not really a "device" with a resource
descriptor, I dont see the point in adding a dummy DSDT entry for the
sake of getting this `struct device`. Also, I'm told adding new
entries to this table requires registering a unique 4 character
identifier and approval from some committees. If there are other ways
to get this structure I'd like to hear about it.

The other alternative would be to piggy back on the ACPI CPU detection
code, which looks for the ACPI0007 device node in the DSDT and use
that as the mbox controller device. This node is already registered
and is an established method to detect CPUs. But I'm not sure what
happens when CPUs are hotplugged off, we surely dont want mailbox
clients such as PCC to break.

The third alternative is to ignore the dev refcounts for ACPI as shown
in this totally untested patch:

----------------8<----------------------------------------


>From 6fe6e583f0b23b08643a4a85545a9a5338b9b1a0 Mon Sep 17 00:00:00 2001
From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Date: Wed, 11 Jun 2014 16:09:35 -0400
Subject: [PATCH] Mailbox: Add support for ACPI

The current mailbox framework only supports DT based bindings.
Add another mechanism for mailbox clients to register with mailbox
controllers and request for specific mailbox channels. This enables
usage of the mailbox framework on kernels with ACPI support.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/mailbox/mailbox.c          | 177 ++++++++++++++++++++++++++-----------
 include/linux/mailbox_client.h     |   2 +-
 include/linux/mailbox_controller.h |   1 +
 3 files changed, 129 insertions(+), 51 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index d83d12c..e2704f5 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/acpi.h>
 #include <linux/mailbox_client.h>
 #include <linux/mailbox_controller.h>

@@ -273,100 +274,166 @@ int mbox_send_message(struct mbox_chan *chan,
void *mssg)
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
- * ERR_PTR for request failure.
- */
-struct mbox_chan *mbox_request_channel(struct mbox_client *cl)
+static int init_channel(struct mbox_chan *chan,
+ struct mbox_client *cl)
+{
+ unsigned long flags;
+ int ret;
+
+ if (!chan) {
+ pr_err("No mailbox channel specified\n");
+ return -EINVAL;
+ }
+
+ spin_lock_irqsave(&chan->lock, flags);
+ chan->msg_free = 0;
+ chan->msg_count = 0;
+ chan->active_req = NULL;
+ chan->cl = cl;
+
+ if (!cl->tx_tout) /* wait for ever */
+ cl->tx_tout = msecs_to_jiffies(3600000);
+ else
+ cl->tx_tout = msecs_to_jiffies(cl->tx_tout);
+ if (chan->txdone_method == TXDONE_BY_POLL
+ && cl->knows_txdone)
+ chan->txdone_method |= TXDONE_BY_ACK;
+ spin_unlock_irqrestore(&chan->lock, flags);
+
+ ret = chan->mbox->ops->startup(chan);
+ if (ret) {
+ pr_err("Unable to startup the chan\n");
+ mbox_free_channel(chan);
+ chan = ERR_PTR(ret);
+ }
+
+ return ret;
+}
+
+static int get_acpi_mbox_chan(struct mbox_client *cl,
+ struct mbox_chan **chan)
+{
+ struct mbox_controller *mbox;
+ int chan_id, ret, len;
+ char *chan_ptr;
+
+ if (!cl->chan_name)
+ return -ENODEV;
+
+ list_for_each_entry(mbox, &mbox_cons, node) {
+ if (mbox->name) {
+ /*
+ * The cl->chan_name has the format => controller:channel
+ * as described in mailbox_client.h
+ */
+
+ len = strlen(mbox->name);
+ chan_ptr = cl->chan_name + len + 1;
+
+ ret = kstrtou32(cl->chan_name, 0, &chan_id);
+
+ if (ret < 0) {
+ pr_err("Err while parsing mailbox:%s channel idx\n",
+ mbox->name);
+ continue;
+ }
+
+ if (!strncmp(cl->chan_name, mbox->name, len)) {
+ *chan = &mbox->chans[chan_id];
+ return init_channel(*chan, cl);
+ }
+ }
+ }
+
+ return -ENODEV;
+}
+
+static int get_of_mbox_chan(struct mbox_client *cl,
+ struct mbox_chan **chan)
 {
  struct device *dev = cl->dev;
  struct mbox_controller *mbox;
  struct of_phandle_args spec;
- struct mbox_chan *chan;
- unsigned long flags;
  int count, i, ret;

  if (!dev || !dev->of_node) {
  pr_err("%s: No owner device node\n", __func__);
- return ERR_PTR(-ENODEV);
+ return -ENODEV;
  }

  count = of_property_count_strings(dev->of_node, "mbox-names");
  if (count < 0) {
  pr_err("%s: mbox-names property of node '%s' missing\n",
  __func__, dev->of_node->full_name);
- return ERR_PTR(-ENODEV);
+ return -ENODEV;
  }
-
- mutex_lock(&con_mutex);
-
- ret = -ENODEV;
  for (i = 0; i < count; i++) {
  const char *s;

  if (of_property_read_string_index(dev->of_node,
- "mbox-names", i, &s))
+ "mbox-names", i, &s))
  continue;

  if (strcmp(cl->chan_name, s))
  continue;

  if (of_parse_phandle_with_args(dev->of_node,
- "mbox", "#mbox-cells", i, &spec))
+ "mbox", "#mbox-cells", i, &spec))
  continue;

- chan = NULL;
  list_for_each_entry(mbox, &mbox_cons, node)
  if (mbox->dev->of_node == spec.np) {
- chan = mbox->of_xlate(mbox, &spec);
+ *chan = mbox->of_xlate(mbox, &spec);
  break;
  }

  of_node_put(spec.np);

- if (!chan)
+ if (!(*chan))
  continue;

  ret = -EBUSY;
- if (!chan->cl && try_module_get(mbox->dev->driver->owner))
+ if (!(*chan)->cl && acpi_disabled &&
+ try_module_get(mbox->dev->driver->owner))
  break;
  }

  if (i == count) {
  mutex_unlock(&con_mutex);
- return ERR_PTR(ret);
+ return ret;
  }

- spin_lock_irqsave(&chan->lock, flags);
- chan->msg_free = 0;
- chan->msg_count = 0;
- chan->active_req = NULL;
- chan->cl = cl;
- if (!cl->tx_tout) /* wait for ever */
- cl->tx_tout = msecs_to_jiffies(3600000);
+ return init_channel(*chan, cl);
+}
+
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
+ * ERR_PTR for request failure.
+ */
+struct mbox_chan *mbox_request_channel(struct mbox_client *cl)
+{
+ struct mbox_chan *chan = NULL;
+ int ret;
+
+ mutex_lock(&con_mutex);
+
+ if (acpi_disabled)
+ ret = get_of_mbox_chan(cl, &chan);
  else
- cl->tx_tout = msecs_to_jiffies(cl->tx_tout);
- if (chan->txdone_method == TXDONE_BY_POLL
- && cl->knows_txdone)
- chan->txdone_method |= TXDONE_BY_ACK;
- spin_unlock_irqrestore(&chan->lock, flags);
+ ret = get_acpi_mbox_chan(cl, &chan);

- ret = chan->mbox->ops->startup(chan);
- if (ret) {
- pr_err("Unable to startup the chan\n");
- mbox_free_channel(chan);
- chan = ERR_PTR(ret);
- }
+ if (ret)
+ pr_err("No mailbox channels found\n");

  mutex_unlock(&con_mutex);
  return chan;
@@ -394,7 +461,9 @@ void mbox_free_channel(struct mbox_chan *chan)
  if (chan->txdone_method == (TXDONE_BY_POLL | TXDONE_BY_ACK))
  chan->txdone_method = TXDONE_BY_POLL;

- module_put(chan->mbox->dev->driver->owner);
+ if (chan->mbox->dev)
+ module_put(chan->mbox->dev->driver->owner);
+
  spin_unlock_irqrestore(&chan->lock, flags);
 }
 EXPORT_SYMBOL_GPL(mbox_free_channel);
@@ -422,7 +491,15 @@ int mbox_controller_register(struct mbox_controller *mbox)
  int i, txdone;

  /* Sanity check */
- if (!mbox || !mbox->dev || !mbox->ops || !mbox->num_chans)
+ if (!mbox || !mbox->ops || !mbox->num_chans)
+ return -EINVAL;
+
+ /*
+ * For ACPI platforms, to get mbox->dev, we'd need to
+ * have a fake meaningless entry in the DSDT for the
+ * mailbox controller.
+ */
+ if (acpi_disabled && !mbox->dev)
  return -EINVAL;

  if (mbox->txdone_irq)
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index bbac2d2..716fbae 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -29,7 +29,7 @@ struct mbox_chan;
  */
 struct mbox_client {
  struct device *dev;
- const char *chan_name;
+ char *chan_name;
  void (*rx_callback)(struct mbox_client *cl, void *mssg);
  void (*tx_done)(struct mbox_client *cl, void *mssg, enum mbox_result r);
  bool tx_block;
diff --git a/include/linux/mailbox_controller.h
b/include/linux/mailbox_controller.h
index cf81e80..06476ef 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -78,6 +78,7 @@ struct mbox_controller {
  unsigned period;
  /* Hook to add to the global controller list */
  struct list_head node;
+ char *name;
 } __aligned(32);

 /*
-- 
1.8.3.2





-------------------------8<-------------------------------

Btw I havent rebased to v7 of the mailbox patchwork yet, since I'd
like to hear feedback on the direction I'm taking with ACPI before I
rebase.


Cheers,
Ashwin
