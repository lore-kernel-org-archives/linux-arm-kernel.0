From: ben-i2c@fluff.org (Ben Dooks)
Date: Wed, 5 Jan 2011 20:21:36 +0000
Subject: [PATCH 3/6] i2c/pxa2xx: Add PCI support for PXA I2C controller
In-Reply-To: <1294246263-31960-4-git-send-email-bigeasy@linutronix.de>
References: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de>
	<1294246263-31960-4-git-send-email-bigeasy@linutronix.de>
Message-ID: <20110105202136.GI817@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 05:51:00PM +0100, Sebastian Andrzej Siewior wrote:
> The Sodaville I2C controller is almost the same as found on PXA2xx. The
> difference:
> - the register are at a different spot

maybe 'offset' is a better word than 'spot' here.

> - no slave support
> 
> The PCI probe code adds three platform devices which are probed then by
> the platform code.
> The X86 part also adds dummy clock defines because we don't have HW
> clock support.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
> ---
>  drivers/i2c/busses/Kconfig       |    7 +-
>  drivers/i2c/busses/Makefile      |    1 +
>  drivers/i2c/busses/i2c-pxa-pci.c |  173 ++++++++++++++++++++++++++++++++++++++
>  drivers/i2c/busses/i2c-pxa.c     |   27 +++++-
>  4 files changed, 203 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-pxa-pci.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 3a6321c..9ee3e60 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -525,15 +525,18 @@ config I2C_PNX
>  
>  config I2C_PXA
>  	tristate "Intel PXA2XX I2C adapter"
> -	depends on ARCH_PXA || ARCH_MMP
> +	depends on ARCH_PXA || ARCH_MMP || (X86_32 && PCI && OF)
>  	help
>  	  If you have devices in the PXA I2C bus, say yes to this option.
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-pxa.
>  
> +config I2C_PXA_PCI
> +	def_bool I2C_PXA && X86_32 && PCI && OF
> +
>  config I2C_PXA_SLAVE
>  	bool "Intel PXA2XX I2C Slave comms support"
> -	depends on I2C_PXA
> +	depends on I2C_PXA && !X86_32
>  	help
>  	  Support I2C slave mode communications on the PXA I2C bus.  This
>  	  is necessary for systems where the PXA may be a target on the
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 84cb16a..78db2e3 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_I2C_PCA_PLATFORM)	+= i2c-pca-platform.o
>  obj-$(CONFIG_I2C_PMCMSP)	+= i2c-pmcmsp.o
>  obj-$(CONFIG_I2C_PNX)		+= i2c-pnx.o
>  obj-$(CONFIG_I2C_PXA)		+= i2c-pxa.o
> +obj-$(CONFIG_I2C_PXA_PCI)	+= i2c-pxa-pci.o
>  obj-$(CONFIG_I2C_S3C2410)	+= i2c-s3c2410.o
>  obj-$(CONFIG_I2C_S6000)		+= i2c-s6000.o
>  obj-$(CONFIG_I2C_SH7760)	+= i2c-sh7760.o
> diff --git a/drivers/i2c/busses/i2c-pxa-pci.c b/drivers/i2c/busses/i2c-pxa-pci.c
> new file mode 100644
> index 0000000..f8709d3
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-pxa-pci.c
> @@ -0,0 +1,173 @@
> +/*
> + * The CE4100's I2C device is more or less the same one as found on PXA.
> + * It does not support slave mode, the register slightly moved. This PCI
> + * device provides three bars, every contains a single I2C controller.
> + */
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/i2c/pxa-i2c.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +
> +#define CE4100_PCI_I2C_DEVS	3
> +
> +struct ce4100_i2c_device {
> +	struct platform_device pdev;
> +	struct resource res[2];
> +	struct i2c_pxa_platform_data pdata;
> +};
> +
> +struct ce4100_devices {
> +	struct ce4100_i2c_device sd[CE4100_PCI_I2C_DEVS];
> +};
> +
> +static void plat_dev_release(struct device *dev)
> +{
> +	struct ce4100_i2c_device *sd = container_of(dev,
> +			struct ce4100_i2c_device, pdev.dev);
> +

maybe add a little to_ce_dev() and use it?

> +	of_device_node_put(&sd->pdev.dev);
> +}
> +static int add_i2c_device(struct pci_dev *dev, int bar,
> +		struct ce4100_i2c_device *sd)
> +{
> +	struct platform_device *pdev = &sd->pdev;
> +	struct i2c_pxa_platform_data *pdata = &sd->pdata;
> +	struct device_node *child;
> +	int found = 0;
> +	static int devnum;
> +
> +	pdev->name = "ce4100-i2c";
> +	pdev->dev.release = plat_dev_release;
> +	pdev->dev.parent = &dev->dev;
> +
> +	pdev->dev.platform_data = pdata;
> +	pdev->resource = sd->res;
> +
> +	sd->res[0].flags = IORESOURCE_MEM;
> +	sd->res[0].start = pci_resource_start(dev, bar);
> +	sd->res[0].end = pci_resource_end(dev, bar);

hmm, could you copy the original resource to this?

> +	sd->res[1].flags = IORESOURCE_IRQ;
> +	sd->res[1].start = dev->irq;
> +	sd->res[1].end = dev->irq;
> +	pdev->num_resources = 2;
> +
> +	for_each_child_of_node(dev->dev.of_node, child) {
> +		const void *prop;
> +		struct resource r;
> +		int ret;
> +
> +		ret = of_address_to_resource(child, 0, &r);
> +		if (ret < 0)
> +			continue;
> +		if (r.start != sd->res[0].start)
> +			continue;
> +		if (r.end != sd->res[0].end)
> +			continue;
> +		if (r.flags != sd->res[0].flags)
> +			continue;
> +
> +		pdev->dev.of_node = child;
> +		prop = of_get_property(child, "fast-mode", NULL);
> +		if (prop)
> +			pdata->fast_mode = 1;
> +
> +		pdev->id = devnum++;
> +		found = 1;
> +		break;
> +	}
> +
> +	if (found)
> +		return platform_device_register(pdev);
> +
> +	dev_err(&dev->dev, "Missing a DT node at %s for controller bar %d.\n",
> +			dev->dev.of_node->full_name, bar);

Hmm, do you really need to print dev->dev.of_node->full_name here, or is
it missing from the dev_err() print?

> +	dev_err(&dev->dev, "Its memory space is 0x%08x - 0x%08x.\n",
> +			sd->res[0].start, sd->res[0].end);

No need for Its in this message. Also, why not print IRQ number?

> +	return -EINVAL;
> +}
> +
> +static int __devinit ce4100_i2c_probe(struct pci_dev *dev,
> +		const struct pci_device_id *ent)
> +{
> +	int ret;
> +	int i;
> +	struct ce4100_devices *sds;
> +
> +	ret = pci_enable_device_mem(dev);
> +	if (ret)
> +		return ret;
> +
> +	if (!dev->dev.of_node) {
> +		dev_err(&dev->dev, "Missing device tree node.\n");
> +		return -EINVAL;
> +	}
> +	sds = kzalloc(sizeof(*sds), GFP_KERNEL);
> +	if (!sds)
> +		goto err_mem;
> +
> +	pci_set_drvdata(dev, sds);
> +
> +	for (i = 0; i < ARRAY_SIZE(sds->sd); i++) {
> +		ret = add_i2c_device(dev, i, &sds->sd[i]);
> +		if (ret) {
> +			while (--i >= 0)
> +				platform_device_unregister(&sds->sd[i].pdev);
> +			goto err_dev_add;
> +		}
> +	}
> +	return 0;
> +
> +err_dev_add:
> +	pci_set_drvdata(dev, NULL);
> +	kfree(sds);
> +err_mem:
> +	pci_disable_device(dev);
> +	return ret;
> +}
> +
> +static void __devexit ce4100_i2c_remove(struct pci_dev *dev)
> +{
> +	struct ce4100_devices *sds;
> +	unsigned int i;
> +
> +	sds = pci_get_drvdata(dev);
> +	pci_set_drvdata(dev, NULL);
> +
> +	for (i = 0; i < ARRAY_SIZE(sds->sd); i++)
> +		platform_device_unregister(&sds->sd[i].pdev);
> +
> +	pci_disable_device(dev);
> +	kfree(sds);
> +}
> +
> +static struct pci_device_id ce4100_i2c_devices[] __devinitdata = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2e68)},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(pci, ce4100_i2c_devices);
> +
> +static struct pci_driver ce4100_i2c_driver = {
> +	.name           = "ce4100_i2c",
> +	.id_table       = ce4100_i2c_devices,
> +	.probe          = ce4100_i2c_probe,
> +	.remove         = __devexit_p(ce4100_i2c_remove),
> +};
> +
> +static int __init ce4100_i2c_init(void)
> +{
> +	return pci_register_driver(&ce4100_i2c_driver);
> +}
> +module_init(ce4100_i2c_init);
> +
> +static void __exit ce4100_i2c_exit(void)
> +{
> +	pci_unregister_driver(&ce4100_i2c_driver);
> +}
> +module_exit(ce4100_i2c_exit);
> +
> +MODULE_DESCRIPTION("CE4100 PCI-I2C glue code for PXA's driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Sebastian Andrzej Siewior <bigeasy@linutronix.de>");

