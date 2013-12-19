From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Dec 2013 16:12:05 -0700
Subject: [PATCH 2/6] ARM: tegra114: fuse: add DFLL FCPU minimum voltage
 override test function
In-Reply-To: <20131219123652.3226.98741.stgit@tamien>
References: <20131219122857.3226.42830.stgit@tamien>
 <20131219123652.3226.98741.stgit@tamien>
Message-ID: <52B37D45.4090905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 05:36 AM, Paul Walmsley wrote:
> Add a function to test the internal Tegra114 chip fuse that indicates
> whether the VDD_CPU lower voltage limit for the fast CPU cluster
> should be overridden.

> diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c

> +bool tegra114_fuse_read_min_vdd_cpu_override(void)
> +{
> +	if (tegra_chip_id != TEGRA114)
> +		return -EINVAL;

-EINVAL doesn't translate to "bool" too well...

> +
> +	return tegra_spare_fuse(TEGRA114_SPARE_FUSE_VDD_CPU_OVERRIDE) ? true :
> +		false;

In the spirit of my comment on patch 1 and consistency, instead perhaps
just read this fuse at boot, and assign it to a global?

BTW, why the need for "? true : false" - doesn't the compiler do the
conversion correctly itself. Perhaps it's to avoid a performance
warning, in which case a leading !! seems to be more popular.
