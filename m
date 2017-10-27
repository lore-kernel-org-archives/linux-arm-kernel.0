From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 27 Oct 2017 11:40:59 +0100
Subject: [PATCH v2 2/3] mailbox: Add support for Hi3660 mailbox
In-Reply-To: <1509084904-2505-3-git-send-email-zhongkaihua@huawei.com>
References: <1509084904-2505-1-git-send-email-zhongkaihua@huawei.com>
 <1509084904-2505-3-git-send-email-zhongkaihua@huawei.com>
Message-ID: <90d25374-cc83-7f75-eb38-766f0cdb9c53@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kaihua,

On 27/10/17 07:15, Kaihua Zhong wrote:
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
> 
> The data transferring supports two modes, one is named as "automatic
> acknowledge" mode so after send message the kernel doesn't need to wait
> for acknowledge from remote and directly return; there have another mode
> is to rely on handling interrupt for acknowledge.
> 
> This commit is for initial version driver, which only supports
> "automatic acknowledge" mode to support CPU clock, which is the only
> one consumer to use mailbox and has been verified.  Later may enhance
> this driver for interrupt mode (e.g. for supporting HIFI).
> 
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Guodong Xu <guodong.xu@linaro.org>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Niranjan Yadla <nyadla@cadence.com>
> Cc: Raj Pawate <pawateb@cadence.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
> Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>
> Signed-off-by: Kevin Wang <kevin.wangtao@hisilicon.com>
> ---
>   drivers/mailbox/Kconfig          |   8 +
>   drivers/mailbox/Makefile         |   2 +
>   drivers/mailbox/hi3660-mailbox.c | 331 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 341 insertions(+)
>   create mode 100644 drivers/mailbox/hi3660-mailbox.c
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index c5731e5..4b5d6e9 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -108,6 +108,14 @@ config TI_MESSAGE_MANAGER
>   	  multiple processors within the SoC. Select this driver if your
>   	  platform has support for the hardware block.
>   
> +config HI3660_MBOX
> +	tristate "Hi3660 Mailbox"
> +	depends on ARCH_HISI && OF
> +	help
> +	  An implementation of the hi3660 mailbox. It is used to send message
> +	  between application processors and other processors/MCU/DSP. Select
> +	  Y here if you want to use Hi3660 mailbox controller.
> +
>   config HI6220_MBOX
>   	tristate "Hi6220 Mailbox"
>   	depends on ARCH_HISI
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index d54e412..7d1bd51 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -26,6 +26,8 @@ obj-$(CONFIG_TI_MESSAGE_MANAGER) += ti-msgmgr.o
>   
>   obj-$(CONFIG_XGENE_SLIMPRO_MBOX) += mailbox-xgene-slimpro.o
>   
> +obj-$(CONFIG_HI3660_MBOX)	+= hi3660-mailbox.o
> +
>   obj-$(CONFIG_HI6220_MBOX)	+= hi6220-mailbox.o
>   
>   obj-$(CONFIG_BCM_PDC_MBOX)	+= bcm-pdc-mailbox.o
> diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
> new file mode 100644
> index 0000000..67df8f8
> --- /dev/null
> +++ b/drivers/mailbox/hi3660-mailbox.c
> @@ -0,0 +1,331 @@
> +/*
> + * Hisilicon's Hi3660 mailbox controller driver
> + *
> + * Copyright (c) 2017 Hisilicon Limited.
> + * Copyright (c) 2017 Linaro Limited.
> + *
> + * Author: Leo Yan <leo.yan@linaro.org>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "mailbox.h"
> +
> +#define MBOX_CHAN_MAX			32
> +
> +#define MBOX_RX				(0x0)
> +#define MBOX_TX				(0x1)
> +
> +#define MBOX_BASE(mbox, ch)		((mbox)->base + ((ch) * 0x40))
> +#define MBOX_SRC_REG			(0x00)
> +#define MBOX_DST_REG			(0x04)
> +#define MBOX_DCLR_REG			(0x08)
> +#define MBOX_DSTAT_REG			(0x0c)
> +#define MBOX_MODE_REG			(0x10)
> +#define MBOX_IMASK_REG			(0x14)
> +#define MBOX_ICLR_REG			(0x18)
> +#define MBOX_SEND_REG			(0x1c)
> +#define MBOX_DATA_REG			(0x20)
> +
> +#define MBOX_IPC_LOCK_REG		(0xa00)
> +#define MBOX_IPC_UNLOCK			(0x1acce551)
> +
> +#define MBOX_AUTOMATIC_ACK		(1)
> +
> +#define MBOX_STATE_IDLE			BIT(4)
> +#define MBOX_STATE_ACK			BIT(7)
> +
> +#define MBOX_MSG_LEN			8
> +
> +/**
> + * Hi3660 mailbox channel device data
> + *
> + * A channel can be used for TX or RX, it can trigger remote
> + * processor interrupt to notify remote processor and can receive
> + * interrupt if has incoming message.
> + *
> + * @dst_irq:	Interrupt vector for remote processor
> + * @ack_irq:	Interrupt vector for local processor
> + */
> +struct hi3660_mbox_dev {
> +	unsigned int dst_irq;
> +	unsigned int ack_irq;
> +};
> +
> +/**
> + * Hi3660 mailbox controller data
> + *
> + * Mailbox controller includes 32 channels and can allocate
> + * channel for message transferring.
> + *
> + * @dev:	Device to which it is attached
> + * @base:	Base address of the register mapping region
> + * @chan:	Representation of channels in mailbox controller
> + * @mdev:	Representation of channel device data
> + * @controller:	Representation of a communication channel controller
> + */
> +struct hi3660_mbox {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct mbox_chan chan[MBOX_CHAN_MAX];
> +	struct hi3660_mbox_dev mdev[MBOX_CHAN_MAX];
> +	struct mbox_controller controller;
> +};
> +
> +static inline struct hi3660_mbox *to_hi3660_mbox(struct mbox_chan *chan)
> +{
> +	return container_of(chan->mbox, struct hi3660_mbox, controller);
> +}
> +
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

