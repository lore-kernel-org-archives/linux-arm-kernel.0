From: GKing@nvidia.com (Gary King)
Date: Mon, 15 Mar 2010 10:41:51 -0700
Subject: [RFC/PATCH] ARM: add Tegra support
In-Reply-To: <4B96798C.6060201@compulab.co.il>
References: <4B96798C.6060201@compulab.co.il>
Message-ID: <A0A1E7539300DF49AA383E614C7827BC048FA21C2F@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Hopefully I've quoted enough context to associate the comments below back to their original source:

> --- /dev/null
> +++ b/arch/arm/mach-tegra/clock.c
> ...
> +		}
> +	}
> +	c->refcnt++;
> +err:

The reference counting in this file is not thread safe.

> --- /dev/null
> +++ b/arch/arm/mach-tegra/tegra2_clocks.c
> ...
> +/* clk_m functions */
> +static unsigned long tegra2_clk_m_autodetect_rate(struct clk *c)
> +{
> +	u32 clk_autodetect;
> +	u32 auto_clk_ctl = clk_readl(0x50) & ~(3<<30);
> +
> ...
> +}

The switch statement here doesn't provide enough tolerance for variability in the source oscillator or crystal; there should be a range of +-2-3 units to cover variability & jitter.

> --- /dev/null
> +++ b/arch/arm/mach-tegra/gpio.c
> ...
> +static int tegra_gpio_irq_set_type(unsigned int irq, unsigned int type)
> +{
> +	int gpio = irq - INT_GPIO_BASE;
> +	struct tegra_gpio_bank *bank = get_irq_data(irq);
> +	int port = GPIO_PORT(gpio);

This should be get_irq_chip_data(irq)

> --- /dev/null
> +++ b/arch/arm/mach-tegra/include/mach/uncompress.h
> ...
> +
> +static void putc(int c)
> +{
> +	volatile u8 *uart = (volatile u8 *)(TEGRA_UARTD_BASE);
> +	int shift = 2;

UARTD as the serial console is Harmony-specific; the specific UART should either be protected by a MACH_HARMONY ifdef or hoisted to a MACH_HARMONY-only header-file.

> --- /dev/null
> +++ b/arch/arm/mach-tegra/include/mach/debug-macro.S
> ...
> +        ldrne   \rx, =IO_APB_VIRT       @ virtual
> +        orr     \rx, \rx, #0x6300	@ UART D
> +	.endm

Same comment as above re: UARTD.

- Gary 
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
