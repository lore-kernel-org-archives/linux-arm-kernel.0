From: robherring2@gmail.com (Rob Herring)
Date: Mon, 07 Nov 2011 09:43:05 -0600
Subject: [PATCH 12/41] ARM: restart: highbank: use new restart hook
In-Reply-To: <E1RN6lF-0001XN-Gz@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6lF-0001XN-Gz@rmk-PC.arm.linux.org.uk>
Message-ID: <4EB7FC89.2040903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2011 11:44 AM, Russell King - ARM Linux wrote:
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-highbank/core.h                |    1 +
>  arch/arm/mach-highbank/highbank.c            |    1 +
>  arch/arm/mach-highbank/include/mach/system.h |    4 +++-
>  arch/arm/mach-highbank/system.c              |    2 +-
>  4 files changed, 6 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob

> diff --git a/arch/arm/mach-highbank/core.h b/arch/arm/mach-highbank/core.h
> index 7e33fc9..d8e2d0b 100644
> --- a/arch/arm/mach-highbank/core.h
> +++ b/arch/arm/mach-highbank/core.h
> @@ -1,5 +1,6 @@
>  extern void highbank_set_cpu_jump(int cpu, void *jump_addr);
>  extern void highbank_clocks_init(void);
> +extern void highbank_restart(char, const char *);
>  extern void __iomem *scu_base_addr;
>  #ifdef CONFIG_DEBUG_HIGHBANK_UART
>  extern void highbank_lluart_map_io(void);
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index b82dcf0..9d356a1 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -142,4 +142,5 @@ DT_MACHINE_START(HIGHBANK, "Highbank")
>  	.timer		= &highbank_timer,
>  	.init_machine	= highbank_init,
>  	.dt_compat	= highbank_match,
> +	.restart	= highbank_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-highbank/include/mach/system.h b/arch/arm/mach-highbank/include/mach/system.h
> index 7e81922..0754c79 100644
> --- a/arch/arm/mach-highbank/include/mach/system.h
> +++ b/arch/arm/mach-highbank/include/mach/system.h
> @@ -21,6 +21,8 @@ static inline void arch_idle(void)
>  	cpu_do_idle();
>  }
>  
> -extern void arch_reset(char mode, const char *cmd);
> +static inline void arch_reset(char mode, const char *cmd)
> +{
> +}
>  
>  #endif
> diff --git a/arch/arm/mach-highbank/system.c b/arch/arm/mach-highbank/system.c
> index 53f0c4c..82c2723 100644
> --- a/arch/arm/mach-highbank/system.c
> +++ b/arch/arm/mach-highbank/system.c
> @@ -20,7 +20,7 @@
>  #include "core.h"
>  #include "sysregs.h"
>  
> -void arch_reset(char mode, const char *cmd)
> +void highbank_restart(char mode, const char *cmd)
>  {
>  	if (mode == 'h')
>  		hignbank_set_pwr_hard_reset();
