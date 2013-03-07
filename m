From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 7 Mar 2013 17:50:16 +0100
Subject: [PATCH 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <1362660865-2755-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1362660865-2755-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130307175016.1dad1405@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Thu,  7 Mar 2013 09:54:21 -0300, Ezequiel Garcia wrote:

> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 067f311..f246f7e 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -40,4 +40,15 @@ config TEGRA30_MC
>  	  analysis, especially for IOMMU/SMMU(System Memory Management
>  	  Unit) module.
>  
> +config MVEBU_DEVBUS
> +	tristate "Marvell EBU Device Bus Controller"
> +	default y
> +	depends on PLAT_ORION && OF
> +	help
> +	  This driver is for the Device Bus controller available in some
> +	  Marvell EBU SoCs such as Discovery (mv78xx0), Orion (88f5xxx) and
> +	  Armada 370 and Armada XP. This controller allows to handle flash
> +	  devices such as NOR, NAND, SRAM, and FPGA.
> +
> +

Entries should be sorted alphabetically (MVEBU_DEVBUS is before
TEGRA30_MC).

>  endif
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index 9cce5d7..156c264 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -8,3 +8,4 @@ endif
>  obj-$(CONFIG_TI_EMIF)		+= emif.o
>  obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
>  obj-$(CONFIG_TEGRA30_MC)	+= tegra30-mc.o
> +obj-$(CONFIG_MVEBU_DEVBUS)	+= mvebu-devbus.o

Same comment.

> +static inline void
> +devbus_get_read_params(int cs, struct devbus_read_params *r)

I don't think it's necessary to mark such functions as "inline". Just
let gcc do whatever it thinks is necessary in terms of inlining.

> +static int devbus_probe_nor_child(struct platform_device *pdev,
> +				 struct device_node *node)
> +{
> +	struct platform_device *child;
> +	struct device *dev = &pdev->dev;
> +	struct resource mem_res;
> +	struct devbus_read_params read_params;
> +	struct devbus_write_params write_params;
> +	int err;
> +	int bank_width;
> +	u32 cs;
> +
> +	/* Read chip select and size */
> +	if (of_property_read_u32(node, "reg", &cs) < 0) {
> +		dev_err(dev, "%s has no 'reg' property\n", node->full_name);
> +		return -ENODEV;
> +	}
> +
> +	if (of_address_to_resource(node, 0, &mem_res)) {
> +		dev_err(dev, "%s has malformed 'reg' property\n",
> +			node->full_name);
> +		return -ENODEV;
> +	}
> +
> +	err = of_property_read_u32(node, "bank-width", &bank_width);
> +	if (err) {
> +		dev_err(dev, "error %d reading bank-width property\n", err);
> +		return err;
> +	}
> +
> +	/*
> +	 * Allocate an address window for this device.
> +	 * If the device probing fails, then we won't be able to
> +	 * remove the allocated address decoding window.
> +	 */
> +	err = mvebu_mbus_add_window(devbus_wins[cs], mem_res.start,
> +				    resource_size(&mem_res));
> +	if (err < 0)
> +		return -EBUSY;

Why not return 'err' here?

> +	/*
> +	 * First we read current parameter value, in order to have
> +	 * a default value for each parameter in case it's not defined
> +	 * by the device tree file.
> +	 */
> +	devbus_get_read_params(cs, &read_params);
> +	devbus_get_write_params(cs, &write_params);
> +
> +	/* Read the device tree child node and set the new parameters */
> +	devbus_get_params_dt(node, &read_params, &write_params);
> +	devbus_set_read_params(dev, cs, &read_params);
> +	devbus_set_write_params(dev, cs, &write_params);
> +
> +	/*
> +	 * If we manage to set 'simple-bus' compatible string
> +	 * to device-bus node, then we don't really need this.
> +	 */
> +	child = of_platform_device_create(node, NULL, &pdev->dev);
> +	if (!child) {
> +		dev_warn(dev, "cannot create child device %s\n", node->name);
> +		/* Remove the allocated window */
> +		mvebu_mbus_del_window(mem_res.start, resource_size(&mem_res));
> +	}
> +
> +	return 0;
> +}
> +
> +static int mvebu_devbus_probe(struct platform_device *pdev)
> +{
> +	struct device_node *child;
> +	struct resource *res;
> +	int err;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	devbus_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(devbus_base))
> +		return PTR_ERR(devbus_base);
> +
> +	/*
> +	 * We probe NOR/NAND with different functions, because
> +	 * we expect them to have some different parameters.
> +	 * If this turns out not to be the case, we'll be able
> +	 * to use any name for the child, and rename to devbus_probe_child().
> +	 */
> +	for_each_node_by_name(child, "nor") {
> +		err = devbus_probe_nor_child(pdev, child);
> +		if (err < 0) {
> +			of_node_put(child);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mvebu_devbus_of_match[] = {
> +	{ .compatible = "marvell,armada370-devbus"	 },
> +	{ .compatible = "marvell,armadaxp-devbus"	 },
> +	{ .compatible = "marvell,mv78xx0-devbus"	 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mvebu_devbus_of_match);
> +
> +static struct platform_driver mvebu_devbus_driver = {
> +	.probe		= mvebu_devbus_probe,
> +	.remove		= NULL, /* Thanks to managed functions! */

Are you sure this is true? In your ->probe() function, you're creating
address decoding windows, and instantiating devices. If mvebu-mbus is
compiled as a module, we want all the child devices to disappear, no?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
