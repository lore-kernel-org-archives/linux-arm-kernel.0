From: anurupvasu@gmail.com (Anurup M)
Date: Fri, 24 Mar 2017 16:16:25 +0530
Subject: [PATCH v6 06/11] drivers: perf: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <20170321155119.GF22188@leverpostej>
References: <1489127302-112735-1-git-send-email-anurup.m@huawei.com>
 <20170321155119.GF22188@leverpostej>
Message-ID: <58D4F901.5070503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review.

On Tuesday 21 March 2017 09:21 PM, Mark Rutland wrote:
> On Fri, Mar 10, 2017 at 01:28:22AM -0500, Anurup M wrote:
>> From: Tan Xiaojun <tanxiaojun@huawei.com>
>>
>> The Hisilicon Djtag is an independent component which connects
>> with some other components in the SoC by Debug Bus. This driver
>> can be configured to access the registers of connecting components
>> (like L3 cache) during real time debugging.
>>
>> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> Signed-off-by: Anurup M <anurup.m@huawei.com>
>> ---
>>   drivers/perf/Makefile           |   1 +
>>   drivers/perf/hisilicon/Makefile |   1 +
>>   drivers/perf/hisilicon/djtag.c  | 773 ++++++++++++++++++++++++++++++++++++++++
>>   drivers/perf/hisilicon/djtag.h  |  42 +++
>>   4 files changed, 817 insertions(+)
>>   create mode 100644 drivers/perf/hisilicon/Makefile
>>   create mode 100644 drivers/perf/hisilicon/djtag.c
>>   create mode 100644 drivers/perf/hisilicon/djtag.h
>>
>> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
>> index 3a5e22f..d262fff 100644
>> --- a/drivers/perf/Makefile
>> +++ b/drivers/perf/Makefile
>> @@ -1,4 +1,5 @@
>>   obj-$(CONFIG_ARM_PMU) += arm_pmu.o
>>   obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
>> +obj-$(CONFIG_HISI_PMU) += hisilicon/
> Please keep this ordered alphabetically. This should be between the
> ARM_PMU and QCOM_L2_PMU cases.

Ok.

>>   obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>>   obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
> The cover letter said this was based upon v4.11-rc1, which does not
> contain this last line.
>
> What exactly is this series based on?

Apologies. Mistake due to internal repo added ARMv8 ACPI patches. Shall 
take care of this and use 4.11.-rc1 linux branch for patches.

> [...]
>
>> +#define SC_DJTAG_TIMEOUT_US    (100 * USEC_PER_MSEC) /* 100ms */
> How was this value chosen?
>
> How likely is a timeout?

As explained in PATCH 7,

The djtag -EBUSY in hardware is a very rare scenario, and by design of 
hardware, does not occur unless there is a Chip hung situation.
The maximum timeout possible in djtag is 30us, and hardware logic shall 
reset it, if djtag is unavailable for more than 30us.
The timeout used in driver is 100ms to ensure that it does not fail in 
any case.

> [...]
>
>> +static DEFINE_IDR(djtag_hosts_idr);
>> +static DEFINE_IDR(djtag_clients_idr);
> Please include <linux/idr.h> for DEFINE_IDR().

Ok.

