From: baruch@tkos.co.il (Baruch Siach)
Date: Sat, 13 Nov 2010 21:25:55 +0200
Subject: [PATCH 1/2] msm: gpio: Add v2 gpio support to MSM SoCs.
In-Reply-To: <1289585342-21341-1-git-send-email-gbean@codeaurora.org>
References: <1289585342-21341-1-git-send-email-gbean@codeaurora.org>
Message-ID: <20101113192555.GA23794@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Fri, Nov 12, 2010 at 10:09:01AM -0800, Gregory Bean wrote:
> Beginning with the MSM8x60, the hardware block responsible for gpio
> support changes.  Provide gpiolib support for the new v2 architecture.
> 
> Signed-off-by: Gregory Bean <gbean@codeaurora.org>
> ---

[snip]

> +static inline void clr_gpio_bits(unsigned n, void __iomem *reg)
> +{
> +	writel(readl(reg) & ~n, reg);

IMO you should move the locking here. And since the only user of this function 
is msm_gpio_direction_input, I'd eliminate it altogether.

> +}

[snip]

> +static int msm_gpio_direction_input(struct gpio_chip *chip, unsigned 
> offset)
> +{
> +	unsigned long irq_flags;
> +
> +	spin_lock_irqsave(&tlmm_lock, irq_flags);
> +	clr_gpio_bits(BIT(GPIO_OE_BIT), GPIO_CONFIG(offset));
> +	spin_unlock_irqrestore(&tlmm_lock, irq_flags);
> +	return 0;
> +}

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
