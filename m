From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 20 Aug 2015 21:44:38 +0800
Subject: [PATCH v2 2/3] mailbox: Hi6220: add mailbox driver
In-Reply-To: <55D568E2.9060505@hisilicon.com>
References: <1440039239-8772-1-git-send-email-leo.yan@linaro.org>
 <1440039239-8772-3-git-send-email-leo.yan@linaro.org>
 <55D568E2.9060505@hisilicon.com>
Message-ID: <20150820134438.GA18629@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yiping,

Thanks for review, please see below comments.

On Thu, Aug 20, 2015 at 01:42:58PM +0800, YiPing Xu wrote:
> On 2015/8/20 10:53, Leo Yan wrote:
> >Add driver for Hi6220 mailbox, the mailbox communicates with MCU; for
> >sending data, it can support two methods for low level implementation:
> >one is to use interrupt as acknowledge, another is automatic mode which
> >without any acknowledge. These two methods have been supported in the
> >driver. For receiving data, it will depend on the interrupt to notify
> >the channel has incoming message; enhance rx channel's message queue,
> >which is based on the code in drivers/mailbox/omap-mailbox.c.
> >
> >Now mailbox driver is used to send message to MCU to control dynamic
> >voltage and frequency scaling for CPU, GPU and DDR.
> >
> >Signed-off-by: Leo Yan <leo.yan@linaro.org>

[...]

> >+static int hi6220_mbox_send_data(struct mbox_chan *chan, void *msg)
> >+{
> >+	struct hi6220_mbox_chan *mchan = chan->con_priv;
> >+	struct hi6220_mbox *mbox = mchan->parent;
> >+	int irq = mchan->remote_irq;
> >+	u32 *buf = msg;
> >+	unsigned long flags;
> >+	int i;
> >+
> >+	hi6220_mbox_set_status(mchan, HI6220_MBOX_STATUS_TX);
> 
> 	hi6220_mbox_set_status is called in send_data context, and it is
> also called in hi6220_mbox_rx_interrupt and
> hi6220_mbox_tx_interrupt.
> 
> 	no race condition here?

Have thought this question yet when writing code; it will _NOT_
introduce race condition according to below implementation details:

- Every channel have its own slot, so there have no race condition
  between channels;
- The channel is unidirectional; so it will be only for tx or rx at
  the same time;
- The channel operation is sequential, so it have the sequence as:
  For tx: startup -> send_data -> tx_irq (for ack);
  For rx: startup -> rx_irq -> recv_data;

Thanks,
Leo Yan
