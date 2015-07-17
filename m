From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 17 Jul 2015 13:04:06 +0100
Subject: [PATCH 5/6] mailbox: Add generic mechanism for testing Mailbox
 Controllers
In-Reply-To: <1437134647-28298-1-git-send-email-lee.jones@linaro.org>
References: <1437134647-28298-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1437134647-28298-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This particular Client implementation uses shared memory in order
to pass messages between Mailbox users; however, it can be easily
hacked to support any type of Controller.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mailbox/Kconfig        |   7 ++
 drivers/mailbox/Makefile       |   2 +
 drivers/mailbox/mailbox-test.c | 210 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)
 create mode 100644 drivers/mailbox/mailbox-test.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 2cc4c39..7720bde 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -77,4 +77,11 @@ config STI_MBOX
 	  Mailbox implementation for STMicroelectonics family chips with
 	  hardware for interprocessor communication.
 
+config MAILBOX_TEST
+	tristate "Mailbox Test Client"
+	depends on OF
+	help
+	  Test client to help with testing new Controller driver
+	  implementations.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 7cb4766..92435ef 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -2,6 +2,8 @@
 
 obj-$(CONFIG_MAILBOX)		+= mailbox.o
 
+obj-$(CONFIG_MAILBOX_TEST)	+= mailbox-test.o
+
 obj-$(CONFIG_ARM_MHU)	+= arm_mhu.o
 
 obj-$(CONFIG_PL320_MBOX)	+= pl320-ipc.o
diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
new file mode 100644
index 0000000..10bfe3a
--- /dev/null
+++ b/drivers/mailbox/mailbox-test.c
@@ -0,0 +1,210 @@
+/*
+ * Copyright (C) 2015 ST Microelectronics
+ *
+ * Author: Lee Jones <lee.jones@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#define MBOX_MAX_MSG_LEN 128
+
+static struct dentry *root_debugfs_dir;
+
+struct mbox_test_device {
+	struct device		*dev;
+	struct mbox_chan	*tx_channel;
+	struct mbox_chan	*rx_channel;
+	void __iomem		*mmio;
+
+};
+
+static ssize_t mbox_test_write(struct file *filp,
+			       const char __user *userbuf,
+			       size_t count, loff_t *ppos)
+{
+	struct mbox_test_device *tdev = filp->private_data;
+	char *message;
+	int ret;
+
+	if (count > MBOX_MAX_MSG_LEN) {
+		dev_err(tdev->dev,
+			"Message length %d greater than max allowed %d\n",
+			count, MBOX_MAX_MSG_LEN);
+		return -EINVAL;
+	}
+
+	message = kzalloc(count, GFP_KERNEL);
+	if (!message)
+		return -ENOMEM;
+
+	ret = copy_from_user(message, userbuf, count);
+	if (ret)
+		return -EFAULT;
+
+	print_hex_dump(KERN_ERR, "Client: Sending: ", DUMP_PREFIX_ADDRESS,
+		       16, 1, message, 16, true);
+
+	ret = mbox_send_message(tdev->tx_channel, message);
+	if (ret < 0)
+		dev_err(tdev->dev, "Failed to send message via mailbox\n");
+
+	kfree(message);
+
+	return ret < 0 ? ret : count;
+}
+
+static const struct file_operations mbox_test_ops = {
+	.write	= mbox_test_write,
+	.open	= simple_open,
+	.llseek	= generic_file_llseek,
+};
+
+static int mbox_test_add_debugfs(struct platform_device *pdev,
+				 struct mbox_test_device *tdev)
+{
+	if (!debugfs_initialized())
+		return 0;
+
+	root_debugfs_dir = debugfs_create_dir("mailbox", NULL);
+	if (!root_debugfs_dir) {
+		dev_err(&pdev->dev, "Failed to create Mailbox debugfs\n");
+		return -EINVAL;
+	}
+
+	debugfs_create_file("send-message", 0200, root_debugfs_dir,
+			    tdev, &mbox_test_ops);
+
+	return 0;
+}
+
+static void mbox_test_receive_message(struct mbox_client *client, void *message)
+{
+	struct mbox_test_device *tdev = dev_get_drvdata(client->dev);
+
+	if (!tdev->mmio) {
+		dev_info(tdev->dev, "Client: Recived something [read mmio]\n");
+		return;
+	}
+
+	print_hex_dump(KERN_ERR, "Client: from co-proc: ", DUMP_PREFIX_ADDRESS,
+		       16, 1, tdev->mmio, MBOX_MAX_MSG_LEN, true);
+}
+
+static void mbox_test_prepare_message(struct mbox_client *client, void *message)
+{
+	struct mbox_test_device *tdev = dev_get_drvdata(client->dev);
+
+	if (tdev->mmio)
+		memcpy(tdev->mmio, message, MBOX_MAX_MSG_LEN);
+}
+
+static void mbox_test_message_sent(struct mbox_client *client,
+				   void *message, int r)
+{
+	if (r)
+		dev_warn(client->dev,
+			 "Client: Message could not be sent: %d\n", r);
+	else
+		dev_info(client->dev,
+			 "Client: Message sent\n");
+}
+
+static struct mbox_chan *
+mbox_test_request_channel(struct platform_device *pdev, const char *name)
+{
+	struct mbox_client *client;
+
+	client = devm_kzalloc(&pdev->dev, sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return ERR_PTR(-ENOMEM);
+
+	client->dev		= &pdev->dev;
+	client->rx_callback	= mbox_test_receive_message;
+	client->tx_prepare	= mbox_test_prepare_message;
+	client->tx_done		= mbox_test_message_sent;
+	client->tx_block	= true;
+	client->knows_txdone	= false;
+	client->tx_tout		= 500;
+
+	return mbox_request_channel_byname(client, name);
+}
+
+static int mbox_test_probe(struct platform_device *pdev)
+{
+	struct mbox_test_device *tdev;
+	struct resource *res;
+	int ret;
+
+	tdev = devm_kzalloc(&pdev->dev, sizeof(*tdev), GFP_KERNEL);
+	if (!tdev)
+		return -ENOMEM;
+
+	/* It's okay for MMIO to be NULL */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	tdev->mmio = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(tdev->mmio))
+		tdev->mmio = NULL;
+
+	tdev->tx_channel = mbox_test_request_channel(pdev, "tx");
+	if (IS_ERR(tdev->tx_channel))
+		return PTR_ERR(tdev->tx_channel);
+
+	tdev->rx_channel = mbox_test_request_channel(pdev, "rx");
+	if (IS_ERR(tdev->rx_channel))
+		return PTR_ERR(tdev->rx_channel);
+
+	tdev->dev = &pdev->dev;
+	platform_set_drvdata(pdev, tdev);
+
+	ret = mbox_test_add_debugfs(pdev, tdev);
+	if (ret)
+		return ret;
+
+	dev_info(&pdev->dev, "Successfully registered\n");
+
+	return 0;
+}
+
+static int mbox_test_remove(struct platform_device *pdev)
+{
+	struct mbox_test_device *tdev = platform_get_drvdata(pdev);
+
+	debugfs_remove_recursive(root_debugfs_dir);
+
+	mbox_free_channel(tdev->tx_channel);
+	mbox_free_channel(tdev->rx_channel);
+
+	return 0;
+}
+
+static const struct of_device_id mbox_test_match[] = {
+	{ .compatible = "mailbox_test" },
+	{},
+};
+
+static struct platform_driver mbox_test_driver = {
+	.driver = {
+		.name = "mailbox_sti_test",
+		.of_match_table = mbox_test_match,
+	},
+	.probe  = mbox_test_probe,
+	.remove = mbox_test_remove,
+};
+module_platform_driver(mbox_test_driver);
+
+MODULE_DESCRIPTION("Generic Mailbox Testing Facility");
+MODULE_AUTHOR("Lee Jones <lee.jones@linaro.org");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
