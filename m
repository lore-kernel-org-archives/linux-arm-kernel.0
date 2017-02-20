From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 20 Feb 2017 23:47:10 +0100
Subject: [RESEND PATCH 2/3] mtd: nand: atmel: Add ->setup_data_interface()
 hooks
In-Reply-To: <1487625149-7234-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1487625149-7234-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487625149-7234-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <4db51424-0e59-bad7-45ff-92516424dead@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2017 10:12 PM, Boris Brezillon wrote:
> The NAND controller IP can adapt the NAND controller timings dynamically.
> Implement the ->setup_data_interface() hook to support this feature.
> 
> Note that it's not supported on at91rm9200 because this SoC has a
> completely different SMC block, which is not supported yet.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mtd/nand/atmel/nand-controller.c | 333 ++++++++++++++++++++++++++++++-
>  1 file changed, 328 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
> index 4207c0d37826..ae46ef711d67 100644
> --- a/drivers/mtd/nand/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/atmel/nand-controller.c
> @@ -57,6 +57,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/atmel-matrix.h>
> +#include <linux/mfd/syscon/atmel-smc.h>
>  #include <linux/module.h>
>  #include <linux/mtd/nand.h>
>  #include <linux/of_address.h>
> @@ -147,6 +148,8 @@ struct atmel_nand_cs {
>  		void __iomem *virt;
>  		dma_addr_t dma;
>  	} io;
> +
> +	struct atmel_smc_cs_conf smcconf;
>  };
>  
>  struct atmel_nand {
> @@ -190,6 +193,8 @@ struct atmel_nand_controller_ops {
>  	void (*nand_init)(struct atmel_nand_controller *nc,
>  			  struct atmel_nand *nand);
>  	int (*ecc_init)(struct atmel_nand *nand);
> +	int (*setup_data_interface)(struct atmel_nand *nand, int csline,
> +				    const struct nand_data_interface *conf);
>  };
>  
>  struct atmel_nand_controller_caps {
> @@ -1144,6 +1149,293 @@ static int atmel_hsmc_nand_ecc_init(struct atmel_nand *nand)
>  	return 0;
>  }
>  
> +static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
> +					const struct nand_data_interface *conf,
> +					struct atmel_smc_cs_conf *smcconf)
> +{
> +	u32 ncycles, totalcycles, timeps, mckperiodps;
> +	struct atmel_nand_controller *nc;
> +	int ret;
> +
> +	nc = to_nand_controller(nand->base.controller);
> +
> +	/* DDR interface not supported. */
> +	if (conf->type != NAND_SDR_IFACE)
> +		return -ENOTSUPP;
> +
> +	/*
> +	 * tRC < 30ns implies EDO mode. This controller does not support this
> +	 * mode.
> +	 */
> +	if (conf->timings.sdr.tRC_min < 30)
> +		return -ENOTSUPP;
> +
> +	atmel_smc_cs_conf_init(smcconf);
> +
> +	mckperiodps = NSEC_PER_SEC / clk_get_rate(nc->mck);
> +	mckperiodps *= 1000;

You probably want to multiply before dividing to retain precision.

> +	/*
> +	 * Set write pulse timing. This one is easy to extract:
> +	 *
> +	 * NWE_PULSE = tWP
> +	 */
> +	ncycles = DIV_ROUND_UP(conf->timings.sdr.tWP_min, mckperiodps);
> +	totalcycles = ncycles;
> +	ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NWE_SHIFT,
> +					  ncycles);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The write setup timing depends on the operation done on the NAND.
> +	 * All operations goes through the same data bus, but the operation
> +	 * type depends on the address we are writing to (ALE/CLE address
> +	 * lines).
> +	 * Since we have no way to differentiate the different operations at
> +	 * the SMC level, we must consider the worst case (the biggest setup
> +	 * time among all operation types):
> +	 *
> +	 * NWE_SETUP = max(tCLS, tCS, tALS, tDS) - NWE_PULSE
> +	 */
> +	timeps = max3(conf->timings.sdr.tCLS_min, conf->timings.sdr.tCS_min,
> +		      conf->timings.sdr.tALS_min);
> +	timeps = max(timeps, conf->timings.sdr.tDS_min);
> +	ncycles = DIV_ROUND_UP(timeps, mckperiodps);
> +	ncycles = ncycles > totalcycles ? ncycles - totalcycles : 0;

Ew, that's totally cryptic here ...

> +	totalcycles += ncycles;
> +	ret = atmel_smc_cs_conf_set_setup(smcconf, ATMEL_SMC_NWE_SHIFT,
> +					  ncycles);
> +	if (ret)
> +		return ret;

[...]

> +static const struct atmel_nand_controller_caps atmel_sam9260_nc_caps = {
> +	.ale_offs = 1 << 21,
> +	.cle_offs = 1 << 22,

BIT(22) ?

>  	.ops = &atmel_smc_nc_ops,
>  };
>  
> @@ -2129,14 +2452,14 @@ static const struct atmel_nand_controller_caps atmel_sam9g45_nc_caps = {
>  static const struct atmel_nand_controller_caps atmel_rm9200_nand_caps = {
>  	.ale_offs = 1 << 21,
>  	.cle_offs = 1 << 22,
> -	.ops = &atmel_smc_nc_ops,
> +	.ops = &at91rm9200_nc_ops,
>  	.legacy_of_bindings = true,
>  };
>  
>  static const struct atmel_nand_controller_caps atmel_sam9261_nand_caps = {
>  	.ale_offs = 1 << 22,
>  	.cle_offs = 1 << 21,
> -	.ops = &atmel_smc_nc_ops,
> +	.ops = &at91rm9200_nc_ops,
>  	.legacy_of_bindings = true,
>  };
>  
> @@ -2144,7 +2467,7 @@ static const struct atmel_nand_controller_caps atmel_sam9g45_nand_caps = {
>  	.has_dma = true,
>  	.ale_offs = 1 << 21,
>  	.cle_offs = 1 << 22,
> -	.ops = &atmel_smc_nc_ops,
> +	.ops = &at91rm9200_nc_ops,
>  	.legacy_of_bindings = true,
>  };
>  
> @@ -2155,7 +2478,7 @@ static const struct of_device_id atmel_nand_controller_of_ids[] = {
>  	},
>  	{
>  		.compatible = "atmel,at91sam9260-nand-controller",
> -		.data = &atmel_rm9200_nc_caps,
> +		.data = &atmel_sam9260_nc_caps,
>  	},
>  	{
>  		.compatible = "atmel,at91sam9261-nand-controller",
> 


-- 
Best regards,
Marek Vasut
