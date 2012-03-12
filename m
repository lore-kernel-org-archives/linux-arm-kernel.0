From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 11 Mar 2012 23:23:03 -0400
Subject: [PATCH 2/2] ARM: kirkwood: Convert orion-nand to fdt
In-Reply-To: <1331476406-9844-3-git-send-email-jm@lentin.co.uk>
References: <1331476406-9844-1-git-send-email-jm@lentin.co.uk>
 <1331476406-9844-3-git-send-email-jm@lentin.co.uk>
Message-ID: <20120312032303.GZ5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 11, 2012 at 02:33:26PM +0000, Jamie Lentin wrote:
> The DNS-320 and 325 have a NAND partitioned to store uboot, uimage and root
> filesystem. Store this information in devicetree.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
>  .../devicetree/bindings/mtd/orion-nand.txt         |   41 +++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-dns320.dts              |   42 ++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-dns325.dts              |   42 ++++++++++++++++++++
>  arch/arm/mach-kirkwood/board-dt.c                  |   30 --------------
>  arch/arm/mach-kirkwood/common.c                    |    6 +++
>  drivers/mtd/nand/orion_nand.c                      |   39 +++++++++++++++++-
>  6 files changed, 168 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/orion-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/orion-nand.txt b/Documentation/devicetree/bindings/mtd/orion-nand.txt
> new file mode 100644
> index 0000000..53fd469
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/orion-nand.txt
> @@ -0,0 +1,41 @@
> +NAND support for Marvell Orion SoC platforms
> +
> +Required properties:
> +- compatible : "mrvl,orion-nand".
> +- reg : Base physical address of the NAND and length of memory mapped
> +	region
> +
> +Optional properties:
> +- cle :
> +- ale :
> +- width :
> +- chip-delay :
> +
> +Examples:
> +
> +nand at f4000000 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	cle = <0>;
> +	ale = <1>;
> +	width = <8>;
> +	chip-delay = <25>;
> +	compatible = "mrvl,orion-nand";
> +	reg = <0xf4000000 0x400>;
> +
> +	partition at 0 {
> +		label = "u-boot";
> +		reg = <0x0000000 0x100000>;
> +		read-only;
> +	};
> +
> +	partition at 100000 {
> +		label = "uImage";
> +		reg = <0x0100000 0x200000>;
> +	};
> +
> +	partition at 300000 {
> +		label = "root";
> +		reg = <0x0300000 0x7d00000>;
> +	};

You may want the example to include a partition for the dtb.

I'll let more experienced folks comment on the guts of the nand
bindings.

thx,

Jason.

