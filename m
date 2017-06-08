From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 8 Jun 2017 17:35:19 +0100
Subject: [PATCH v8 6/9] drivers: perf: hisi: Add support for Hisilicon
 Djtag driver
In-Reply-To: <1495457312-237127-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1495457312-237127-1-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <20170608163519.GA19643@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 22, 2017 at 08:48:32PM +0800, Shaokun Zhang wrote:
> +/*
> + * hisi_djtag_lock_v2: djtag lock to avoid djtag access conflict b/w kernel
> + * and UEFI.

The mention of UEFI here worries me somewhat, and I have a number of
questions specifically relating to how we interact with UEFI here.

When precisely does UEFI need to touch the djtag hardware? e.g. does
this happen in runtime services? ... or completely asynchronously?

What does UEFI do with djtag when it holds the lock?

Are there other software agents (e.g. secure firmware) which try to
take this lock?

Can you explain how the locking scheme works? e.g. is this an advisory
software-only policy, or does the hardware prohibit accesses from other
agents somehow?

What happens if the kernel takes the lock, but doesn't release it?

What happens if UEFI takes the lock, but doesn't release it?

Are there any points at which UEFI needs to hold the locks of several
djtag units simultaneously?

> + * @reg_base:	djtag register base address
> + *
> + * Return - none.
> + */
> +static void hisi_djtag_lock_v2(void __iomem *regs_base)
> +{
> +	u32 rd, wr, mod_sel;
> +
> +	/* Continuously poll to ensure the djtag is free */
> +	while (1) {
> +		rd = readl(regs_base + SC_DJTAG_MSTR_CFG_EX);
> +		mod_sel = ((rd >> DEBUG_MODULE_SEL_SHIFT_EX) & 0xFF);
> +		if (mod_sel == SC_DJTAG_V2_UNLOCK) {
> +			wr = ((rd & SC_DJTAG_V2_MODULE_SEL_MASK) |
> +			      (SC_DJTAG_V2_KERNEL_LOCK <<
> +			       DEBUG_MODULE_SEL_SHIFT_EX));
> +			writel(wr, regs_base + SC_DJTAG_MSTR_CFG_EX);
> +			udelay(10); /* 10us */
> +
> +			rd = readl(regs_base + SC_DJTAG_MSTR_CFG_EX);
> +			mod_sel = ((rd >> DEBUG_MODULE_SEL_SHIFT_EX) & 0xFF);
> +			if (mod_sel == SC_DJTAG_V2_KERNEL_LOCK)
> +				break;
> +		}
> +		udelay(10); /* 10us */
> +	}
> +}
> +
> +/*
> + * hisi_djtag_unlock_v2: djtag unlock
> + * @reg_base:	djtag register base address
> + *
> + * Return - none.
> + */
> +static void hisi_djtag_unlock_v2(void __iomem *regs_base)
> +{
> +	u32 rd, wr;
> +
> +	rd = readl(regs_base + SC_DJTAG_MSTR_CFG_EX);
> +
> +	wr = ((rd & SC_DJTAG_V2_MODULE_SEL_MASK) |
> +	      (SC_DJTAG_V2_UNLOCK << DEBUG_MODULE_SEL_SHIFT_EX));
> +	/*
> +	 * Release djtag module by writing to module
> +	 * selection bits of DJTAG_MSTR_CFG register
> +	 */
> +	writel(wr, regs_base + SC_DJTAG_MSTR_CFG_EX);
> +}

[...]

