From: michael.williamson@criticallink.com (Michael Williamson)
Date: Mon, 03 Jan 2011 08:07:30 -0500
Subject: [PATCH v3] davinci: Support various speedgrades for MityDSP-L138
	and MityARM-1808 SoMs
In-Reply-To: <1294060053-2761-1-git-send-email-michael.williamson@criticallink.com>
References: <1294060053-2761-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <4D21CA12.4080509@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please IGNORE this patch.  I sent the wrong file.  Sorry for the noise.

-Mike

On 1/3/2011 8:07 AM, Michael Williamson wrote:

> For the MityDSP-L138/MityARM-1808 SoMs, the speed grade can be determined
> from the part number string read from the factory configuration block on
> the on-board I2C PROM.  Configure the maximum CPU speed based on this
> information.
> 
> This patch was tested using a MityDSP-L138 at various speedgrades.  Also,
> for code coverage, a bogus configuration was tested as well as a
> configuration having an unknown part number.
> 
> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
> Tested-by: Michael Williamson <michael.williamson@criticallink.com>
> ---
> Built against linux-davinci tree.
> 
> Changes since v2.
> 
>  - reworked logic to use fall-through logic for mityomapl138_cpugreq_init call
>    per comments.
> 
>  arch/arm/mach-davinci/board-mityomapl138.c |   83 +++++++++++++++++++++++++---
>  1 files changed, 75 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
> index 0bb5f0c..8ba1937 100644
> --- a/arch/arm/mach-davinci/board-mityomapl138.c
> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
> @@ -44,38 +44,109 @@ struct factory_config {
>  
>  static struct factory_config factory_config;
>  
> +struct part_no_info {
> +	const char	*part_no;	/* part number string of interest */
> +	int		max_freq;	/* khz */
> +};
> +
> +static struct part_no_info mityomapl138_pn_info[] = {
> +	{
> +		.part_no	= "L138-C",
> +		.max_freq	= 300000,
> +	},
> +	{
> +		.part_no	= "L138-D",
> +		.max_freq	= 375000,
> +	},
> +	{
> +		.part_no	= "L138-F",
> +		.max_freq	= 456000,
> +	},
> +	{
> +		.part_no	= "1808-C",
> +		.max_freq	= 300000,
> +	},
> +	{
> +		.part_no	= "1808-D",
> +		.max_freq	= 375000,
> +	},
> +	{
> +		.part_no	= "1808-F",
> +		.max_freq	= 456000,
> +	},
> +	{
> +		.part_no	= "1810-D",
> +		.max_freq	= 375000,
> +	},
> +};
> +
> +#ifdef CONFIG_CPU_FREQ
> +static void mityomapl138_cpufreq_init(const char *partnum)
> +{
> +	int i, ret;
> +
> +	for (i = 0; partnum && i < ARRAY_SIZE(mityomapl138_pn_info); i++) {
> +		/*
> +		 * the part number has additional characters beyond what is
> +		 * stored in the table.  This information is not needed for
> +		 * determining the speed grade, and would require several
> +		 * more table entries.  Only check the first N characters
> +		 * for a match.
> +		 */
> +		if (!strncmp(partnum, mityomapl138_pn_info[i].part_no,
> +			strlen(mityomapl138_pn_info[i].part_no))) {
> +			da850_max_speed = mityomapl138_pn_info[i].max_freq;
> +			break;
> +		}
> +	}
> +
> +	ret = da850_register_cpufreq("pll0_sysclk3");
> +	if (ret)
> +		pr_warning("cpufreq registration failed: %d\n", ret);
> +}
> +#else
> +static void mityomapl138_cpufreq_init(const char *partnum) { }
> +#endif
> +
>  static void read_factory_config(struct memory_accessor *a, void *context)
>  {
>  	int ret;
> +	const char *partnum = NULL;
>  	struct davinci_soc_info *soc_info = &davinci_soc_info;
>  
>  	ret = a->read(a, (char *)&factory_config, 0, sizeof(factory_config));
>  	if (ret != sizeof(struct factory_config)) {
>  		pr_warning("MityOMAPL138: Read Factory Config Failed: %d\n",
>  				ret);
> -		return;
> +		goto bad_config;
>  	}
>  
>  	if (factory_config.magic != FACTORY_CONFIG_MAGIC) {
>  		pr_warning("MityOMAPL138: Factory Config Magic Wrong (%X)\n",
>  				factory_config.magic);
> -		return;
> +		goto bad_config;
>  	}
>  
>  	if (factory_config.version != FACTORY_CONFIG_VERSION) {
>  		pr_warning("MityOMAPL138: Factory Config Version Wrong (%X)\n",
>  				factory_config.version);
> -		return;
> +		goto bad_config;
>  	}
>  
>  	pr_info("MityOMAPL138: Found MAC = %pM\n", factory_config.mac);
> -	pr_info("MityOMAPL138: Part Number = %s\n", factory_config.partnum);
>  	if (is_valid_ether_addr(factory_config.mac))
>  		memcpy(soc_info->emac_pdata->mac_addr,
>  			factory_config.mac, ETH_ALEN);
>  	else
>  		pr_warning("MityOMAPL138: Invalid MAC found "
>  				"in factory config block\n");
> +
> +	partnum = factory_config.partnum;
> +	pr_info("MityOMAPL138: Part Number = %s\n", partnum);
> +
> +bad_config:
> +	/* default maximum speed is valid for all platforms */
> +	mityomapl138_cpufreq_init(NULL);
>  }
>  
>  static struct at24_platform_data mityomapl138_fd_chip = {
> @@ -383,10 +454,6 @@ static void __init mityomapl138_init(void)
>  	if (ret)
>  		pr_warning("rtc setup failed: %d\n", ret);
>  
> -	ret = da850_register_cpufreq("pll0_sysclk3");
> -	if (ret)
> -		pr_warning("cpufreq registration failed: %d\n", ret);
> -
>  	ret = da8xx_register_cpuidle();
>  	if (ret)
>  		pr_warning("cpuidle registration failed: %d\n", ret);
