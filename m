From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Dec 2012 15:41:15 +0000
Subject: [PATCH 5/7] arm64: ARMv8 RTSM model (SoC) support
In-Reply-To: <1354914392-9634-6-git-send-email-catalin.marinas@arm.com>
References: <1354914392-9634-1-git-send-email-catalin.marinas@arm.com>
 <1354914392-9634-6-git-send-email-catalin.marinas@arm.com>
Message-ID: <201212111541.16479.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 December 2012, Catalin Marinas wrote:
> diff --git a/arch/arm64/platforms/Kconfig b/arch/arm64/platforms/Kconfig
> index e69de29..3533d71 100644
> --- a/arch/arm64/platforms/Kconfig
> +++ b/arch/arm64/platforms/Kconfig
> @@ -0,0 +1,11 @@
> +config ARCH_VEXPRESS
> +       bool "ARMv8 software model (Versatile Express)"
> +       select ARCH_REQUIRE_GPIOLIB
> +       select ARM_AMBA
> +       select ARM_GIC
> +       select COMMON_CLK_VERSATILE
> +       select GENERIC_GPIO
> +       select VEXPRESS_CONFIG

I would expect that we can always select ARCH_REQUIRE_GPIOLIB, ARM_AMBA,
ARM_GIC and GENERIC_GPIO for ARM64. Do you expect to see systems that
don't have all of those?

> diff --git a/arch/arm6
> +static const char *vexpress_dt_match[] __initdata = {
> +       "arm,vexpress",
> +       NULL,
> +};
> +
> +static int __init vexpress_init(void)
> +{
> +       if (!of_flat_dt_match(of_get_flat_dt_root(), vexpress_dt_match))
> +               return 0;
> +
> +       vexpress_sysreg_of_early_init();
> +       vexpress_clk_of_init();
> +
> +       return 0;
> +}
> +arch_initcall(vexpress_init);

I think it would be more appropriate for these two to check the presence of
the individual devices, and move the caller into the actual device driver,
rather than checking for the root node of the device tree.

There may be cases where we want to check the root node, but both the clock
setup and the sysreg should both be detectable.

	Arnd
