From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 12 Jun 2013 10:46:58 -0700
Subject: [PATCH 1/3] ARM: msm: Move debug-macro.S to include/debug
In-Reply-To: <1371001686-15985-2-git-send-email-sboyd@codeaurora.org>
References: <1371001686-15985-1-git-send-email-sboyd@codeaurora.org>
 <1371001686-15985-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130612174658.GC10823@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11, Stephen Boyd wrote:
> diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
> index efa113e..284cc56 100644
> --- a/arch/arm/mach-msm/io.c
> +++ b/arch/arm/mach-msm/io.c
> @@ -52,10 +52,6 @@ static struct map_desc msm_io_desc[] __initdata = {
>  	MSM_CHIP_DEVICE_TYPE(GPIO1, MSM7X00, MT_DEVICE_NONSHARED),
>  	MSM_CHIP_DEVICE_TYPE(GPIO2, MSM7X00, MT_DEVICE_NONSHARED),
>  	MSM_DEVICE_TYPE(CLK_CTL, MT_DEVICE_NONSHARED),
> -#if defined(CONFIG_DEBUG_MSM_UART1) || defined(CONFIG_DEBUG_MSM_UART2) || \
> -	defined(CONFIG_DEBUG_MSM_UART3)
> -	MSM_DEVICE_TYPE(DEBUG_UART, MT_DEVICE_NONSHARED),
> -#endif

Hmm debug_ll_io_init() uses MT_DEVICE so I think I'll add a dummy
entry here and fill in the address with debug_ll_addr.

>  	{
>  		.virtual =  (unsigned long) MSM_SHARED_RAM_BASE,
>  		.pfn = __phys_to_pfn(MSM_SHARED_RAM_PHYS),
> @@ -71,6 +67,7 @@ void __init msm_map_common_io(void)
>  	 * pages are peripheral interface or not.
>  	 */
>  	asm("mcr p15, 0, %0, c15, c2, 4" : : "r" (0));
> +	debug_ll_io_init();
>  	iotable_init(msm_io_desc, ARRAY_SIZE(msm_io_desc));
>  }
>  #endif

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
