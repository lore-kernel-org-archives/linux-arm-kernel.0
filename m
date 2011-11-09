From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 9 Nov 2011 15:45:49 +0530
Subject: [PATCHv4 08/13] ARM: spear: convert to MULTI_IRQ_HANDLER
In-Reply-To: <1320369010-23428-9-git-send-email-jamie@jamieiles.com>
References: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
 <1320369010-23428-9-git-send-email-jamie@jamieiles.com>
Message-ID: <4EBA52D5.4010801@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/4/2011 6:40 AM, Jamie Iles wrote:
> Now that there is a generic IRQ handler for multiple VIC devices use it
> for spear to help building multi platform kernels.
> 
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
>  arch/arm/Kconfig                                  |    1 +
>  arch/arm/mach-spear3xx/include/mach/entry-macro.S |   27 ---------------
>  arch/arm/mach-spear3xx/spear300_evb.c             |    2 +
>  arch/arm/mach-spear3xx/spear310_evb.c             |    2 +
>  arch/arm/mach-spear3xx/spear320_evb.c             |    2 +
>  arch/arm/mach-spear6xx/include/mach/entry-macro.S |   36 ---------------------
>  arch/arm/mach-spear6xx/spear600_evb.c             |    2 +
>  7 files changed, 9 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 32929ef..46d0319 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -956,6 +956,7 @@ config PLAT_SPEAR
>  	select CLKSRC_MMIO
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_CLK
> +	select MULTI_IRQ_HANDLER
>  	help
>  	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
>  
> diff --git a/arch/arm/mach-spear3xx/include/mach/entry-macro.S b/arch/arm/mach-spear3xx/include/mach/entry-macro.S
> index 53da422..de3bb41 100644
> --- a/arch/arm/mach-spear3xx/include/mach/entry-macro.S
> +++ b/arch/arm/mach-spear3xx/include/mach/entry-macro.S
> @@ -11,35 +11,8 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> -#include <asm/hardware/vic.h>
> -#include <mach/hardware.h>
> -
>  		.macro	disable_fiq
>  		.endm
>  
> -		.macro	get_irqnr_preamble, base, tmp
> -		.endm
> -
>  		.macro	arch_ret_to_user, tmp1, tmp2
>  		.endm
> -
> -		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
> -		ldr	\base, =VA_SPEAR3XX_ML1_VIC_BASE
> -		ldr	\irqstat, [\base, #VIC_IRQ_STATUS]	@ get status
> -		teq	\irqstat, #0
> -		beq	1001f				@ this will set/reset
> -							@ zero register
> -		/*
> -		 * Following code will find bit position of least significang
> -		 * bit set in irqstat, using following equation
> -		 * least significant bit set in n = (n & ~(n-1))
> -		 */
> -		sub	\tmp, \irqstat, #1		@ tmp = irqstat - 1
> -		mvn	\tmp, \tmp			@ tmp = ~tmp
> -		and	\irqstat, \irqstat, \tmp	@ irqstat &= tmp
> -		/* Now, irqstat is = bit no. of 1st bit set in vic irq status */
> -		clz	\tmp, \irqstat			@ tmp = leading zeros
> -		rsb	\irqnr, \tmp, #0x1F		@ irqnr = 32 - tmp - 1
> -
> -1001:		/* EQ will be set if no irqs pending */
> -		.endm
> diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
> index a5ff98e..61068ba 100644
> --- a/arch/arm/mach-spear3xx/spear300_evb.c
> +++ b/arch/arm/mach-spear3xx/spear300_evb.c
> @@ -11,6 +11,7 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> +#include <asm/hardware/vic.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach-types.h>
>  #include <mach/generic.h>
> @@ -67,6 +68,7 @@ MACHINE_START(SPEAR300, "ST-SPEAR300-EVB")
>  	.atag_offset	=	0x100,
>  	.map_io		=	spear3xx_map_io,
>  	.init_irq	=	spear3xx_init_irq,
> +	.handle_irq	=	vic_handle_irq,
>  	.timer		=	&spear3xx_timer,
>  	.init_machine	=	spear300_evb_init,
>  MACHINE_END
> diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
> index 45d180d..7903abe 100644
> --- a/arch/arm/mach-spear3xx/spear310_evb.c
> +++ b/arch/arm/mach-spear3xx/spear310_evb.c
> @@ -11,6 +11,7 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> +#include <asm/hardware/vic.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach-types.h>
>  #include <mach/generic.h>
> @@ -73,6 +74,7 @@ MACHINE_START(SPEAR310, "ST-SPEAR310-EVB")
>  	.atag_offset	=	0x100,
>  	.map_io		=	spear3xx_map_io,
>  	.init_irq	=	spear3xx_init_irq,
> +	.handle_irq	=	vic_handle_irq,
>  	.timer		=	&spear3xx_timer,
>  	.init_machine	=	spear310_evb_init,
>  MACHINE_END
> diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
> index 2287984..e9751f9 100644
> --- a/arch/arm/mach-spear3xx/spear320_evb.c
> +++ b/arch/arm/mach-spear3xx/spear320_evb.c
> @@ -11,6 +11,7 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> +#include <asm/hardware/vic.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach-types.h>
>  #include <mach/generic.h>
> @@ -71,6 +72,7 @@ MACHINE_START(SPEAR320, "ST-SPEAR320-EVB")
>  	.atag_offset	=	0x100,
>  	.map_io		=	spear3xx_map_io,
>  	.init_irq	=	spear3xx_init_irq,
> +	.handle_irq	=	vic_handle_irq,
>  	.timer		=	&spear3xx_timer,
>  	.init_machine	=	spear320_evb_init,
>  MACHINE_END
> diff --git a/arch/arm/mach-spear6xx/include/mach/entry-macro.S b/arch/arm/mach-spear6xx/include/mach/entry-macro.S
> index 8a0b0ed..d490a91 100644
> --- a/arch/arm/mach-spear6xx/include/mach/entry-macro.S
> +++ b/arch/arm/mach-spear6xx/include/mach/entry-macro.S
> @@ -11,44 +11,8 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> -#include <asm/hardware/vic.h>
> -#include <mach/hardware.h>
> -
>  		.macro	disable_fiq
>  		.endm
>  
> -		.macro	get_irqnr_preamble, base, tmp
> -		.endm
> -
>  		.macro	arch_ret_to_user, tmp1, tmp2
>  		.endm
> -
> -		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
> -		ldr	\base, =VA_SPEAR6XX_CPU_VIC_PRI_BASE
> -		ldr	\irqstat, [\base, #VIC_IRQ_STATUS]	@ get status
> -		mov	\irqnr, #0
> -		teq	\irqstat, #0
> -		bne	1001f
> -		ldr	\base, =VA_SPEAR6XX_CPU_VIC_SEC_BASE
> -		ldr	\irqstat, [\base, #VIC_IRQ_STATUS]	@ get status
> -		teq	\irqstat, #0
> -		beq	1002f				@ this will set/reset
> -							@ zero register
> -		mov	\irqnr, #32
> -1001:
> -		/*
> -		 * Following code will find bit position of least significang
> -		 * bit set in irqstat, using following equation
> -		 * least significant bit set in n = (n & ~(n-1))
> -		 */
> -		sub	\tmp, \irqstat, #1		@ tmp = irqstat - 1
> -		mvn	\tmp, \tmp			@ tmp = ~tmp
> -		and	\irqstat, \irqstat, \tmp	@ irqstat &= tmp
> -		/* Now, irqstat is = bit no. of 1st bit set in vic irq status */
> -		clz	\tmp, \irqstat			@ tmp = leading zeros
> -
> -		rsb	\tmp, \tmp, #0x1F		@ tmp = 32 - tmp - 1
> -		add	\irqnr, \irqnr, \tmp
> -
> -1002:		/* EQ will be set if no irqs pending */
> -		.endm
> diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
> index 8238fe3..ff139ed 100644
> --- a/arch/arm/mach-spear6xx/spear600_evb.c
> +++ b/arch/arm/mach-spear6xx/spear600_evb.c
> @@ -11,6 +11,7 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> +#include <asm/hardware/vic.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach-types.h>
>  #include <mach/generic.h>
> @@ -46,6 +47,7 @@ MACHINE_START(SPEAR600, "ST-SPEAR600-EVB")
>  	.atag_offset	=	0x100,
>  	.map_io		=	spear6xx_map_io,
>  	.init_irq	=	spear6xx_init_irq,
> +	.handle_irq	=	vic_handle_irq,
>  	.timer		=	&spear6xx_timer,
>  	.init_machine	=	spear600_evb_init,
>  MACHINE_END

Acked-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
