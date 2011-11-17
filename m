From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2011 17:29:19 +0000
Subject: [PATCH 15/41] ARM: restart: iop13xx: use new restart hook
In-Reply-To: <E1RN6mE-0001XZ-RX@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6mE-0001XZ-RX@rmk-PC.arm.linux.org.uk>
Message-ID: <20111117172919.GB9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ack?

On Sun, Nov 06, 2011 at 05:45:02PM +0000, Russell King - ARM Linux wrote:
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-iop13xx/include/mach/iop13xx.h |    1 +
>  arch/arm/mach-iop13xx/include/mach/system.h  |   10 ----------
>  arch/arm/mach-iop13xx/iq81340mc.c            |    1 +
>  arch/arm/mach-iop13xx/iq81340sc.c            |    1 +
>  arch/arm/mach-iop13xx/setup.c                |   11 +++++++++++
>  5 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-iop13xx/include/mach/iop13xx.h b/arch/arm/mach-iop13xx/include/mach/iop13xx.h
> index 52b7fab..07e9ff7 100644
> --- a/arch/arm/mach-iop13xx/include/mach/iop13xx.h
> +++ b/arch/arm/mach-iop13xx/include/mach/iop13xx.h
> @@ -10,6 +10,7 @@ void iop13xx_map_io(void);
>  void iop13xx_platform_init(void);
>  void iop13xx_add_tpmi_devices(void);
>  void iop13xx_init_irq(void);
> +void iop13xx_restart(char, const char *);
>  
>  /* CPUID CP6 R0 Page 0 */
>  static inline int iop13xx_cpu_id(void)
> diff --git a/arch/arm/mach-iop13xx/include/mach/system.h b/arch/arm/mach-iop13xx/include/mach/system.h
> index d0c66ef..7f798dc 100644
> --- a/arch/arm/mach-iop13xx/include/mach/system.h
> +++ b/arch/arm/mach-iop13xx/include/mach/system.h
> @@ -7,7 +7,6 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> -#include <mach/iop13xx.h>
>  static inline void arch_idle(void)
>  {
>  	cpu_do_idle();
> @@ -15,13 +14,4 @@ static inline void arch_idle(void)
>  
>  static inline void arch_reset(char mode, const char *cmd)
>  {
> -	/*
> -	 * Reset the internal bus (warning both cores are reset)
> -	 */
> -	write_wdtcr(IOP_WDTCR_EN_ARM);
> -	write_wdtcr(IOP_WDTCR_EN);
> -	write_wdtsr(IOP13XX_WDTSR_WRITE_EN | IOP13XX_WDTCR_IB_RESET);
> -	write_wdtcr(0x1000);
> -
> -	for(;;);
>  }
> diff --git a/arch/arm/mach-iop13xx/iq81340mc.c b/arch/arm/mach-iop13xx/iq81340mc.c
> index 4cf2cc4..abaee88 100644
> --- a/arch/arm/mach-iop13xx/iq81340mc.c
> +++ b/arch/arm/mach-iop13xx/iq81340mc.c
> @@ -96,4 +96,5 @@ MACHINE_START(IQ81340MC, "Intel IQ81340MC")
>  	.init_irq       = iop13xx_init_irq,
>  	.timer          = &iq81340mc_timer,
>  	.init_machine   = iq81340mc_init,
> +	.restart	= iop13xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-iop13xx/iq81340sc.c b/arch/arm/mach-iop13xx/iq81340sc.c
> index cd9e274..690916a 100644
> --- a/arch/arm/mach-iop13xx/iq81340sc.c
> +++ b/arch/arm/mach-iop13xx/iq81340sc.c
> @@ -98,4 +98,5 @@ MACHINE_START(IQ81340SC, "Intel IQ81340SC")
>  	.init_irq       = iop13xx_init_irq,
>  	.timer          = &iq81340sc_timer,
>  	.init_machine   = iq81340sc_init,
> +	.restart	= iop13xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-iop13xx/setup.c b/arch/arm/mach-iop13xx/setup.c
> index a5b9897..daabb1f 100644
> --- a/arch/arm/mach-iop13xx/setup.c
> +++ b/arch/arm/mach-iop13xx/setup.c
> @@ -606,3 +606,14 @@ static int __init iop13xx_init_adma_setup(char *str)
>  __setup("iop13xx_init_adma", iop13xx_init_adma_setup);
>  __setup("iop13xx_init_uart", iop13xx_init_uart_setup);
>  __setup("iop13xx_init_i2c", iop13xx_init_i2c_setup);
> +
> +void iop13xx_restart(char mode, const char *cmd)
> +{
> +	/*
> +	 * Reset the internal bus (warning both cores are reset)
> +	 */
> +	write_wdtcr(IOP_WDTCR_EN_ARM);
> +	write_wdtcr(IOP_WDTCR_EN);
> +	write_wdtsr(IOP13XX_WDTSR_WRITE_EN | IOP13XX_WDTCR_IB_RESET);
> +	write_wdtcr(0x1000);
> +}
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
