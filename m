From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 5 Jul 2017 14:25:17 +0100
Subject: [PATCH v2 09/12] coresight tmc: Add capability information
In-Reply-To: <1498490576-1350-10-git-send-email-suzuki.poulose@arm.com>
References: <1498490576-1350-1-git-send-email-suzuki.poulose@arm.com>
 <1498490576-1350-10-git-send-email-suzuki.poulose@arm.com>
Message-ID: <7f3a4112-178b-8819-f627-4f91bf280c85@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/17 16:22, Suzuki K Poulose wrote:
> This patch adds description of the capabilities of a given TMC.
> This will help us to handle different versions of the TMC in the
> same driver by checking the capabilities.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---

The updated TRM has provisions to detect the new features of the TMC
via DEVID registers. I have also confirmed with the architects here,
that the DEVID bits in the older TMC are indeed RES0 (even though the
TRM only mentions "reserved"). So we are safe to use this register
to detect the functionality. I will rework this in the next revision.

Thanks
Suzuki


>  drivers/hwtracing/coresight/coresight-tmc.c | 10 +++++++++-
>  drivers/hwtracing/coresight/coresight-tmc.h | 18 ++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 73184a1..b2f9466 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -399,16 +399,24 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>  	ret = misc_register(&drvdata->miscdev);
>  	if (ret)
>  		coresight_unregister(drvdata->csdev);
> +	else if (id->data)
> +		drvdata->caps = *(struct tmc_caps *)id->data;
>  out:
>  	return ret;
>  }
>
> +static struct tmc_caps coresight_soc_400_tmc_caps = {
> +	.caps = CORESIGHT_SOC_400_TMC_CAPS,
> +};
> +
>  static struct amba_id tmc_ids[] = {
>  	{
> +		/* Coresight SoC 400 TMC */
>  		.id     = 0x000bb961,
>  		.mask   = 0x000fffff,
> +		.data	= &coresight_soc_400_tmc_caps,
>  	},
> -	{ 0, 0},
> +	{},
>  };
>
>  static struct amba_driver tmc_driver = {
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index c78de00..87e4561 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -89,6 +89,18 @@ enum tmc_mem_intf_width {
>  	TMC_MEM_INTF_WIDTH_256BITS	= 8,
>  };
>
> +#define TMC_CAP_ETR_SG_UNIT			(1U << 0)
> +
> +/**
> + * struct tmc_cap - Describes the capabilities of the TMC.
> + * @caps:	- Bitmask of the capacities
> + */
> +struct tmc_caps {
> +	u32	caps;
> +};
> +
> +#define CORESIGHT_SOC_400_TMC_CAPS	(TMC_CAP_ETR_SG_UNIT)
> +
>  /**
>   * struct tmc_drvdata - specifics associated to an TMC component
>   * @base:	memory mapped base address for this component.
> @@ -110,6 +122,7 @@ struct tmc_drvdata {
>  	void __iomem		*base;
>  	struct device		*dev;
>  	struct coresight_device	*csdev;
> +	struct tmc_caps		caps;
>  	struct miscdevice	miscdev;
>  	spinlock_t		spinlock;
>  	bool			reading;
> @@ -158,4 +171,9 @@ TMC_REG_PAIR(rrp, TMC_RRP, TMC_RRPHI)
>  TMC_REG_PAIR(rwp, TMC_RWP, TMC_RWPHI)
>  TMC_REG_PAIR(dba, TMC_DBALO, TMC_DBAHI)
>
> +static inline bool tmc_has_cap(struct tmc_drvdata *drvdata, u32 cap)
> +{
> +	return !!(drvdata->caps.caps & cap);
> +}
> +
>  #endif
>
