From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 25 Mar 2012 10:57:44 -0400
Subject: [PATCH V3 2/3] ARM: kirkwood: Convert orion-nand to fdt
In-Reply-To: <alpine.DEB.2.02.1203250012060.8994@gonzo>
References: <1332594876-8673-1-git-send-email-jm@lentin.co.uk>
 <1332594876-8673-3-git-send-email-jm@lentin.co.uk>
 <201203241901.00405.arnd@arndb.de>
 <alpine.DEB.2.02.1203250012060.8994@gonzo>
Message-ID: <20120325145744.GO2484@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 25, 2012 at 12:17:24AM +0000, Jamie Lentin wrote:
> Convert orion-nand to use fdt and add common setup to kirkwood.dtsi, including
> a default value for chip-delay (all current boards seem to use 25 anyway).
> 
> Add placeholder documentation for the bindings, for someone more knowledgable
> than me to fill in the details of the properties.
> 
> Move common partition table documentation into a separate file and reference
> this.

Jamie,

This looks great!  In addition to Arnd's comments, could you split this
into two?  The orion_nand dt bindings work, and kirkwood making use of
it?  It's not earth-shattering, but it helps folks on orion5x/dove/etc
pull it in and try it without worrying about kirkwood.

> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
> Re-arranged documentation as you suggest, however it's tempting to
> have this as a separate patch and add references to partition.txt
> for the other binding documentation files. Let me know if you want
> me to do this.

If it's not too much trouble, this would be appreciated.

thx,

Jason.

