From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 5 Jan 2011 23:18:52 +0100
Subject: [PATCH 3/6] i2c/pxa2xx: Add PCI support for PXA I2C controller
In-Reply-To: <20110105202136.GI817@trinity.fluff.org>
References: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de>
	<1294246263-31960-4-git-send-email-bigeasy@linutronix.de>
	<20110105202136.GI817@trinity.fluff.org>
Message-ID: <20110105221852.GA16334@www.tglx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ben Dooks | 2011-01-05 20:21:36 [+0000]:

>On Wed, Jan 05, 2011 at 05:51:00PM +0100, Sebastian Andrzej Siewior wrote:
>> The Sodaville I2C controller is almost the same as found on PXA2xx. The
>> difference:
>> - the register are at a different spot
>
>maybe 'offset' is a better word than 'spot' here.
okay.

>> 
>> diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
>> new file mode 100644
>> index 0000000..f8709d3
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-pxa-pci.c
>> @@ -0,0 +1,173 @@
>> +/*
>> + * The CE4100's I2C device is more or less the same one as found on PXA.
>> + * It does not support slave mode, the register slightly moved. This PCI
>> + * device provides three bars, every contains a single I2C controller.
>> + */
>> +#include <linux/pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/i2c/pxa-i2c.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_address.h>
>> +
>> +#define CE4100_PCI_I2C_DEVS	3
>> +
>> +struct ce4100_i2c_device {
>> +	struct platform_device pdev;
>> +	struct resource res[2];
>> +	struct i2c_pxa_platform_data pdata;
>> +};
>> +
>> +struct ce4100_devices {
>> +	struct ce4100_i2c_device sd[CE4100_PCI_I2C_DEVS];
>> +};
>> +
>> +static void plat_dev_release(struct device *dev)
>> +{
>> +	struct ce4100_i2c_device *sd = container_of(dev,
>> +			struct ce4100_i2c_device, pdev.dev);
>> +
>
>maybe add a little to_ce_dev() and use it?
Well okay but it will be used only once.

>> +	of_device_node_put(&sd->pdev.dev);
>> +}
>> +static int add_i2c_device(struct pci_dev *dev, int bar,
>> +		struct ce4100_i2c_device *sd)
>> +{
>> +	struct platform_device *pdev = &sd->pdev;
>> +	struct i2c_pxa_platform_data *pdata = &sd->pdata;
>> +	struct device_node *child;
>> +	int found = 0;
>> +	static int devnum;
>> +
>> +	pdev->name = "ce4100-i2c";
>> +	pdev->dev.release = plat_dev_release;
>> +	pdev->dev.parent = &dev->dev;
>> +
>> +	pdev->dev.platform_data = pdata;
>> +	pdev->resource = sd->res;
>> +
>> +	sd->res[0].flags = IORESOURCE_MEM;
>> +	sd->res[0].start = pci_resource_start(dev, bar);
>> +	sd->res[0].end = pci_resource_end(dev, bar);
>
>hmm, could you copy the original resource to this?
something like
    sd->res = &dev->resource[bar]

? This would work for res[0] but what about[1]? They have to be an array
don't they?

>> +	sd->res[1].flags = IORESOURCE_IRQ;
>> +	sd->res[1].start = dev->irq;
>> +	sd->res[1].end = dev->irq;
>> +	pdev->num_resources = 2;
>> +
>> +	for_each_child_of_node(dev->dev.of_node, child) {
>> +		const void *prop;
>> +		struct resource r;
>> +		int ret;
>> +
>> +		ret = of_address_to_resource(child, 0, &r);
>> +		if (ret < 0)
>> +			continue;
>> +		if (r.start != sd->res[0].start)
>> +			continue;
>> +		if (r.end != sd->res[0].end)
>> +			continue;
>> +		if (r.flags != sd->res[0].flags)
>> +			continue;
>> +
>> +		pdev->dev.of_node = child;
>> +		prop = of_get_property(child, "fast-mode", NULL);
>> +		if (prop)
>> +			pdata->fast_mode = 1;
>> +
>> +		pdev->id = devnum++;
>> +		found = 1;
>> +		break;
>> +	}
>> +
>> +	if (found)
>> +		return platform_device_register(pdev);
>> +
>> +	dev_err(&dev->dev, "Missing a DT node at %s for controller bar %d.\n",
>> +			dev->dev.of_node->full_name, bar);
>
>Hmm, do you really need to print dev->dev.of_node->full_name here, or is
>it missing from the dev_err() print?
dev_err shows the pci addreess while of_node->full_name is something
like /soc at 0/pci at 3fc/pci at av/i2c-controller at 15a00,0,0. And this node is
missing a child node or its address is wrong somewhere and the
translation went wrong and therefore there is no match. I just tried to
be accurate here.

>> +	dev_err(&dev->dev, "Its memory space is 0x%08x - 0x%08x.\n",
>> +			sd->res[0].start, sd->res[0].end);
>
>No need for Its in this message. Also, why not print IRQ number?

Okay. I don't think that the interrupt number is important here. I print
the physical memory address so the user can look it up in his device
tree. On the other hand I could be brief here and just mention the bar
number and the user would use lspci to lookup the memory address.

>> +	return -EINVAL;
>> +}
>
>> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
>> index fc2a90e..225e9a5 100644
>> --- a/drivers/i2c/busses/i2c-pxa.c
>> +++ b/drivers/i2c/busses/i2c-pxa.c
>> @@ -69,11 +77,19 @@ static struct pxa_reg_layout pxa_reg_layout[] = {
>>  		.isr =	0x18,
>>  		.isar =	0x20,
>>  	},
>> +	[REGS_CE4100] = {
>> +		.ibmr =	0x14,
>> +		.idbr =	0x0c,
>> +		.icr =	0x00,
>> +		.isr =	0x04,
>> +		/* no isar register */
>> +	},
>>  };
>>  
>>  static const struct platform_device_id i2c_pxa_id_table[] = {
>>  	{ "pxa2xx-i2c",		REGS_PXA2XX },
>>  	{ "pxa3xx-pwri2c",	REGS_PXA3XX },
>> +	{ "ce4100-i2c",		REGS_CE4100 },
>>  	{ },
>>  };
>>  MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
>> @@ -442,7 +458,8 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>>  	writel(I2C_ISR_INIT, _ISR(i2c));
>>  	writel(readl(_ICR(i2c)) & ~ICR_UR, _ICR(i2c));
>>  
>> -	writel(i2c->slave_addr, _ISAR(i2c));
>> +	if (i2c->reg_isar)
>> +		writel(i2c->slave_addr, _ISAR(i2c));
>>  
>>  	/* set control register values */
>>  	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
>> @@ -1074,7 +1091,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
>>  	i2c->reg_idbr = i2c->reg_base + pxa_reg_layout[i2c_type].idbr;
>>  	i2c->reg_icr = i2c->reg_base + pxa_reg_layout[i2c_type].icr;
>>  	i2c->reg_isr = i2c->reg_base + pxa_reg_layout[i2c_type].isr;
>> -	i2c->reg_isar = i2c->reg_base + pxa_reg_layout[i2c_type].isar;
>> +	if (i2c_type != REGS_CE4100)
>> +		i2c->reg_isar = i2c->reg_base + pxa_reg_layout[i2c_type].isar;
>
>do you really need to bother to checking i2c_type here?
What would you prefer? I don't want to assign anything to ->reg_isar on
REGS_CE4100 so the NULL pointer can catch any accidental writes / reads.
And in i2c_pxa_reset() I'm going to skip writes to it.

Sebastian
