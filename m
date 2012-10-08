From: vipin.kumar@st.com (Vipin Kumar)
Date: Mon, 8 Oct 2012 09:38:35 +0530
Subject: [PATCH 1/1] mtd: st fsmc_nand: pass the ale and cmd resource
 via resource
In-Reply-To: <1349356456-13371-1-git-send-email-plagnioj@jcrosoft.com>
References: <1349356456-13371-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <507251C3.7020506@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/4/2012 6:44 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Do not use the platform_data to pass resource and be smart in the drivers.
> Just pass it via resource
>
> Switch to devm_request_and_ioremap at the sametime
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
> Cc: Linus Walleij<linus.walleij@linaro.org>
> Cc: Vipin Kumar<vipin.kumar@st.com>
> Cc: linux-mtd at lists.infradead.org
> ---
>   .../devicetree/bindings/mtd/fsmc-nand.txt          |   12 +++---
>   arch/arm/boot/dts/spear13xx.dtsi                   |   10 ++---
>   arch/arm/boot/dts/spear300.dtsi                    |    8 ++--
>   arch/arm/boot/dts/spear310.dtsi                    |    8 ++--
>   arch/arm/boot/dts/spear320.dtsi                    |    8 ++--
>   arch/arm/boot/dts/spear600.dtsi                    |    8 ++--
>   arch/arm/mach-u300/core.c                          |   14 ++++++-
>   drivers/mtd/nand/fsmc_nand.c                       |   44 +++++---------------
>   include/linux/mtd/fsmc.h                           |    3 --
>   9 files changed, 49 insertions(+), 66 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
> index e2c663b..e3ea32e 100644
> --- a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
> @@ -3,9 +3,7 @@
>   Required properties:
>   - compatible : "st,spear600-fsmc-nand"
>   - reg : Address range of the mtd chip
> -- reg-names: Should contain the reg names "fsmc_regs" and "nand_data"
> -- st,ale-off : Chip specific offset to ALE
> -- st,cle-off : Chip specific offset to CLE
> +- reg-names: Should contain the reg names "fsmc_regs", "nand_data", "nand_addr" and "nand_cmd"
>
>   Optional properties:
>   - bank-width : Width (in bytes) of the device.  If not present, the width
> @@ -19,10 +17,10 @@ Example:
>   		#address-cells =<1>;
>   		#size-cells =<1>;
>   		reg =<0xd1800000 0x1000	/* FSMC Register */
> -		       0xd2000000 0x4000>;	/* NAND Base */
> -		reg-names = "fsmc_regs", "nand_data";
> -		st,ale-off =<0x20000>;
> -		st,cle-off =<0x10000>;
> +		       0xd2000000 0x0010	/* NAND Base DATA */
> +		       0xd2020000 0x0010	/* NAND Base ADDR */
> +		       0xd2010000 0x0010>;	/* NAND Base CMD */
> +		reg-names = "fsmc_regs", "nand_data", "nand_addr", "nand_cmd";
>
>   		bank-width =<1>;
>   		nand-skip-bbtscan;
> diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
> index f7b84ac..14a6d15 100644
> --- a/arch/arm/boot/dts/spear13xx.dtsi
> +++ b/arch/arm/boot/dts/spear13xx.dtsi
> @@ -104,15 +104,15 @@
>   			compatible = "st,spear600-fsmc-nand";
>   			#address-cells =<1>;
>   			#size-cells =<1>;
> -			reg =<0xb0000000 0x1000	/* FSMC Register */
> -			       0xb0800000 0x0010>;	/* NAND Base */
> -			reg-names = "fsmc_regs", "nand_data";
> +			reg =<0xb0000000 0x1000	/* FSMC Register*/
> +			       0xb0800000 0x0010	/* NAND Base DATA */
> +			       0xb0820000 0x0010	/* NAND Base ADDR */
> +			       0xb0810000 0x0010>;	/* NAND Base CMD */
> +			reg-names = "fsmc_regs", "nand_data", "nand_addr", "nand_cmd";
>   			interrupts =<0 20 0x4
>   				      0 21 0x4
>   				      0 22 0x4
>   				      0 23 0x4>;
> -			st,ale-off =<0x20000>;
> -			st,cle-off =<0x10000>;
>   			status = "disabled";
>   		};
>
> diff --git a/arch/arm/boot/dts/spear300.dtsi b/arch/arm/boot/dts/spear300.dtsi
> index ed3627c..bc43638 100644
> --- a/arch/arm/boot/dts/spear300.dtsi
> +++ b/arch/arm/boot/dts/spear300.dtsi
> @@ -38,10 +38,10 @@
>   			#address-cells =<1>;
>   			#size-cells =<1>;
>   			reg =<0x94000000 0x1000	/* FSMC Register */
> -			       0x80000000 0x0010>;	/* NAND Base */
> -			reg-names = "fsmc_regs", "nand_data";
> -			st,ale-off =<0x20000>;
> -			st,cle-off =<0x10000>;
> +			       0x80000000 0x0010	/* NAND Base DATA */
> +			       0x80020000 0x0010	/* NAND Base ADDR */
> +			       0x80010000 0x0010>;	/* NAND Base CMD */
> +			reg-names = "fsmc_regs", "nand_data", "nand_addr", "nand_cmd";
>   			status = "disabled";
>   		};
>
> diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
> index 62fc4fb..7840e52 100644
> --- a/arch/arm/boot/dts/spear310.dtsi
> +++ b/arch/arm/boot/dts/spear310.dtsi
> @@ -32,10 +32,10 @@
>   			#address-cells =<1>;
>   			#size-cells =<1>;
>   			reg =<0x44000000 0x1000	/* FSMC Register */
> -			       0x40000000 0x0010>;	/* NAND Base */
> -			reg-names = "fsmc_regs", "nand_data";
> -			st,ale-off =<0x10000>;
> -			st,cle-off =<0x20000>;
> +			       0x40000000 0x0010	/* NAND Base DATA */
> +			       0x40020000 0x0010	/* NAND Base ADDR */
> +			       0x40010000 0x0010>;	/* NAND Base CMD */
> +			reg-names = "fsmc_regs", "nand_data", "nand_addr", "nand_cmd";
>   			status = "disabled";
>   		};
>
> diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
> index 1f49d69..5ad8206 100644
> --- a/arch/arm/boot/dts/spear320.dtsi
> +++ b/arch/arm/boot/dts/spear320.dtsi
> @@ -38,10 +38,10 @@
>   			#address-cells =<1>;
>   			#size-cells =<1>;
>   			reg =<0x4c000000 0x1000	/* FSMC Register */
> -			       0x50000000 0x0010>;	/* NAND Base */
> -			reg-names = "fsmc_regs", "nand_data";
> -			st,ale-off =<0x20000>;
> -			st,cle-off =<0x10000>;
> +			       0x50000000 0x0010	/* NAND Base DATA */
> +			       0x50020000 0x0010	/* NAND Base ADDR */
> +			       0x50010000 0x0010>;	/* NAND Base CMD */
> +			reg-names = "fsmc_regs", "nand_data", "nand_addr", "nand_cmd";
>   			status = "disabled";
>   		};
>
> diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
> index a3c36e4..4ecc66f 100644
> --- a/arch/arm/boot/dts/spear600.dtsi
> +++ b/arch/arm/boot/dts/spear600.dtsi
> @@ -67,10 +67,10 @@
>   			#address-cells =<1>;
>   			#size-cells =<1>;
>   			reg =<0xd1800000 0x1000	/* FSMC Register */
> -			       0xd2000000 0x4000>;	/* NAND Base */
> -			reg-names = "fsmc_regs", "nand_data";
> -			st,ale-off =<0x20000>;
> -			st,cle-off =<0x10000>;
> +			       0xd2000000 0x0010	/* NAND Base DATA */
> +			       0xd2020000 0x0010	/* NAND Base ADDR */
> +			       0xd2010000 0x0010>;	/* NAND Base CMD */
> +			reg-names = "fsmc_regs", "nand_data", "nand_addr", "nand_cmd";
>   			status = "disabled";
>   		};
>
> diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
> index ef6f602..527bcc2 100644
> --- a/arch/arm/mach-u300/core.c
> +++ b/arch/arm/mach-u300/core.c
> @@ -252,6 +252,18 @@ static struct resource rtc_resources[] = {
>    */
>   static struct resource fsmc_resources[] = {
>   	{
> +		.name  = "nand_addr",
> +		.start = U300_NAND_CS0_PHYS_BASE + PLAT_NAND_ALE,
> +		.end   = U300_NAND_CS0_PHYS_BASE + PLAT_NAND_ALE + SZ_16K - 1,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
> +		.name  = "nand_cmd",
> +		.start = U300_NAND_CS0_PHYS_BASE + PLAT_NAND_CLE,
> +		.end   = U300_NAND_CS0_PHYS_BASE + PLAT_NAND_CLE + SZ_16K - 1,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	{
>   		.name  = "nand_data",
>   		.start = U300_NAND_CS0_PHYS_BASE,
>   		.end   = U300_NAND_CS0_PHYS_BASE + SZ_16K - 1,
> @@ -1496,8 +1508,6 @@ static struct fsmc_nand_platform_data nand_platform_data = {
>   	.nr_partitions = ARRAY_SIZE(u300_partitions),
>   	.options = NAND_SKIP_BBTSCAN,
>   	.width = FSMC_NAND_BW8,
> -	.ale_off = PLAT_NAND_ALE,
> -	.cle_off = PLAT_NAND_CLE,
>   };
>
>   static struct platform_device nand_device = {
> diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
> index 38d2624..cb86450 100644
> --- a/drivers/mtd/nand/fsmc_nand.c
> +++ b/drivers/mtd/nand/fsmc_nand.c
> @@ -876,8 +876,6 @@ static int __devinit fsmc_nand_probe_config_dt(struct platform_device *pdev,
>   			return -EINVAL;
>   		}
>   	}
> -	of_property_read_u32(np, "st,ale-off",&pdata->ale_off);
> -	of_property_read_u32(np, "st,cle-off",&pdata->cle_off);
>   	if (of_get_property(np, "nand-skip-bbtscan", NULL))
>   		pdata->options = NAND_SKIP_BBTSCAN;
>
> @@ -935,41 +933,28 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
>   	if (!res)
>   		return -EINVAL;
>
> -	if (!devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
> -				pdev->name)) {
> -		dev_err(&pdev->dev, "Failed to get memory data resourse\n");
> -		return -ENOENT;
> -	}
> -
> -	host->data_pa = (dma_addr_t)res->start;
> -	host->data_va = devm_ioremap(&pdev->dev, res->start,
> -			resource_size(res));
> +	host->data_va = devm_request_and_ioremap(&pdev->dev, res);
>   	if (!host->data_va) {
>   		dev_err(&pdev->dev, "data ioremap failed\n");
>   		return -ENOMEM;
>   	}
> +	host->data_pa = (dma_addr_t)res->start;
>
> -	if (!devm_request_mem_region(&pdev->dev, res->start + pdata->ale_off,
> -			resource_size(res), pdev->name)) {
> -		dev_err(&pdev->dev, "Failed to get memory ale resourse\n");
> -		return -ENOENT;
> -	}
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "nand_addr");
> +	if (!res)
> +		return -EINVAL;
>
> -	host->addr_va = devm_ioremap(&pdev->dev, res->start + pdata->ale_off,
> -			resource_size(res));
> +	host->addr_va = devm_request_and_ioremap(&pdev->dev, res);
>   	if (!host->addr_va) {
>   		dev_err(&pdev->dev, "ale ioremap failed\n");
>   		return -ENOMEM;
>   	}
>
> -	if (!devm_request_mem_region(&pdev->dev, res->start + pdata->cle_off,
> -			resource_size(res), pdev->name)) {
> -		dev_err(&pdev->dev, "Failed to get memory cle resourse\n");
> -		return -ENOENT;
> -	}
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "nand_cmd");
> +	if (!res)
> +		return -EINVAL;
>
> -	host->cmd_va = devm_ioremap(&pdev->dev, res->start + pdata->cle_off,
> -			resource_size(res));
> +	host->cmd_va = devm_request_and_ioremap(&pdev->dev, res);
>   	if (!host->cmd_va) {
>   		dev_err(&pdev->dev, "ale ioremap failed\n");
>   		return -ENOMEM;
> @@ -979,14 +964,7 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
>   	if (!res)
>   		return -EINVAL;
>
> -	if (!devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
> -			pdev->name)) {
> -		dev_err(&pdev->dev, "Failed to get memory regs resourse\n");
> -		return -ENOENT;
> -	}
> -
> -	host->regs_va = devm_ioremap(&pdev->dev, res->start,
> -			resource_size(res));
> +	host->regs_va = devm_request_and_ioremap(&pdev->dev, res);
>   	if (!host->regs_va) {
>   		dev_err(&pdev->dev, "regs ioremap failed\n");
>   		return -ENOMEM;
> diff --git a/include/linux/mtd/fsmc.h b/include/linux/mtd/fsmc.h
> index b200292..d6ed61e 100644
> --- a/include/linux/mtd/fsmc.h
> +++ b/include/linux/mtd/fsmc.h
> @@ -155,9 +155,6 @@ struct fsmc_nand_platform_data {
>   	unsigned int		width;
>   	unsigned int		bank;
>
> -	/* CLE, ALE offsets */
> -	unsigned int		cle_off;
> -	unsigned int		ale_off;
>   	enum access_mode	mode;
>
>   	void			(*select_bank)(uint32_t bank, uint32_t busw);

btw, I also have a few pending patches on this driver which I would be 
sending soon

Reviewed By: Vipin Kumar <vipin.kumar@st.com>