There is an existing sev() macro for this.

> +	return 0;
> +}
> +
> +static int hi3660_mbox_unlock(struct mbox_chan *chan)
> +{
> +	struct hi3660_mbox *mbox = to_hi3660_mbox(chan);
> +	unsigned int val, retry = 3;
> +
> +	do {
> +		writel_relaxed(MBOX_IPC_UNLOCK, mbox->base + MBOX_IPC_LOCK_REG);
> +
> +		val = readl_relaxed(mbox->base + MBOX_IPC_LOCK_REG);
> +		if (!val)
> +			break;
> +
> +		udelay(10);
> +	} while (retry--);
> +
> +	return (!val) ? 0 : -ETIMEDOUT;
> +}
> +
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
> +			continue;

So this is going to "wfe" when retry == 0 and the continue statement 
will take us out of the loop?

Also, there is a wfe() macro for arm and arm64 which could be used here.

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

If timeout occurs while waiting for the MBOX to be idle, val will hold 
the last value from MBOX_MODE_REG, and if this can be different than 0, 
this will hide the fact it timed out.

Maybe the following would be more appropriate:

return (retry >= 0) ? 0 : -ETIMEDOUT;

Also, your do {} while loops for the timeouts falsely give the 
impression we do "retry" attempts when we actually do "retry + 1" 
attempts (but I guess it doesn't make a big difference from the 
functional point of view).

> +}
> +
> +static int hi3660_mbox_send(struct mbox_chan *chan, u32 *msg)
> +{
> +	unsigned long ch = (unsigned long)chan->con_priv;
> +	struct hi3660_mbox *mbox = to_hi3660_mbox(chan);
> +	struct hi3660_mbox_dev *mdev = &mbox->mdev[ch];
> +	void __iomem *base = MBOX_BASE(mbox, ch);
> +	unsigned int i;
> +
> +	/* Clear mask for destination interrupt */
> +	writel_relaxed(~BIT(mdev->dst_irq), base + MBOX_IMASK_REG);
> +
> +	/* Config destination for interrupt vector */
> +	writel_relaxed(BIT(mdev->dst_irq), base + MBOX_DST_REG);
> +
> +	/* Automatic acknowledge mode */
> +	writel_relaxed(MBOX_AUTOMATIC_ACK, base + MBOX_MODE_REG);
> +
> +	/* Fill message data */
> +	for (i = 0; i < MBOX_MSG_LEN; i++)
> +		writel_relaxed(msg[i], base + MBOX_DATA_REG + i * 4);
> +
> +	/* Trigger data transferring */
> +	writel_relaxed(BIT(mdev->ack_irq), base + MBOX_SEND_REG);
> +	return 0;
> +}
> +
> +static int hi3660_mbox_send_data(struct mbox_chan *chan, void *msg)
> +{
> +	struct hi3660_mbox *mbox = to_hi3660_mbox(chan);
> +	int err;
> +
> +	err = hi3660_mbox_check_state(chan);
> +	if (err) {
> +		dev_err(mbox->dev, "checking state failed\n");
> +		return err;
> +	}
> +
> +	err = hi3660_mbox_unlock(chan);
> +	if (err) {
> +		dev_err(mbox->dev, "unlocking mailbox failed\n");
> +		return err;
> +	}
> +
> +	err = hi3660_mbox_acquire_channel(chan);
> +	if (err) {
> +		dev_err(mbox->dev, "acquiring channel failed\n");
> +		return err;
> +	}
> +
> +	return hi3660_mbox_send(chan, msg);
> +}
> +
> +static struct mbox_chan_ops hi3660_mbox_ops = {
> +	.send_data    = hi3660_mbox_send_data,
> +};
> +
> +static struct mbox_chan *hi3660_mbox_xlate(struct mbox_controller *controller,
> +					   const struct of_phandle_args *spec)
> +{
> +	struct hi3660_mbox *mbox = dev_get_drvdata(controller->dev);

nit:
In to_hi3660_mbox, you use the fact that the mbox_controller structure 
is part of hi3660_mbox and use container of to retrieve hi3660_mbox.

I think it would be nice to be consistent about this, either use 
container_of or dev drvdata, but not both.

Cheers,

-- 
Julien Thierry