> [...]
>
>> +struct hisi_djtag_host {
>> +	spinlock_t lock;
>> +	int id;
>> +	u32 scl_id;
>> +	struct device dev;
> Please include <linux/device.h> for struct device.

Ok.

>> +	struct list_head client_list;
>> +	void __iomem *sysctl_reg_map;
>> +	struct device_node *of_node;
>> +	const struct hisi_djtag_ops *djtag_ops;
>> +};
> [...]
>
>> +static void djtag_prepare_v1(void __iomem *regs_base, u32 offset,
>> +			     u32 mod_sel, u32 mod_mask)
>> +{
>> +	/* djtag master enable & accelerate R,W */
>> +	writel(DJTAG_NOR_CFG | DJTAG_MSTR_EN, regs_base + SC_DJTAG_MSTR_EN);
> I don't follow this comment. What exactly does this write do? What is
> being accelerated?

The bit DJTAG_NOR_CFG will enable normal access mode for djtag. There is 
also low speed access mode.
The DJTAG_MSTR_EN will enable the djtag access.
I shall modify comment as

+	/* djtag master enable & support normal mode for R,W */



> Please include <linux/io.h> for the IO accessors.

Ok.

> [...]
>
>> +static int djtag_do_operation_v1(void __iomem *regs_base)
>> +{
>> +	u32 rd;
>> +	int timeout = SC_DJTAG_TIMEOUT_US;
>> +
>> +	/* start to write to djtag register */
>> +	writel(DJTAG_MSTR_START_EN, regs_base + SC_DJTAG_MSTR_START_EN);
>> +
>> +	/* ensure the djtag operation is done */
>> +	do {
>> +		rd = readl(regs_base + SC_DJTAG_MSTR_START_EN);
>> +		if (!(rd & DJTAG_MSTR_EN))
>> +			break;
>> +
>> +		udelay(1);
>> +	} while (timeout--);
>> +
>> +	if (timeout < 0)
>> +		return -EBUSY;
> Please include <linux/errno.h> for error values.

Ok.

>> +
>> +	return 0;
>> +}
> Please use readl_poll_timeout(), e.g.
>
> static int djtag_do_operation_v1(void __iomem *regs_base)
> {
> 	int ret;
> 	u32 val;
>
> 	/* start to write to djtag register */
> 	writel(DJTAG_MSTR_START_EN, regs_base + SC_DJTAG_MSTR_START_EN);
>
> 	/* wait for the operation to complete */
> 	ret = readl_poll_timout(regs_base + SC_DJTAG_MSTR_START_EN,
> 				val, !(val & DJTAG_MSTR_EN),
> 				1, SC_DJTAG_TIMEOUT_US);
> 	
> 	if (ret)
> 		pr_warn("djtag operation timed out.\n");
>
> 	return ret;
> }
>
> Depending on how serious a timeout is, this might want to be some kind
> of WARN variant.
>
> Note that this will return -ETIMEDOUT when the condition is not met
> before the timeout.

Thanks. I shall try this and update.

> Please include <linux/iopoll.h> for this.
>
> [...]

Ok.

>> +static int djtag_do_operation_v2(void __iomem *regs_base)
>> +{
>> +	u32 rd;
>> +	int timeout = SC_DJTAG_TIMEOUT_US;
>> +
>> +	/* start to write to djtag register */
>> +	writel(DJTAG_MSTR_START_EN_EX, regs_base + SC_DJTAG_MSTR_START_EN_EX);
>> +
>> +	/* ensure the djtag operation is done */
>> +	do {
>> +		rd = readl(regs_base + SC_DJTAG_MSTR_START_EN_EX);
>> +
>> +		if (!(rd & DJTAG_MSTR_START_EN_EX))
>> +			break;
>> +
>> +		udelay(1);
>> +	} while (timeout--);
>> +
>> +	if (timeout < 0)
>> +		goto timeout;
>> +
>> +	timeout = SC_DJTAG_TIMEOUT_US;
>> +	do {
>> +		rd = readl(regs_base + SC_DJTAG_OP_ST_EX);
>> +
>> +		if (rd & DJTAG_OP_DONE_EX)
>> +			break;
>> +
>> +		udelay(1);
>> +	} while (timeout--);
>> +
>> +	if (timeout < 0)
>> +		goto timeout;
>> +
>> +	return 0;
>> +
>> +timeout:
>> +	return -EBUSY;
>> +}
> Likewise, please use readl_poll_timeout() for these.
>
> [...]
>
>> +static int djtag_read_v1(void __iomem *regs_base, u32 offset, u32 mod_sel,
>> +			 u32 mod_mask, int chain_id, u32 *rval)
>> +{
>> +	int ret;
>> +
>> +	if (!(mod_mask & CHAIN_UNIT_CFG_EN)) {
>> +		pr_warn("djtag: do nothing.\n");
>> +		return 0;
>> +	}
> When does this happen, why should we warn, and why should we return?

Agreed, the value of mod_mask used is always >=1 so this check shall be 
removed.

>> +
>> +	djtag_prepare_v1(regs_base, offset, mod_sel, mod_mask);
>> +
>> +	writel(DJTAG_MSTR_R, regs_base + SC_DJTAG_MSTR_WR);
>> +
>> +	ret = djtag_do_operation_v1(regs_base);
>> +	if (ret) {
>> +		if (ret == EBUSY)
>> +			pr_err("djtag: %s timeout!\n", "read");
>> +		return ret;
>> +	}
> There's no reason to parameterise the message like this, and the only
> non-zero return is a timeout, so we don't need to check the specific
> error code.

Agreed. Shall correct it.

>> +
>> +	*rval = readl(regs_base + SC_DJTAG_RD_DATA_BASE + chain_id * 0x4);
>> +
>> +	return 0;
>> +}
>> +
>> +static int djtag_read_v2(void __iomem *regs_base, u32 offset, u32 mod_sel,
>> +			 u32 mod_mask, int chain_id, u32 *rval)
>> +{
>> +	int ret;
>> +
>> +	if (!(mod_mask & CHAIN_UNIT_CFG_EN_EX)) {
>> +		pr_warn("djtag: do nothing.\n");
>> +		return 0;
>> +	}
>> +
>> +	djtag_prepare_v2(regs_base, offset, mod_sel, mod_mask);
>> +
>> +	writel(DJTAG_MSTR_RD_EX
>> +			| (mod_sel << DEBUG_MODULE_SEL_SHIFT_EX)
>> +			| (mod_mask & CHAIN_UNIT_CFG_EN_EX),
>> +			regs_base + SC_DJTAG_MSTR_CFG_EX);
> This is rather painful to read, and violates kernel style. Each '|'
> should be on the end of a line rather than starting the next one.
>
> It would be nicer to generate the value in advance, and pass it in. e.g.
>
> 	u32 val = DJTAG_MSTR_RD_EX |
> 		  (mod_sel << DEBUG_MODULE_SEL_SHIFT_EX) |
> 		  (mod_mask & CHAIN_UNIT_CFG_EN_EX);
> 	writel(val, regs_base + SC_DJTAG_MSTR_CFG_EX);

Thanks, shall correct it.

>> +
>> +	ret = djtag_do_operation_v2(regs_base);
>> +	if (ret) {
>> +		if (ret == EBUSY)
>> +			pr_err("djtag: %s timeout!\n", "read");
>> +		return ret;
>> +	}
>> +
>> +	*rval = readl(regs_base + SC_DJTAG_RD_DATA_BASE_EX +
>> +					      chain_id * 0x4);
> Weird alignment. Please align to the right of the '(', using spaces as
> necessary, e.g.
>
> 	*rval = readl(regs_base + SC_DJTAG_RD_DATA_BASE_EX +
> 		      chain_id * 4);

Thanks, shall correct it and recheck in the entire series.

>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * djtag_write_v1/v2: djtag write interface
>> + * @reg_base:	djtag register base address
>> + * @offset:	register's offset
>> + * @mod_sel:	module selection
>> + * @mod_mask:	mask to select specific modules for write
>> + * @wval:	value to register for write
>> + * @chain_id:	which sub module for read
>> + *
>> + * Return non-zero if error, else return 0.
>> + */
>> +static int djtag_write_v1(void __iomem *regs_base, u32 offset, u32 mod_sel,
>> +			  u32 mod_mask, u32 wval, int chain_id)
>> +{
>> +	int ret;
>> +
>> +	if (!(mod_mask & CHAIN_UNIT_CFG_EN)) {
>> +		pr_warn("djtag: do nothing.\n");
>> +		return 0;
>> +	}
>> +
>> +	djtag_prepare_v1(regs_base, offset, mod_sel, mod_mask);
>> +
>> +	writel(DJTAG_MSTR_W, regs_base + SC_DJTAG_MSTR_WR);
>> +	writel(wval, regs_base + SC_DJTAG_MSTR_DATA);
>> +
>> +	ret = djtag_do_operation_v1(regs_base);
>> +	if (ret) {
>> +		if (ret == EBUSY)
>> +			pr_err("djtag: %s timeout!\n", "write");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> Same comments as with the read case.
>

Ok

>> +static int djtag_write_v2(void __iomem *regs_base, u32 offset, u32 mod_sel,
>> +			  u32 mod_mask, u32 wval, int chain_id)
>> +{
>> +	int ret;
>> +
>> +	if (!(mod_mask & CHAIN_UNIT_CFG_EN_EX)) {
>> +		pr_warn("djtag: do nothing.\n");
>> +		return 0;
>> +	}
>> +
>> +	djtag_prepare_v2(regs_base, offset, mod_sel, mod_mask);
>> +
>> +	writel(DJTAG_MSTR_WR_EX
>> +			| (mod_sel << DEBUG_MODULE_SEL_SHIFT_EX)
>> +			| (mod_mask & CHAIN_UNIT_CFG_EN_EX),
>> +			regs_base + SC_DJTAG_MSTR_CFG_EX);
>> +	writel(wval, regs_base + SC_DJTAG_MSTR_DATA_EX);
>> +
>> +	ret = djtag_do_operation_v2(regs_base);
>> +	if (ret) {
>> +		if (ret == EBUSY)
>> +			pr_err("djtag: %s timeout!\n", "write");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
> Likewise.
>
>> +/**
>> + * djtag_writel - write registers via djtag
>> + * @client: djtag client handle
>> + * @offset:	register's offset
>> + * @mod_sel:	module selection
>> + * @mod_mask:	mask to select specific modules
>> + * @val:	value to write to register
>> + *
>> + * If error return errno, otherwise return 0.
>> + */
>> +int hisi_djtag_writel(struct hisi_djtag_client *client, u32 offset,
>> +		      u32 mod_sel, u32 mod_mask, u32 val)
> The function name doesn't match the comment block above.
>

Thanks, shall correct it and recheck in this file.

>> +{
>> +	void __iomem *reg_map = client->host->sysctl_reg_map;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	spin_lock_irqsave(&client->host->lock, flags);
>> +	ret = client->host->djtag_ops->djtag_write(reg_map, offset, mod_sel,
>> +						   mod_mask, val, 0);
>> +	if (ret)
>> +		pr_err("djtag_writel: error! ret=%d\n", ret);
>> +	spin_unlock_irqrestore(&client->host->lock, flags);
>> +
>> +	return ret;
>> +}
> Please use some temporary variables rather than a long chain of
> dereferences.
>
> AFAICT, the error here is pointless noise given the write op already
> logs an error when it return a non-zero value.
>
> So I think this can be:
>
> int hisi_djtag_writel(struct hisi_djtag_client *client, u32 offset,
> 		      u32 mod_sel, u32 mod_mask, u32 val)
> {
> 	struct hisi_djtag_host *host = client->host;
> 	struct hisi_djtag_ops *ops = host->djtag_ops;
> 	void __iomem *reg_map = host->sysctl_reg_map;
> 	unsigned long flags;
> 	int ret;
>
> 	spin_lock_irqsave(&client->host->lock, flags);
> 	ret = ops->djtag_write(reg_map, offset, mod_sel, mod_mask, val, 0);
> 	spin_unlock_irqrestore(&client->host->lock, flags);
>
> 	return ret;
> }
>
> Please consistently use the hisi_djtag_ prefix. It is confusing that
> some functions have it while others do not.
> 	

Thanks, shall modify accordingly.

>> +/**
>> + * djtag_readl - read registers via djtag
>> + * @client: djtag client handle
>> + * @offset:	register's offset
>> + * @mod_sel:	module type selection
>> + * @chain_id:	chain_id number, mostly is 0
>> + * @val:	register's value
>> + *
>> + * If error return errno, otherwise return 0.
>> + */
>> +int hisi_djtag_readl(struct hisi_djtag_client *client, u32 offset,
>> +		     u32 mod_sel, int chain_id, u32 *val)
>> +{
>> +	void __iomem *reg_map = client->host->sysctl_reg_map;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	spin_lock_irqsave(&client->host->lock, flags);
>> +	ret = client->host->djtag_ops->djtag_read(reg_map, offset, mod_sel,
>> +						  0xffff, chain_id, val);
>> +	if (ret)
>> +		pr_err("djtag_readl: error! ret=%d\n", ret);
>> +	spin_unlock_irqrestore(&client->host->lock, flags);
>> +
>> +	return ret;
>> +}
> Same comments as for hisi_djtag_writel.

Ok.

> [...]
>
>> +static struct attribute *hisi_djtag_dev_attrs[] = {
>> +	NULL,
>> +	/* modalias helps coldplug:  modprobe $(cat .../modalias) */
>> +	&dev_attr_modalias.attr,
>> +	NULL
>> +};
> Why is the first entry NULL?

its a mistake. shall remove it.

> [...]
>
>> +static struct hisi_djtag_client *hisi_djtag_verify_client(struct device *dev)
>> +{
>> +	return (dev->type == &hisi_djtag_client_type)
>> +			? to_hisi_djtag_client(dev)
>> +			: NULL;
>> +}
> s/verify/get/
>
> Why would this be called for a device which is not a djtag client?

Yes. Djtag followed i2c bus. So this code came here. Thanks for pointing 
it. Shall remove it.

> [...]
>
>> +static int hisi_djtag_device_match(struct device *dev,
>> +				   struct device_driver *drv)
>> +{
>> +	struct hisi_djtag_client *client = hisi_djtag_verify_client(dev);
>> +
>> +	if (!client)
>> +		return false;
> Does this case ever happen?

Agreeed. only for djtag client this will be called. so shall remove it.

> [...]
>
>> +	snprintf(client->name, DJTAG_CLIENT_NAME_LEN, "%s%s_%d",
>> +		 DJTAG_PREFIX, device_name, client->id);
>> +	dev_set_name(&client->dev, "%s", client->name);
> This implies that hisi_djtag_client::name is redundant.
>
> Please get rid of it, and use the name of hisi_djtag_client::dev where
> necessary.

Agreed. hisi_djtag_client::name is not needed. shall use 
hisi_djtag_client::dev.

> [...]
>
>> +static void djtag_register_devices(struct hisi_djtag_host *host)
>> +{
>> +	struct device_node *node;
>> +
>> +	if (host->of_node) {
> This is always true since the driver only probes via DT.
>
> Please get rid of this check until it becomes necessary.

Ok. shall add it when adding ACPI support.

> [...]
>
>> +static int djtag_host_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct hisi_djtag_host *host;
>> +	struct resource *res;
>> +	int rc;
> s/rc/ret/ for consistency with other code in this directory.
>
> That applies to all instances in this patch.

Ok. I shall make it consistent.

> I'm aware the xgene PMU doesn't stick to that style, and that was a
> mistake.
>
>> +	host = kzalloc(sizeof(*host), GFP_KERNEL);
>> +	if (!host)
>> +		return -ENOMEM;
>> +
>> +	if (dev->of_node) {
> Likewise this should always be the case, since the driver only probes
> via DT.
>
> Please get rid of this check until it becomes necessary.

Ok. shall add it when adding ACPI support.


> [...]
>
>> +	if (!resource_size(res)) {
>> +		dev_err(dev, "Zero reg entry!\n");
>> +		rc = -EINVAL;
>> +		goto fail;
>> +	}
> ... but any non-zero size is fine?
>
> If you want to check the size, please check it meets your minimum
> requirement.

The resource size should be 0x10000. I shall add macro and a check for it.

Thanks,
Anurup

> Thanks,
> Mark.
