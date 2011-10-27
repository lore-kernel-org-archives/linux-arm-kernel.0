From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 27 Oct 2011 09:03:54 -0700
Subject: [PATCHv2] arm/tegra: clk_get should not be fatal
In-Reply-To: <1319618501-15020-1-git-send-email-pdeschrijver@nvidia.com>
References: <1319618501-15020-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173E1B48B0@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pdeschrijver at nvidia.com wrote at Wednesday, October 26, 2011 2:42 AM:
> The timer and rtc-timer clocks aren't gated by default, so there is no reason
> to crash the system if the dummy enable call failed.
...
>  	clk = clk_get_sys("timer", NULL);
> -	BUG_ON(IS_ERR(clk));
> -	clk_enable(clk);
> +	if (IS_ERR(clk))
> +		pr_warn("Unable to get timer clock\n");
> +	else
> +		clk_enable(clk);

This seems reasonable to me, and is certainly required for Tegra30 support
until we get a full clock tree set up for Tegra30, which I think we'll
probably defer until the common clock infra-structure is in place.

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