> +static void hisi_djtag_prepare_v2(void __iomem *regs_base, u32 offset,
> +				  u32 mod_sel, u32 mod_mask)
> +{
> +	/* djtag mster enable */

s/mster/master/ ?

[...]

> +static ssize_t show_modalias(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	struct hisi_djtag_client *client = to_hisi_djtag_client(dev);
> +
> +	return sprintf(buf, "%s%s\n", MODULE_PREFIX, dev_name(&client->dev));
> +}
> +static DEVICE_ATTR(modalias, 0444, show_modalias, NULL);
> +
> +static struct attribute *hisi_djtag_dev_attrs[] = {
> +	/* modalias helps coldplug:  modprobe $(cat .../modalias) */
> +	&dev_attr_modalias.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(hisi_djtag_dev);
> +
> +static struct device_type hisi_djtag_client_type = {
> +	.groups	= hisi_djtag_dev_groups,
> +};

Can you elaborate on what this sysfs stuff is for?

> +static int hisi_djtag_device_match(struct device *dev,
> +				   struct device_driver *drv)
> +{
> +	/* Attempt an OF style match */
> +	if (of_driver_match_device(dev, drv))
> +		return true;
> +
> +#ifdef CONFIG_ACPI
> +	if (acpi_driver_match_device(dev, drv))
> +		return true;
> +#endif

You can drop the ifdef here. When CONFIG_ACPI is not selected,
acpi_driver_match_device() is a static inline that always returns false.

> +	return false;
> +}

[...]

> +static int hisi_djtag_set_client_name(struct hisi_djtag_client *client,
> +				      const char *device_name)
> +{
> +	char name[DJTAG_CLIENT_NAME_LEN];
> +	int id;
> +
> +	id = hisi_djtag_get_client_id(client);
> +	if (id < 0)
> +		return id;
> +
> +	client->id = id;
> +	snprintf(name, DJTAG_CLIENT_NAME_LEN, "%s%s_%d", DJTAG_PREFIX,
> +		 device_name, client->id);
> +	dev_set_name(&client->dev, "%s", name);
> +
> +	return 0;
> +}

Given dev_set_name() takes a fmt string, you don't need the temporary
name here, and can have dev_set_name() handle that directly, e.g.

	err = dev_set_name(&client->dev, %s%s_%d",
  			   DJTAG_PREFIX, device_name, client->id);
	if (err)
		return err;


Given DJTAG_PREFIX is only used here, it would be better to fold it into
the format string, also.

> +
> +static int hisi_djtag_new_of_device(struct hisi_djtag_host *host,
> +				    struct device_node *node)
> +{
> +	struct hisi_djtag_client *client;
> +	int ret;
> +
> +	client = hisi_djtag_client_alloc(host);
> +	if (!client) {
> +		dev_err(&host->dev, "DT: Client alloc fail!\n");
> +		return -ENOMEM;
> +	}
> +
> +	client->dev.of_node = of_node_get(node);
> +
> +	ret = hisi_djtag_set_client_name(client, node->name);

I don't think it's a good idea to take the name directly from the DT.

Can we please use a standard name, looked up based on the compatible
string? Then we can also use the same names for ACPI. Where there are
multiple instances, we can use the module-id too.

[...]

> +static void djtag_register_devices(struct hisi_djtag_host *host)
> +{
> +	struct device_node *node;
> +
> +	if (host->of_node) {
> +		for_each_available_child_of_node(host->of_node, node) {
> +			if (of_node_test_and_set_flag(node, OF_POPULATED))
> +				continue;
> +			if (hisi_djtag_new_of_device(host, node))
> +				break;

Why do we stop, rather than rolling back and freeing what we allocated?

Either that, or we should return an error code, such that a higher level
can choose to do so.

> +		}
> +	} else if (host->acpi_handle) {
> +		acpi_handle handle = host->acpi_handle;
> +		acpi_status status;
> +
> +		status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +					     djtag_add_new_acpi_device, NULL,
> +					     host, NULL);
> +		if (ACPI_FAILURE(status)) {
> +			dev_err(&host->dev,
> +				"ACPI: Fail to read client devices!\n");
> +			return;

Likewise, why aren't we rolling back?

[...]

> +#define DJTAG_CLIENT_NAME_LEN 32

I beleive this can go.

Thanks,
Mark.
