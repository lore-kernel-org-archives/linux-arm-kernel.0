From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 30 Nov 2017 11:34:09 +0100
Subject: MMC-Patch for mt7623 / Bananapi R2
In-Reply-To: <trinity-e74e6fc5-83cc-4b58-a02c-44dcd4eedcbc-1511977859500@3c-app-gmx-bs37>
References: <trinity-e74e6fc5-83cc-4b58-a02c-44dcd4eedcbc-1511977859500@3c-app-gmx-bs37>
Message-ID: <a14e55ac-abc4-db6b-3040-0afffa4783a0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

On 11/29/2017 06:50 PM, Frank Wunderlich wrote:
> 
> Hi,
> finally got the MMC working on BananaPi R2 in 4.14.0

Welcome! It's nice to see more contributer for Mediatek boards :)

> 
> note this is my first Pull-request, hope its right ;)

Unfortunately not. First of all, normally we don't do pull requests, but 
you send the patches (one-by-one, check git send-email) to a selected 
group of people and mailinglist (user ./scripts/get_maintainer.pl 
<patch> <patch> for this).

You should user ./scripts/checkpatch.pl <patch> <patch>
to see if any style problems occure, you have a quite some.

Please read a bit in 
http://elixir.free-electrons.com/linux/latest/source/Documentation/process
at least 4. and 5.

If you have any ad-hoc question, I'm normally on IRC freenode 
#linux-mediatek (in CET time zone, like you I suppose :)

> 
> merge of:
> 1) mmc-patch
> http://lists.infradead.org/pipermail/linux-mediatek/2017-October/010827.html

Development in the Linux community is done against torvalds master 
branch [1], normally we take -rc1 and develop against this branch.

I your case, the patch you mention is already part of v4.15-rc1, so no 
action needed on your side.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/

> 2) regulator-patch
> http://forum.banana-pi.org/t/what-s-the-best-practice-to-build-own-kernel/3937/59
> 3) fall back to mt2701 instead mt8135 + LOW ACTIVE instead of HIGH ACTIVE
> http://forum.banana-pi.org/t/what-s-the-best-practice-to-build-own-kernel/3937/71
> 

If you think the patches are necessary, please submit them to the 
mailinglist. Beware that 3) got already submitted Sean, I didn't check 2).

Best regards,
Matthias

