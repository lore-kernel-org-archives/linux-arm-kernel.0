From: anurupvasu@gmail.com (Anurup M)
Date: Tue, 15 Nov 2016 15:45:27 +0530
Subject: [RESEND PATCH v1 03/11] drivers: soc: hisi: Add support for
 Hisilicon Djtag driver
In-Reply-To: <20161110175510.GB10137@leverpostej>
References: <1478151727-20250-1-git-send-email-anurup.m@huawei.com>
 <1478151727-20250-4-git-send-email-anurup.m@huawei.com>
 <20161110175510.GB10137@leverpostej>
Message-ID: <582AE03F.5070402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 10 November 2016 11:25 PM, Mark Rutland wrote:
> On Thu, Nov 03, 2016 at 01:41:59AM -0400, Anurup M wrote:
>> From: Tan Xiaojun <tanxiaojun@huawei.com>
>>
>> 	The Hisilicon Djtag is an independent component which connects
>> 	with some other components in the SoC by Debug Bus. This driver
>> 	can be configured to access the registers of connecting components
>> 	(like L3 cache) during real time debugging.
>>
> Just to check, is this likely to be used in multi-socket hardware, and
> if so, are instances always-on?
Yes, It could be used in multi-socket hardware also.
The sockets are always enabled  after bootup. Sorry I didn't get the
>> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> Signed-off-by: Anurup M <anurup.m@huawei.com>
>> ---
>>   drivers/soc/Kconfig                 |   1 +
>>   drivers/soc/Makefile                |   1 +
>>   drivers/soc/hisilicon/Kconfig       |  12 +
>>   drivers/soc/hisilicon/Makefile      |   1 +
>>   drivers/soc/hisilicon/djtag.c       | 639 ++++++++++++++++++++++++++++++++++++
>>   include/linux/soc/hisilicon/djtag.h |  38 +++
>>   6 files changed, 692 insertions(+)
>>   create mode 100644 drivers/soc/hisilicon/Kconfig
>>   create mode 100644 drivers/soc/hisilicon/Makefile
>>   create mode 100644 drivers/soc/hisilicon/djtag.c
>>   create mode 100644 include/linux/soc/hisilicon/djtag.h
> Other than the PMU driver(s), what is going to use this?
>
> If you don't have something in particular, please also place this under
> drivers/perf/hisilicon, along with the PMU driver(s).
>
> We can always move it later if necessary.
>
> [...]
Arnd also suggested the same. Currently as there are no other users I 
shall move it to
drivers/perf/hisilicon.
>> +#define SC_DJTAG_TIMEOUT		100000	/* 100ms */
> This would be better as:
>
> #define SC_DJTAG_TIMEOUT_US	(100 * USEC_PER_MSEC)
>
> (you'll need to include <linux/time64.h>)
>
> [...]
OK.
>> +static void djtag_read32_relaxed(void __iomem *regs_base, u32 off, u32 *value)
>> +{
>> +	void __iomem *reg_addr = regs_base + off;
>> +
>> +	*value = readl_relaxed(reg_addr);
>> +}
>> +
>> +static void djtag_write32(void __iomem *regs_base, u32 off, u32 val)
>> +{
>> +	void __iomem *reg_addr = regs_base + off;
>> +
>> +	writel(val, reg_addr);
>> +}
> I think these make the driver harder to read, especially given the read
> function is void and takes an output pointer.
>
> In either case you can call readl/writel directly with base + off for
> the __iomem ptr. Please do that.
Ok.
>> +
>> +/*
>> + * djtag_readwrite_v1/v2: djtag read/write interface
>> + * @reg_base:	djtag register base address
>> + * @offset:	register's offset
>> + * @mod_sel:	module selection
>> + * @mod_mask:	mask to select specific modules for write
>> + * @is_w:	write -> true, read -> false
>> + * @wval:	value to register for write
>> + * @chain_id:	which sub module for read
>> + * @rval:	value in register for read
>> + *
>> + * Return non-zero if error, else return 0.
>> + */
>> +static int djtag_readwrite_v1(void __iomem *regs_base, u32 offset, u32 mod_sel,
>> +		u32 mod_mask, bool is_w, u32 wval, int chain_id, u32 *rval)
>> +{
>> +	u32 rd;
>> +	int timeout = SC_DJTAG_TIMEOUT;
>> +
>> +	if (!(mod_mask & CHAIN_UNIT_CFG_EN)) {
>> +		pr_warn("djtag: do nothing.\n");
>> +		return 0;
>> +	}
>> +
>> +	/* djtag mster enable & accelerate R,W */
>> +	djtag_write32(regs_base, SC_DJTAG_MSTR_EN,
>> +			DJTAG_NOR_CFG | DJTAG_MSTR_EN);
>> +
>> +	/* select module */
>> +	djtag_write32(regs_base, SC_DJTAG_DEBUG_MODULE_SEL, mod_sel);
>> +	djtag_write32(regs_base, SC_DJTAG_CHAIN_UNIT_CFG_EN,
>> +				mod_mask & CHAIN_UNIT_CFG_EN);
>> +
>> +	if (is_w) {
>> +		djtag_write32(regs_base, SC_DJTAG_MSTR_WR, DJTAG_MSTR_W);
>> +		djtag_write32(regs_base, SC_DJTAG_MSTR_DATA, wval);
>> +	} else
>> +		djtag_write32(regs_base, SC_DJTAG_MSTR_WR, DJTAG_MSTR_R);
>> +
>> +	/* address offset */
>> +	djtag_write32(regs_base, SC_DJTAG_MSTR_ADDR, offset);
>> +
>> +	/* start to write to djtag register */
>> +	djtag_write32(regs_base, SC_DJTAG_MSTR_START_EN, DJTAG_MSTR_START_EN);
>> +
>> +	/* ensure the djtag operation is done */
>> +	do {
>> +		djtag_read32_relaxed(regs_base, SC_DJTAG_MSTR_START_EN, &rd);
>> +		if (!(rd & DJTAG_MSTR_EN))
>> +			break;
>> +
>> +		udelay(1);
>> +	} while (timeout--);
>> +
>> +	if (timeout < 0) {
>> +		pr_err("djtag: %s timeout!\n", is_w ? "write" : "read");
>> +		return -EBUSY;
>> +	}
>> +
>> +	if (!is_w)
>> +		djtag_read32_relaxed(regs_base,
>> +			SC_DJTAG_RD_DATA_BASE + chain_id * 0x4, rval);
>> +
>> +	return 0;
>> +}
> Please factor out the common bits into helpers and have separate
> read/write functions. It's incredibly difficult to follow the code with
> read/write hidden behind a boolean parameter.
Ok. Shall change it.
>> +static const struct of_device_id djtag_of_match[] = {
>> +	/* for hip05(D02) cpu die */
>> +	{ .compatible = "hisilicon,hip05-cpu-djtag-v1",
>> +		.data = (void *)djtag_readwrite_v1 },
>> +	/* for hip05(D02) io die */
>> +	{ .compatible = "hisilicon,hip05-io-djtag-v1",
>> +		.data = (void *)djtag_readwrite_v1 },
>> +	/* for hip06(D03) cpu die */
>> +	{ .compatible = "hisilicon,hip06-cpu-djtag-v1",
>> +		.data = (void *)djtag_readwrite_v1 },
>> +	/* for hip06(D03) io die */
>> +	{ .compatible = "hisilicon,hip06-io-djtag-v2",
>> +		.data = (void *)djtag_readwrite_v2 },
>> +	/* for hip07(D05) cpu die */
>> +	{ .compatible = "hisilicon,hip07-cpu-djtag-v2",
>> +		.data = (void *)djtag_readwrite_v2 },
>> +	/* for hip07(D05) io die */
>> +	{ .compatible = "hisilicon,hip07-io-djtag-v2",
>> +		.data = (void *)djtag_readwrite_v2 },
>> +	{},
>> +};
> Binding documentation for all of these should be added *before* this
> patch, per Documentation/devicetree/bindings/submitting-patches.txt.
> Please move any relevant binding documentation earlier in the series.
The binding documentation added in "[RESEND PATCH v1 02/11] dt-bindings: 
hisi: Add Hisilicon HiP05/06/07 Sysctrl and Djtag dts bindings]".

