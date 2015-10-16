From: lkp@intel.com (kbuild test robot)
Date: Fri, 16 Oct 2015 16:39:48 +0800
Subject: [PATCH v4 4/5] mailbox: Add generic mechanism for testing
 Mailbox Controllers
In-Reply-To: <1444980091-16728-5-git-send-email-lee.jones@linaro.org>
Message-ID: <201510161646.D4m1dK6L%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

[auto build test WARNING on v4.3-rc5 -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Lee-Jones/Mailbox-Provide-support-STi-based-platforms/20151016-152650
config: x86_64-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/mailbox/mailbox-test.c:225:36: sparse: incorrect type in argument 6 (different address spaces)
   drivers/mailbox/mailbox-test.c:225:36:    expected void const *buf
   drivers/mailbox/mailbox-test.c:225:36:    got void [noderef] <asn:2>*mmio
   drivers/mailbox/mailbox-test.c:226:17: sparse: incorrect type in argument 2 (different address spaces)
   drivers/mailbox/mailbox-test.c:226:17:    expected void const *from
   drivers/mailbox/mailbox-test.c:226:17:    got void [noderef] <asn:2>*mmio
   drivers/mailbox/mailbox-test.c:243:25: sparse: incorrect type in argument 1 (different address spaces)
   drivers/mailbox/mailbox-test.c:243:25:    expected void *to
   drivers/mailbox/mailbox-test.c:243:25:    got void [noderef] <asn:2>*mmio
   drivers/mailbox/mailbox-test.c:245:25: sparse: incorrect type in argument 1 (different address spaces)
   drivers/mailbox/mailbox-test.c:245:25:    expected void *to
   drivers/mailbox/mailbox-test.c:245:25:    got void [noderef] <asn:2>*mmio
   drivers/mailbox/mailbox-test.c: In function 'mbox_test_signal_write':
>> drivers/mailbox/mailbox-test.c:56:4: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t {aka long unsigned int}' [-Wformat=]
       "Signal length %d greater than max allowed %d\n",
       ^
   drivers/mailbox/mailbox-test.c: In function 'mbox_test_message_write':
   drivers/mailbox/mailbox-test.c:95:4: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t {aka long unsigned int}' [-Wformat=]
       "Message length %d greater than max allowed %d\n",
       ^

sparse warnings: (new ones prefixed by >>)

>> drivers/mailbox/mailbox-test.c:225:36: sparse: incorrect type in argument 6 (different address spaces)
   drivers/mailbox/mailbox-test.c:225:36:    expected void const *buf
   drivers/mailbox/mailbox-test.c:225:36:    got void [noderef] <asn:2>*mmio
>> drivers/mailbox/mailbox-test.c:226:17: sparse: incorrect type in argument 2 (different address spaces)
   drivers/mailbox/mailbox-test.c:226:17:    expected void const *from
   drivers/mailbox/mailbox-test.c:226:17:    got void [noderef] <asn:2>*mmio
>> drivers/mailbox/mailbox-test.c:243:25: sparse: incorrect type in argument 1 (different address spaces)
   drivers/mailbox/mailbox-test.c:243:25:    expected void *to
   drivers/mailbox/mailbox-test.c:243:25:    got void [noderef] <asn:2>*mmio
   drivers/mailbox/mailbox-test.c:245:25: sparse: incorrect type in argument 1 (different address spaces)
   drivers/mailbox/mailbox-test.c:245:25:    expected void *to
   drivers/mailbox/mailbox-test.c:245:25:    got void [noderef] <asn:2>*mmio
   drivers/mailbox/mailbox-test.c: In function 'mbox_test_signal_write':
   drivers/mailbox/mailbox-test.c:56:4: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t {aka long unsigned int}' [-Wformat=]
       "Signal length %d greater than max allowed %d\n",
       ^
   drivers/mailbox/mailbox-test.c: In function 'mbox_test_message_write':
   drivers/mailbox/mailbox-test.c:95:4: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t {aka long unsigned int}' [-Wformat=]
       "Message length %d greater than max allowed %d\n",
       ^

vim +56 drivers/mailbox/mailbox-test.c

    50			dev_err(tdev->dev, "Channel cannot do Tx\n");
    51			return -EINVAL;
    52		}
    53	
    54		if (count > MBOX_MAX_SIG_LEN) {
    55			dev_err(tdev->dev,
  > 56				"Signal length %d greater than max allowed %d\n",
    57				count, MBOX_MAX_SIG_LEN);
    58			return -EINVAL;
    59		}
    60	
    61		tdev->signal = kzalloc(MBOX_MAX_SIG_LEN, GFP_KERNEL);
    62		if (!tdev->signal)
    63			return -ENOMEM;
    64	
    65		ret = copy_from_user(tdev->signal, userbuf, count);
    66		if (ret) {
    67			kfree(tdev->signal);
    68			return -EFAULT;
    69		}
    70	
    71		return ret < 0 ? ret : count;
    72	}
    73	
    74	static const struct file_operations mbox_test_signal_ops = {
    75		.write	= mbox_test_signal_write,
    76		.open	= simple_open,
    77		.llseek	= generic_file_llseek,
    78	};
    79	
    80	static ssize_t mbox_test_message_write(struct file *filp,
    81					       const char __user *userbuf,
    82					       size_t count, loff_t *ppos)
    83	{
    84		struct mbox_test_device *tdev = filp->private_data;
    85		void *data;
    86		int ret;
    87	
    88		if (!tdev->tx_channel) {
    89			dev_err(tdev->dev, "Channel cannot do Tx\n");
    90			return -EINVAL;
    91		}
    92	
    93		if (count > MBOX_MAX_MSG_LEN) {
    94			dev_err(tdev->dev,
    95				"Message length %d greater than max allowed %d\n",
    96				count, MBOX_MAX_MSG_LEN);
    97			return -EINVAL;
    98		}
    99	
   100		tdev->message = kzalloc(MBOX_MAX_MSG_LEN, GFP_KERNEL);
   101		if (!tdev->message)
   102			return -ENOMEM;
   103	
   104		ret = copy_from_user(tdev->message, userbuf, count);
   105		if (ret) {
   106			ret = -EFAULT;
   107			goto out;
   108		}
   109	
   110		/*
   111		 * A separate signal is only of use if there is
   112		 * MMIO to subsequently pass the message through
   113		 */
   114		if (tdev->mmio && tdev->signal) {
   115			print_hex_dump(KERN_INFO, "Client: Sending: Signal: ", DUMP_PREFIX_ADDRESS,
   116				       MBOX_BYTES_PER_LINE, 1, tdev->signal, MBOX_MAX_SIG_LEN, true);
   117	
   118			data = tdev->signal;
   119		} else
   120			data = tdev->message;
   121	
   122		print_hex_dump(KERN_INFO, "Client: Sending: Message: ", DUMP_PREFIX_ADDRESS,
   123			       MBOX_BYTES_PER_LINE, 1, tdev->message, MBOX_MAX_MSG_LEN, true);
   124	
   125		ret = mbox_send_message(tdev->tx_channel, data);
   126		if (ret < 0)
   127			dev_err(tdev->dev, "Failed to send message via mailbox\n");
   128	
   129	out:
   130		kfree(tdev->signal);
   131		kfree(tdev->message);
   132	
   133		return ret < 0 ? ret : count;
   134	}
   135	
   136	static ssize_t mbox_test_message_read(struct file *filp, char __user *userbuf,
   137					      size_t count, loff_t *ppos)
   138	{
   139		struct mbox_test_device *tdev = filp->private_data;
   140		unsigned long flags;
   141		char *touser, *ptr;
   142		int l = 0;
   143		int ret;
   144	
   145		touser = kzalloc(MBOX_HEXDUMP_MAX_LEN, GFP_KERNEL);
   146		if (!touser)
   147			return -ENOMEM;
   148	
   149		if (!tdev->rx_channel) {
   150			ret = snprintf(touser, 20, "<NO RX CAPABILITY>\n");
   151			ret = simple_read_from_buffer(userbuf, count, ppos,
   152						      touser, ret);
   153			goto out;
   154		}
   155	
   156		if (tdev->rx_buffer[0] == '\0') {
   157			ret = snprintf(touser, 9, "<EMPTY>\n");
   158			ret = simple_read_from_buffer(userbuf, count, ppos,
   159						      touser, ret);
   160			goto out;
   161		}
   162	
   163		spin_lock_irqsave(&tdev->lock, flags);
   164	
   165		ptr = tdev->rx_buffer;
   166		while (l < MBOX_HEXDUMP_MAX_LEN) {
   167			hex_dump_to_buffer(ptr,
   168					   MBOX_BYTES_PER_LINE,
   169					   MBOX_BYTES_PER_LINE, 1, touser + l,
   170					   MBOX_HEXDUMP_LINE_LEN, true);
   171	
   172			ptr += MBOX_BYTES_PER_LINE;
   173			l += MBOX_HEXDUMP_LINE_LEN;
   174			*(touser + (l - 1)) = '\n';
   175		}
   176		*(touser + l) = '\0';
   177	
   178		memset(tdev->rx_buffer, 0, MBOX_MAX_MSG_LEN);
   179	
   180		spin_unlock_irqrestore(&tdev->lock, flags);
   181	
   182		ret = simple_read_from_buffer(userbuf, count, ppos, touser, MBOX_HEXDUMP_MAX_LEN);
   183	out:
   184		kfree(touser);
   185		return ret;
   186	}
   187	
   188	static const struct file_operations mbox_test_message_ops = {
   189		.write	= mbox_test_message_write,
   190		.read	= mbox_test_message_read,
   191		.open	= simple_open,
   192		.llseek	= generic_file_llseek,
   193	};
   194	
   195	static int mbox_test_add_debugfs(struct platform_device *pdev,
   196					 struct mbox_test_device *tdev)
   197	{
   198		if (!debugfs_initialized())
   199			return 0;
   200	
   201		root_debugfs_dir = debugfs_create_dir("mailbox", NULL);
   202		if (!root_debugfs_dir) {
   203			dev_err(&pdev->dev, "Failed to create Mailbox debugfs\n");
   204			return -EINVAL;
   205		}
   206	
   207		debugfs_create_file("message", 0600, root_debugfs_dir,
   208				    tdev, &mbox_test_message_ops);
   209	
   210		debugfs_create_file("signal", 0200, root_debugfs_dir,
   211				    tdev, &mbox_test_signal_ops);
   212	
   213		return 0;
   214	}
   215	
   216	static void mbox_test_receive_message(struct mbox_client *client, void *message)
   217	{
   218		struct mbox_test_device *tdev = dev_get_drvdata(client->dev);
   219		unsigned long flags;
   220	
   221		spin_lock_irqsave(&tdev->lock, flags);
   222		if (tdev->mmio) {
   223			print_hex_dump(KERN_INFO, "Client: Received [MMIO]: ",
   224				       DUMP_PREFIX_ADDRESS, MBOX_BYTES_PER_LINE, 1,
 > 225				       tdev->mmio, MBOX_MAX_MSG_LEN, true);
 > 226			memcpy(tdev->rx_buffer, tdev->mmio, MBOX_MAX_MSG_LEN);
   227	
   228		} else if (message) {
   229			print_hex_dump(KERN_INFO, "Client: Received [API]: ",
   230				       DUMP_PREFIX_ADDRESS, MBOX_BYTES_PER_LINE, 1,
   231				       message, MBOX_MAX_MSG_LEN, true);
   232			memcpy(tdev->rx_buffer, message, MBOX_MAX_MSG_LEN);
   233		}
   234		spin_unlock_irqrestore(&tdev->lock, flags);
   235	}
   236	
   237	static void mbox_test_prepare_message(struct mbox_client *client, void *message)
   238	{
   239		struct mbox_test_device *tdev = dev_get_drvdata(client->dev);
   240	
   241		if (tdev->mmio) {
   242			if (tdev->signal)
 > 243				memcpy(tdev->mmio, tdev->message, MBOX_MAX_MSG_LEN);
   244			else
   245				memcpy(tdev->mmio, message, MBOX_MAX_MSG_LEN);
   246		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 50056 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151016/cde8a178/attachment-0001.obj>
