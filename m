From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 14 Jun 2017 12:22:51 -0600
Subject: [PATCH 09/12] coresight tmc: Add capability information
In-Reply-To: <1497278211-5001-10-git-send-email-suzuki.poulose@arm.com>
References: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
 <1497278211-5001-10-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170614182251.GE22030@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 03:36:48PM +0100, Suzuki K Poulose wrote:
> This patch adds description of the capabilities of a given TMC.
> This will help us to handle different versions of the TMC in the
> same driver by checking the capabilities.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc.c | 10 +++++++++-
>  drivers/hwtracing/coresight/coresight-tmc.h | 18 ++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 7152656..e88f2f3 100644
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

Do we need this?  I don't see anywhere a check for TMC_CAP_ETR_SG_UNIT.  And
I also suppose that the SoC600 suite also supports scatter-gather - is there a
need to differenciate both that may not be implemented in this set?

I'm also wondering if capabilities for SoC600 could not be retrieved from HW
registers rather than hard coded?

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

A simple u32 is probably best here rather than introducing a new structure.  If
capabilites can't be retrieved from HW and have to be declared statically, a
*u32 referencing ->data is sufficient rather than copying memory.

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
> -- 
> 2.7.4
> 