> +};
> diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/kirkwood-dns320.dts
> index c039041..6772f9d 100644
> --- a/arch/arm/boot/dts/kirkwood-dns320.dts
> +++ b/arch/arm/boot/dts/kirkwood-dns320.dts
> @@ -51,4 +51,46 @@
>  		dma-mask = <0xffffffff>;
>  		phy-version = "";
>  	};
> +
> +	nand at f4000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		cle = <0>;
> +		ale = <1>;
> +		width = <8>;
> +		chip-delay = <25>;
> +		compatible = "mrvl,orion-nand";
> +		reg = <0xf4000000 0x400>;
> +
> +		partition at 0 {
> +			label = "u-boot";
> +			reg = <0x0000000 0x100000>;
> +			read-only;
> +		};
> +
> +		partition at 100000 {
> +			label = "uImage";
> +			reg = <0x0100000 0x500000>;
> +		};
> +
> +		partition at 600000 {
> +			label = "ramdisk";
> +			reg = <0x0600000 0x500000>;
> +		};
> +
> +		partition at b00000 {
> +			label = "image";
> +			reg = <0x0b00000 0x6600000>;
> +		};
> +
> +		partition at 7100000 {
> +			label = "mini firmware";
> +			reg = <0x7100000 0xa00000>;
> +		};
> +
> +		partition at 7b00000 {
> +			label = "config";
> +			reg = <0x7b00000 0x500000>;
> +		};
> +	};
>  };
> diff --git a/arch/arm/boot/dts/kirkwood-dns325.dts b/arch/arm/boot/dts/kirkwood-dns325.dts
> index a7c2c26..34740ad 100644
> --- a/arch/arm/boot/dts/kirkwood-dns325.dts
> +++ b/arch/arm/boot/dts/kirkwood-dns325.dts
> @@ -37,4 +37,46 @@
>  		dma-mask = <0xffffffff>;
>  		phy-version = "";
>  	};
> +
> +	nand at f4000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		cle = <0>;
> +		ale = <1>;
> +		width = <8>;
> +		chip-delay = <25>;
> +		compatible = "mrvl,orion-nand";
> +		reg = <0xf4000000 0x400>;
> +
> +		partition at 0 {
> +			label = "u-boot";
> +			reg = <0x0000000 0x100000>;
> +			read-only;
> +		};
> +
> +		partition at 100000 {
> +			label = "uImage";
> +			reg = <0x0100000 0x500000>;
> +		};
> +
> +		partition at 600000 {
> +			label = "ramdisk";
> +			reg = <0x0600000 0x500000>;
> +		};
> +
> +		partition at b00000 {
> +			label = "image";
> +			reg = <0x0b00000 0x6600000>;
> +		};
> +
> +		partition at 7100000 {
> +			label = "mini firmware";
> +			reg = <0x7100000 0xa00000>;
> +		};
> +
> +		partition at 7b00000 {
> +			label = "config";
> +			reg = <0x7b00000 0x500000>;
> +		};
> +	};
>  };
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index 0885713..d5bc60a 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -158,35 +158,6 @@ static void __init dreamplug_init(void)
>   * DNS-320 & DNS-325 specifics
>   ****************************************************************************/
>  
> -static struct mtd_partition dnskw_nand_parts[] = {
> -	{
> -		.name		= "u-boot",
> -		.offset		= 0,
> -		.size		= SZ_1M,
> -		.mask_flags	= MTD_WRITEABLE
> -	}, {
> -		.name		= "uImage",
> -		.offset		= MTDPART_OFS_NXTBLK,
> -		.size		= 5 * SZ_1M
> -	}, {
> -		.name		= "ramdisk",
> -		.offset		= MTDPART_OFS_NXTBLK,
> -		.size		= 5 * SZ_1M
> -	}, {
> -		.name		= "image",
> -		.offset		= MTDPART_OFS_NXTBLK,
> -		.size		= 102 * SZ_1M
> -	}, {
> -		.name		= "mini firmware",
> -		.offset		= MTDPART_OFS_NXTBLK,
> -		.size		= 10 * SZ_1M
> -	}, {
> -		.name		= "config",
> -		.offset		= MTDPART_OFS_NXTBLK,
> -		.size		= 5 * SZ_1M
> -	},
> -};
> -
>  static struct mv643xx_eth_platform_data dnskw_ge00_data = {
>  	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
>  };
> @@ -395,7 +366,6 @@ static void __init dnskw_init(void)
>  	u32 dev, rev;
>  
>  	kirkwood_mpp_conf(dnskw_mpp_config);
> -	kirkwood_nand_init(ARRAY_AND_SIZE(dnskw_nand_parts), 25);
>  
>  	kirkwood_ge00_init(&dnskw_ge00_data);
>  	kirkwood_i2c_init();
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index 70ee7ac..f135854 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -505,6 +505,12 @@ static int __init kirkwood_clock_gate(void)
>  		of_node_put(np);
>  	}
>  
> +	np = of_find_compatible_node(NULL, NULL, "mrvl,orion-nand");
> +	if (np && of_device_is_available(np)) {
> +		kirkwood_clk_ctrl |= CGC_RUNIT;
> +		of_node_put(np);
> +	}
> +
>  	np = of_find_compatible_node(NULL, NULL, "mrvl,orion-sata");
>  	if (np && of_device_is_available(np)) {
>  		int nr_ports;
> diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
> index 29f505a..5ae0030 100644
> --- a/drivers/mtd/nand/orion_nand.c
> +++ b/drivers/mtd/nand/orion_nand.c
> @@ -13,6 +13,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/of.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/nand.h>
>  #include <linux/mtd/partitions.h>
> @@ -74,11 +75,13 @@ static void orion_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
>  static int __init orion_nand_probe(struct platform_device *pdev)
>  {
>  	struct mtd_info *mtd;
> +	struct mtd_part_parser_data ppdata = {};
>  	struct nand_chip *nc;
>  	struct orion_nand_data *board;
>  	struct resource *res;
>  	void __iomem *io_base;
>  	int ret = 0;
> +	u32 val = 0;
>  
>  	nc = kzalloc(sizeof(struct nand_chip) + sizeof(struct mtd_info), GFP_KERNEL);
>  	if (!nc) {
> @@ -101,7 +104,24 @@ static int __init orion_nand_probe(struct platform_device *pdev)
>  		goto no_res;
>  	}
>  
> -	board = pdev->dev.platform_data;
> +	if (pdev->dev.of_node) {
> +		board = kzalloc(sizeof(struct orion_nand_data), GFP_KERNEL);
> +		if (!board) {
> +			printk(KERN_ERR "orion_nand: failed to allocate board structure.\n");
> +			ret = -ENOMEM;
> +			goto no_res;
> +		}
> +		if (!of_property_read_u32(pdev->dev.of_node, "cle", &val))
> +			board->cle = (u8)val;
> +		if (!of_property_read_u32(pdev->dev.of_node, "ale", &val))
> +			board->ale = (u8)val;
> +		if (!of_property_read_u32(pdev->dev.of_node, "width", &val))
> +			board->width = (u8)val;
> +		if (!of_property_read_u32(pdev->dev.of_node,
> +						"chip-delay", &val))
> +			board->chip_delay = (u8)val;
> +	} else
> +		board = pdev->dev.platform_data;
>  
>  	mtd->priv = nc;
>  	mtd->owner = THIS_MODULE;
> @@ -129,7 +149,8 @@ static int __init orion_nand_probe(struct platform_device *pdev)
>  	}
>  
>  	mtd->name = "orion_nand";
> -	ret = mtd_device_parse_register(mtd, NULL, 0,
> +	ppdata.of_node = pdev->dev.of_node;
> +	ret = mtd_device_parse_register(mtd, NULL, &ppdata,
>  			board->parts, board->nr_parts);
>  	if (ret) {
>  		nand_release(mtd);
> @@ -141,6 +162,8 @@ static int __init orion_nand_probe(struct platform_device *pdev)
>  no_dev:
>  	platform_set_drvdata(pdev, NULL);
>  	iounmap(io_base);
> +	if (pdev->dev.of_node)
> +		kfree(board);
>  no_res:
>  	kfree(nc);
>  
> @@ -156,16 +179,28 @@ static int __devexit orion_nand_remove(struct platform_device *pdev)
>  
>  	iounmap(nc->IO_ADDR_W);
>  
> +	if (pdev->dev.of_node)
> +		kfree(nc->priv);
>  	kfree(nc);
>  
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static struct of_device_id orion_nand_of_match_table[] = {
> +	{ .compatible = "mrvl,orion-nand", },
> +	{},
> +};
> +#else
> +#define orion_nand_of_match_table NULL
> +#endif
> +
>  static struct platform_driver orion_nand_driver = {
>  	.remove		= __devexit_p(orion_nand_remove),
>  	.driver		= {
>  		.name	= "orion_nand",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(orion_nand_of_match_table),
>  	},
>  };
>  
> -- 
> 1.7.9.1
> 
