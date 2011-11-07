From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 7 Nov 2011 11:03:15 -0800
Subject: [PATCH v3 2/8] arm/tegra: prepare early init for multiple tegra
 variants
In-Reply-To: <1320675617-20751-3-git-send-email-pdeschrijver@nvidia.com>
References: <1320675617-20751-1-git-send-email-pdeschrijver@nvidia.com>
 <1320675617-20751-3-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173F9A50E8@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Monday, November 07, 2011 7:20 AM:
> This patch splits the early init code in a common and a tegra20 specific part.
> L2 cache initialization is generalized and discovers the cache associativity
> at runtime. Also use arm_pm_restart instead of arm_arch_reset and reset the
> the system using the PMC reset feature rather then the CAR system reset.

> -static void __init tegra_init_cache(void)
...
> +	aux_ctrl = readl(p + L2X0_CACHE_TYPE);
> +	aux_ctrl = (aux_ctrl & 0x700) << (17-8);
> +	aux_ctrl |= 0x6C000001;

It might be slightly clearer here to write:

> +	aux_ctrl = 0x6C000001;
> +	cache_type = readl(p + L2X0_CACHE_TYPE);
> +	aux_ctrl |= (cache_type & 0x700) << (17-8);

So that the contents of the cache type register isn't assigned to something
named after an unrelated register.

-- 
nvpublic