>> +MODULE_DEVICE_TABLE(of, djtag_of_match);
>> +
>> +static ssize_t
>> +show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct hisi_djtag_client *client = to_hisi_djtag_client(dev);
>> +
>> +	return sprintf(buf, "%s%s\n", MODULE_PREFIX, client->name);
>> +}
>> +static DEVICE_ATTR(modalias, 0444, show_modalias, NULL);
>> +
>> +static struct attribute *hisi_djtag_dev_attrs[] = {
>> +	NULL,
>> +	/* modalias helps coldplug:  modprobe $(cat .../modalias) */
>> +	&dev_attr_modalias.attr,
>> +	NULL
>> +};
>> +ATTRIBUTE_GROUPS(hisi_djtag_dev);
> Why do we need to expose this under sysfs?
This is to know the djtag clients registered with the bus.
>> +struct bus_type hisi_djtag_bus = {
>> +	.name		= "hisi-djtag",
>> +	.match		= hisi_djtag_device_match,
>> +	.probe		= hisi_djtag_device_probe,
>> +	.remove		= hisi_djtag_device_remove,
>> +};
> I take it the core bus code handles reference-counting users of the bus?
The bus_register registers with kobject. Did It answer the question?
>> +struct hisi_djtag_client *hisi_djtag_new_device(struct hisi_djtag_host *host,
>> +						struct device_node *node)
>> +{
>> +	struct hisi_djtag_client *client;
>> +	int status;
>> +
>> +	client = kzalloc(sizeof(*client), GFP_KERNEL);
>> +	if (!client)
>> +		return NULL;
>> +
>> +	client->host = host;
>> +
>> +	client->dev.parent = &client->host->dev;
>> +	client->dev.bus = &hisi_djtag_bus;
>> +	client->dev.type = &hisi_djtag_client_type;
>> +	client->dev.of_node = node;
> I suspect that we should do:
>
> 	client->dev.of_node = of_node_get(node);
>
> ... so that it's guaranteed we retain a reference.
Ok.
>> +	snprintf(client->name, DJTAG_CLIENT_NAME_LEN, "%s%s",
>> +					DJTAG_PREFIX, node->name);
>> +	dev_set_name(&client->dev, "%s", client->name);
>> +
>> +	status = device_register(&client->dev);
>> +	if (status < 0) {
>> +		pr_err("error adding new device, status=%d\n", status);
>> +		kfree(client);
>> +		return NULL;
>> +	}
>> +
>> +	return client;
>> +}
>> +
>> +static struct hisi_djtag_client *hisi_djtag_of_register_device(
>> +						struct hisi_djtag_host *host,
>> +						struct device_node *node)
>> +{
>> +	struct hisi_djtag_client *client;
>> +
>> +	client = hisi_djtag_new_device(host, node);
>> +	if (client == NULL) {
>> +		dev_err(&host->dev, "error registering device %s\n",
>> +			node->full_name);
>> +		of_node_put(node);
> I don't think this should be here, given what djtag_register_devices()
> does.
Will move this to djtag_register_devices.
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	return client;
>> +}
>> +
>> +static void djtag_register_devices(struct hisi_djtag_host *host)
>> +{
>> +	struct device_node *node;
>> +	struct hisi_djtag_client *client;
>> +
>> +	if (!host->of_node)
>> +		return;
>> +
>> +	for_each_available_child_of_node(host->of_node, node) {
>> +		if (of_node_test_and_set_flag(node, OF_POPULATED))
>> +			continue;
>> +		client = hisi_djtag_of_register_device(host, node);
>> +		list_add(&client->next, &host->client_list);
>> +	}
>> +}
> Given hisi_djtag_of_register_device() can return ERR_PTR(-EINVAL), the
> list_add is not safe.
Shall add the check and handle accordingly.
>> +static int djtag_host_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct hisi_djtag_host *host;
>> +	const struct of_device_id *of_id;
>> +	struct resource *res;
>> +	int rc;
>> +
>> +	of_id = of_match_device(djtag_of_match, dev);
>> +	if (!of_id)
>> +		return -EINVAL;
>> +
>> +	host = kzalloc(sizeof(*host), GFP_KERNEL);
>> +	if (!host)
>> +		return -ENOMEM;
>> +
>> +	host->of_node = dev->of_node;
> 	host->of_node = of_node_get(dev->of_node);
>
>> +	host->djtag_readwrite = of_id->data;
>> +	spin_lock_init(&host->lock);
>> +
>> +	INIT_LIST_HEAD(&host->client_list);
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "No reg resorces!\n");
>> +		kfree(host);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!resource_size(res)) {
>> +		dev_err(&pdev->dev, "Zero reg entry!\n");
>> +		kfree(host);
>> +		return -EINVAL;
>> +	}
>> +
>> +	host->sysctl_reg_map = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(host->sysctl_reg_map)) {
>> +		dev_warn(dev, "Unable to map sysctl registers.\n");
>> +		kfree(host);
>> +		return -EINVAL;
>> +	}
> Please have a common error path rather than duplicating this free.
>
> e.g. at the end of the function have:
>
> 	err_free:
> 		kfree(host);
> 		return err;
>
> ... and in cases like this, have:
>
> 	if (whatever()) {
> 		dev_warn(dev, "this failed xxx\n");
> 		err = -EINVAL;
> 		goto err_free;
> 	}
Ok. thanks. will change it.

Thanks,
Anurup
> Thanks,
> Mark.
