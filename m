From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 Feb 2012 08:45:05 -0800
Subject: [PATCH 2/3] ARM: OMAP2+: Split omap2_hsmmc_init() to properly
 support I2C GPIO pins
In-Reply-To: <20120215182825.18884.40972.stgit@kaulin.local>
References: <20120215182355.18884.18682.stgit@kaulin.local>
 <20120215182825.18884.40972.stgit@kaulin.local>
Message-ID: <20120216164504.GD15692@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120215 09:57]:
>  
> +void omap_hsmmc_late_init(struct omap2_hsmmc_info *controllers)
> +{
> +	struct platform_device *pdev;
> +	int res;
> +
> +	for (; controllers->mmc; controllers++) {
> +		if (!controllers->deferred)
> +			continue;
> +
> +		pdev = controllers->pdev;
> +		if (!pdev)
> +			continue;
> +
> +		res = omap_device_register(pdev);
> +		if (res) {
> +			pr_err("Could not late init MMC %s\n",
> +			       controllers->name);
> +			continue;
> +		}
> +	}
> +}

Most likely there's no need to pass struct omap2_hsmmc_info *controllers
to omap_hsmmc_late_init() here. And I'll also take a look at making
it a completion to make it more generic across various PMICs.

Tony
