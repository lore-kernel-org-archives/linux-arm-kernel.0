From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 20 Dec 2010 13:37:37 +0100
Subject: [PATCH] ux500: rename modem IRQ and MBOX files
Message-ID: <1292848657-31267-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suffix the U5500 modem IRQ and MBOX files with *-db5500* so that
we clearly know the SoC they belong to, in line with the rest of
the files in mach-ux500.

Cc: Stefan Nilsson <stefan.xk.nilsson@stericsson.com>
Cc: Martin Persson <martin.persson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/Makefile                   |    4 +-
 arch/arm/mach-ux500/include/mach/mbox-db5500.h |   88 ++++
 arch/arm/mach-ux500/include/mach/mbox.h        |   88 ----
 arch/arm/mach-ux500/mbox-db5500.c              |  567 ++++++++++++++++++++++++
 arch/arm/mach-ux500/mbox.c                     |  567 ------------------------
 arch/arm/mach-ux500/modem-irq-db5500.c         |  139 ++++++
 arch/arm/mach-ux500/modem_irq.c                |  139 ------
 drivers/net/caif/caif_shm_u5500.c              |    2 +-
 8 files changed, 797 insertions(+), 797 deletions(-)
 create mode 100644 arch/arm/mach-ux500/include/mach/mbox-db5500.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/mbox.h
 create mode 100644 arch/arm/mach-ux500/mbox-db5500.c
 delete mode 100644 arch/arm/mach-ux500/mbox.c
 create mode 100644 arch/arm/mach-ux500/modem-irq-db5500.c
 delete mode 100644 arch/arm/mach-ux500/modem_irq.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 9e27a84..ed2f2d7 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -11,5 +11,5 @@ obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 obj-$(CONFIG_REGULATOR_AB8500)	+= board-mop500-regulators.o
