From: daniel@makrotopia.org (Daniel Golle)
Date: Tue, 18 Oct 2016 13:08:07 +0200
Subject: [RFC PATCH] mtd: nand: Add OX820 NAND Support
In-Reply-To: <20161018090927.1990-1-narmstrong@baylibre.com>
References: <20161018090927.1990-1-narmstrong@baylibre.com>
Message-ID: <20161018110807.GD1641@makrotopia.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

great to see progress towards supporting OX820!
The NAND driver I hacked up for Kernel 4.1 and 4.4 in OpenWrt/LEDE
looks very similar, see

https://git.lede-project.org/?p=lede/dangole/staging.git;a=blob;f=target/linux/oxnas/files/drivers/mtd/nand/oxnas_nand.c;h=f5a142950e32227fee304de731e619278350a91b;hb=refs/heads/oxnas-nand

To me therefore this looks quite good, just one small question below.

Cheers

Daniel


On Tue, Oct 18, 2016 at 11:09:27AM +0200, Neil Armstrong wrote:
> Add NAND driver to support the Oxford Semiconductor OX820 NAND Controller.
> This is a simple memory mapped NAND controller with single chip select and
> software ECC.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/mtd/oxnas-nand.txt         |  24 ++++
>  drivers/mtd/nand/Kconfig                           |   5 +
>  drivers/mtd/nand/Makefile                          |   1 +
>  drivers/mtd/nand/oxnas_nand.c                      | 144 +++++++++++++++++++++
>  4 files changed, 174 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/oxnas-nand.txt
>  create mode 100644 drivers/mtd/nand/oxnas_nand.c
> 
> diff --git a/Documentation/devicetree/bindings/mtd/oxnas-nand.txt b/Documentation/devicetree/bindings/mtd/oxnas-nand.txt
> new file mode 100644
> index 0000000..83b684d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/oxnas-nand.txt
> @@ -0,0 +1,24 @@
> +* Oxford Semiconductor OXNAS NAND Controller
> +
> +Please refer to nand.txt for generic information regarding MTD NAND bindings.
> +
> +Required properties:
> + - compatible: "oxsemi,ox820-nand"
> + - reg: Base address and length for NAND mapped memory.
> +
> +Optional Properties:
> + - clocks: phandle to the NAND gate clock if needed.
> + - resets: phandle to the NAND reset control if needed.
> +
> +Example:
> +
> +nand: nand at 41000000 {
> +	compatible = "oxsemi,ox820-nand";
> +	reg = <0x41000000 0x100000>;
> +	nand-ecc-mode = "soft";
> +	clocks = <&stdclk CLK_820_NAND>;
> +	resets = <&reset RESET_NAND>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	status = "disabled";
> +};
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 7b7a887..c023125 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -426,6 +426,11 @@ config MTD_NAND_ORION
>  	  No board specific support is done by this driver, each board
>  	  must advertise a platform_device for the driver to attach.
>  
> +config MTD_NAND_OXNAS
> +	tristate "NAND Flash support for Oxford Semiconductor SoC"
> +	help
> +	  This enables the NAND flash controller on Oxford Semiconductor SoCs.
> +
>  config MTD_NAND_FSL_ELBC
>  	tristate "NAND support for Freescale eLBC controllers"
>  	depends on FSL_SOC
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index cafde6f..05fc054 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_MTD_NAND_TMIO)		+= tmio_nand.o
>  obj-$(CONFIG_MTD_NAND_PLATFORM)		+= plat_nand.o
>  obj-$(CONFIG_MTD_NAND_PASEMI)		+= pasemi_nand.o
>  obj-$(CONFIG_MTD_NAND_ORION)		+= orion_nand.o
> +obj-$(CONFIG_MTD_NAND_OXNAS)		+= oxnas_nand.o
>  obj-$(CONFIG_MTD_NAND_FSL_ELBC)		+= fsl_elbc_nand.o
>  obj-$(CONFIG_MTD_NAND_FSL_IFC)		+= fsl_ifc_nand.o
>  obj-$(CONFIG_MTD_NAND_FSL_UPM)		+= fsl_upm.o
> diff --git a/drivers/mtd/nand/oxnas_nand.c b/drivers/mtd/nand/oxnas_nand.c
> new file mode 100644
> index 0000000..ee402ab
> --- /dev/null
> +++ b/drivers/mtd/nand/oxnas_nand.c
> @@ -0,0 +1,144 @@
> +/*
> + * Oxford Semiconductor OXNAS NAND driver
> + *
> + * Heavily based on plat_nand.c :
> + * Author: Vitaly Wool <vitalywool@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/partitions.h>
> +
> +/* nand commands */
> +#define NAND_CMD_ALE		BIT(18)
> +#define NAND_CMD_CLE		BIT(19)
> +#define NAND_CMD_CS		0
> +#define NAND_CMD_RESET		0xff
> +#define NAND_CMD		(NAND_CMD_CS | NAND_CMD_CLE)
> +#define NAND_ADDR		(NAND_CMD_CS | NAND_CMD_ALE)
> +#define NAND_DATA		(NAND_CMD_CS)
> +
> +struct oxnas_nand_data {
> +	struct nand_chip	chip;
> +	void __iomem		*io_base;

Why do you redundantly keep io_base in platform data rather than
just using chip.IO_ADDR_R and >chip.IO_ADDR_W?


> +	struct clk		*clk;
> +};
> +
> +static void oxnas_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
> +				unsigned int ctrl)
> +{
> +	struct nand_chip *this = mtd->priv;
> +	unsigned long nandaddr = (unsigned long) this->IO_ADDR_W;
> +
> +	if (ctrl & NAND_CTRL_CHANGE) {
> +		nandaddr &= ~(NAND_CMD | NAND_ADDR);
> +		if (ctrl & NAND_CLE)
> +			nandaddr |= NAND_CMD;
> +		else if (ctrl & NAND_ALE)
> +			nandaddr |= NAND_ADDR;
> +		this->IO_ADDR_W = (void __iomem *) nandaddr;
> +	}
> +
> +	if (cmd != NAND_CMD_NONE)
> +		writeb(cmd, (void __iomem *) nandaddr);
> +}
> +
> +/*
> + * Probe for the NAND device.
> + */
> +static int oxnas_nand_probe(struct platform_device *pdev)
> +{
> +	struct oxnas_nand_data *data;
> +	struct mtd_info *mtd;
> +	struct resource *res;
> +	int err = 0;
> +
> +	/* Allocate memory for the device structure (and zero it) */
> +	data = devm_kzalloc(&pdev->dev, sizeof(struct oxnas_nand_data),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->io_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(data->io_base))
> +		return PTR_ERR(data->io_base);
> +
> +	data->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(data->clk))
> +		data->clk = NULL;
> +
> +	nand_set_flash_node(&data->chip, pdev->dev.of_node);
> +	mtd = nand_to_mtd(&data->chip);
> +	mtd->dev.parent = &pdev->dev;
> +	mtd->priv = &data->chip;
> +
> +	data->chip.IO_ADDR_R = data->io_base;
> +	data->chip.IO_ADDR_W = data->io_base;
> +	data->chip.cmd_ctrl = oxnas_nand_cmd_ctrl;
> +	data->chip.chip_delay = 30;
> +	data->chip.ecc.mode = NAND_ECC_SOFT;
> +	data->chip.ecc.algo = NAND_ECC_HAMMING;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	clk_prepare_enable(data->clk);
> +	device_reset_optional(&pdev->dev);
> +
> +	/* Scan to find existence of the device */
> +	if (nand_scan(mtd, 1)) {
> +		err = -ENXIO;
> +		goto out;
> +	}
> +
> +	err = mtd_device_parse_register(mtd, NULL, NULL, NULL, 0);
> +	if (!err)
> +		return err;
> +
> +	nand_release(mtd);
> +out:
> +	return err;
> +}
> +
> +static int oxnas_nand_remove(struct platform_device *pdev)
> +{
> +	struct oxnas_nand_data *data = platform_get_drvdata(pdev);
> +
> +	nand_release(nand_to_mtd(&data->chip));
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id oxnas_nand_match[] = {
> +	{ .compatible = "oxsemi,ox820-nand" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, oxnas_nand_match);
> +
> +static struct platform_driver oxnas_nand_driver = {
> +	.probe	= oxnas_nand_probe,
> +	.remove	= oxnas_nand_remove,
> +	.driver	= {
> +		.name		= "oxnas_nand",
> +		.of_match_table = oxnas_nand_match,
> +	},
> +};
> +
> +module_platform_driver(oxnas_nand_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Vitaly Wool");
> +MODULE_DESCRIPTION("Oxnas NAND driver");
> +MODULE_ALIAS("platform:oxnas_nand");
> -- 
> 2.7.0
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
