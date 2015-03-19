From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 19 Mar 2015 17:32:52 +0000
Subject: [UPDATED] [PATCH 3/5] arm-cci: Get rid of secure transactions
 for PMU driver
In-Reply-To: <1426585901-19137-1-git-send-email-suzuki.poulose@arm.com>
References: <1426000735-14375-4-git-send-email-suzuki.poulose@arm.com>
 <1426585901-19137-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20150319173252.GC10153@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more thing:

> @@ -883,7 +894,11 @@ static inline const struct cci_pmu_model *get_cci_model(struct platform_device *
>  							pdev->dev.of_node);
>  	if (!match)
>  		return NULL;
> +	if (match->data)
> +		return match->data;
>  
> +	dev_warn(&pdev->dev, "DEPRECATED compatible property,"
> +			 "requires secure access to CCI registers");
>  	return probe_cci_model(pdev);
>  }

Before the probe, could we please have:

	if (!IS_ENABLED(CONFIG_ARM))
		return -EINVAL;

On arm64 we require a model-specific string, and we shouldn't go
touching secure-only registers.

Mark.