looks ok.

> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index fc2a90e..225e9a5 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -38,6 +38,13 @@
>  
>  #include <asm/irq.h>
>  
> +#ifdef CONFIG_X86
> +#define clk_get(dev, id)	NULL
> +#define clk_put(clk)		do { } while (0)
> +#define clk_disable(clk)	do { } while (0)
> +#define clk_enable(clk)		do { } while (0)
> +#endif
> +
>  struct pxa_reg_layout {
>  	u32 ibmr;
>  	u32 idbr;
> @@ -49,6 +56,7 @@ struct pxa_reg_layout {
>  enum pxa_i2c_types {
>  	REGS_PXA2XX,
>  	REGS_PXA3XX,
> +	REGS_CE4100,
>  };
>  
>  /*
> @@ -69,11 +77,19 @@ static struct pxa_reg_layout pxa_reg_layout[] = {
>  		.isr =	0x18,
>  		.isar =	0x20,
>  	},
> +	[REGS_CE4100] = {
> +		.ibmr =	0x14,
> +		.idbr =	0x0c,
> +		.icr =	0x00,
> +		.isr =	0x04,
> +		/* no isar register */
> +	},
>  };
>  
>  static const struct platform_device_id i2c_pxa_id_table[] = {
>  	{ "pxa2xx-i2c",		REGS_PXA2XX },
>  	{ "pxa3xx-pwri2c",	REGS_PXA3XX },
> +	{ "ce4100-i2c",		REGS_CE4100 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(platform, i2c_pxa_id_table);
> @@ -442,7 +458,8 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>  	writel(I2C_ISR_INIT, _ISR(i2c));
>  	writel(readl(_ICR(i2c)) & ~ICR_UR, _ICR(i2c));
>  
> -	writel(i2c->slave_addr, _ISAR(i2c));
> +	if (i2c->reg_isar)
> +		writel(i2c->slave_addr, _ISAR(i2c));
>  
>  	/* set control register values */
>  	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
> @@ -1074,7 +1091,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  	i2c->reg_idbr = i2c->reg_base + pxa_reg_layout[i2c_type].idbr;
>  	i2c->reg_icr = i2c->reg_base + pxa_reg_layout[i2c_type].icr;
>  	i2c->reg_isr = i2c->reg_base + pxa_reg_layout[i2c_type].isr;
> -	i2c->reg_isar = i2c->reg_base + pxa_reg_layout[i2c_type].isar;
> +	if (i2c_type != REGS_CE4100)
> +		i2c->reg_isar = i2c->reg_base + pxa_reg_layout[i2c_type].isar;

do you really need to bother to checking i2c_type here?

>  
>  	i2c->iobase = res->start;
>  	i2c->iosize = resource_size(res);
> @@ -1113,7 +1131,10 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  	i2c->adap.algo_data = i2c;
>  	i2c->adap.dev.parent = &dev->dev;
>  
> -	ret = i2c_add_numbered_adapter(&i2c->adap);
> +	if (i2c_type == REGS_CE4100)
> +		ret = i2c_add_adapter(&i2c->adap);
> +	else
> +		ret = i2c_add_numbered_adapter(&i2c->adap);
>  	if (ret < 0) {
>  		printk(KERN_INFO "I2C: Failed to add bus\n");
>  		goto eadapt;
> -- 
> 1.7.3.2


-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
