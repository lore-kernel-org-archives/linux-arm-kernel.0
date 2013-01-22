From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 22 Jan 2013 20:05:42 +0800
Subject: [stericsson:dbx500-prcmu-mailbox 1/10]
 drivers/mailbox/mailbox.c:41:39: error: 'CONFIG_OMAP_MBOX_KFIFO_SIZE'
 undeclared here (not in a function)
Message-ID: <50fe8096.5y0j9WIlGU1oKxxK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git dbx500-prcmu-mailbox
head:   5a9f6660cdca2b31e9e51d096a815ce2c12c29d7
commit: 9f5fa59c7f06a3ff7c3ede2816bbfaa96573be62 [1/10] mailbox: OMAP: introduce mailbox framework
config: make ARCH=x86_64 allmodconfig

Note: the stericsson/dbx500-prcmu-mailbox HEAD 5a9f666 builds fine.
      It only hurts bisectibility.

All error/warnings:

>> drivers/mailbox/mailbox.c:41:39: error: 'CONFIG_OMAP_MBOX_KFIFO_SIZE' undeclared here (not in a function)
   drivers/mailbox/mailbox.c: In function 'mbox_rx_work':
>> drivers/mailbox/mailbox.c:155:5: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

vim +/CONFIG_OMAP_MBOX_KFIFO_SIZE +41 drivers/mailbox/mailbox.c

    35	
    36	static struct omap_mbox **mboxes;
    37	
    38	static int mbox_configured;
    39	static DEFINE_MUTEX(mbox_configured_lock);
    40	
  > 41	static unsigned int mbox_kfifo_size = CONFIG_OMAP_MBOX_KFIFO_SIZE;
    42	module_param(mbox_kfifo_size, uint, S_IRUGO);
    43	MODULE_PARM_DESC(mbox_kfifo_size, "Size of omap's mailbox kfifo (bytes)");
    44	
    45	/* Mailbox FIFO handle functions */
    46	static inline mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)
    47	{
    48		return mbox->ops->fifo_read(mbox);
    49	}
    50	static inline void mbox_fifo_write(struct omap_mbox *mbox, mbox_msg_t msg)
    51	{
    52		mbox->ops->fifo_write(mbox, msg);
    53	}
    54	static inline int mbox_fifo_empty(struct omap_mbox *mbox)
    55	{
    56		return mbox->ops->fifo_empty(mbox);
    57	}
    58	static inline int mbox_fifo_full(struct omap_mbox *mbox)
    59	{
    60		return mbox->ops->fifo_full(mbox);
    61	}
    62	
    63	/* Mailbox IRQ handle functions */
    64	static inline void ack_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
    65	{
    66		if (mbox->ops->ack_irq)
    67			mbox->ops->ack_irq(mbox, irq);
    68	}
    69	static inline int is_mbox_irq(struct omap_mbox *mbox, omap_mbox_irq_t irq)
    70	{
    71		return mbox->ops->is_irq(mbox, irq);
    72	}
    73	
    74	/*
    75	 * message sender
    76	 */
    77	static int __mbox_poll_for_space(struct omap_mbox *mbox)
    78	{
    79		int ret = 0, i = 1000;
    80	
    81		while (mbox_fifo_full(mbox)) {
    82			if (mbox->ops->type == OMAP_MBOX_TYPE2)
    83				return -1;
    84			if (--i == 0)
    85				return -1;
    86			udelay(1);
    87		}
    88		return ret;
    89	}
    90	
    91	int omap_mbox_msg_send(struct omap_mbox *mbox, mbox_msg_t msg)
    92	{
    93		struct omap_mbox_queue *mq = mbox->txq;
    94		int ret = 0, len;
    95	
    96		spin_lock_bh(&mq->lock);
    97	
    98		if (kfifo_avail(&mq->fifo) < sizeof(msg)) {
    99			ret = -ENOMEM;
   100			goto out;
   101		}
   102	
   103		if (kfifo_is_empty(&mq->fifo) && !__mbox_poll_for_space(mbox)) {
   104			mbox_fifo_write(mbox, msg);
   105			goto out;
   106		}
   107	
   108		len = kfifo_in(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
   109		WARN_ON(len != sizeof(msg));
   110	
   111		tasklet_schedule(&mbox->txq->tasklet);
   112	
   113	out:
   114		spin_unlock_bh(&mq->lock);
   115		return ret;
   116	}
   117	EXPORT_SYMBOL(omap_mbox_msg_send);
   118	
   119	static void mbox_tx_tasklet(unsigned long tx_data)
   120	{
   121		struct omap_mbox *mbox = (struct omap_mbox *)tx_data;
   122		struct omap_mbox_queue *mq = mbox->txq;
   123		mbox_msg_t msg;
   124		int ret;
   125	
   126		while (kfifo_len(&mq->fifo)) {
   127			if (__mbox_poll_for_space(mbox)) {
   128				omap_mbox_enable_irq(mbox, IRQ_TX);
   129				break;
   130			}
   131	
   132			ret = kfifo_out(&mq->fifo, (unsigned char *)&msg,
   133					sizeof(msg));
   134			WARN_ON(ret != sizeof(msg));
   135	
   136			mbox_fifo_write(mbox, msg);
   137		}
   138	}
   139	
   140	/*
   141	 * Message receiver(workqueue)
   142	 */
   143	static void mbox_rx_work(struct work_struct *work)
   144	{
   145		struct omap_mbox_queue *mq =
   146			container_of(work, struct omap_mbox_queue, work);
   147		mbox_msg_t msg;
   148		int len;
   149	
   150		while (kfifo_len(&mq->fifo) >= sizeof(msg)) {
   151			len = kfifo_out(&mq->fifo, (unsigned char *)&msg, sizeof(msg));
   152			WARN_ON(len != sizeof(msg));
   153	
   154			blocking_notifier_call_chain(&mq->mbox->notifier, len,
   155					(void *)msg);
   156			spin_lock_irq(&mq->lock);
   157			if (mq->full) {
   158				mq->full = false;

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
