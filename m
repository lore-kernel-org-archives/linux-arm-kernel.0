From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 3 Jan 2011 12:10:01 +0530
Subject: [PATCH v2] davinci: Support various speedgrades for
	MityDSP-L138 and	MityARM-1808 SoMs
In-Reply-To: <1293720222-27299-1-git-send-email-michael.williamson@criticallink.com>
References: <1293720222-27299-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024816D313@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 30, 2010 at 20:13:42, Michael Williamson wrote:
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

>  static void read_factory_config(struct memory_accessor *a, void *context)
>  {
>  	int ret;
> @@ -53,29 +117,37 @@ static void read_factory_config(struct memory_accessor *a, void *context)
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
> +	pr_info("MityOMAPL138: Part Number = %s\n", factory_config.partnum);
> +	mityomapl138_cpufreq_init(factory_config.partnum);
> +
> +	return;
> +
> +bad_config:
> +	/* default maximum speed is valid for all platforms */
> +	mityomapl138_cpufreq_init(NULL);

There should be no need to make multiple calls to mityomapl138_cpufreq_init()
Just use a variable "partnum" initialized to null which gets set to actual
partnumber only if the entire parsing suceeds. mityomapl138_cpufreq_init()
is always called with partnum as argument.

Thanks,
Sekhar