> Cheers for your help!
> 
>  .../devicetree/bindings/mtd/mtd-physmap.txt        |   24 +--------
>  .../devicetree/bindings/mtd/orion-nand.txt         |   50 ++++++++++++++++++++
>  .../devicetree/bindings/mtd/partition.txt          |   38 +++++++++++++++
>  arch/arm/boot/dts/kirkwood.dtsi                    |   15 ++++++-
>  arch/arm/mach-kirkwood/common.c                    |   12 +++++
>  drivers/mtd/nand/orion_nand.c                      |   34 +++++++++++++-
>  6 files changed, 149 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/orion-nand.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/partition.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> index 80152cb..9b873d4 100644
> --- a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> +++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> @@ -23,27 +23,9 @@ are defined:
>   - vendor-id : Contains the flash chip's vendor id (1 byte).
>   - device-id : Contains the flash chip's device id (1 byte).
> 
> -In addition to the information on the mtd bank itself, the
> -device tree may optionally contain additional information
> -describing partitions of the address space.  This can be
> -used on platforms which have strong conventions about which
> -portions of a flash are used for what purposes, but which don't
> -use an on-flash partition table such as RedBoot.
> -
> -Each partition is represented as a sub-node of the mtd device.
> -Each node's name represents the name of the corresponding
> -partition of the mtd device.
> -
> -Flash partitions
> - - reg : The partition's offset and size within the mtd bank.
> - - label : (optional) The label / name for this partition.
> -   If omitted, the label is taken from the node name (excluding
> -   the unit address).
> - - read-only : (optional) This parameter, if present, is a hint to
> -   Linux that this partition should only be mounted
> -   read-only.  This is usually used for flash partitions
> -   containing early-boot firmware images or data which should not
> -   be clobbered.
> +In addition to the information on the mtd bank itself, the device tree may
> +optionally contain additional sub-nodes describing partitions of the address
> +space. See partition.txt for more detail.
> 
>  Example:
> 
> diff --git a/Documentation/devicetree/bindings/mtd/orion-nand.txt b/Documentation/devicetree/bindings/mtd/orion-nand.txt
> new file mode 100644
> index 0000000..e9acbd2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/orion-nand.txt
> @@ -0,0 +1,50 @@
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
> +- bank-width :
> +- chip-delay :
> +
> +In addition to the information on the mtd bank itself, the device tree may
> +optionally contain additional sub-nodes describing partitions of the address
> +space. See partition.txt for more detail.
> +
> +Examples:
> +
> +nand at f4000000 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	cle = <0>;
> +	ale = <1>;
> +	bank-width = <8>;
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
> +		label = "dtb";
> +		reg = <0x0300000 0x100000>;
> +	};
> +
> +	partition at 400000 {
> +		label = "root";
> +		reg = <0x0400000 0x7d00000>;
> +	};
> +};
> diff --git a/Documentation/devicetree/bindings/mtd/partition.txt b/Documentation/devicetree/bindings/mtd/partition.txt
> new file mode 100644
> index 0000000..f114ce1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partition.txt
> @@ -0,0 +1,38 @@
> +Representing flash partitions in devicetree
> +
> +Partitions can be represented by sub-nodes of an mtd device. This can be used
> +on platforms which have strong conventions about which portions of a flash are
> +used for what purposes, but which don't use an on-flash partition table such
> +as RedBoot.
> +
> +#address-cells & #size-cells must both be present in the mtd device and be
> +equal to 1.
> +
> +Required properties:
> +- reg : The partition's offset and size within the mtd bank.
> +
> +Optional properties:
> +- label : The label / name for this partition.  If omitted, the label is taken
> +  from the node name (excluding the unit address).
> +- read-only : This parameter, if present, is a hint to Linux that this
> +  partition should only be mounted read-only. This is usually used for flash
> +  partitions containing early-boot firmware images or data which should not be
> +  clobbered.
> +
> +Examples:
> +
> +
> +flash at 0 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	partition at 0 {
> +		label = "u-boot";
> +		reg = <0x0000000 0x100000>;
> +		read-only;
> +	};
> +
> +	uimage at 100000 {
> +		reg = <0x0100000 0x200000>;
> +	};
> +];
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index 3474ef8..6b80374 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -5,7 +5,7 @@
> 
>  	ocp at f1000000 {
>  		compatible = "simple-bus";
> -		ranges = <0 0xf1000000 0x1000000>;
> +		ranges = <0 0xf1000000 0x4000000>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> 
> @@ -32,5 +32,18 @@
>  			reg = <0x10300 0x20>;
>  			interrupts = <53>;
>  		};
> +
> +		nand at 3000000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			cle = <0>;
> +			ale = <1>;
> +			bank-width = <8>;
> +			compatible = "mrvl,orion-nand";
> +			reg = <0x3000000 0x400>;
> +			chip-delay = <25>;
> +			/* set partition map and/or chip-delay in board dts */
> +			status = "disabled";
> +		};
>  	};
>  };
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index a02cae8..3ad0373 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -15,6 +15,7 @@
>  #include <linux/ata_platform.h>
>  #include <linux/mtd/nand.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/of.h>
>  #include <net/dsa.h>
>  #include <asm/page.h>
>  #include <asm/timex.h>
> @@ -482,6 +483,9 @@ static int __init kirkwood_clock_gate(void)
>  	unsigned int curr = readl(CLOCK_GATING_CTRL);
>  	u32 dev, rev;
> 
> +#ifdef CONFIG_OF
> +	struct device_node *np;
> +#endif
>  	kirkwood_pcie_id(&dev, &rev);
>  	printk(KERN_DEBUG "Gating clock of unused units\n");
>  	printk(KERN_DEBUG "before: 0x%08x\n", curr);
> @@ -489,6 +493,14 @@ static int __init kirkwood_clock_gate(void)
>  	/* Make sure those units are accessible */
>  	writel(curr | CGC_SATA0 | CGC_SATA1 | CGC_PEX0 | CGC_PEX1, CLOCK_GATING_CTRL);
> 
> +#ifdef CONFIG_OF
> +	np = of_find_compatible_node(NULL, NULL, "mrvl,orion-nand");
> +	if (np && of_device_is_available(np)) {
> +		kirkwood_clk_ctrl |= CGC_RUNIT;
> +		of_node_put(np);
> +	}
> +#endif
> +
>  	/* For SATA: first shutdown the phy */
>  	if (!(kirkwood_clk_ctrl & CGC_SATA0)) {
>  		/* Disable PLL and IVREF */
> diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
> index 29f505a..6a5f47b 100644
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
> @@ -101,7 +104,25 @@ static int __init orion_nand_probe(struct platform_device *pdev)
>  		goto no_res;
>  	}
> 
> -	board = pdev->dev.platform_data;
> +	if (pdev->dev.of_node) {
> +		board = devm_kzalloc(&pdev->dev, sizeof(struct orion_nand_data),
> +					GFP_KERNEL);
> +		if (!board) {
> +			printk(KERN_ERR "orion_nand: failed to allocate board structure.\n");
> +			ret = -ENOMEM;
> +			goto no_res;
> +		}
> +		if (!of_property_read_u32(pdev->dev.of_node, "cle", &val))
> +			board->cle = (u8)val;
> +		if (!of_property_read_u32(pdev->dev.of_node, "ale", &val))
> +			board->ale = (u8)val;
> +		if (!of_property_read_u32(pdev->dev.of_node, "bank-width", &val))
> +			board->width = (u8)val;
> +		if (!of_property_read_u32(pdev->dev.of_node,
> +						"chip-delay", &val))
> +			board->chip_delay = (u8)val;
> +	} else
> +		board = pdev->dev.platform_data;
> 
>  	mtd->priv = nc;
>  	mtd->owner = THIS_MODULE;
> @@ -129,7 +150,8 @@ static int __init orion_nand_probe(struct platform_device *pdev)
>  	}
> 
>  	mtd->name = "orion_nand";
> -	ret = mtd_device_parse_register(mtd, NULL, 0,
> +	ppdata.of_node = pdev->dev.of_node;
> +	ret = mtd_device_parse_register(mtd, NULL, &ppdata,
>  			board->parts, board->nr_parts);
>  	if (ret) {
>  		nand_release(mtd);
> @@ -161,11 +183,19 @@ static int __devexit orion_nand_remove(struct platform_device *pdev)
>  	return 0;
>  }
> 
> +#ifdef CONFIG_OF
> +static struct of_device_id orion_nand_of_match_table[] = {
> +	{ .compatible = "mrvl,orion-nand", },
> +	{},
> +};
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
