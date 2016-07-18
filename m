From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 18 Jul 2016 16:51:05 +0800
Subject: [PATCH V2 02/10] mailbox: tegra-hsp: Add HSP(Hardware
 Synchronization Primitives) driver
In-Reply-To: <20160707211016.GA9897@kickseed.nvidia.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-3-josephl@nvidia.com>
 <20160707211016.GA9897@kickseed.nvidia.com>
Message-ID: <578C9879.9080509@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2016 05:10 AM, Sivaram Nair wrote:
> On Tue, Jul 05, 2016 at 05:04:23PM +0800, Joseph Lo wrote:
>> The Tegra HSP mailbox driver implements the signaling doorbell-based
>> interprocessor communication (IPC) for remote processors currently. The
>> HSP HW modules support some different features for that, which are
>> shared mailboxes, shared semaphores, arbitrated semaphores, and
>> doorbells. And there are multiple HSP HW instances on the chip. So the
>> driver is extendable to support more features for different IPC
>> requirement.
>>
>> The driver of remote processor can use it as a mailbox client and deal
>> with the IPC protocol to synchronize the data communications.
>>
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>> Changes in V2:
>> - Update the driver to support the binding changes in V2
>> - it's extendable to support multiple HSP sub-modules on the same HSP HW block
>>    now.
>> ---
>>   drivers/mailbox/Kconfig     |   9 +
>>   drivers/mailbox/Makefile    |   2 +
>>   drivers/mailbox/tegra-hsp.c | 418 ++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 429 insertions(+)
>>   create mode 100644 drivers/mailbox/tegra-hsp.c
>>
>> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
>> index 5305923752d2..fe584cb54720 100644
>> --- a/drivers/mailbox/Kconfig
>> +++ b/drivers/mailbox/Kconfig
>> @@ -114,6 +114,15 @@ config MAILBOX_TEST
>>   	  Test client to help with testing new Controller driver
>>   	  implementations.
>>
>> +config TEGRA_HSP_MBOX
>> +	bool "Tegra HSP(Hardware Synchronization Primitives) Driver"
>> +	depends on ARCH_TEGRA_186_SOC
>> +	help
>> +	  The Tegra HSP driver is used for the interprocessor communication
>> +	  between different remote processors and host processors on Tegra186
>> +	  and later SoCs. Say Y here if you want to have this support.
>> +	  If unsure say N.
>> +
>>   config XGENE_SLIMPRO_MBOX
>>   	tristate "APM SoC X-Gene SLIMpro Mailbox Controller"
>>   	depends on ARCH_XGENE
>> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
>> index 0be3e742bb7d..26d8f91c7fea 100644
>> --- a/drivers/mailbox/Makefile
>> +++ b/drivers/mailbox/Makefile
>> @@ -25,3 +25,5 @@ obj-$(CONFIG_TI_MESSAGE_MANAGER) += ti-msgmgr.o
>>   obj-$(CONFIG_XGENE_SLIMPRO_MBOX) += mailbox-xgene-slimpro.o
>>
>>   obj-$(CONFIG_HI6220_MBOX)	+= hi6220-mailbox.o
>> +
>> +obj-${CONFIG_TEGRA_HSP_MBOX}	+= tegra-hsp.o
>> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
>> new file mode 100644
>> index 000000000000..93c3ef58f29f
>> --- /dev/null
>> +++ b/drivers/mailbox/tegra-hsp.c
>> @@ -0,0 +1,418 @@
>> +/*
>> + * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/mailbox_controller.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <dt-bindings/mailbox/tegra186-hsp.h>
>> +
>> +#define HSP_INT_DIMENSIONING	0x380
>> +#define HSP_nSM_OFFSET		0
>> +#define HSP_nSS_OFFSET		4
>> +#define HSP_nAS_OFFSET		8
>> +#define HSP_nDB_OFFSET		12
>> +#define HSP_nSI_OFFSET		16
>> +#define HSP_nINT_MASK		0xf
>> +
>> +#define HSP_DB_REG_TRIGGER	0x0
>> +#define HSP_DB_REG_ENABLE	0x4
>> +#define HSP_DB_REG_RAW		0x8
>> +#define HSP_DB_REG_PENDING	0xc
>> +
>> +#define HSP_DB_CCPLEX		1
>> +#define HSP_DB_BPMP		3
>> +
>> +#define MAX_NUM_HSP_CHAN 32
>
> Is this an arbitrarily chosen number?

Ah, this should be MAX_NUM_HSP_DB_CHAN now.

But the mbox driver still needs a max channel number, I will check how 
to enhance it properly with multiple HSP modules support in the same driver.

Maybe 4 channels for SM, AS, SS and DB. And the sub channels for 
different functions under them. Then it may able to fix the double loop 
issue in the hsp_db_irq function.

>
>> +#define MAX_NUM_HSP_DB 7
>> +
>> +#define hsp_db_offset(i, d) \
>> +	(d->base + ((1 + (d->nr_sm >> 1) + d->nr_ss + d->nr_as) << 16) + \
>> +	(i) * 0x100)
>> +
>> +struct tegra_hsp_db_chan {
>> +	int master_id;
>> +	int db_id;
>
> These should be unsigned?
Yes, will fix them.

>
>> +};
>> +
>> +struct tegra_hsp_mbox_chan {
>> +	int type;
>
> This too...
>
>> +	union {
>> +		struct tegra_hsp_db_chan db_chan;
>> +	};
>> +};
>
> Why do we need to use a union?

Because we only support DB right now, there is only one member in the 
union. We can add something like sm_chan here when we need to support 
that later.

>
>> +
>> +struct tegra_hsp_mbox {
>> +	struct mbox_controller *mbox;
>> +	void __iomem *base;
>> +	void __iomem *db_base[MAX_NUM_HSP_DB];
>> +	int db_irq;
>> +	int nr_sm;
>> +	int nr_as;
>> +	int nr_ss;
>> +	int nr_db;
>> +	int nr_si;
>> +	spinlock_t lock;
>
> You might need to change this to a mutex - see below.

OK, will fix this.

>
>> +};
>> +
>> +static inline u32 hsp_readl(void __iomem *base, int reg)
>> +{
>> +	return readl(base + reg);
>> +}
>> +
>> +static inline void hsp_writel(void __iomem *base, int reg, u32 val)
>> +{
>> +	writel(val, base + reg);
>> +	readl(base + reg);
>> +}
>> +
>> +static int hsp_db_can_ring(void __iomem *db_base)
>> +{
>> +	u32 reg;
>> +
>> +	reg = hsp_readl(db_base, HSP_DB_REG_ENABLE);
>> +
>> +	return !!(reg & BIT(HSP_DB_MASTER_CCPLEX));
>> +}
>> +
>> +static irqreturn_t hsp_db_irq(int irq, void *p)
>> +{
>> +	struct tegra_hsp_mbox *hsp_mbox = p;
>> +	ulong val;
>
> This should be u32 and...
>
>> +	int master_id;
>> +
>> +	val = (ulong)hsp_readl(hsp_mbox->db_base[HSP_DB_CCPLEX],
>> +			       HSP_DB_REG_PENDING);
>
> the cast should/can be removed (hsp_readl and hsp_writel both use u32)?
Yes.

>
>> +	hsp_writel(hsp_mbox->db_base[HSP_DB_CCPLEX], HSP_DB_REG_PENDING, val);
>> +
>> +	spin_lock(&hsp_mbox->lock);
>> +	for_each_set_bit(master_id, &val, MAX_NUM_HSP_CHAN) {
>> +		struct mbox_chan *chan;
>> +		struct tegra_hsp_mbox_chan *mchan;
>> +		int i;
>> +
>> +		for (i = 0; i < MAX_NUM_HSP_CHAN; i++) {
>> +			chan = &hsp_mbox->mbox->chans[i];
>> +
>> +			if (!chan->con_priv)
>> +				continue;
>> +
>> +			mchan = chan->con_priv;
>> +			if (mchan->type == HSP_MBOX_TYPE_DB &&
>> +			    mchan->db_chan.master_id == master_id)
>> +				break;
>> +			chan = NULL;
>> +		}
>
> Like Alexandre, I didn't like this use of inner loop as well. But I will
> add my comment to the other thread.
>
>> +
>> +		if (chan)
>> +			mbox_chan_received_data(chan, NULL);
>> +	}
>> +	spin_unlock(&hsp_mbox->lock);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int hsp_db_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +	struct tegra_hsp_mbox_chan *mchan = chan->con_priv;
>> +	struct tegra_hsp_db_chan *db_chan = &mchan->db_chan;
>> +	struct tegra_hsp_mbox *hsp_mbox = dev_get_drvdata(chan->mbox->dev);
>> +
>> +	hsp_writel(hsp_mbox->db_base[db_chan->db_id], HSP_DB_REG_TRIGGER, 1);
>> +
>> +	return 0;
>> +}
>> +
>> +static int hsp_db_startup(struct mbox_chan *chan)
>> +{
>> +	struct tegra_hsp_mbox_chan *mchan = chan->con_priv;
>> +	struct tegra_hsp_db_chan *db_chan = &mchan->db_chan;
>> +	struct tegra_hsp_mbox *hsp_mbox = dev_get_drvdata(chan->mbox->dev);
>> +	u32 val;
>> +	unsigned long flag;
>> +
>> +	if (db_chan->master_id >= MAX_NUM_HSP_CHAN) {
>
> Is this a valid check? IIUC, MAX_NUM_HSP_CHAN is independent of the
> number of masters.

This should be MAX_NUM_HSP_DB_CHAN.

>
>> +		dev_err(chan->mbox->dev, "invalid HSP chan: master ID: %d\n",
>> +			db_chan->master_id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	spin_lock_irqsave(&hsp_mbox->lock, flag);
>> +	val = hsp_readl(hsp_mbox->db_base[HSP_DB_CCPLEX], HSP_DB_REG_ENABLE);
>> +	val |= BIT(db_chan->master_id);
>> +	hsp_writel(hsp_mbox->db_base[HSP_DB_CCPLEX], HSP_DB_REG_ENABLE, val);
>> +	spin_unlock_irqrestore(&hsp_mbox->lock, flag);
>> +
>> +	if (!hsp_db_can_ring(hsp_mbox->db_base[db_chan->db_id]))
>> +		return -ENODEV;
>> +
>> +	return 0;
>> +}
>> +
>> +static void hsp_db_shutdown(struct mbox_chan *chan)
>> +{
>> +	struct tegra_hsp_mbox_chan *mchan = chan->con_priv;
>> +	struct tegra_hsp_db_chan *db_chan = &mchan->db_chan;
>> +	struct tegra_hsp_mbox *hsp_mbox = dev_get_drvdata(chan->mbox->dev);
>> +	u32 val;
>> +	unsigned long flag;
>> +
>> +	spin_lock_irqsave(&hsp_mbox->lock, flag);
>> +	val = hsp_readl(hsp_mbox->db_base[HSP_DB_CCPLEX], HSP_DB_REG_ENABLE);
>> +	val &= ~BIT(db_chan->master_id);
>> +	hsp_writel(hsp_mbox->db_base[HSP_DB_CCPLEX], HSP_DB_REG_ENABLE, val);
>> +	spin_unlock_irqrestore(&hsp_mbox->lock, flag);
>> +}
>> +
>> +static bool hsp_db_last_tx_done(struct mbox_chan *chan)
>> +{
>> +	return true;
>> +}
>> +
>> +static int tegra_hsp_db_init(struct tegra_hsp_mbox *hsp_mbox,
>> +			     struct mbox_chan *mchan, int master_id)
>> +{
>> +	struct platform_device *pdev = to_platform_device(hsp_mbox->mbox->dev);
>> +	struct tegra_hsp_mbox_chan *hsp_mbox_chan;
>> +	int ret;
>> +
>> +	if (!hsp_mbox->db_irq) {
>> +		int i;
>> +
>> +		hsp_mbox->db_irq = platform_get_irq_byname(pdev, "doorbell");
>> +		ret = devm_request_irq(&pdev->dev, hsp_mbox->db_irq,
>> +				       hsp_db_irq, IRQF_NO_SUSPEND,
>> +				       dev_name(&pdev->dev), hsp_mbox);
>> +		if (ret)
>> +			return ret;
>> +
>> +		for (i = 0; i < MAX_NUM_HSP_DB; i++)
>> +			hsp_mbox->db_base[i] = hsp_db_offset(i, hsp_mbox);
>> +	}
>> +
>> +	hsp_mbox_chan = devm_kzalloc(&pdev->dev, sizeof(*hsp_mbox_chan),
>> +				     GFP_KERNEL);
>> +	if (!hsp_mbox_chan)
>> +		return -ENOMEM;
>> +
>> +	hsp_mbox_chan->type = HSP_MBOX_TYPE_DB;
>> +	hsp_mbox_chan->db_chan.master_id = master_id;
>> +	switch (master_id) {
>> +	case HSP_DB_MASTER_BPMP:
>> +		hsp_mbox_chan->db_chan.db_id = HSP_DB_BPMP;
>> +		break;
>> +	default:
>> +		hsp_mbox_chan->db_chan.db_id = MAX_NUM_HSP_DB;
>> +		break;
>> +	}
>> +
>> +	mchan->con_priv = hsp_mbox_chan;
>> +
>> +	return 0;
>> +}
>> +
>> +static int hsp_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +	struct tegra_hsp_mbox_chan *hsp_mbox_chan = chan->con_priv;
>> +	int ret = 0;
>> +
>> +	switch (hsp_mbox_chan->type) {
>> +	case HSP_MBOX_TYPE_DB:
>> +		ret = hsp_db_send_data(chan, data);
>> +		break;
>> +	default:
>
> Should you return an error here?
>
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int hsp_startup(struct mbox_chan *chan)
>> +{
>> +	struct tegra_hsp_mbox_chan *hsp_mbox_chan = chan->con_priv;
>> +	int ret = 0;
>> +
>> +	switch (hsp_mbox_chan->type) {
>> +	case HSP_MBOX_TYPE_DB:
>> +		ret = hsp_db_startup(chan);
>> +		break;
>> +	default:
>
> And here too...?
OK, will fix both.

>
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static void hsp_shutdown(struct mbox_chan *chan)
>> +{
>> +	struct tegra_hsp_mbox_chan *hsp_mbox_chan = chan->con_priv;
>> +
>> +	switch (hsp_mbox_chan->type) {
>> +	case HSP_MBOX_TYPE_DB:
>> +		hsp_db_shutdown(chan);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	chan->con_priv = NULL;
>> +}
>> +
>> +static bool hsp_last_tx_done(struct mbox_chan *chan)
>> +{
>> +	struct tegra_hsp_mbox_chan *hsp_mbox_chan = chan->con_priv;
>> +	bool ret = true;
>> +
>> +	switch (hsp_mbox_chan->type) {
>> +	case HSP_MBOX_TYPE_DB:
>> +		ret = hsp_db_last_tx_done(chan);
>
> hsp_db_last_tx_done() return true - so we might as well make this parent
> function to return true and remove hsp_db_last_tx_done()?
Yes, true.

>
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct mbox_chan_ops tegra_hsp_ops = {
>> +	.send_data = hsp_send_data,
>> +	.startup = hsp_startup,
>> +	.shutdown = hsp_shutdown,
>> +	.last_tx_done = hsp_last_tx_done,
>> +};
>> +
>> +static const struct of_device_id tegra_hsp_match[] = {
>> +	{ .compatible = "nvidia,tegra186-hsp" },
>> +	{ }
>> +};
>> +
>> +static struct mbox_chan *
>> +of_hsp_mbox_xlate(struct mbox_controller *mbox,
>> +		  const struct of_phandle_args *sp)
>> +{
>> +	int mbox_id = sp->args[0];
>> +	int hsp_type = (mbox_id >> 16) & 0xf;
>
> Wouldn't it be nicer if the shift and mask constants are made defines in
> the DT bindings header (tegra186-hsp.h)?
Should be OK.

>
>> +	int master_id = mbox_id & 0xff;
>> +	struct tegra_hsp_mbox *hsp_mbox = dev_get_drvdata(mbox->dev);
>> +	struct mbox_chan *free_chan;
>> +	int i, ret = 0;
>> +
>> +	spin_lock(&hsp_mbox->lock);
>
> If you must use spin locks, you will have to use the irqsave/restore
> veriants in this function (called from thread context).
>
>> +
>> +	for (i = 0; i < mbox->num_chans; i++) {
>> +		free_chan = &mbox->chans[i];
>> +		if (!free_chan->con_priv)
>> +			break;
>> +		free_chan = NULL;
>> +	}
>> +
>> +	if (!free_chan) {
>> +		spin_unlock(&hsp_mbox->lock);
>> +		return ERR_PTR(-EFAULT);
>> +	}
>
> IMO, it will be cleaner & simpler if you move the above code (doing the
> lookup) into a separate function that returns free_chan - and you can
> reuse that in hsp_db_irq()
?
I think it's different usage.
>
>> +
>> +	switch (hsp_type) {
>> +	case HSP_MBOX_TYPE_DB:
>> +		ret = tegra_hsp_db_init(hsp_mbox, free_chan, master_id);
>
> tegra_hsp_db_init() uses devm_kzalloc and you are doing this holding a
> spinlock.
>
>> +		break;
>> +	default:
>
> Not returning error here will also cause resource leak (free_chan).
>
>> +		break;
>> +	}

Thanks,
-Joseph
