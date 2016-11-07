From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Nov 2016 14:26:59 +0100
Subject: [PATCH v1 03/11] drivers: soc: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <1478101374-18778-4-git-send-email-anurup.m@huawei.com>
References: <1478101374-18778-1-git-send-email-anurup.m@huawei.com>
 <1478101374-18778-4-git-send-email-anurup.m@huawei.com>
Message-ID: <2127881.qmAR1XgW9F@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 2, 2016 11:42:46 AM CET Anurup M wrote:
> From: Tan Xiaojun <tanxiaojun@huawei.com>
> 
> 	The Hisilicon Djtag is an independent component which connects
> 	with some other components in the SoC by Debug Bus. This driver
> 	can be configured to access the registers of connecting components
> 	(like L3 cache) during real time debugging.

The formatting of the text seems odd, please remove the leading spaces.

>  drivers/soc/Kconfig                 |   1 +
>  drivers/soc/Makefile                |   1 +
>  drivers/soc/hisilicon/Kconfig       |  12 +
>  drivers/soc/hisilicon/Makefile      |   1 +
>  drivers/soc/hisilicon/djtag.c       | 639 ++++++++++++++++++++++++++++++++++++
>  include/linux/soc/hisilicon/djtag.h |  38 +++

Do you expect other drivers to be added that reference this interface?
If not, or if you are unsure, just put all of it under drivers/perf
so we don't introduce a global API that has only one user.

> +
> +#include <linux/bitops.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +#include <asm-generic/delay.h>

Never include files from asm-generic directly except from
an architecture specific asm/*.h header file.


> +DEFINE_IDR(djtag_hosts_idr);

make this static

> +static void djtag_read32_relaxed(void __iomem *regs_base, u32 off, u32 *value)
> +{
> +	void __iomem *reg_addr = regs_base + off;
> +
> +	*value = readl_relaxed(reg_addr);
> +}
> +
> +static void djtag_write32(void __iomem *regs_base, u32 off, u32 val)
> +{
> +	void __iomem *reg_addr = regs_base + off;
> +
> +	writel(val, reg_addr);
> +}

This looks like an odd combination of interfaces.
Why can the reads be "relaxed" when the writes can not?

Generally speaking, I'd advise to always use non-relaxed accessors
unless there is a strong performance reason, and in that case there
should be a comment explaining the use at each of the callers
of a relaxed accessor.

> +	/* ensure the djtag operation is done */
> +	do {
> +		djtag_read32_relaxed(regs_base, SC_DJTAG_MSTR_START_EN_EX, &rd);
> +
> +		if (!(rd & DJTAG_MSTR_START_EN_EX))
> +			break;
> +
> +		udelay(1);
> +	} while (timeout--);

This one is obviously not performance critical at all, so use a non-relaxed
accessor. Same for the other two in this function.

Are these functions ever called from atomic context? If yes, please document
from what context they can be called, otherwise please consider changing
the udelay calls into sleeping waits.

> +int hisi_djtag_writel(struct hisi_djtag_client *client, u32 offset, u32 mod_sel,
> +							u32 mod_mask, u32 val)
> +{
> +	void __iomem *reg_map = client->host->sysctl_reg_map;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&client->host->lock, flags);
> +	ret = client->host->djtag_readwrite(reg_map, offset, mod_sel, mod_mask,
> +					true, val, 0, NULL);
> +	if (ret)
> +		pr_err("djtag_writel: error! ret=%d\n", ret);
> +	spin_unlock_irqrestore(&client->host->lock, flags);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(hisi_djtag_writel);

That would of course imply changing the spinlock to a mutex here as well.

> +static const struct of_device_id djtag_of_match[] = {
> +	/* for hip05(D02) cpu die */
> +	{ .compatible = "hisilicon,hip05-cpu-djtag-v1",
> +		.data = (void *)djtag_readwrite_v1 },
> +	/* for hip05(D02) io die */
> +	{ .compatible = "hisilicon,hip05-io-djtag-v1",
> +		.data = (void *)djtag_readwrite_v1 },
> +	/* for hip06(D03) cpu die */
> +	{ .compatible = "hisilicon,hip06-cpu-djtag-v1",
> +		.data = (void *)djtag_readwrite_v1 },
> +	/* for hip06(D03) io die */
> +	{ .compatible = "hisilicon,hip06-io-djtag-v2",
> +		.data = (void *)djtag_readwrite_v2 },
> +	/* for hip07(D05) cpu die */
> +	{ .compatible = "hisilicon,hip07-cpu-djtag-v2",
> +		.data = (void *)djtag_readwrite_v2 },
> +	/* for hip07(D05) io die */
> +	{ .compatible = "hisilicon,hip07-io-djtag-v2",
> +		.data = (void *)djtag_readwrite_v2 },
> +	{},
> +};

If these are backwards compatible, just mark them as compatible in DT,
e.g. hip06 can use

	compatible = "hisilicon,hip06-cpu-djtag-v1", "hisilicon,hip05-cpu-djtag-v1";

so you can tell the difference if you need to, but the driver only has to
list the oldest one here.

What is the difference between the cpu and io djtag interfaces?

I think you can also drop the '(void *)'.

> +static void djtag_register_devices(struct hisi_djtag_host *host)
> +{
> +	struct device_node *node;
> +	struct hisi_djtag_client *client;
> +
> +	if (!host->of_node)
> +		return;
> +
> +	for_each_available_child_of_node(host->of_node, node) {
> +		if (of_node_test_and_set_flag(node, OF_POPULATED))
> +			continue;
> +		client = hisi_djtag_of_register_device(host, node);
> +		list_add(&client->next, &host->client_list);
> +	}
> +}

Can you explain your thoughts behind creating a new bus type
and adding the child devices manually rather than using
platform_device structures with of_platform_populate()?

Do you expect to see other implementations of this bus type
with incompatible bus drivers?

	Arnd
