From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 6 Jun 2014 21:34:00 -0400 (EDT)
Subject: [PATCH v2] ARM: EXYNOS: mcpm: Don't rely on firmware's
 secondary_cpu_start
In-Reply-To: <1402096465-13218-1-git-send-email-dianders@chromium.org>
References: <1402090985-8061-1-git-send-email-dianders@chromium.org>
 <1402096465-13218-1-git-send-email-dianders@chromium.org>
Message-ID: <alpine.LFD.2.11.1406062132480.25775@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Jun 2014, Doug Anderson wrote:

> On exynos mcpm systems the firmware is hardcoded to jump to an address
> in SRAM (0x02073000) when secondary CPUs come up.  By default the
> firmware puts a bunch of code at that location.  That code expects the
> kernel to fill in a few slots with addresses that it uses to jump back
> to the kernel's entry point for secondary CPUs.
> 
> Originally (on prerelease hardware) this firmware code contained a
> bunch of workarounds to deal with boot ROM bugs.  However on all
> shipped hardware we simply use this code to redirect to a kernel
> function for bringing up the CPUs.
> 
> Let's stop relying on the code provided by the bootloader and just
> plumb in our own (simple) code jump to the kernel.  This has the nice
> benefit of fixing problems due to the fact that older bootloaders
> (like the one shipped on the Samsung Chromebook 2) might have put
> slightly different code into this location.
> 
> Once suspend/resume is implemented for systems using exynos-mcpm we'll
> need to make sure we reinstall our fixed up code after resume.  ...but
> that's not anything new since IRAM (and thus the address of the
> mcpm_entry_point) is lost across suspend/resume anyway.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
> Changes in v2:
> - Removed #define
> 
>  arch/arm/mach-exynos/mcpm-exynos.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
> index 0498d0b..ace0ed6 100644
> --- a/arch/arm/mach-exynos/mcpm-exynos.c
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -25,7 +25,6 @@
>  
>  #define EXYNOS5420_CPUS_PER_CLUSTER	4
>  #define EXYNOS5420_NR_CLUSTERS		2
> -#define MCPM_BOOT_ADDR_OFFSET		0x1c
>  
>  /*
>   * The common v7_exit_coherency_flush API could not be used because of the
> @@ -343,11 +342,13 @@ static int __init exynos_mcpm_init(void)
>  	pr_info("Exynos MCPM support installed\n");
>  
>  	/*
> -	 * Future entries into the kernel can now go
> -	 * through the cluster entry vectors.
> +	 * U-Boot SPL is hardcoded to jump to the start of ns_sram_base_addr
> +	 * as part of secondary_cpu_start().  Let's redirect it to the
> +	 * mcpm_entry_point().
>  	 */
> -	__raw_writel(virt_to_phys(mcpm_entry_point),
> -			ns_sram_base_addr + MCPM_BOOT_ADDR_OFFSET);
> +	__raw_writel(0xe59f0000, ns_sram_base_addr);     /* ldr r0, [pc, #0] */
> +	__raw_writel(0xe12fff10, ns_sram_base_addr + 4); /* bx  r0 */
> +	__raw_writel(virt_to_phys(mcpm_entry_point), ns_sram_base_addr + 8);
>  
>  	iounmap(ns_sram_base_addr);
>  
> -- 
> 2.0.0.526.g5318336
> 
