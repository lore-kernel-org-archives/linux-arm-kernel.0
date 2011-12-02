From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Fri, 02 Dec 2011 21:10:27 +0100
Subject: [PATCH 3/3] ARM: S3C64XX: Implement basic power domain support
In-Reply-To: <1322765339-29879-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1322765339-29879-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <4ED930B3.3020200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

good to see someone adding a proper power domain support for s3c64xx.

On 12/01/2011 07:48 PM, Mark Brown wrote:
> The S3C64xx SoCs contain a set of gateable power domains which can be
> enabled and disabled at runtime in order to save power.  Use the generic
> power domain code to implement support for these in software, enabling
> runtime control of most domains:
> 
>  - ETM (not supported in mainline).
>  - Domain G: 3D acceleration (no mainline support).
>  - Domain V: MFC (no mainline support).
>  - Domain I: JPEG and camera interface (no mainline support).
>  - Domain P: 2D acceleration, TV encoder and scaler (no mainline support)
>  - Domain S: Security (no mainline support).
>  - Domain F: LCD (driver already uses runtime PM), post processing and
>    rotation (no mainline support).
> 
> The IROM domain is marked as always enabled as we should arrange for it
> to be enabled when we suspend which will need a bit more work.
> 
> Due to all the conditional device registration that the platform does
> wrap s3c_pm_init() with s3c64xx_pm_init() which actually puts the device
> into the power domain after the machines have registered, looking for
> platform data to tell if the device was registered. Since currently only
> Cragganmore actually sets up PM that is the only machine updated.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
...
> +
> +static int s3c64xx_pd_on(struct generic_pm_domain *domain)
> +{
> +	struct s3c64xx_pm_domain *pd;
> +	u32 val;
> +	long retry = 1000000L;
> +
> +	pd = container_of(domain, struct s3c64xx_pm_domain, pd);
> +
> +	val = __raw_readl(S3C64XX_NORMAL_CFG);
> +	val |= pd->ena;
> +	__raw_writel(val, S3C64XX_NORMAL_CFG);
> +
> +	/* Not all domains provide power status readback */
> +	if (pd->pwr_stat) {
> +		while (retry--)
> +			if (__raw_readl(S3C64XX_BLK_PWR_STAT) & pd->pwr_stat)
> +				break;

How about adding cpu_relax() in this busy wait loop ?

> +		if (!retry) {
> +			pr_err("Failed to start domain %s\n", pd->name);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	return 0;
> +}

--

Regards,
Sylwester
