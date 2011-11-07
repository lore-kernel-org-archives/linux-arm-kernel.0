From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Nov 2011 17:16:14 +0000
Subject: [PATCH 38/41] ARM: restart: w90x900: use new restart hook
In-Reply-To: <E1RN6tm-0001Z9-Ha@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6tm-0001Z9-Ha@rmk-PC.arm.linux.org.uk>
Message-ID: <20111107171614.GR12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 06, 2011 at 05:52:50PM +0000, Russell King - ARM Linux wrote:
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This one doesn't compile - cpu.h isn't included by the *evb.c files.
What's more... this isn't nice:

arch/arm/mach-w90x900/nuc960.h:extern void nuc900_init_irq(void);
arch/arm/mach-w90x900/nuc910.h:extern void nuc900_init_irq(void);
arch/arm/mach-w90x900/nuc950.h:extern void nuc900_init_irq(void);

arch/arm/mach-w90x900/nuc910.h:extern struct sys_timer nuc900_timer;
arch/arm/mach-w90x900/nuc950.h:extern struct sys_timer nuc900_timer;
arch/arm/mach-w90x900/nuc960.h:extern struct sys_timer nuc900_timer;

It's wanting a common nuc9xx.h header containing the common stuff,
which'll include the nuc900_restart() function prototype.

So, I'm punting this into part 3 of the patchset until it's fixed.

> ---
>  arch/arm/mach-w90x900/cpu.c                 |   15 +++++++++++++++
>  arch/arm/mach-w90x900/cpu.h                 |    1 +
>  arch/arm/mach-w90x900/include/mach/system.h |   17 -----------------
>  arch/arm/mach-w90x900/mach-nuc910evb.c      |    1 +
>  arch/arm/mach-w90x900/mach-nuc950evb.c      |    1 +
>  arch/arm/mach-w90x900/mach-nuc960evb.c      |    1 +
>  6 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
> index 0a235e5..07eddd7 100644
> --- a/arch/arm/mach-w90x900/cpu.c
> +++ b/arch/arm/mach-w90x900/cpu.c
> @@ -33,6 +33,7 @@
>  #include <mach/regs-serial.h>
>  #include <mach/regs-clock.h>
>  #include <mach/regs-ebi.h>
> +#include <mach/regs-timer.h>
>  
>  #include "cpu.h"
>  #include "clock.h"
> @@ -222,3 +223,17 @@ void __init nuc900_init_clocks(void)
>  	clkdev_add_table(nuc900_clkregs, ARRAY_SIZE(nuc900_clkregs));
>  }
>  
> +#define	WTCR	(TMR_BA + 0x1C)
> +#define	WTCLK	(1 << 10)
> +#define	WTE	(1 << 7)
> +#define	WTRE	(1 << 1)
> +
> +void nuc900_restart(char mode, const char *cmd)
> +{
> +	if (mode == 's') {
> +		/* Jump into ROM at address 0 */
> +		soft_restart(0);
> +	} else {
> +		__raw_writel(WTE | WTRE | WTCLK, WTCR);
> +	}
> +}
> diff --git a/arch/arm/mach-w90x900/cpu.h b/arch/arm/mach-w90x900/cpu.h
> index f8730b6..b56799d 100644
> --- a/arch/arm/mach-w90x900/cpu.h
> +++ b/arch/arm/mach-w90x900/cpu.h
> @@ -49,6 +49,7 @@ extern void nuc900_clock_source(struct device *dev, unsigned char *src);
>  extern void nuc900_init_clocks(void);
>  extern void nuc900_map_io(struct map_desc *mach_desc, int mach_size);
>  extern void nuc900_board_init(struct platform_device **device, int size);
> +extern void nuc900_restart(char, const char *);
>  
>  /* for either public between 910 and 920, or between 920 and 950 */
>  
> diff --git a/arch/arm/mach-w90x900/include/mach/system.h b/arch/arm/mach-w90x900/include/mach/system.h
> index 68875a1..001a2f9 100644
> --- a/arch/arm/mach-w90x900/include/mach/system.h
> +++ b/arch/arm/mach-w90x900/include/mach/system.h
> @@ -14,28 +14,11 @@
>   * (at your option) any later version.
>   *
>   */
> -
> -#include <linux/io.h>
> -#include <asm/proc-fns.h>
> -#include <mach/map.h>
> -#include <mach/regs-timer.h>
> -
> -#define	WTCR	(TMR_BA + 0x1C)
> -#define	WTCLK	(1 << 10)
> -#define	WTE	(1 << 7)
> -#define	WTRE	(1 << 1)
> -
>  static void arch_idle(void)
>  {
>  }
>  
>  static void arch_reset(char mode, const char *cmd)
>  {
> -	if (mode == 's') {
> -		/* Jump into ROM at address 0 */
> -		soft_restart(0);
> -	} else {
> -		__raw_writel(WTE | WTRE | WTCLK, WTCR);
> -	}
>  }
>  
> diff --git a/arch/arm/mach-w90x900/mach-nuc910evb.c b/arch/arm/mach-w90x900/mach-nuc910evb.c
> index 31c1090..10852dc 100644
> --- a/arch/arm/mach-w90x900/mach-nuc910evb.c
> +++ b/arch/arm/mach-w90x900/mach-nuc910evb.c
> @@ -38,4 +38,5 @@ MACHINE_START(W90P910EVB, "W90P910EVB")
>  	.init_irq	= nuc900_init_irq,
>  	.init_machine	= nuc910evb_init,
>  	.timer		= &nuc900_timer,
> +	.restart	= nuc900_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-w90x900/mach-nuc950evb.c b/arch/arm/mach-w90x900/mach-nuc950evb.c
> index 4062e55..b549967 100644
> --- a/arch/arm/mach-w90x900/mach-nuc950evb.c
> +++ b/arch/arm/mach-w90x900/mach-nuc950evb.c
> @@ -41,4 +41,5 @@ MACHINE_START(W90P950EVB, "W90P950EVB")
>  	.init_irq	= nuc900_init_irq,
>  	.init_machine	= nuc950evb_init,
>  	.timer		= &nuc900_timer,
> +	.restart	= nuc900_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-w90x900/mach-nuc960evb.c b/arch/arm/mach-w90x900/mach-nuc960evb.c
> index 0ab9995..1ea5acf 100644
> --- a/arch/arm/mach-w90x900/mach-nuc960evb.c
> +++ b/arch/arm/mach-w90x900/mach-nuc960evb.c
> @@ -38,4 +38,5 @@ MACHINE_START(W90N960EVB, "W90N960EVB")
>  	.init_irq	= nuc900_init_irq,
>  	.init_machine	= nuc960evb_init,
>  	.timer		= &nuc900_timer,
> +	.restart	= nuc900_restart,
>  MACHINE_END
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