-obj-$(CONFIG_U5500_MODEM_IRQ)	+= modem_irq.o
-obj-$(CONFIG_U5500_MBOX)	+= mbox.o
+obj-$(CONFIG_U5500_MODEM_IRQ)	+= modem-irq-db5500.o
+obj-$(CONFIG_U5500_MBOX)	+= mbox-db5500.o
diff --git a/arch/arm/mach-ux500/include/mach/mbox-db5500.h b/arch/arm/mach-ux500/include/mach/mbox-db5500.h
new file mode 100644
index 0000000..7f9da4d
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/mbox-db5500.h
@@ -0,0 +1,88 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ * Author: Stefan Nilsson <stefan.xk.nilsson@stericsson.com> for ST-Ericsson.
+ * Author: Martin Persson <martin.persson@stericsson.com> for ST-Ericsson.
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+#ifndef __INC_STE_MBOX_H
+#define __INC_STE_MBOX_H
+
+#define MBOX_BUF_SIZE 16
+#define MBOX_NAME_SIZE 8
+
+/**
+  * mbox_recv_cb_t - Definition of the mailbox callback.
+  * @mbox_msg:	The mailbox message.
+  * @priv:	The clients private data as specified in the call to mbox_setup.
+  *
+  * This function will be called upon reception of new mailbox messages.
+  */
+typedef void mbox_recv_cb_t (u32 mbox_msg, void *priv);
+
+/**
+  * struct mbox - Mailbox instance struct
+  * @list:		Linked list head.
+  * @pdev:		Pointer to device struct.
+  * @cb:		Callback function. Will be called
+  *			when new data is received.
+  * @client_data:	Clients private data. Will be sent back
+  *			in the callback function.
+  * @virtbase_peer:	Virtual address for outgoing mailbox.
+  * @virtbase_local:	Virtual address for incoming mailbox.
+  * @buffer:		Then internal queue for outgoing messages.
+  * @name:		Name of this mailbox.
+  * @buffer_available:	Completion variable to achieve "blocking send".
+  *			This variable will be signaled when there is
+  *			internal buffer space available.
+  * @client_blocked:	To keep track if any client is currently
+  *			blocked.
+  * @lock:		Spinlock to protect this mailbox instance.
+  * @write_index:	Index in internal buffer to write to.
+  * @read_index:	Index in internal buffer to read from.
+  * @allocated:		Indicates whether this particular mailbox
+  *			id has been allocated by someone.
+  */
+struct mbox {
+	struct list_head list;
+	struct platform_device *pdev;
+	mbox_recv_cb_t *cb;
+	void *client_data;
+	void __iomem *virtbase_peer;
+	void __iomem *virtbase_local;
+	u32 buffer[MBOX_BUF_SIZE];
+	char name[MBOX_NAME_SIZE];
+	struct completion buffer_available;
+	u8 client_blocked;
+	spinlock_t lock;
+	u8 write_index;
+	u8 read_index;
+	bool allocated;
+};
+
+/**
+  * mbox_setup - Set up a mailbox and return its instance.
+  * @mbox_id:	The ID number of the mailbox. 0 or 1 for modem CPU,
+  *		2 for modem DSP.
+  * @mbox_cb:	Pointer to the callback function to be called when a new message
+  *		is received.
+  * @priv:	Client user data which will be returned in the callback.
+  *
+  * Returns a mailbox instance to be specified in subsequent calls to mbox_send.
+  */
+struct mbox *mbox_setup(u8 mbox_id, mbox_recv_cb_t *mbox_cb, void *priv);
+
+/**
+  * mbox_send - Send a mailbox message.
+  * @mbox:	Mailbox instance (returned by mbox_setup)
+  * @mbox_msg:	The mailbox message to send.
+  * @block:	Specifies whether this call will block until send is possible,
+  *		or return an error if the mailbox buffer is full.
+  *
+  * Returns 0 on success or a negative error code on error. -ENOMEM indicates
+  * that the internal buffer is full and you have to try again later (or
+  * specify "block" in order to block until send is possible).
+  */
+int mbox_send(struct mbox *mbox, u32 mbox_msg, bool block);
+
+#endif /*INC_STE_MBOX_H*/
diff --git a/arch/arm/mach-ux500/include/mach/mbox.h b/arch/arm/mach-ux500/include/mach/mbox.h
deleted file mode 100644
index 7f9da4d..0000000
--- a/arch/arm/mach-ux500/include/mach/mbox.h
+++ /dev/null
@@ -1,88 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- * Author: Stefan Nilsson <stefan.xk.nilsson@stericsson.com> for ST-Ericsson.
- * Author: Martin Persson <martin.persson@stericsson.com> for ST-Ericsson.
- * License terms: GNU General Public License (GPL), version 2.
- */
-
-#ifndef __INC_STE_MBOX_H
-#define __INC_STE_MBOX_H
-
-#define MBOX_BUF_SIZE 16
-#define MBOX_NAME_SIZE 8
-
-/**
-  * mbox_recv_cb_t - Definition of the mailbox callback.
-  * @mbox_msg:	The mailbox message.
-  * @priv:	The clients private data as specified in the call to mbox_setup.
-  *
-  * This function will be called upon reception of new mailbox messages.
-  */
-typedef void mbox_recv_cb_t (u32 mbox_msg, void *priv);
-
-/**
-  * struct mbox - Mailbox instance struct
-  * @list:		Linked list head.
-  * @pdev:		Pointer to device struct.
-  * @cb:		Callback function. Will be called
-  *			when new data is received.
-  * @client_data:	Clients private data. Will be sent back
-  *			in the callback function.
-  * @virtbase_peer:	Virtual address for outgoing mailbox.
-  * @virtbase_local:	Virtual address for incoming mailbox.
-  * @buffer:		Then internal queue for outgoing messages.
-  * @name:		Name of this mailbox.
-  * @buffer_available:	Completion variable to achieve "blocking send".
-  *			This variable will be signaled when there is
-  *			internal buffer space available.
-  * @client_blocked:	To keep track if any client is currently
-  *			blocked.
-  * @lock:		Spinlock to protect this mailbox instance.
-  * @write_index:	Index in internal buffer to write to.
-  * @read_index:	Index in internal buffer to read from.
-  * @allocated:		Indicates whether this particular mailbox
-  *			id has been allocated by someone.
-  */
-struct mbox {
-	struct list_head list;
-	struct platform_device *pdev;
-	mbox_recv_cb_t *cb;
-	void *client_data;
-	void __iomem *virtbase_peer;
-	void __iomem *virtbase_local;
-	u32 buffer[MBOX_BUF_SIZE];
-	char name[MBOX_NAME_SIZE];
-	struct completion buffer_available;
-	u8 client_blocked;
-	spinlock_t lock;
-	u8 write_index;
-	u8 read_index;
-	bool allocated;
-};
-
-/**
-  * mbox_setup - Set up a mailbox and return its instance.
-  * @mbox_id:	The ID number of the mailbox. 0 or 1 for modem CPU,
-  *		2 for modem DSP.
-  * @mbox_cb:	Pointer to the callback function to be called when a new message
-  *		is received.
-  * @priv:	Client user data which will be returned in the callback.
-  *
-  * Returns a mailbox instance to be specified in subsequent calls to mbox_send.
-  */
-struct mbox *mbox_setup(u8 mbox_id, mbox_recv_cb_t *mbox_cb, void *priv);
-
-/**
-  * mbox_send - Send a mailbox message.
-  * @mbox:	Mailbox instance (returned by mbox_setup)
-  * @mbox_msg:	The mailbox message to send.
-  * @block:	Specifies whether this call will block until send is possible,
-  *		or return an error if the mailbox buffer is full.
-  *
-  * Returns 0 on success or a negative error code on error. -ENOMEM indicates
-  * that the internal buffer is full and you have to try again later (or
-  * specify "block" in order to block until send is possible).
-  */
-int mbox_send(struct mbox *mbox, u32 mbox_msg, bool block);
-
-#endif /*INC_STE_MBOX_H*/
diff --git a/arch/arm/mach-ux500/mbox-db5500.c b/arch/arm/mach-ux500/mbox-db5500.c
new file mode 100644
index 0000000..cbf1571
--- /dev/null
+++ b/arch/arm/mach-ux500/mbox-db5500.c
@@ -0,0 +1,567 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ * Author: Stefan Nilsson <stefan.xk.nilsson@stericsson.com> for ST-Ericsson.
+ * Author: Martin Persson <martin.persson@stericsson.com> for ST-Ericsson.
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+/*
+ * Mailbox nomenclature:
+ *
+ *       APE           MODEM
+ *           mbox pairX
+ *   ..........................
+ *   .                       .
+ *   .           peer        .
+ *   .     send  ----        .
+ *   .      -->  |  |        .
+ *   .           |  |        .
+ *   .           ----        .
+ *   .                       .
+ *   .           local       .
+ *   .     rec   ----        .
+ *   .           |  | <--    .
+ *   .           |  |        .
+ *   .           ----        .
+ *   .........................
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/completion.h>
+#include <mach/mbox-db5500.h>
+
+#define MBOX_NAME "mbox"
+
+#define MBOX_FIFO_DATA        0x000
+#define MBOX_FIFO_ADD         0x004
+#define MBOX_FIFO_REMOVE      0x008
+#define MBOX_FIFO_THRES_FREE  0x00C
+#define MBOX_FIFO_THRES_OCCUP 0x010
+#define MBOX_FIFO_STATUS      0x014
+
+#define MBOX_DISABLE_IRQ 0x4
+#define MBOX_ENABLE_IRQ  0x0
+#define MBOX_LATCH 1
+
+/* Global list of all mailboxes */
+static struct list_head mboxs = LIST_HEAD_INIT(mboxs);
+
+static struct mbox *get_mbox_with_id(u8 id)
+{
+	u8 i;
+	struct list_head *pos = &mboxs;
+	for (i = 0; i <= id; i++)
+		pos = pos->next;
+
+	return (struct mbox *) list_entry(pos, struct mbox, list);
+}
+
+int mbox_send(struct mbox *mbox, u32 mbox_msg, bool block)
+{
+	int res = 0;
+
+	spin_lock(&mbox->lock);
+
+	dev_dbg(&(mbox->pdev->dev),
+		"About to buffer 0x%X to mailbox 0x%X."
+		" ri = %d, wi = %d\n",
+		mbox_msg, (u32)mbox, mbox->read_index,
+		mbox->write_index);
+
+	/* Check if write buffer is full */
+	while (((mbox->write_index + 1) % MBOX_BUF_SIZE) == mbox->read_index) {
+		if (!block) {
+			dev_dbg(&(mbox->pdev->dev),
+			"Buffer full in non-blocking call! "
+			"Returning -ENOMEM!\n");
+			res = -ENOMEM;
+			goto exit;
+		}
+		spin_unlock(&mbox->lock);
+		dev_dbg(&(mbox->pdev->dev),
+			"Buffer full in blocking call! Sleeping...\n");
+		mbox->client_blocked = 1;
+		wait_for_completion(&mbox->buffer_available);
+		dev_dbg(&(mbox->pdev->dev),
+			"Blocking send was woken up! Trying again...\n");
+		spin_lock(&mbox->lock);
+	}
+
+	mbox->buffer[mbox->write_index] = mbox_msg;
+	mbox->write_index = (mbox->write_index + 1) % MBOX_BUF_SIZE;
+
+	/*
+	 * Indicate that we want an IRQ as soon as there is a slot
+	 * in the FIFO
+	 */
+	writel(MBOX_ENABLE_IRQ, mbox->virtbase_peer + MBOX_FIFO_THRES_FREE);
+
+exit:
+	spin_unlock(&mbox->lock);
+	return res;
+}
+EXPORT_SYMBOL(mbox_send);
+
+#if defined(CONFIG_DEBUG_FS)
+/*
+ * Expected input: <value> <nbr sends>
+ * Example: "echo 0xdeadbeef 4 > mbox-node" sends 0xdeadbeef 4 times
+ */
+static ssize_t mbox_write_fifo(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf,
+			       size_t count)
+{
+	unsigned long mbox_mess;
+	unsigned long nbr_sends;
+	unsigned long i;
+	char int_buf[16];
+	char *token;
+	char *val;
+
+	struct mbox *mbox = (struct mbox *) dev->platform_data;
+
+	strncpy((char *) &int_buf, buf, sizeof(int_buf));
+	token = (char *) &int_buf;
+
+	/* Parse message */
+	val = strsep(&token, " ");
+	if ((val == NULL) || (strict_strtoul(val, 16, &mbox_mess) != 0))
+		mbox_mess = 0xDEADBEEF;
+
+	val = strsep(&token, " ");
+	if ((val == NULL) || (strict_strtoul(val, 10, &nbr_sends) != 0))
+		nbr_sends = 1;
+
+	dev_dbg(dev, "Will write 0x%lX %ld times using data struct at 0x%X\n",
+		mbox_mess, nbr_sends, (u32) mbox);
+
+	for (i = 0; i < nbr_sends; i++)
+		mbox_send(mbox, mbox_mess, true);
+
+	return count;
+}
+
+static ssize_t mbox_read_fifo(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	int mbox_value;
+	struct mbox *mbox = (struct mbox *) dev->platform_data;
+
+	if ((readl(mbox->virtbase_local + MBOX_FIFO_STATUS) & 0x7) <= 0)
+		return sprintf(buf, "Mailbox is empty\n");
+
+	mbox_value = readl(mbox->virtbase_local + MBOX_FIFO_DATA);
+	writel(MBOX_LATCH, (mbox->virtbase_local + MBOX_FIFO_REMOVE));
+
+	return sprintf(buf, "0x%X\n", mbox_value);
+}
+
+static DEVICE_ATTR(fifo, S_IWUGO | S_IRUGO, mbox_read_fifo, mbox_write_fifo);
+
+static int mbox_show(struct seq_file *s, void *data)
+{
+	struct list_head *pos;
+	u8 mbox_index = 0;
+
+	list_for_each(pos, &mboxs) {
+		struct mbox *m =
+			(struct mbox *) list_entry(pos, struct mbox, list);
+		if (m == NULL) {
+			seq_printf(s,
+				   "Unable to retrieve mailbox %d\n",
+				   mbox_index);
+			continue;
+		}
+
+		spin_lock(&m->lock);
+		if ((m->virtbase_peer == NULL) || (m->virtbase_local == NULL)) {
+			seq_printf(s, "MAILBOX %d not setup or corrupt\n",
+				   mbox_index);
+			spin_unlock(&m->lock);
+			continue;
+		}
+
+		seq_printf(s,
+		"===========================\n"
+		" MAILBOX %d\n"
+		" PEER MAILBOX DUMP\n"
+		"---------------------------\n"
+		"FIFO:                 0x%X (%d)\n"
+		"Free     Threshold:   0x%.2X (%d)\n"
+		"Occupied Threshold:   0x%.2X (%d)\n"
+		"Status:               0x%.2X (%d)\n"
+		"   Free spaces  (ot):    %d (%d)\n"
+		"   Occup spaces (ot):    %d (%d)\n"
+		"===========================\n"
+		" LOCAL MAILBOX DUMP\n"
+		"---------------------------\n"
+		"FIFO:                 0x%.X (%d)\n"
+		"Free     Threshold:   0x%.2X (%d)\n"
+		"Occupied Threshold:   0x%.2X (%d)\n"
+		"Status:               0x%.2X (%d)\n"
+		"   Free spaces  (ot):    %d (%d)\n"
+		"   Occup spaces (ot):    %d (%d)\n"
+		"===========================\n"
+		"write_index: %d\n"
+		"read_index : %d\n"
+		"===========================\n"
+		"\n",
+		mbox_index,
+		readl(m->virtbase_peer + MBOX_FIFO_DATA),
+		readl(m->virtbase_peer + MBOX_FIFO_DATA),
+		readl(m->virtbase_peer + MBOX_FIFO_THRES_FREE),
+		readl(m->virtbase_peer + MBOX_FIFO_THRES_FREE),
+		readl(m->virtbase_peer + MBOX_FIFO_THRES_OCCUP),
+		readl(m->virtbase_peer + MBOX_FIFO_THRES_OCCUP),
+		readl(m->virtbase_peer + MBOX_FIFO_STATUS),
+		readl(m->virtbase_peer + MBOX_FIFO_STATUS),
+		(readl(m->virtbase_peer + MBOX_FIFO_STATUS) >> 4) & 0x7,
+		(readl(m->virtbase_peer + MBOX_FIFO_STATUS) >> 7) & 0x1,
+		(readl(m->virtbase_peer + MBOX_FIFO_STATUS) >> 0) & 0x7,
+		(readl(m->virtbase_peer + MBOX_FIFO_STATUS) >> 3) & 0x1,
+		readl(m->virtbase_local + MBOX_FIFO_DATA),
+		readl(m->virtbase_local + MBOX_FIFO_DATA),
+		readl(m->virtbase_local + MBOX_FIFO_THRES_FREE),
+		readl(m->virtbase_local + MBOX_FIFO_THRES_FREE),
+		readl(m->virtbase_local + MBOX_FIFO_THRES_OCCUP),
+		readl(m->virtbase_local + MBOX_FIFO_THRES_OCCUP),
+		readl(m->virtbase_local + MBOX_FIFO_STATUS),
+		readl(m->virtbase_local + MBOX_FIFO_STATUS),
+		(readl(m->virtbase_local + MBOX_FIFO_STATUS) >> 4) & 0x7,
+		(readl(m->virtbase_local + MBOX_FIFO_STATUS) >> 7) & 0x1,
+		(readl(m->virtbase_local + MBOX_FIFO_STATUS) >> 0) & 0x7,
+		(readl(m->virtbase_local + MBOX_FIFO_STATUS) >> 3) & 0x1,
+		m->write_index, m->read_index);
+		mbox_index++;
+		spin_unlock(&m->lock);
+	}
+
+	return 0;
+}
+
+static int mbox_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mbox_show, NULL);
+}
+
+static const struct file_operations mbox_operations = {
+	.owner = THIS_MODULE,
+	.open = mbox_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+#endif
+
+static irqreturn_t mbox_irq(int irq, void *arg)
+{
+	u32 mbox_value;
+	int nbr_occup;
+	int nbr_free;
+	struct mbox *mbox = (struct mbox *) arg;
+
+	spin_lock(&mbox->lock);
+
+	dev_dbg(&(mbox->pdev->dev),
+		"mbox IRQ [%d] received. ri = %d, wi = %d\n",
+		irq, mbox->read_index, mbox->write_index);
+
+	/*
+	 * Check if we have any outgoing messages, and if there is space for
+	 * them in the FIFO.
+	 */
+	if (mbox->read_index != mbox->write_index) {
+		/*
+		 * Check by reading FREE for LOCAL since that indicates
+		 * OCCUP for PEER
+		 */
+		nbr_free = (readl(mbox->virtbase_local + MBOX_FIFO_STATUS)
+			    >> 4) & 0x7;
+		dev_dbg(&(mbox->pdev->dev),
+			"Status indicates %d empty spaces in the FIFO!\n",
+			nbr_free);
+
+		while ((nbr_free > 0) &&
+		       (mbox->read_index != mbox->write_index)) {
+			/* Write the message and latch it into the FIFO */
+			writel(mbox->buffer[mbox->read_index],
+			       (mbox->virtbase_peer + MBOX_FIFO_DATA));
+			writel(MBOX_LATCH,
+			       (mbox->virtbase_peer + MBOX_FIFO_ADD));
+			dev_dbg(&(mbox->pdev->dev),
+				"Wrote message 0x%X to addr 0x%X\n",
+				mbox->buffer[mbox->read_index],
+				(u32) (mbox->virtbase_peer + MBOX_FIFO_DATA));
+
+			nbr_free--;
+			mbox->read_index =
+				(mbox->read_index + 1) % MBOX_BUF_SIZE;
+		}
+
+		/*
+		 * Check if we still want IRQ:s when there is free
+		 * space to send
+		 */
+		if (mbox->read_index != mbox->write_index) {
+			dev_dbg(&(mbox->pdev->dev),
+				"Still have messages to send, but FIFO full. "
+				"Request IRQ again!\n");
+			writel(MBOX_ENABLE_IRQ,
+			       mbox->virtbase_peer + MBOX_FIFO_THRES_FREE);
+		} else {
+			dev_dbg(&(mbox->pdev->dev),
+				"No more messages to send. "
+				"Do not request IRQ again!\n");
+			writel(MBOX_DISABLE_IRQ,
+			       mbox->virtbase_peer + MBOX_FIFO_THRES_FREE);
+		}
+
+		/*
+		 * Check if we can signal any blocked clients that it is OK to
+		 * start buffering again
+		 */
+		if (mbox->client_blocked &&
+		    (((mbox->write_index + 1) % MBOX_BUF_SIZE)
+		     != mbox->read_index)) {
+			dev_dbg(&(mbox->pdev->dev),
+				"Waking up blocked client\n");
+			complete(&mbox->buffer_available);
+			mbox->client_blocked = 0;
+		}
+	}
+
+	/* Check if we have any incoming messages */
+	nbr_occup = readl(mbox->virtbase_local + MBOX_FIFO_STATUS) & 0x7;
+	if (nbr_occup == 0)
+		goto exit;
+
+	if (mbox->cb == NULL) {
+		dev_dbg(&(mbox->pdev->dev), "No receive callback registered, "
+			"leaving %d incoming messages in fifo!\n", nbr_occup);
+		goto exit;
+	}
+
+	/* Read and acknowledge the message */
+	mbox_value = readl(mbox->virtbase_local + MBOX_FIFO_DATA);
+	writel(MBOX_LATCH, (mbox->virtbase_local + MBOX_FIFO_REMOVE));
+
+	/* Notify consumer of new mailbox message */
+	dev_dbg(&(mbox->pdev->dev), "Calling callback for message 0x%X!\n",
+		mbox_value);
+	mbox->cb(mbox_value, mbox->client_data);
+
+exit:
+	dev_dbg(&(mbox->pdev->dev), "Exit mbox IRQ. ri = %d, wi = %d\n",
+		mbox->read_index, mbox->write_index);
+	spin_unlock(&mbox->lock);
+
+	return IRQ_HANDLED;
+}
+
+/* Setup is executed once for each mbox pair */
+struct mbox *mbox_setup(u8 mbox_id, mbox_recv_cb_t *mbox_cb, void *priv)
+{
+	struct resource *resource;
+	int irq;
+	int res;
+	struct mbox *mbox;
+
+	mbox = get_mbox_with_id(mbox_id);
+	if (mbox == NULL) {
+		dev_err(&(mbox->pdev->dev), "Incorrect mailbox id: %d!\n",
+			mbox_id);
+		goto exit;
+	}
+
+	/*
+	 * Check if mailbox has been allocated to someone else,
+	 * otherwise allocate it
+	 */
+	if (mbox->allocated) {
+		dev_err(&(mbox->pdev->dev), "Mailbox number %d is busy!\n",
+			mbox_id);
+		mbox = NULL;
+		goto exit;
+	}
+	mbox->allocated = true;
+
+	dev_dbg(&(mbox->pdev->dev), "Initiating mailbox number %d: 0x%X...\n",
+		mbox_id, (u32)mbox);
+
+	mbox->client_data = priv;
+	mbox->cb = mbox_cb;
+
+	/* Get addr for peer mailbox and ioremap it */
+	resource = platform_get_resource_byname(mbox->pdev,
+						IORESOURCE_MEM,
+						"mbox_peer");
+	if (resource == NULL) {
+		dev_err(&(mbox->pdev->dev),
+			"Unable to retrieve mbox peer resource\n");
+		mbox = NULL;
+		goto exit;
+	}
+	dev_dbg(&(mbox->pdev->dev),
+		"Resource name: %s start: 0x%X, end: 0x%X\n",
+		resource->name, resource->start, resource->end);
+	mbox->virtbase_peer =
+		ioremap(resource->start, resource->end - resource->start);
+	if (!mbox->virtbase_peer) {
+		dev_err(&(mbox->pdev->dev), "Unable to ioremap peer mbox\n");
+		mbox = NULL;
+		goto exit;
+	}
+	dev_dbg(&(mbox->pdev->dev),
+		"ioremapped peer physical: (0x%X-0x%X) to virtual: 0x%X\n",
+		resource->start, resource->end, (u32) mbox->virtbase_peer);
+
+	/* Get addr for local mailbox and ioremap it */
+	resource = platform_get_resource_byname(mbox->pdev,
+						IORESOURCE_MEM,
+						"mbox_local");
+	if (resource == NULL) {
+		dev_err(&(mbox->pdev->dev),
+			"Unable to retrieve mbox local resource\n");
+		mbox = NULL;
+		goto exit;
+	}
+	dev_dbg(&(mbox->pdev->dev),
+		"Resource name: %s start: 0x%X, end: 0x%X\n",
+		resource->name, resource->start, resource->end);
+	mbox->virtbase_local =
+		ioremap(resource->start, resource->end - resource->start);
+	if (!mbox->virtbase_local) {
+		dev_err(&(mbox->pdev->dev), "Unable to ioremap local mbox\n");
+		mbox = NULL;
+		goto exit;
+	}
+	dev_dbg(&(mbox->pdev->dev),
+		"ioremapped local physical: (0x%X-0x%X) to virtual: 0x%X\n",
+		resource->start, resource->end, (u32) mbox->virtbase_peer);
+
+	init_completion(&mbox->buffer_available);
+	mbox->client_blocked = 0;
+
+	/* Get IRQ for mailbox and allocate it */
+	irq = platform_get_irq_byname(mbox->pdev, "mbox_irq");
+	if (irq < 0) {
+		dev_err(&(mbox->pdev->dev),
+			"Unable to retrieve mbox irq resource\n");
+		mbox = NULL;
+		goto exit;
+	}
+
+	dev_dbg(&(mbox->pdev->dev), "Allocating irq %d...\n", irq);
+	res = request_irq(irq, mbox_irq, 0, mbox->name, (void *) mbox);
+	if (res < 0) {
+		dev_err(&(mbox->pdev->dev),
+			"Unable to allocate mbox irq %d\n", irq);
+		mbox = NULL;
+		goto exit;
+	}
+
+	/* Set up mailbox to not launch IRQ on free space in mailbox */
+	writel(MBOX_DISABLE_IRQ, mbox->virtbase_peer + MBOX_FIFO_THRES_FREE);
+
+	/*
+	 * Set up mailbox to launch IRQ on new message if we have
+	 * a callback set. If not, do not raise IRQ, but keep message
+	 * in FIFO for manual retrieval
+	 */
+	if (mbox_cb != NULL)
+		writel(MBOX_ENABLE_IRQ,
+		       mbox->virtbase_local + MBOX_FIFO_THRES_OCCUP);
+	else
+		writel(MBOX_DISABLE_IRQ,
+		       mbox->virtbase_local + MBOX_FIFO_THRES_OCCUP);
+
+#if defined(CONFIG_DEBUG_FS)
+	res = device_create_file(&(mbox->pdev->dev), &dev_attr_fifo);
+	if (res != 0)
+		dev_warn(&(mbox->pdev->dev),
+			 "Unable to create mbox sysfs entry");
+
+	(void) debugfs_create_file("mbox", S_IFREG | S_IRUGO, NULL,
+				   NULL, &mbox_operations);
+#endif
+
+	dev_info(&(mbox->pdev->dev),
+		 "Mailbox driver with index %d initated!\n", mbox_id);
+
+exit:
+	return mbox;
+}
+EXPORT_SYMBOL(mbox_setup);
+
+
+int __init mbox_probe(struct platform_device *pdev)
+{
+	struct mbox local_mbox;
+	struct mbox *mbox;
+	int res = 0;
+	dev_dbg(&(pdev->dev), "Probing mailbox (pdev = 0x%X)...\n", (u32) pdev);
+
+	memset(&local_mbox, 0x0, sizeof(struct mbox));
+
+	/* Associate our mbox data with the platform device */
+	res = platform_device_add_data(pdev,
+				       (void *) &local_mbox,
+				       sizeof(struct mbox));
+	if (res != 0) {
+		dev_err(&(pdev->dev),
+			"Unable to allocate driver platform data!\n");
+		goto exit;
+	}
+
+	mbox = (struct mbox *) pdev->dev.platform_data;
+	mbox->pdev = pdev;
+	mbox->write_index = 0;
+	mbox->read_index = 0;
+
+	INIT_LIST_HEAD(&(mbox->list));
+	list_add_tail(&(mbox->list), &mboxs);
+
+	sprintf(mbox->name, "%s", MBOX_NAME);
+	spin_lock_init(&mbox->lock);
+
+	dev_info(&(pdev->dev), "Mailbox driver loaded\n");
+
+exit:
+	return res;
+}
+
+static struct platform_driver mbox_driver = {
+	.driver = {
+		.name = MBOX_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init mbox_init(void)
+{
+	return platform_driver_probe(&mbox_driver, mbox_probe);
+}
+
+module_init(mbox_init);
+
+void __exit mbox_exit(void)
+{
+	platform_driver_unregister(&mbox_driver);
+}
+
+module_exit(mbox_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MBOX driver");
diff --git a/arch/arm/mach-ux500/mbox.c b/arch/arm/mach-ux500/mbox.c
deleted file mode 100644
index 6343538..0000000
--- a/arch/arm/mach-ux500/mbox.c
+++ /dev/null
@@ -1,567 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- * Author: Stefan Nilsson <stefan.xk.nilsson@stericsson.com> for ST-Ericsson.
- * Author: Martin Persson <martin.persson@stericsson.com> for ST-Ericsson.
- * License terms: GNU General Public License (GPL), version 2.
- */
-
-/*
- * Mailbox nomenclature:
- *
- *       APE           MODEM
- *           mbox pairX
- *   ..........................
- *   .                       .
- *   .           peer        .
- *   .     send  ----        .
- *   .      -->  |  |        .
- *   .           |  |        .
- *   .           ----        .
- *   .                       .
- *   .           local       .
- *   .     rec   ----        .
- *   .           |  | <--    .
- *   .           |  |        .
- *   .           ----        .
- *   .........................
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <linux/errno.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/platform_device.h>
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-#include <linux/completion.h>
-#include <mach/mbox.h>
-
-#define MBOX_NAME "mbox"
-
-#define MBOX_FIFO_DATA        0x000
-#define MBOX_FIFO_ADD         0x004
-#define MBOX_FIFO_REMOVE      0x008
-#define MBOX_FIFO_THRES_FREE  0x00C
-#define MBOX_FIFO_THRES_OCCUP 0x010
-#define MBOX_FIFO_STATUS      0x014
-
-#define MBOX_DISABLE_IRQ 0x4
-#define MBOX_ENABLE_IRQ  0x0
-#define MBOX_LATCH 1
-
-/* Global list of all mailboxes */
-static struct list_head mboxs = LIST_HEAD_INIT(mboxs);
-
-static struct mbox *get_mbox_with_id(u8 id)
-{
-	u8 i;
-	struct list_head *pos = &mboxs;
-	for (i = 0; i <= id; i++)
-		pos = pos->next;
-
-	return (struct mbox *) list_entry(pos, struct mbox, list);
-}
-
-int mbox_send(struct mbox *mbox, u32 mbox_msg, bool block)
-{
-	int res = 0;
-
-	spin_lock(&mbox->lock);
-
-	dev_dbg(&(mbox->pdev->dev),
-		"About to buffer 0x%X to mailbox 0x%X."
-		" ri = %d, wi = %d\n",
-		mbox_msg, (u32)mbox, mbox->read_index,
-		mbox->write_index);
-
-	/* Check if write buffer is full */
-	while (((mbox->write_index + 1) % MBOX_BUF_SIZE) == mbox->read_index) {
-		if (!block) {
-			dev_dbg(&(mbox->pdev->dev),
-			"Buffer full in non-blocking call! "
-			"Returning -ENOMEM!\n");
-			res = -ENOMEM;
-			goto exit;
-		}
-		spin_unlock(&mbox->lock);
-		dev_dbg(&(mbox->pdev->dev),
-			"Buffer full in blocking call! Sleeping...\n");
-		mbox->client_blocked = 1;
-		wait_for_completion(&mbox->buffer_available);
-		dev_dbg(&(mbox->pdev->dev),
-			"Blocking send was woken up! Trying again...\n");
-		spin_lock(&mbox->lock);
-	}
-
-	mbox->buffer[mbox->write_index] = mbox_msg;
-	mbox->write_index = (mbox->write_index + 1) % MBOX_BUF_SIZE;
-
-	/*
-	 * Indicate that we want an IRQ as soon as there is a slot
-	 * in the FIFO
-	 */
-	writel(MBOX_ENABLE_IRQ, mbox->virtbase_peer + MBOX_FIFO_THRES_FREE);
-
-exit:
-	spin_unlock(&mbox->lock);
-	return res;
-}
-EXPORT_SYMBOL(mbox_send);
-
-#if defined(CONFIG_DEBUG_FS)
-/*
- * Expected input: <value> <nbr sends>
- * Example: "echo 0xdeadbeef 4 > mbox-node" sends 0xdeadbeef 4 times
- */
-static ssize_t mbox_write_fifo(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf,
-			       size_t count)
-{
-	unsigned long mbox_mess;
-	unsigned long nbr_sends;
-	unsigned long i;
-	char int_buf[16];
-	char *token;
-	char *val;
-
-	struct mbox *mbox = (struct mbox *) dev->platform_data;
-
-	strncpy((char *) &int_buf, buf, sizeof(int_buf));
-	token = (char *) &int_buf;
-
-	/* Parse message */
-	val = strsep(&token, " ");
-	if ((val == NULL) || (strict_strtoul(val, 16, &mbox_mess) != 0))
-		mbox_mess = 0xDEADBEEF;
-
-	val = strsep(&token, " ");
-	if ((val == NULL) || (strict_strtoul(val, 10, &nbr_sends) != 0))
-		nbr_sends = 1;
-
-	dev_dbg(dev, "Will write 0x%lX %ld times using data struct at 0x%X\n",
-		mbox_mess, nbr_sends, (u32) mbox);
-
-	for (i = 0; i < nbr_sends; i++)
-		mbox_send(mbox, mbox_mess, true);
-
-	return count;
-}
-
-static ssize_t mbox_read_fifo(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	int mbox_value;
-	struct mbox *mbox = (struct mbox *) dev->platform_data;
-
-	if ((readl(mbox->virtbase_local + MBOX_FIFO_STATUS) & 0x7) <= 0)
-		return sprintf(buf, "Mailbox is empty\n");
-
-	mbox_value = readl(mbox->virtbase_local + MBOX_FIFO_DATA);
-	writel(MBOX_LATCH, (mbox->virtbase_local + MBOX_FIFO_REMOVE));
-
-	return sprintf(buf, "0x%X\n", mbox_value);
-}
-
-static DEVICE_ATTR(fifo, S_IWUGO | S_IRUGO, mbox_read_fifo, mbox_write_fifo);
-
-static int mbox_show(struct seq_file *s, void *data)
-{
-	struct list_head *pos;
-	u8 mbox_index = 0;
-
-	list_for_each(pos, &mboxs) {
-		struct mbox *m =
-			(struct mbox *) list_entry(pos, struct mbox, list);
-		if (m == NULL) {
-			seq_printf(s,
-				   "Unable to retrieve mailbox %d\n",
-				   mbox_index);
-			continue;
-		}
-
-		spin_lock(&m->lock);
-		if ((m->virtbase_peer == NULL) || (m->virtbase_local == NULL)) {
-			seq_printf(s, "MAILBOX %d not setup or corrupt\n",
-				   mbox_index);
-			spin_unlock(&m->lock);
-			continue;
-		}
-
-		seq_printf(s,
-		"===========================\n"
-		" MAILBOX %d\n"
-		" PEER MAILBOX DUMP\n"
-		"---------------------------\n"
-		"FIFO:                 0x%X (%d)\n"
-		"Free     Threshold:   0x%.2X (%d)\n"
-		"Occupied Threshold:   0x%.2X (%d)\n"
-		"Status:               0x%.2X (%d)\n"
-		"   Free spaces  (ot):    %d (%d)\n"
-		"   Occup spaces (ot):    %d (%d)\n"
-		"===========================\n"
-		" LOCAL MAILBOX DUMP\n"
-		"---------------------------\n"
-		"FIFO:                 0x%.X (%d)\n"
-		"Free     Threshold:   0x%.2X (%d)\n"
-		"Occupied Threshold:   0x%.2X (%d)\n"
-		"Status:               0x%.2X (%d)\n"
-		"   Free spaces  (ot):    %d (%d)\n"
-		"   Occup spaces (ot):    %d (%d)\n"
-		"===========================\n"
-		"write_index: %d\n"
-		"read_index : %d\n"
-		"===========================\n"
-		"\n",
-		mbox_index,
-		readl(m->virtbase_peer + MBOX_FIFO_DATA),
-		readl(m->virtbase_peer + MBOX_FIFO_DATA),
-		readl(m->virtbase_peer + MBOX_FIFO_THRES_FREE),
-		readl(m->virtbase_peer + MBOX_FIFO_THRES_FREE),
-		readl(m->virtbase_peer + MBOX_FIFO_THRES_OCCUP),
-		readl(m->virtbase_peer + MBOX_FIFO_THRES_OCCUP),
-		readl(m->virtbase_peer + MBOX_FIFO_STATUS),
-		readl(m->virtbase_peer + MBOX_FIFO_STATUS),
-		(readl(m->virtbase_peer + MBOX_FIFO_STATUS) >> 4) & 0x7,
-		(readl(m->virtbase_peer + MBOX_FIFO_STATUS) >> 7) & 0x1,
-		(readl(m->virtbase_peer + MBOX_FIFO_STATUS) >> 0) & 0x7,
-		(readl(m->virtbase_peer + MBOX_FIFO_STATUS) >> 3) & 0x1,
-		readl(m->virtbase_local + MBOX_FIFO_DATA),
-		readl(m->virtbase_local + MBOX_FIFO_DATA),
-		readl(m->virtbase_local + MBOX_FIFO_THRES_FREE),
-		readl(m->virtbase_local + MBOX_FIFO_THRES_FREE),
-		readl(m->virtbase_local + MBOX_FIFO_THRES_OCCUP),
-		readl(m->virtbase_local + MBOX_FIFO_THRES_OCCUP),
-		readl(m->virtbase_local + MBOX_FIFO_STATUS),
-		readl(m->virtbase_local + MBOX_FIFO_STATUS),
-		(readl(m->virtbase_local + MBOX_FIFO_STATUS) >> 4) & 0x7,
-		(readl(m->virtbase_local + MBOX_FIFO_STATUS) >> 7) & 0x1,
-		(readl(m->virtbase_local + MBOX_FIFO_STATUS) >> 0) & 0x7,
-		(readl(m->virtbase_local + MBOX_FIFO_STATUS) >> 3) & 0x1,
-		m->write_index, m->read_index);
-		mbox_index++;
-		spin_unlock(&m->lock);
-	}
-
-	return 0;
-}
-
-static int mbox_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, mbox_show, NULL);
-}
-
-static const struct file_operations mbox_operations = {
-	.owner = THIS_MODULE,
-	.open = mbox_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-#endif
-
-static irqreturn_t mbox_irq(int irq, void *arg)
-{
-	u32 mbox_value;
-	int nbr_occup;
-	int nbr_free;
-	struct mbox *mbox = (struct mbox *) arg;
-
-	spin_lock(&mbox->lock);
-
-	dev_dbg(&(mbox->pdev->dev),
-		"mbox IRQ [%d] received. ri = %d, wi = %d\n",
-		irq, mbox->read_index, mbox->write_index);
-
-	/*
-	 * Check if we have any outgoing messages, and if there is space for
-	 * them in the FIFO.
-	 */
-	if (mbox->read_index != mbox->write_index) {
-		/*
-		 * Check by reading FREE for LOCAL since that indicates
-		 * OCCUP for PEER
-		 */
-		nbr_free = (readl(mbox->virtbase_local + MBOX_FIFO_STATUS)
-			    >> 4) & 0x7;
-		dev_dbg(&(mbox->pdev->dev),
-			"Status indicates %d empty spaces in the FIFO!\n",
-			nbr_free);
-
-		while ((nbr_free > 0) &&
-		       (mbox->read_index != mbox->write_index)) {
-			/* Write the message and latch it into the FIFO */
-			writel(mbox->buffer[mbox->read_index],
-			       (mbox->virtbase_peer + MBOX_FIFO_DATA));
-			writel(MBOX_LATCH,
-			       (mbox->virtbase_peer + MBOX_FIFO_ADD));
-			dev_dbg(&(mbox->pdev->dev),
-				"Wrote message 0x%X to addr 0x%X\n",
-				mbox->buffer[mbox->read_index],
-				(u32) (mbox->virtbase_peer + MBOX_FIFO_DATA));
-
-			nbr_free--;
-			mbox->read_index =
-				(mbox->read_index + 1) % MBOX_BUF_SIZE;
-		}
-
-		/*
-		 * Check if we still want IRQ:s when there is free
-		 * space to send
-		 */
-		if (mbox->read_index != mbox->write_index) {
-			dev_dbg(&(mbox->pdev->dev),
-				"Still have messages to send, but FIFO full. "
-				"Request IRQ again!\n");
-			writel(MBOX_ENABLE_IRQ,
-			       mbox->virtbase_peer + MBOX_FIFO_THRES_FREE);
-		} else {
-			dev_dbg(&(mbox->pdev->dev),
-				"No more messages to send. "
-				"Do not request IRQ again!\n");
-			writel(MBOX_DISABLE_IRQ,
-			       mbox->virtbase_peer + MBOX_FIFO_THRES_FREE);
-		}
-
-		/*
-		 * Check if we can signal any blocked clients that it is OK to
-		 * start buffering again
-		 */
-		if (mbox->client_blocked &&
-		    (((mbox->write_index + 1) % MBOX_BUF_SIZE)
-		     != mbox->read_index)) {
-			dev_dbg(&(mbox->pdev->dev),
-				"Waking up blocked client\n");
-			complete(&mbox->buffer_available);
-			mbox->client_blocked = 0;
-		}
-	}
-
-	/* Check if we have any incoming messages */
-	nbr_occup = readl(mbox->virtbase_local + MBOX_FIFO_STATUS) & 0x7;
-	if (nbr_occup == 0)
-		goto exit;
-
-	if (mbox->cb == NULL) {
-		dev_dbg(&(mbox->pdev->dev), "No receive callback registered, "
-			"leaving %d incoming messages in fifo!\n", nbr_occup);
-		goto exit;
-	}
-
-	/* Read and acknowledge the message */
-	mbox_value = readl(mbox->virtbase_local + MBOX_FIFO_DATA);
-	writel(MBOX_LATCH, (mbox->virtbase_local + MBOX_FIFO_REMOVE));
-
-	/* Notify consumer of new mailbox message */
-	dev_dbg(&(mbox->pdev->dev), "Calling callback for message 0x%X!\n",
-		mbox_value);
-	mbox->cb(mbox_value, mbox->client_data);
-
-exit:
-	dev_dbg(&(mbox->pdev->dev), "Exit mbox IRQ. ri = %d, wi = %d\n",
-		mbox->read_index, mbox->write_index);
-	spin_unlock(&mbox->lock);
-
-	return IRQ_HANDLED;
-}
-
-/* Setup is executed once for each mbox pair */
-struct mbox *mbox_setup(u8 mbox_id, mbox_recv_cb_t *mbox_cb, void *priv)
-{
-	struct resource *resource;
-	int irq;
-	int res;
-	struct mbox *mbox;
-
-	mbox = get_mbox_with_id(mbox_id);
-	if (mbox == NULL) {
-		dev_err(&(mbox->pdev->dev), "Incorrect mailbox id: %d!\n",
-			mbox_id);
-		goto exit;
-	}
-
-	/*
-	 * Check if mailbox has been allocated to someone else,
-	 * otherwise allocate it
-	 */
-	if (mbox->allocated) {
-		dev_err(&(mbox->pdev->dev), "Mailbox number %d is busy!\n",
-			mbox_id);
-		mbox = NULL;
-		goto exit;
-	}
-	mbox->allocated = true;
-
-	dev_dbg(&(mbox->pdev->dev), "Initiating mailbox number %d: 0x%X...\n",
-		mbox_id, (u32)mbox);
-
-	mbox->client_data = priv;
-	mbox->cb = mbox_cb;
-
-	/* Get addr for peer mailbox and ioremap it */
-	resource = platform_get_resource_byname(mbox->pdev,
-						IORESOURCE_MEM,
-						"mbox_peer");
-	if (resource == NULL) {
-		dev_err(&(mbox->pdev->dev),
-			"Unable to retrieve mbox peer resource\n");
-		mbox = NULL;
-		goto exit;
-	}
-	dev_dbg(&(mbox->pdev->dev),
-		"Resource name: %s start: 0x%X, end: 0x%X\n",
-		resource->name, resource->start, resource->end);
-	mbox->virtbase_peer =
-		ioremap(resource->start, resource->end - resource->start);
-	if (!mbox->virtbase_peer) {
-		dev_err(&(mbox->pdev->dev), "Unable to ioremap peer mbox\n");
-		mbox = NULL;
-		goto exit;
-	}
-	dev_dbg(&(mbox->pdev->dev),
-		"ioremapped peer physical: (0x%X-0x%X) to virtual: 0x%X\n",
-		resource->start, resource->end, (u32) mbox->virtbase_peer);
-
-	/* Get addr for local mailbox and ioremap it */
-	resource = platform_get_resource_byname(mbox->pdev,
-						IORESOURCE_MEM,
-						"mbox_local");
-	if (resource == NULL) {
-		dev_err(&(mbox->pdev->dev),
-			"Unable to retrieve mbox local resource\n");
-		mbox = NULL;
-		goto exit;
-	}
-	dev_dbg(&(mbox->pdev->dev),
-		"Resource name: %s start: 0x%X, end: 0x%X\n",
-		resource->name, resource->start, resource->end);
-	mbox->virtbase_local =
-		ioremap(resource->start, resource->end - resource->start);
-	if (!mbox->virtbase_local) {
-		dev_err(&(mbox->pdev->dev), "Unable to ioremap local mbox\n");
-		mbox = NULL;
-		goto exit;
-	}
-	dev_dbg(&(mbox->pdev->dev),
-		"ioremapped local physical: (0x%X-0x%X) to virtual: 0x%X\n",
-		resource->start, resource->end, (u32) mbox->virtbase_peer);
-
-	init_completion(&mbox->buffer_available);
-	mbox->client_blocked = 0;
-
-	/* Get IRQ for mailbox and allocate it */
-	irq = platform_get_irq_byname(mbox->pdev, "mbox_irq");
-	if (irq < 0) {
-		dev_err(&(mbox->pdev->dev),
-			"Unable to retrieve mbox irq resource\n");
-		mbox = NULL;
-		goto exit;
-	}
-
-	dev_dbg(&(mbox->pdev->dev), "Allocating irq %d...\n", irq);
-	res = request_irq(irq, mbox_irq, 0, mbox->name, (void *) mbox);
-	if (res < 0) {
-		dev_err(&(mbox->pdev->dev),
-			"Unable to allocate mbox irq %d\n", irq);
-		mbox = NULL;
-		goto exit;
-	}
-
-	/* Set up mailbox to not launch IRQ on free space in mailbox */
-	writel(MBOX_DISABLE_IRQ, mbox->virtbase_peer + MBOX_FIFO_THRES_FREE);
-
-	/*
-	 * Set up mailbox to launch IRQ on new message if we have
-	 * a callback set. If not, do not raise IRQ, but keep message
-	 * in FIFO for manual retrieval
-	 */
-	if (mbox_cb != NULL)
-		writel(MBOX_ENABLE_IRQ,
-		       mbox->virtbase_local + MBOX_FIFO_THRES_OCCUP);
-	else
-		writel(MBOX_DISABLE_IRQ,
-		       mbox->virtbase_local + MBOX_FIFO_THRES_OCCUP);
-
-#if defined(CONFIG_DEBUG_FS)
-	res = device_create_file(&(mbox->pdev->dev), &dev_attr_fifo);
-	if (res != 0)
-		dev_warn(&(mbox->pdev->dev),
-			 "Unable to create mbox sysfs entry");
-
-	(void) debugfs_create_file("mbox", S_IFREG | S_IRUGO, NULL,
-				   NULL, &mbox_operations);
-#endif
-
-	dev_info(&(mbox->pdev->dev),
-		 "Mailbox driver with index %d initated!\n", mbox_id);
-
-exit:
-	return mbox;
-}
-EXPORT_SYMBOL(mbox_setup);
-
-
-int __init mbox_probe(struct platform_device *pdev)
-{
-	struct mbox local_mbox;
-	struct mbox *mbox;
-	int res = 0;
-	dev_dbg(&(pdev->dev), "Probing mailbox (pdev = 0x%X)...\n", (u32) pdev);
-
-	memset(&local_mbox, 0x0, sizeof(struct mbox));
-
-	/* Associate our mbox data with the platform device */
-	res = platform_device_add_data(pdev,
-				       (void *) &local_mbox,
-				       sizeof(struct mbox));
-	if (res != 0) {
-		dev_err(&(pdev->dev),
-			"Unable to allocate driver platform data!\n");
-		goto exit;
-	}
-
-	mbox = (struct mbox *) pdev->dev.platform_data;
-	mbox->pdev = pdev;
-	mbox->write_index = 0;
-	mbox->read_index = 0;
-
-	INIT_LIST_HEAD(&(mbox->list));
-	list_add_tail(&(mbox->list), &mboxs);
-
-	sprintf(mbox->name, "%s", MBOX_NAME);
-	spin_lock_init(&mbox->lock);
-
-	dev_info(&(pdev->dev), "Mailbox driver loaded\n");
-
-exit:
-	return res;
-}
-
-static struct platform_driver mbox_driver = {
-	.driver = {
-		.name = MBOX_NAME,
-		.owner = THIS_MODULE,
-	},
-};
-
-static int __init mbox_init(void)
-{
-	return platform_driver_probe(&mbox_driver, mbox_probe);
-}
-
-module_init(mbox_init);
-
-void __exit mbox_exit(void)
-{
-	platform_driver_unregister(&mbox_driver);
-}
-
-module_exit(mbox_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("MBOX driver");
diff --git a/arch/arm/mach-ux500/modem-irq-db5500.c b/arch/arm/mach-ux500/modem-irq-db5500.c
new file mode 100644
index 0000000..3187f88
--- /dev/null
+++ b/arch/arm/mach-ux500/modem-irq-db5500.c
@@ -0,0 +1,139 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ * Author: Stefan Nilsson <stefan.xk.nilsson@stericsson.com> for ST-Ericsson.
+ * Author: Martin Persson <martin.persson@stericsson.com> for ST-Ericsson.
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#define MODEM_INTCON_BASE_ADDR 0xBFFD3000
+#define MODEM_INTCON_SIZE 0xFFF
+
+#define DEST_IRQ41_OFFSET 0x2A4
+#define DEST_IRQ43_OFFSET 0x2AC
+#define DEST_IRQ45_OFFSET 0x2B4
+
+#define PRIO_IRQ41_OFFSET 0x6A4
+#define PRIO_IRQ43_OFFSET 0x6AC
+#define PRIO_IRQ45_OFFSET 0x6B4
+
+#define ALLOW_IRQ_OFFSET 0x104
+
+#define MODEM_INTCON_CPU_NBR 0x1
+#define MODEM_INTCON_PRIO_HIGH 0x0
+
+#define MODEM_INTCON_ALLOW_IRQ41 0x0200
+#define MODEM_INTCON_ALLOW_IRQ43 0x0800
+#define MODEM_INTCON_ALLOW_IRQ45 0x2000
+
+#define MODEM_IRQ_REG_OFFSET 0x4
+
+struct modem_irq {
+	void __iomem *modem_intcon_base;
+};
+
+
+static void setup_modem_intcon(void __iomem *modem_intcon_base)
+{
+	/* IC_DESTINATION_BASE_ARRAY - Which CPU to receive the IRQ */
+	writel(MODEM_INTCON_CPU_NBR, modem_intcon_base + DEST_IRQ41_OFFSET);
+	writel(MODEM_INTCON_CPU_NBR, modem_intcon_base + DEST_IRQ43_OFFSET);
+	writel(MODEM_INTCON_CPU_NBR, modem_intcon_base + DEST_IRQ45_OFFSET);
+
+	/* IC_PRIORITY_BASE_ARRAY - IRQ priority in modem IRQ controller */
+	writel(MODEM_INTCON_PRIO_HIGH, modem_intcon_base + PRIO_IRQ41_OFFSET);
+	writel(MODEM_INTCON_PRIO_HIGH, modem_intcon_base + PRIO_IRQ43_OFFSET);
+	writel(MODEM_INTCON_PRIO_HIGH, modem_intcon_base + PRIO_IRQ45_OFFSET);
+
+	/* IC_ALLOW_ARRAY - IRQ enable */
+	writel(MODEM_INTCON_ALLOW_IRQ41 |
+		   MODEM_INTCON_ALLOW_IRQ43 |
+		   MODEM_INTCON_ALLOW_IRQ45,
+		   modem_intcon_base + ALLOW_IRQ_OFFSET);
+}
+
+static irqreturn_t modem_cpu_irq_handler(int irq, void *data)
+{
+	int real_irq;
+	int virt_irq;
+	struct modem_irq *mi = (struct modem_irq *)data;
+
+	/* Read modem side IRQ number from modem IRQ controller */
+	real_irq = readl(mi->modem_intcon_base + MODEM_IRQ_REG_OFFSET) & 0xFF;
+	virt_irq = IRQ_MODEM_EVENTS_BASE + real_irq;
+
+	pr_debug("modem_irq: Worker read addr 0x%X and got value 0x%X "
+		 "which will be 0x%X (%d) which translates to "
+		 "virtual IRQ 0x%X (%d)!\n",
+		   (u32)mi->modem_intcon_base + MODEM_IRQ_REG_OFFSET,
+		   real_irq,
+		   real_irq & 0xFF,
+		   real_irq & 0xFF,
+		   virt_irq,
+		   virt_irq);
+
+	if (virt_irq != 0)
+		generic_handle_irq(virt_irq);
+
+	pr_debug("modem_irq: Done handling virtual IRQ %d!\n", virt_irq);
+
+	return IRQ_HANDLED;
+}
+
+static void create_virtual_irq(int irq, struct irq_chip *modem_irq_chip)
+{
+	set_irq_chip(irq, modem_irq_chip);
+	set_irq_handler(irq, handle_simple_irq);
+	set_irq_flags(irq, IRQF_VALID);
+
+	pr_debug("modem_irq: Created virtual IRQ %d\n", irq);
+}
+
+static int modem_irq_init(void)
+{
+	int err;
+	static struct irq_chip  modem_irq_chip;
+	struct modem_irq *mi;
+
+	pr_info("modem_irq: Set up IRQ handler for incoming modem IRQ %d\n",
+		   IRQ_DB5500_MODEM);
+
+	mi = kmalloc(sizeof(struct modem_irq), GFP_KERNEL);
+	if (!mi) {
+		pr_err("modem_irq: Could not allocate device\n");
+		return -ENOMEM;
+	}
+
+	mi->modem_intcon_base =
+		ioremap(MODEM_INTCON_BASE_ADDR, MODEM_INTCON_SIZE);
+	pr_debug("modem_irq: ioremapped modem_intcon_base from "
+		 "phy 0x%x to virt 0x%x\n", MODEM_INTCON_BASE_ADDR,
+		 (u32)mi->modem_intcon_base);
+
+	setup_modem_intcon(mi->modem_intcon_base);
+
+	modem_irq_chip = dummy_irq_chip;
+	modem_irq_chip.name = "modem_irq";
+
+	/* Create the virtual IRQ:s needed */
+	create_virtual_irq(MBOX_PAIR0_VIRT_IRQ, &modem_irq_chip);
+	create_virtual_irq(MBOX_PAIR1_VIRT_IRQ, &modem_irq_chip);
+	create_virtual_irq(MBOX_PAIR2_VIRT_IRQ, &modem_irq_chip);
+
+	err = request_threaded_irq(IRQ_DB5500_MODEM, NULL,
+				   modem_cpu_irq_handler, IRQF_ONESHOT,
+				   "modem_irq", mi);
+	if (err)
+		pr_err("modem_irq: Could not register IRQ %d\n",
+		       IRQ_DB5500_MODEM);
+
+	return 0;
+}
+
+arch_initcall(modem_irq_init);
diff --git a/arch/arm/mach-ux500/modem_irq.c b/arch/arm/mach-ux500/modem_irq.c
deleted file mode 100644
index 3187f88..0000000
--- a/arch/arm/mach-ux500/modem_irq.c
+++ /dev/null
@@ -1,139 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- * Author: Stefan Nilsson <stefan.xk.nilsson@stericsson.com> for ST-Ericsson.
- * Author: Martin Persson <martin.persson@stericsson.com> for ST-Ericsson.
- * License terms: GNU General Public License (GPL), version 2.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-
-#define MODEM_INTCON_BASE_ADDR 0xBFFD3000
-#define MODEM_INTCON_SIZE 0xFFF
-
-#define DEST_IRQ41_OFFSET 0x2A4
-#define DEST_IRQ43_OFFSET 0x2AC
-#define DEST_IRQ45_OFFSET 0x2B4
-
-#define PRIO_IRQ41_OFFSET 0x6A4
-#define PRIO_IRQ43_OFFSET 0x6AC
-#define PRIO_IRQ45_OFFSET 0x6B4
-
-#define ALLOW_IRQ_OFFSET 0x104
-
-#define MODEM_INTCON_CPU_NBR 0x1
-#define MODEM_INTCON_PRIO_HIGH 0x0
-
-#define MODEM_INTCON_ALLOW_IRQ41 0x0200
-#define MODEM_INTCON_ALLOW_IRQ43 0x0800
-#define MODEM_INTCON_ALLOW_IRQ45 0x2000
-
-#define MODEM_IRQ_REG_OFFSET 0x4
-
-struct modem_irq {
-	void __iomem *modem_intcon_base;
-};
-
-
-static void setup_modem_intcon(void __iomem *modem_intcon_base)
-{
-	/* IC_DESTINATION_BASE_ARRAY - Which CPU to receive the IRQ */
-	writel(MODEM_INTCON_CPU_NBR, modem_intcon_base + DEST_IRQ41_OFFSET);
-	writel(MODEM_INTCON_CPU_NBR, modem_intcon_base + DEST_IRQ43_OFFSET);
-	writel(MODEM_INTCON_CPU_NBR, modem_intcon_base + DEST_IRQ45_OFFSET);
-
-	/* IC_PRIORITY_BASE_ARRAY - IRQ priority in modem IRQ controller */
-	writel(MODEM_INTCON_PRIO_HIGH, modem_intcon_base + PRIO_IRQ41_OFFSET);
-	writel(MODEM_INTCON_PRIO_HIGH, modem_intcon_base + PRIO_IRQ43_OFFSET);
-	writel(MODEM_INTCON_PRIO_HIGH, modem_intcon_base + PRIO_IRQ45_OFFSET);
-
-	/* IC_ALLOW_ARRAY - IRQ enable */
-	writel(MODEM_INTCON_ALLOW_IRQ41 |
-		   MODEM_INTCON_ALLOW_IRQ43 |
-		   MODEM_INTCON_ALLOW_IRQ45,
-		   modem_intcon_base + ALLOW_IRQ_OFFSET);
-}
-
-static irqreturn_t modem_cpu_irq_handler(int irq, void *data)
-{
-	int real_irq;
-	int virt_irq;
-	struct modem_irq *mi = (struct modem_irq *)data;
-
-	/* Read modem side IRQ number from modem IRQ controller */
-	real_irq = readl(mi->modem_intcon_base + MODEM_IRQ_REG_OFFSET) & 0xFF;
-	virt_irq = IRQ_MODEM_EVENTS_BASE + real_irq;
-
-	pr_debug("modem_irq: Worker read addr 0x%X and got value 0x%X "
-		 "which will be 0x%X (%d) which translates to "
-		 "virtual IRQ 0x%X (%d)!\n",
-		   (u32)mi->modem_intcon_base + MODEM_IRQ_REG_OFFSET,
-		   real_irq,
-		   real_irq & 0xFF,
-		   real_irq & 0xFF,
-		   virt_irq,
-		   virt_irq);
-
-	if (virt_irq != 0)
-		generic_handle_irq(virt_irq);
-
-	pr_debug("modem_irq: Done handling virtual IRQ %d!\n", virt_irq);
-
-	return IRQ_HANDLED;
-}
-
-static void create_virtual_irq(int irq, struct irq_chip *modem_irq_chip)
-{
-	set_irq_chip(irq, modem_irq_chip);
-	set_irq_handler(irq, handle_simple_irq);
-	set_irq_flags(irq, IRQF_VALID);
-
-	pr_debug("modem_irq: Created virtual IRQ %d\n", irq);
-}
-
-static int modem_irq_init(void)
-{
-	int err;
-	static struct irq_chip  modem_irq_chip;
-	struct modem_irq *mi;
-
-	pr_info("modem_irq: Set up IRQ handler for incoming modem IRQ %d\n",
-		   IRQ_DB5500_MODEM);
-
-	mi = kmalloc(sizeof(struct modem_irq), GFP_KERNEL);
-	if (!mi) {
-		pr_err("modem_irq: Could not allocate device\n");
-		return -ENOMEM;
-	}
-
-	mi->modem_intcon_base =
-		ioremap(MODEM_INTCON_BASE_ADDR, MODEM_INTCON_SIZE);
-	pr_debug("modem_irq: ioremapped modem_intcon_base from "
-		 "phy 0x%x to virt 0x%x\n", MODEM_INTCON_BASE_ADDR,
-		 (u32)mi->modem_intcon_base);
-
-	setup_modem_intcon(mi->modem_intcon_base);
-
-	modem_irq_chip = dummy_irq_chip;
-	modem_irq_chip.name = "modem_irq";
-
-	/* Create the virtual IRQ:s needed */
-	create_virtual_irq(MBOX_PAIR0_VIRT_IRQ, &modem_irq_chip);
-	create_virtual_irq(MBOX_PAIR1_VIRT_IRQ, &modem_irq_chip);
-	create_virtual_irq(MBOX_PAIR2_VIRT_IRQ, &modem_irq_chip);
-
-	err = request_threaded_irq(IRQ_DB5500_MODEM, NULL,
-				   modem_cpu_irq_handler, IRQF_ONESHOT,
-				   "modem_irq", mi);
-	if (err)
-		pr_err("modem_irq: Could not register IRQ %d\n",
-		       IRQ_DB5500_MODEM);
-
-	return 0;
-}
-
-arch_initcall(modem_irq_init);
diff --git a/drivers/net/caif/caif_shm_u5500.c b/drivers/net/caif/caif_shm_u5500.c
index 1cd90da..13fa535 100644
--- a/drivers/net/caif/caif_shm_u5500.c
+++ b/drivers/net/caif/caif_shm_u5500.c
@@ -11,7 +11,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
-#include <mach/mbox.h>
+#include <mach/mbox-db5500.h>
 #include <net/caif/caif_shm.h>
 
 MODULE_LICENSE("GPL");
-- 
1.7.3.2