> regards Frank
> 
> =========================================================================================================
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index ec8a074..da35544 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -640,7 +640,8 @@
>   
>   	mmc0: mmc at 11230000 {
>   		compatible = "mediatek,mt7623-mmc",
> -			     "mediatek,mt8135-mmc";
> +//			     "mediatek,mt8135-mmc";
> +			     "mediatek,mt2701-mmc";
>   		reg = <0 0x11230000 0 0x1000>;
>   		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
>   		clocks = <&pericfg CLK_PERI_MSDC30_0>,
> @@ -651,7 +652,8 @@
>   
>   	mmc1: mmc at 11240000 {
>   		compatible = "mediatek,mt7623-mmc",
> -			     "mediatek,mt8135-mmc";
> +//			     "mediatek,mt8135-mmc";
> +				 "mediatek,mt2701-mmc";
>   		reg = <0 0x11240000 0 0x1000>;
>   		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_LOW>;
>   		clocks = <&pericfg CLK_PERI_MSDC30_1>,
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 688a863..890b37f 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -204,9 +204,10 @@
>   	bus-width = <4>;
>   	max-frequency = <50000000>;
>   	cap-sd-highspeed;
> -	cd-gpios = <&pio 261 0>;
> +	cd-gpios = <&pio 261 1>;
>   	vmmc-supply = <&mt6323_vmch_reg>;
> -	vqmmc-supply = <&mt6323_vio18_reg>;
> +//	vqmmc-supply = <&mt6323_vio18_reg>;
> +	vqmmc-supply = <&mt6323_vmc_reg>;
>   };
>   
>   &pio {
> diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
> index 26ab7af..e8403c4 100644
> --- a/drivers/mmc/Makefile
> +++ b/drivers/mmc/Makefile
> @@ -1,6 +1,5 @@
>   #
>   # Makefile for the kernel mmc device drivers.
>   #
> -
>   obj-$(CONFIG_MMC)		+= core/
>   obj-$(subst m,y,$(CONFIG_MMC))	+= host/
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 267f7ab..6f43eb7 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -12,6 +12,7 @@
>    * GNU General Public License for more details.
>    */
>   
> +#define DEBUG
>   #include <linux/module.h>
>   #include <linux/clk.h>
>   #include <linux/delay.h>
> @@ -95,6 +96,9 @@
>   #define MSDC_CFG_CKDIV          (0xff << 8)	/* RW */
>   #define MSDC_CFG_CKMOD          (0x3 << 16)	/* RW */
>   #define MSDC_CFG_HS400_CK_MODE  (0x1 << 18)	/* RW */
> +#define MSDC_CFG_HS400_CK_MODE_EXTRA  (0x1 << 22)	/* RW */
> +#define MSDC_CFG_CKDIV_EXTRA    (0xfff << 8)	/* RW */
> +#define MSDC_CFG_CKMOD_EXTRA    (0x3 << 20)	/* RW */
>   
>   /* MSDC_IOCON mask */
>   #define MSDC_IOCON_SDR104CKS    (0x1 << 0)	/* RW */
> @@ -295,6 +299,10 @@ struct msdc_save_para {
>   	u32 emmc50_cfg0;
>   };
>   
> +struct mtk_mmc_compatible {
> +	u8 clk_div_bits;
> +};
> +
>   struct msdc_tune_para {
>   	u32 iocon;
>   	u32 pad_tune;
> @@ -309,6 +317,7 @@ struct msdc_delay_phase {
>   
>   struct msdc_host {
>   	struct device *dev;
> +	const struct mtk_mmc_compatible *dev_comp;
>   	struct mmc_host *mmc;	/* mmc structure */
>   	int cmd_rsp;
>   
> @@ -350,6 +359,31 @@ struct msdc_host {
>   	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
>   };
>   
> +static const struct mtk_mmc_compatible mt8135_compat = {
> +	.clk_div_bits = 8,
> +};
> +
> +static const struct mtk_mmc_compatible mt8173_compat = {
> +	.clk_div_bits = 8,
> +};
> +
> +static const struct mtk_mmc_compatible mt2701_compat = {
> +	.clk_div_bits = 12,
> +};
> +
> +static const struct mtk_mmc_compatible mt2712_compat = {
> +	.clk_div_bits = 12,
> +};
> +
> +static const struct of_device_id msdc_of_ids[] = {
> +	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
> +	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
> +	{ .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
> +	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, msdc_of_ids);
> +
>   static void sdr_set_bits(void __iomem *reg, u32 bs)
>   {
>   	u32 val = readl(reg);
> @@ -509,7 +543,12 @@ static void msdc_set_timeout(struct msdc_host *host, u32 ns, u32 clks)
>   		timeout = (ns + clk_ns - 1) / clk_ns + clks;
>   		/* in 1048576 sclk cycle unit */
>   		timeout = (timeout + (0x1 << 20) - 1) >> 20;
> -		sdr_get_field(host->base + MSDC_CFG, MSDC_CFG_CKMOD, &mode);
> +		if (host->dev_comp->clk_div_bits == 8)
> +			sdr_get_field(host->base + MSDC_CFG,
> +				      MSDC_CFG_CKMOD, &mode);
> +		else
> +			sdr_get_field(host->base + MSDC_CFG,
> +				      MSDC_CFG_CKMOD_EXTRA, &mode);
>   		/*DDR mode will double the clk cycles for data timeout */
>   		timeout = mode >= 2 ? timeout * 2 : timeout;
>   		timeout = timeout > 1 ? timeout - 1 : 0;
> @@ -548,7 +587,11 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>   
>   	flags = readl(host->base + MSDC_INTEN);
>   	sdr_clr_bits(host->base + MSDC_INTEN, flags);
> -	sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_HS400_CK_MODE);
> +	if (host->dev_comp->clk_div_bits == 8)
> +		sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_HS400_CK_MODE);
> +	else
> +		sdr_clr_bits(host->base + MSDC_CFG,
> +			     MSDC_CFG_HS400_CK_MODE_EXTRA);
>   	if (timing == MMC_TIMING_UHS_DDR50 ||
>   	    timing == MMC_TIMING_MMC_DDR52 ||
>   	    timing == MMC_TIMING_MMC_HS400) {
> @@ -568,8 +611,12 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>   
>   		if (timing == MMC_TIMING_MMC_HS400 &&
>   		    hz >= (host->src_clk_freq >> 1)) {
> -			sdr_set_bits(host->base + MSDC_CFG,
> -				     MSDC_CFG_HS400_CK_MODE);
> +			if (host->dev_comp->clk_div_bits == 8)
> +				sdr_set_bits(host->base + MSDC_CFG,
> +					     MSDC_CFG_HS400_CK_MODE);
> +			else
> +				sdr_set_bits(host->base + MSDC_CFG,
> +					     MSDC_CFG_HS400_CK_MODE_EXTRA);
>   			sclk = host->src_clk_freq >> 1;
>   			div = 0; /* div is ignore when bit18 is set */
>   		}
> @@ -587,8 +634,15 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>   			sclk = (host->src_clk_freq >> 2) / div;
>   		}
>   	}
> -	sdr_set_field(host->base + MSDC_CFG, MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
> -		      (mode << 8) | div);
> +	if (host->dev_comp->clk_div_bits == 8)
> +		sdr_set_field(host->base + MSDC_CFG,
> +			      MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
> +			      (mode << 8) | div);
> +	else
> +		sdr_set_field(host->base + MSDC_CFG,
> +			      MSDC_CFG_CKMOD_EXTRA | MSDC_CFG_CKDIV_EXTRA,
> +			      (mode << 12) | div);
> +
>   	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
>   	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
>   		cpu_relax();
> @@ -1617,12 +1671,17 @@ static int msdc_drv_probe(struct platform_device *pdev)
>   	struct mmc_host *mmc;
>   	struct msdc_host *host;
>   	struct resource *res;
> +	const struct of_device_id *of_id;
>   	int ret;
>   
>   	if (!pdev->dev.of_node) {
>   		dev_err(&pdev->dev, "No DT found\n");
>   		return -EINVAL;
>   	}
> +
> +	of_id = of_match_node(msdc_of_ids, pdev->dev.of_node);
> +	if (!of_id)
> +		return -EINVAL;
>   	/* Allocate MMC host for this device */
>   	mmc = mmc_alloc_host(sizeof(struct msdc_host), &pdev->dev);
>   	if (!mmc)
> @@ -1686,11 +1745,15 @@ static int msdc_drv_probe(struct platform_device *pdev)
>   	msdc_of_property_parse(pdev, host);
>   
>   	host->dev = &pdev->dev;
> +	host->dev_comp = of_id->data;
>   	host->mmc = mmc;
>   	host->src_clk_freq = clk_get_rate(host->src_clk);
>   	/* Set host parameters to mmc */
>   	mmc->ops = &mt_msdc_ops;
> -	mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 255);
> +	if (host->dev_comp->clk_div_bits == 8)
> +		mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 255);
> +	else
> +		mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 4095);
>   
>   	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
>   	/* MMC core transfer sizes tunable parameters */
> @@ -1839,12 +1902,6 @@ static int msdc_runtime_resume(struct device *dev)
>   	SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
>   };
>   
> -static const struct of_device_id msdc_of_ids[] = {
> -	{   .compatible = "mediatek,mt8135-mmc", },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(of, msdc_of_ids);
> -
>   static struct platform_driver mt_msdc_driver = {
>   	.probe = msdc_drv_probe,
>   	.remove = msdc_drv_remove,
> 
