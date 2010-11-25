From: ben-i2c@fluff.org (Ben Dooks)
Date: Thu, 25 Nov 2010 23:59:33 +0000
Subject: [PATCH 3/7] i2c/pxa2xx: Add PCI support for PXA I2C controller
In-Reply-To: <1290633617-15311-4-git-send-email-bigeasy@linutronix.de>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>
	<1290633617-15311-4-git-send-email-bigeasy@linutronix.de>
Message-ID: <20101125235933.GD15948@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 10:20:13PM +0100, Sebastian Andrzej Siewior wrote:
> The Sodaville I2C controller is almost the same as found on PXA2xx. The
> difference:
> - the register are at a different spot
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
>  arch/x86/include/asm/pxa_i2c.h   |   24 ++++++
>  drivers/i2c/busses/Kconfig       |    7 +-
>  drivers/i2c/busses/Makefile      |    1 +
>  drivers/i2c/busses/i2c-pxa-pci.c |  160 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 190 insertions(+), 2 deletions(-)
>  create mode 100644 arch/x86/include/asm/pxa_i2c.h
>  create mode 100644 drivers/i2c/busses/i2c-pxa-pci.c
> 
> diff --git a/arch/x86/include/asm/pxa_i2c.h b/arch/x86/include/asm/pxa_i2c.h
> new file mode 100644
> index 0000000..9f73b3de
> --- /dev/null
> +++ b/arch/x86/include/asm/pxa_i2c.h
> @@ -0,0 +1,24 @@
> +#ifndef __ASM_PXA_I2C_H__
> +#define __ASM_PXA_I2C_H__
> +
> +/*
> + * I2C registers definitions
> + */
> +#define IBMR            (0x14)
> +#define IDBR            (0x0c)
> +#define ICR             (0x00)
> +#define ISR             (0x04)
> +
> +#define _IBMR(i2c)	((i2c)->reg_base + IBMR)
> +#define _IDBR(i2c)	((i2c)->reg_base + IDBR)
> +#define _ICR(i2c)	((i2c)->reg_base + ICR)
> +#define _ISR(i2c)	((i2c)->reg_base + ISR)

couldn't these be in common code?

> +struct clk;
> +
> +#define clk_get(dev, id)	NULL
> +#define clk_put(clk)		do { } while (0)
> +#define clk_disable(clk)	do { } while (0)
> +#define clk_enable(clk)		do { } while (0)
> +
> +#endif
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 3a6321c..76b5f15 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -525,15 +525,18 @@ config I2C_PNX
>  
>  config I2C_PXA
>  	tristate "Intel PXA2XX I2C adapter"
> -	depends on ARCH_PXA || ARCH_MMP
> +	depends on ARCH_PXA || ARCH_MMP || (X86 && PCI)
>  	help
>  	  If you have devices in the PXA I2C bus, say yes to this option.
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-pxa.
>  
> +config I2C_PXA_PCI
> +	def_bool I2C_PXA && X86 && PCI
> +
>  config I2C_PXA_SLAVE
>  	bool "Intel PXA2XX I2C Slave comms support"
> -	depends on I2C_PXA
> +	depends on I2C_PXA && !X86
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
> index 0000000..9ab7a36
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-pxa-pci.c
> @@ -0,0 +1,160 @@
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
> +	of_device_node_put(&sd->pdev.dev);
> +}
> +
> +static int add_i2c_device(struct pci_dev *dev, int bar,
> +		struct ce4100_i2c_device *sd)
> +{
> +	struct platform_device *pdev = &sd->pdev;
> +	struct i2c_pxa_platform_data *pdata = &sd->pdata;
> +
> +	pdev->name = "pxa2xx-i2c";
> +	pdev->dev.release = plat_dev_release;
> +	/*
> +	 * We assume one PCI bus here. devfn uses the lower 8 bits. To remain
> +	 * unique we encode the also bar
> +	 */
> +	pdev->id = dev->devfn << 3 | bar;
> +	pdev->dev.parent = &dev->dev;
> +#ifdef CONFIG_OF
> +	if (dev->dev.of_node) {
> +		struct device_node *child;
> +
> +		for_each_child_of_node(dev->dev.of_node, child) {
> +			const void *prop;
> +			u32 child_reg;
> +
> +			prop = of_get_property(child, "reg", NULL);
> +			if (!prop)
> +				continue;
> +			child_reg = be32_to_cpup(prop);
> +			if (child_reg == bar) {
> +				pdev->dev.of_node = child;
> +				break;
> +			}
> +		}
> +	}
> +#endif
> +	pdev->dev.platform_data = pdata;
> +	pdev->resource = sd->res;
> +
> +	sd->res[0].flags = IORESOURCE_MEM;
> +	sd->res[0].start = pci_resource_start(dev, bar);
> +	sd->res[0].end = pci_resource_end(dev, bar);
> +
> +	sd->res[1].flags = IORESOURCE_IRQ;
> +	sd->res[1].start = dev->irq;
> +	sd->res[1].end = dev->irq;
> +
> +	pdev->num_resources = 2;
> +
> +	return platform_device_register(pdev);
> +}
> +
> +static int __devinit ce4100_i2c_probe(struct pci_dev *dev,
> +		const struct pci_device_id *ent)
> +{
> +	int ret;
> +	int i;
> +	struct ce4100_devices *sds;
> +
> +	sds = kzalloc(sizeof(*sds), GFP_KERNEL);
> +	if (!sds)
> +		return -ENOMEM;
> +
> +	ret = pci_enable_device_mem(dev);
> +	if (ret)
> +		goto en_dev;
> +
> +	pci_set_drvdata(dev, sds);
> +
> +	for (i = 0; i < CE4100_PCI_I2C_DEVS; i++) {
> +		ret = add_i2c_device(dev, i, &sds->sd[i]);
> +		if (ret) {
> +			while (--i >= 0)
> +				platform_device_unregister(&sds->sd[i].pdev);
> +
> +			goto err_dev_add;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_dev_add:
> +	pci_set_drvdata(dev, NULL);
> +	pci_disable_device(dev);
> +en_dev:
> +	kfree(sds);
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
> +	for (i = 0; i < CE4100_PCI_I2C_DEVS; i++)
how about using ARRAY_SIZE of sds->sd[i] ?

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
> -- 
> 1.7.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
