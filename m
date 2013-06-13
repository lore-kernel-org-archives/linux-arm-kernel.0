From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Jun 2013 13:19:29 -0600
Subject: [PATCH v2 1/3] ARM: tegra: basic support for Trusted Foundations
In-Reply-To: <1371114745-24710-2-git-send-email-acourbot@nvidia.com>
References: <1371114745-24710-1-git-send-email-acourbot@nvidia.com>
 <1371114745-24710-2-git-send-email-acourbot@nvidia.com>
Message-ID: <51BA1B41.6030002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2013 03:12 AM, Alexandre Courbot wrote:
> Add basic support for booting secondary processors on Tegra devices
> using the Trusted Foundations secure monitor.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  Documentation/devicetree/bindings/arm/tegra.txt    | 11 +++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  arch/arm/configs/tegra_defconfig                   |  1 +

The defconfig change should be a separate patch, so that I can squash it
into any other defconfig updates separately from all the code changes.

> diff --git a/arch/arm/mach-tegra/firmware.c b/arch/arm/mach-tegra/firmware.c

> +void __init tegra_init_firmware(void)
> +{
> +	struct device_node *node;
> +
> +	if (!of_have_populated_dt())
> +		return;
> +
> +	node = of_find_compatible_node(NULL, NULL, "tl,trusted-foundations");
> +	if (node && !IS_ENABLED(CONFIG_TEGRA_TRUSTED_FOUNDATIONS))
> +		pr_warn("Trusted Foundations detected but support missing!\n");
> +#if IS_ENABLED(CONFIG_TEGRA_TRUSTED_FOUNDATIONS)
> +	else if (node)
> +		register_firmware_ops(&tegra_trusted_foundations_ops);
> +#endif
> +}

Is it worth continuing on in the node && !IS_ENABLED case here? After
all, we can be pretty certain that the write to the CPU reset vector is
immediately going to trap...

I suppose that perhaps without SMP, cpuidle, suspend, ... we could keep
running, but that seems a little niche.
