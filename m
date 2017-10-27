From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 27 Oct 2017 11:46:00 +0100
Subject: [PATCH v2 2/3] mailbox: Add support for Hi3660 mailbox
In-Reply-To: <1509084904-2505-3-git-send-email-zhongkaihua@huawei.com>
References: <1509084904-2505-1-git-send-email-zhongkaihua@huawei.com>
 <1509084904-2505-3-git-send-email-zhongkaihua@huawei.com>
Message-ID: <20171027104559.em5n5ogro46ethmq@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 27, 2017 at 02:15:03PM +0800, Kaihua Zhong wrote:
> Hi3660 mailbox controller is used to send message within multiple
> processors, MCU, HIFI, etc.  It supports 32 mailbox channels and every
> channel can only be used for single transferring direction.  Once the
> channel is enabled, it needs to specify the destination interrupt and
> acknowledge interrupt, these two interrupt vectors are used to create
> the connection between the mailbox and interrupt controllers.
> 
> The application processor (or from point of view of kernel) is not the
> only one master which can launch the data transferring, other
> processors or MCU/DSP also can kick off the data transferring.  So this
> driver implements a locking mechanism to support exclusive accessing.

... and that locking mechanism is what precisely?

Where is the protocol defined?

> +static int hi3660_mbox_check_state(struct mbox_chan *chan)
> +{
> +	unsigned long ch = (unsigned long)chan->con_priv;
> +	struct hi3660_mbox *mbox = to_hi3660_mbox(chan);
> +	struct hi3660_mbox_dev *mdev = &mbox->mdev[ch];
> +	void __iomem *base = MBOX_BASE(mbox, ch);
> +	unsigned long val;
> +	unsigned int state, ret;
> +
> +	/* Mailbox is idle so directly bail out */
> +	state = readl_relaxed(base + MBOX_MODE_REG);
> +	if (state & MBOX_STATE_IDLE)
> +		return 0;
> +
> +	/* Wait for acknowledge from remote */
> +	ret = readx_poll_timeout_atomic(readl_relaxed, base + MBOX_MODE_REG,
> +			val, (val & MBOX_STATE_ACK), 1000, 300000);
> +	if (ret) {
> +		dev_err(mbox->dev, "%s: timeout for receiving ack\n", __func__);
> +		return ret;
> +	}
> +
> +	/* Ensure channel is released */
> +	writel_relaxed(0xffffffff, base + MBOX_IMASK_REG);
> +	writel_relaxed(BIT(mdev->ack_irq), base + MBOX_SRC_REG);
> +	__asm__ volatile ("sev");
> +	return 0;
> +}

Drivers really shouldn't be using SEV directly (even if via the sev() macro)...

This SEV isn't ordered w.r.t. anything, and it's unclear what ordering you
need, so this simply does not work.

> +static int hi3660_mbox_acquire_channel(struct mbox_chan *chan)
> +{
> +	unsigned long ch = (unsigned long)chan->con_priv;
> +	struct hi3660_mbox *mbox = to_hi3660_mbox(chan);
> +	struct hi3660_mbox_dev *mdev = &mbox->mdev[ch];
> +	void __iomem *base = MBOX_BASE(mbox, ch);
> +	unsigned int val = 0, retry = 10;
> +
> +	/*
> +	 * Hardware locking for exclusive accessing within CPUs
> +	 * without exclusive monitor mechanism.
> +	 */
> +	do {
> +		val = readl_relaxed(base + MBOX_MODE_REG);
> +		if (!(val & MBOX_STATE_IDLE)) {
> +			__asm__ volatile ("wfe");

... and likewise for WFE / wfe().

> +			continue;
> +		}
> +
> +		/* Check if channel has be acquired */
> +		writel_relaxed(BIT(mdev->ack_irq), base + MBOX_SRC_REG);
> +		val = readl_relaxed(base + MBOX_SRC_REG) & BIT(mdev->ack_irq);
> +		if (val)
> +			break;
> +
> +	} while (retry--);
> +
> +	return (val) ? 0 : -ETIMEDOUT;
> +}

Please elaborate on how this synchronisation mechanism is expected to work, and
why it is necessary in the first place.

Thanks,
Mark.
