From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 23 Nov 2018 12:17:00 +0100
Subject: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
In-Reply-To: <20181122084712.GA5741@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <CABb+yY3HwvG6sSKnweiDpyg85Fk8Q9hOVaF-s7gv4RDzEoaGqA@mail.gmail.com>
 <20181120152907.GA28796@ulmo> <20181121142740.GA29704@ulmo>
 <CABb+yY0nH3Su6a11TZLJf=CCpD+gTpqUkLnRhpy4MUwNJk5prw@mail.gmail.com>
 <20181122084712.GA5741@ulmo>
Message-ID: <20181123111700.GA31881@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 09:47:12AM +0100, Thierry Reding wrote:
[...]
> Perhaps you'd be less concerned about such a change if it was perhaps
> more explicit? Just throwing ideas around, I think something that could
> also work is if we explicitly add a mbox_flush() function that would
> basically be calling ->flush(). That way users of the mailbox can make
> their requirement very explicit. I haven't actually tested that, but I
> think it would work. Does that sound more acceptable to you?

I tried implementing the explicit flushing on top of this series and it
would look roughly like the below. What do you think?

Thierry

--->8---
diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 3e7e2c4358aa..fbdcc82a61ae 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -267,14 +267,6 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		unsigned long wait;
 		int ret;
 
-		if (irqs_disabled() && chan->mbox->ops->flush) {
-			ret = chan->mbox->ops->flush(chan, chan->cl->tx_tout);
-			if (ret < 0)
-				tx_tick(chan, ret);
-
-			return ret;
-		}
-
 		if (!chan->cl->tx_tout) /* wait forever */
 			wait = msecs_to_jiffies(3600000);
 		else
@@ -291,6 +283,34 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 }
 EXPORT_SYMBOL_GPL(mbox_send_message);
 
+/**
+ * mbox_flush - flush a mailbox channel
+ * @chan: mailbox channel to flush
+ * @timeout: time, in milliseconds, to allow the flush operation to succeed
+ *
+ * Mailbox controllers that need to work in atomic context can implement the
+ * ->flush() callback to busy loop until a transmission has been completed.
+ * The implementation must call mbox_chan_txdone() upon success. Clients can
+ * call the mbox_flush() function at any time after mbox_send_message() to
+ * flush the transmission. After the function returns success, the mailbox
+ * transmission is guaranteed to have completed.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int mbox_flush(struct mbox_chan *chan, unsigned long timeout)
+{
+	int ret;
+
+	if (!chan->mbox->ops->flush)
+		return -ENOTSUPP;
+
+	ret = chan->mbox->ops->flush(chan, timeout);
+	if (ret < 0)
+		tx_tick(chan, ret);
+
+	return ret;
+}
+
 /**
  * mbox_request_channel - Request a mailbox channel.
  * @cl: Identity of the client requesting the channel.
diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index f99c406cb3cc..e443f6a2ec4b 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -387,15 +387,13 @@ static int tegra_hsp_mailbox_send_data(struct mbox_chan *chan, void *data)
 
 	tegra_hsp_channel_writel(&mb->channel, value, HSP_SM_SHRD_MBOX);
 
-	if (!irqs_disabled()) {
-		/* enable EMPTY interrupt for the shared mailbox */
-		spin_lock_irqsave(&hsp->lock, flags);
+	/* enable EMPTY interrupt for the shared mailbox */
+	spin_lock_irqsave(&hsp->lock, flags);
 
-		hsp->mask |= BIT(HSP_INT_EMPTY_SHIFT + mb->index);
-		tegra_hsp_writel(hsp, hsp->mask, HSP_INT_IE(hsp->shared_irq));
+	hsp->mask |= BIT(HSP_INT_EMPTY_SHIFT + mb->index);
+	tegra_hsp_writel(hsp, hsp->mask, HSP_INT_IE(hsp->shared_irq));
 
-		spin_unlock_irqrestore(&hsp->lock, flags);
-	}
+	spin_unlock_irqrestore(&hsp->lock, flags);
 
 	return 0;
 }
diff --git a/drivers/tty/serial/tegra-tcu.c b/drivers/tty/serial/tegra-tcu.c
index 1d360cd03b18..59eaa13e169e 100644
--- a/drivers/tty/serial/tegra-tcu.c
+++ b/drivers/tty/serial/tegra-tcu.c
@@ -57,6 +57,7 @@ static void tegra_tcu_write_one(struct tegra_tcu *tcu, u32 value,
 	value |= TCU_MBOX_NUM_BYTES(count);
 	msg = (void *)(unsigned long)value;
 	mbox_send_message(tcu->tx, msg);
+	mbox_flush(tcu->tx, 1000);
 }
 
 static void tegra_tcu_write(struct tegra_tcu *tcu, const char *s,
@@ -184,9 +185,6 @@ static int tegra_tcu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	tcu->tx_client.dev = &pdev->dev;
-	tcu->tx_client.tx_block = true;
-	tcu->tx_client.tx_tout = 10000;
-	tcu->rx_client.dev = &pdev->dev;
 	tcu->rx_client.rx_callback = tegra_tcu_receive;
 
 	tcu->tx = mbox_request_channel_byname(&tcu->tx_client, "tx");
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index 44348710953f..faa7da3c9c8b 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -44,6 +44,7 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
 					      const char *name);
 struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index);
 int mbox_send_message(struct mbox_chan *chan, void *mssg);
+int mbox_flush(struct mbox_chan *chan, unsigned long timeout);
 void mbox_client_txdone(struct mbox_chan *chan, int r); /* atomic */
 bool mbox_client_peek_data(struct mbox_chan *chan); /* atomic */
 void mbox_free_channel(struct mbox_chan *chan); /* may sleep */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181123/a7155856/attachment-0001.sig>
