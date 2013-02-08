From: rmallon@gmail.com (Ryan Mallon)
Date: Fri, 08 Feb 2013 17:08:08 +1100
Subject: [PATCH 2/2] ARM: ep93xx: bump IRQ offset to 64
In-Reply-To: <1360168544-20376-1-git-send-email-linus.walleij@linaro.org>
References: <1360168544-20376-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <51149648.80402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The patch looks okay to me. My ep93xx hardware isn't setup at the
moment. I've Cc'ed Hartley, who might be able to test this. If not, I'll
try and find some time to drag my board out and give it a test over the
weekend.

~Ryan

On 07/02/13 03:35, Linus Walleij wrote:
> The EP93XX IRQs offset from zero, which is illegal, since Linux
> IRQ 0 is NO_IRQ.
> 
> Cc: Florian Fainelli <florian@openwrt.org>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Todor Colov <todorcolov@gmail.com>
> Cc: Rafal Prylowski <prylowski@metasoft.pl>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> It'd be nice if someone using the EP93xx could test this patch
> on top of the latest v3.8 RC.
> ---
>  arch/arm/mach-ep93xx/core.c              |   6 +-
>  arch/arm/mach-ep93xx/include/mach/irqs.h | 122 ++++++++++++++++---------------
>  2 files changed, 67 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index e85bf17..4490b04 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -179,8 +179,10 @@ struct sys_timer ep93xx_timer = {
>   *************************************************************************/
>  void __init ep93xx_init_irq(void)
>  {
> -	vic_init(EP93XX_VIC1_BASE, 0, EP93XX_VIC1_VALID_IRQ_MASK, 0);
> -	vic_init(EP93XX_VIC2_BASE, 32, EP93XX_VIC2_VALID_IRQ_MASK, 0);
> +	vic_init(EP93XX_VIC1_BASE, EP93XX_VIC1_IRQ_BASE,
> +		 EP93XX_VIC1_VALID_IRQ_MASK, 0);
> +	vic_init(EP93XX_VIC2_BASE, EP93XX_VIC2_IRQ_BASE,
> +		 EP93XX_VIC2_VALID_IRQ_MASK, 0);
>  }
>  
>  
> diff --git a/arch/arm/mach-ep93xx/include/mach/irqs.h b/arch/arm/mach-ep93xx/include/mach/irqs.h
> index ff98390..a96c50e 100644
> --- a/arch/arm/mach-ep93xx/include/mach/irqs.h
> +++ b/arch/arm/mach-ep93xx/include/mach/irqs.h
> @@ -5,69 +5,73 @@
>  #ifndef __ASM_ARCH_IRQS_H
>  #define __ASM_ARCH_IRQS_H
>  
> -#define IRQ_EP93XX_COMMRX		2
> -#define IRQ_EP93XX_COMMTX		3
> -#define IRQ_EP93XX_TIMER1		4
> -#define IRQ_EP93XX_TIMER2		5
> -#define IRQ_EP93XX_AACINTR		6
> -#define IRQ_EP93XX_DMAM2P0		7
> -#define IRQ_EP93XX_DMAM2P1		8
> -#define IRQ_EP93XX_DMAM2P2		9
> -#define IRQ_EP93XX_DMAM2P3		10
> -#define IRQ_EP93XX_DMAM2P4		11
> -#define IRQ_EP93XX_DMAM2P5		12
> -#define IRQ_EP93XX_DMAM2P6		13
> -#define IRQ_EP93XX_DMAM2P7		14
> -#define IRQ_EP93XX_DMAM2P8		15
> -#define IRQ_EP93XX_DMAM2P9		16
> -#define IRQ_EP93XX_DMAM2M0		17
> -#define IRQ_EP93XX_DMAM2M1		18
> -#define IRQ_EP93XX_GPIO0MUX		19
> -#define IRQ_EP93XX_GPIO1MUX		20
> -#define IRQ_EP93XX_GPIO2MUX		21
> -#define IRQ_EP93XX_GPIO3MUX		22
> -#define IRQ_EP93XX_UART1RX		23
> -#define IRQ_EP93XX_UART1TX		24
> -#define IRQ_EP93XX_UART2RX		25
> -#define IRQ_EP93XX_UART2TX		26
> -#define IRQ_EP93XX_UART3RX		27
> -#define IRQ_EP93XX_UART3TX		28
> -#define IRQ_EP93XX_KEY			29
> -#define IRQ_EP93XX_TOUCH		30
> +#define EP93XX_VIC1_IRQ_BASE		64
> +#define EP93XX_VIC2_IRQ_BASE		(EP93XX_VIC1_IRQ_BASE + 32)
> +#define EP93XX_VIC2_IRQ_END		(EP93XX_VIC2_IRQ_BASE + 32)
> +
> +#define IRQ_EP93XX_COMMRX		(EP93XX_VIC1_IRQ_BASE + 2)
> +#define IRQ_EP93XX_COMMTX		(EP93XX_VIC1_IRQ_BASE + 3)
> +#define IRQ_EP93XX_TIMER1		(EP93XX_VIC1_IRQ_BASE + 4)
> +#define IRQ_EP93XX_TIMER2		(EP93XX_VIC1_IRQ_BASE + 5)
> +#define IRQ_EP93XX_AACINTR		(EP93XX_VIC1_IRQ_BASE + 6)
> +#define IRQ_EP93XX_DMAM2P0		(EP93XX_VIC1_IRQ_BASE + 7)
> +#define IRQ_EP93XX_DMAM2P1		(EP93XX_VIC1_IRQ_BASE + 8)
> +#define IRQ_EP93XX_DMAM2P2		(EP93XX_VIC1_IRQ_BASE + 9)
> +#define IRQ_EP93XX_DMAM2P3		(EP93XX_VIC1_IRQ_BASE + 10)
> +#define IRQ_EP93XX_DMAM2P4		(EP93XX_VIC1_IRQ_BASE + 11)
> +#define IRQ_EP93XX_DMAM2P5		(EP93XX_VIC1_IRQ_BASE + 12)
> +#define IRQ_EP93XX_DMAM2P6		(EP93XX_VIC1_IRQ_BASE + 13)
> +#define IRQ_EP93XX_DMAM2P7		(EP93XX_VIC1_IRQ_BASE + 14)
> +#define IRQ_EP93XX_DMAM2P8		(EP93XX_VIC1_IRQ_BASE + 15)
> +#define IRQ_EP93XX_DMAM2P9		(EP93XX_VIC1_IRQ_BASE + 16)
> +#define IRQ_EP93XX_DMAM2M0		(EP93XX_VIC1_IRQ_BASE + 17)
> +#define IRQ_EP93XX_DMAM2M1		(EP93XX_VIC1_IRQ_BASE + 18)
> +#define IRQ_EP93XX_GPIO0MUX		(EP93XX_VIC1_IRQ_BASE + 19)
> +#define IRQ_EP93XX_GPIO1MUX		(EP93XX_VIC1_IRQ_BASE + 20)
> +#define IRQ_EP93XX_GPIO2MUX		(EP93XX_VIC1_IRQ_BASE + 21)
> +#define IRQ_EP93XX_GPIO3MUX		(EP93XX_VIC1_IRQ_BASE + 22)
> +#define IRQ_EP93XX_UART1RX		(EP93XX_VIC1_IRQ_BASE + 23)
> +#define IRQ_EP93XX_UART1TX		(EP93XX_VIC1_IRQ_BASE + 24)
> +#define IRQ_EP93XX_UART2RX		(EP93XX_VIC1_IRQ_BASE + 25)
> +#define IRQ_EP93XX_UART2TX		(EP93XX_VIC1_IRQ_BASE + 26)
> +#define IRQ_EP93XX_UART3RX		(EP93XX_VIC1_IRQ_BASE + 27)
> +#define IRQ_EP93XX_UART3TX		(EP93XX_VIC1_IRQ_BASE + 28)
> +#define IRQ_EP93XX_KEY			(EP93XX_VIC1_IRQ_BASE + 29)
> +#define IRQ_EP93XX_TOUCH		(EP93XX_VIC1_IRQ_BASE + 30)
>  #define EP93XX_VIC1_VALID_IRQ_MASK	0x7ffffffc
>  
> -#define IRQ_EP93XX_EXT0			32
> -#define IRQ_EP93XX_EXT1			33
> -#define IRQ_EP93XX_EXT2			34
> -#define IRQ_EP93XX_64HZ			35
> -#define IRQ_EP93XX_WATCHDOG		36
> -#define IRQ_EP93XX_RTC			37
> -#define IRQ_EP93XX_IRDA			38
> -#define IRQ_EP93XX_ETHERNET		39
> -#define IRQ_EP93XX_EXT3			40
> -#define IRQ_EP93XX_PROG			41
> -#define IRQ_EP93XX_1HZ			42
> -#define IRQ_EP93XX_VSYNC		43
> -#define IRQ_EP93XX_VIDEO_FIFO		44
> -#define IRQ_EP93XX_SSP1RX		45
> -#define IRQ_EP93XX_SSP1TX		46
> -#define IRQ_EP93XX_GPIO4MUX		47
> -#define IRQ_EP93XX_GPIO5MUX		48
> -#define IRQ_EP93XX_GPIO6MUX		49
> -#define IRQ_EP93XX_GPIO7MUX		50
> -#define IRQ_EP93XX_TIMER3		51
> -#define IRQ_EP93XX_UART1		52
> -#define IRQ_EP93XX_SSP			53
> -#define IRQ_EP93XX_UART2		54
> -#define IRQ_EP93XX_UART3		55
> -#define IRQ_EP93XX_USB			56
> -#define IRQ_EP93XX_ETHERNET_PME		57
> -#define IRQ_EP93XX_DSP			58
> -#define IRQ_EP93XX_GPIO_AB		59
> -#define IRQ_EP93XX_SAI			60
> +#define IRQ_EP93XX_EXT0			(EP93XX_VIC2_IRQ_BASE + 0)
> +#define IRQ_EP93XX_EXT1			(EP93XX_VIC2_IRQ_BASE + 1)
> +#define IRQ_EP93XX_EXT2			(EP93XX_VIC2_IRQ_BASE + 2)
> +#define IRQ_EP93XX_64HZ			(EP93XX_VIC2_IRQ_BASE + 3)
> +#define IRQ_EP93XX_WATCHDOG		(EP93XX_VIC2_IRQ_BASE + 4)
> +#define IRQ_EP93XX_RTC			(EP93XX_VIC2_IRQ_BASE + 5)
> +#define IRQ_EP93XX_IRDA			(EP93XX_VIC2_IRQ_BASE + 6)
> +#define IRQ_EP93XX_ETHERNET		(EP93XX_VIC2_IRQ_BASE + 7)
> +#define IRQ_EP93XX_EXT3			(EP93XX_VIC2_IRQ_BASE + 8)
> +#define IRQ_EP93XX_PROG			(EP93XX_VIC2_IRQ_BASE + 9)
> +#define IRQ_EP93XX_1HZ			(EP93XX_VIC2_IRQ_BASE + 10)
> +#define IRQ_EP93XX_VSYNC		(EP93XX_VIC2_IRQ_BASE + 11)
> +#define IRQ_EP93XX_VIDEO_FIFO		(EP93XX_VIC2_IRQ_BASE + 12)
> +#define IRQ_EP93XX_SSP1RX		(EP93XX_VIC2_IRQ_BASE + 13)
> +#define IRQ_EP93XX_SSP1TX		(EP93XX_VIC2_IRQ_BASE + 14)
> +#define IRQ_EP93XX_GPIO4MUX		(EP93XX_VIC2_IRQ_BASE + 15)
> +#define IRQ_EP93XX_GPIO5MUX		(EP93XX_VIC2_IRQ_BASE + 16)
> +#define IRQ_EP93XX_GPIO6MUX		(EP93XX_VIC2_IRQ_BASE + 17)
> +#define IRQ_EP93XX_GPIO7MUX		(EP93XX_VIC2_IRQ_BASE + 18)
> +#define IRQ_EP93XX_TIMER3		(EP93XX_VIC2_IRQ_BASE + 19)
> +#define IRQ_EP93XX_UART1		(EP93XX_VIC2_IRQ_BASE + 20)
> +#define IRQ_EP93XX_SSP			(EP93XX_VIC2_IRQ_BASE + 21)
> +#define IRQ_EP93XX_UART2		(EP93XX_VIC2_IRQ_BASE + 22)
> +#define IRQ_EP93XX_UART3		(EP93XX_VIC2_IRQ_BASE + 23)
> +#define IRQ_EP93XX_USB			(EP93XX_VIC2_IRQ_BASE + 24)
> +#define IRQ_EP93XX_ETHERNET_PME		(EP93XX_VIC2_IRQ_BASE + 25)
> +#define IRQ_EP93XX_DSP			(EP93XX_VIC2_IRQ_BASE + 26)
> +#define IRQ_EP93XX_GPIO_AB		(EP93XX_VIC2_IRQ_BASE + 27)
> +#define IRQ_EP93XX_SAI			(EP93XX_VIC2_IRQ_BASE + 28)
>  #define EP93XX_VIC2_VALID_IRQ_MASK	0x1fffffff
>  
> -#define NR_EP93XX_IRQS			(64 + 24)
> +#define NR_EP93XX_IRQS			(EP93XX_VIC2_IRQ_END + 24)
>  
>  #define EP93XX_BOARD_IRQ(x)		(NR_EP93XX_IRQS + (x))
>  #define EP93XX_BOARD_IRQS		32
> 
