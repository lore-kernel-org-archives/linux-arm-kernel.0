From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2011 17:28:58 +0000
Subject: [PATCH 14/41] ARM: restart: iop3xx: use new restart hook
In-Reply-To: <E1RN6lu-0001XV-D3@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6lu-0001XV-D3@rmk-PC.arm.linux.org.uk>
Message-ID: <20111117172858.GA9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ack?

On Sun, Nov 06, 2011 at 05:44:42PM +0000, Russell King - ARM Linux wrote:
> Hook these platforms restart code into the arm_pm_restart hook rather
> than using arch_reset().
> 
> In doing so, we split out the n2100 platform specific restart handler
> into the n2100 platform file.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/hardware/iop3xx.h     |    1 +
>  arch/arm/mach-iop32x/em7210.c              |    1 +
>  arch/arm/mach-iop32x/glantank.c            |    1 +
>  arch/arm/mach-iop32x/include/mach/system.h |   15 ---------------
>  arch/arm/mach-iop32x/iq31244.c             |    2 ++
>  arch/arm/mach-iop32x/iq80321.c             |    1 +
>  arch/arm/mach-iop32x/n2100.c               |    9 +++++++++
>  arch/arm/mach-iop33x/include/mach/system.h |    6 ------
>  arch/arm/mach-iop33x/iq80331.c             |    1 +
>  arch/arm/mach-iop33x/iq80332.c             |    1 +
>  arch/arm/plat-iop/Makefile                 |    2 ++
>  arch/arm/plat-iop/restart.c                |   19 +++++++++++++++++++
>  12 files changed, 38 insertions(+), 21 deletions(-)
>  create mode 100644 arch/arm/plat-iop/restart.c
> 
> diff --git a/arch/arm/include/asm/hardware/iop3xx.h b/arch/arm/include/asm/hardware/iop3xx.h
> index 5daea29..077c323 100644
> --- a/arch/arm/include/asm/hardware/iop3xx.h
> +++ b/arch/arm/include/asm/hardware/iop3xx.h
> @@ -234,6 +234,7 @@ extern int iop3xx_get_init_atu(void);
>  void iop3xx_map_io(void);
>  void iop_init_cp6_handler(void);
>  void iop_init_time(unsigned long tickrate);
> +void iop3xx_restart(char, const char *);
>  
>  static inline u32 read_tmr0(void)
>  {
> diff --git a/arch/arm/mach-iop32x/em7210.c b/arch/arm/mach-iop32x/em7210.c
> index 4325055..24069e0 100644
> --- a/arch/arm/mach-iop32x/em7210.c
> +++ b/arch/arm/mach-iop32x/em7210.c
> @@ -208,4 +208,5 @@ MACHINE_START(EM7210, "Lanner EM7210")
>  	.init_irq	= iop32x_init_irq,
>  	.timer		= &em7210_timer,
>  	.init_machine	= em7210_init_machine,
> +	.restart	= iop3xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-iop32x/glantank.c b/arch/arm/mach-iop32x/glantank.c
> index 0edc880..204e1d1 100644
> --- a/arch/arm/mach-iop32x/glantank.c
> +++ b/arch/arm/mach-iop32x/glantank.c
> @@ -212,4 +212,5 @@ MACHINE_START(GLANTANK, "GLAN Tank")
>  	.init_irq	= iop32x_init_irq,
>  	.timer		= &glantank_timer,
>  	.init_machine	= glantank_init_machine,
> +	.restart	= iop3xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-iop32x/include/mach/system.h b/arch/arm/mach-iop32x/include/mach/system.h
> index b4f83e5..44e46f2 100644
> --- a/arch/arm/mach-iop32x/include/mach/system.h
> +++ b/arch/arm/mach-iop32x/include/mach/system.h
> @@ -7,10 +7,6 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> -#include <asm/mach-types.h>
> -#include <asm/hardware/iop3xx.h>
> -#include <mach/n2100.h>
> -
>  static inline void arch_idle(void)
>  {
>  	cpu_do_idle();
> @@ -18,15 +14,4 @@ static inline void arch_idle(void)
>  
>  static inline void arch_reset(char mode, const char *cmd)
>  {
> -	if (machine_is_n2100()) {
> -		gpio_line_set(N2100_HARDWARE_RESET, GPIO_LOW);
> -		gpio_line_config(N2100_HARDWARE_RESET, GPIO_OUT);
> -		while (1)
> -			;
> -	}
> -
> -	*IOP3XX_PCSR = 0x30;
> -
> -	/* Jump into ROM at address 0 */
> -	soft_restart(0);
>  }
> diff --git a/arch/arm/mach-iop32x/iq31244.c b/arch/arm/mach-iop32x/iq31244.c
> index 9e7aacc..3eb642a 100644
> --- a/arch/arm/mach-iop32x/iq31244.c
> +++ b/arch/arm/mach-iop32x/iq31244.c
> @@ -318,6 +318,7 @@ MACHINE_START(IQ31244, "Intel IQ31244")
>  	.init_irq	= iop32x_init_irq,
>  	.timer		= &iq31244_timer,
>  	.init_machine	= iq31244_init_machine,
> +	.restart	= iop3xx_restart,
>  MACHINE_END
>  
>  /* There should have been an ep80219 machine identifier from the beginning.
> @@ -332,4 +333,5 @@ MACHINE_START(EP80219, "Intel EP80219")
>  	.init_irq	= iop32x_init_irq,
>  	.timer		= &iq31244_timer,
>  	.init_machine	= iq31244_init_machine,
> +	.restart	= iop3xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-iop32x/iq80321.c b/arch/arm/mach-iop32x/iq80321.c
> index 53ea86f..2ec724b 100644
> --- a/arch/arm/mach-iop32x/iq80321.c
> +++ b/arch/arm/mach-iop32x/iq80321.c
> @@ -191,4 +191,5 @@ MACHINE_START(IQ80321, "Intel IQ80321")
>  	.init_irq	= iop32x_init_irq,
>  	.timer		= &iq80321_timer,
>  	.init_machine	= iq80321_init_machine,
> +	.restart	= iop3xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
> index d726927..6b6d559 100644
> --- a/arch/arm/mach-iop32x/n2100.c
> +++ b/arch/arm/mach-iop32x/n2100.c
> @@ -291,6 +291,14 @@ static void n2100_power_off(void)
>  		;
>  }
>  
> +static void n2100_restart(char mode, const char *cmd)
> +{
> +	gpio_line_set(N2100_HARDWARE_RESET, GPIO_LOW);
> +	gpio_line_config(N2100_HARDWARE_RESET, GPIO_OUT);
> +	while (1)
> +		;
> +}
> +
>  
>  static struct timer_list power_button_poll_timer;
>  
> @@ -332,4 +340,5 @@ MACHINE_START(N2100, "Thecus N2100")
>  	.init_irq	= iop32x_init_irq,
>  	.timer		= &n2100_timer,
>  	.init_machine	= n2100_init_machine,
> +	.restart	= n2100_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-iop33x/include/mach/system.h b/arch/arm/mach-iop33x/include/mach/system.h
> index 86d1b20..696d88c 100644
> --- a/arch/arm/mach-iop33x/include/mach/system.h
> +++ b/arch/arm/mach-iop33x/include/mach/system.h
> @@ -7,8 +7,6 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> -#include <asm/hardware/iop3xx.h>
> -
>  static inline void arch_idle(void)
>  {
>  	cpu_do_idle();
> @@ -16,8 +14,4 @@ static inline void arch_idle(void)
>  
>  static inline void arch_reset(char mode, const char *cmd)
>  {
> -	*IOP3XX_PCSR = 0x30;
> -
> -	/* Jump into ROM at address 0 */
> -	soft_restart(0);
>  }
> diff --git a/arch/arm/mach-iop33x/iq80331.c b/arch/arm/mach-iop33x/iq80331.c
> index 9e14ccc..abce934 100644
> --- a/arch/arm/mach-iop33x/iq80331.c
> +++ b/arch/arm/mach-iop33x/iq80331.c
> @@ -146,4 +146,5 @@ MACHINE_START(IQ80331, "Intel IQ80331")
>  	.init_irq	= iop33x_init_irq,
>  	.timer		= &iq80331_timer,
>  	.init_machine	= iq80331_init_machine,
> +	.restart	= iop3xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-iop33x/iq80332.c b/arch/arm/mach-iop33x/iq80332.c
> index 09c899a..7513559 100644
> --- a/arch/arm/mach-iop33x/iq80332.c
> +++ b/arch/arm/mach-iop33x/iq80332.c
> @@ -146,4 +146,5 @@ MACHINE_START(IQ80332, "Intel IQ80332")
>  	.init_irq	= iop33x_init_irq,
>  	.timer		= &iq80332_timer,
>  	.init_machine	= iq80332_init_machine,
> +	.restart	= iop3xx_restart,
>  MACHINE_END
> diff --git a/arch/arm/plat-iop/Makefile b/arch/arm/plat-iop/Makefile
> index 69b09c1..f5aebfe 100644
> --- a/arch/arm/plat-iop/Makefile
> +++ b/arch/arm/plat-iop/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_IOP32X) += io.o
>  obj-$(CONFIG_ARCH_IOP32X) += cp6.o
>  obj-$(CONFIG_ARCH_IOP32X) += adma.o
>  obj-$(CONFIG_ARCH_IOP32X) += pmu.o
> +obj-$(CONFIG_ARCH_IOP32X) += restart.o
>  
>  # IOP33X
>  obj-$(CONFIG_ARCH_IOP33X) += gpio.o
> @@ -25,6 +26,7 @@ obj-$(CONFIG_ARCH_IOP33X) += io.o
>  obj-$(CONFIG_ARCH_IOP33X) += cp6.o
>  obj-$(CONFIG_ARCH_IOP33X) += adma.o
>  obj-$(CONFIG_ARCH_IOP33X) += pmu.o
> +obj-$(CONFIG_ARCH_IOP33X) += restart.o
>  
>  # IOP13XX
>  obj-$(CONFIG_ARCH_IOP13XX) += cp6.o
> diff --git a/arch/arm/plat-iop/restart.c b/arch/arm/plat-iop/restart.c
> new file mode 100644
> index 0000000..6a85a0c
> --- /dev/null
> +++ b/arch/arm/plat-iop/restart.c
> @@ -0,0 +1,19 @@
> +/*
> + * restart.c
> + *
> + * Copyright (C) 2001 MontaVista Software, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <asm/hardware/iop3xx.h>
> +#include <mach/hardware.h>
> +
> +void iop3xx_restart(char mode, const char *cmd)
> +{
> +	*IOP3XX_PCSR = 0x30;
> +
> +	/* Jump into ROM at address 0 */
> +	soft_restart(0);
> +}
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
