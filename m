From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 16 Nov 2010 07:32:14 +0200
Subject: [PATCH v2 1/2] msm: gpio: Add v2 gpio support to MSM SoCs.
In-Reply-To: <1289852419-7122-1-git-send-email-gbean@codeaurora.org>
References: <1289852419-7122-1-git-send-email-gbean@codeaurora.org>
Message-ID: <20101116053214.GB15652@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Mon, Nov 15, 2010 at 12:20:18PM -0800, Gregory Bean wrote:
> Beginning with the MSM8x60, the hardware block responsible for gpio
> support changes.  Provide gpiolib support for the new v2 architecture.
> 
> Cc: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Gregory Bean <gbean@codeaurora.org>
> ---

[snip]

> +struct msm_gpio_dev {
> +	struct gpio_chip gpio_chip;
> +};

This wrapper struct seems redundant. You only use it in msm_gpio_probe, where 
you can just use 'struct gpio_chip' directly.

> +static DEFINE_SPINLOCK(tlmm_lock);
> +
> +static inline struct msm_gpio_dev *to_msm_gpio_dev(struct gpio_chip *chip)
> +{
> +	return container_of(chip, struct msm_gpio_dev, gpio_chip);
> +}

Not used.

> +static inline void set_gpio_bits(unsigned n, void __iomem *reg)
> +{
> +	writel(readl(reg) | n, reg);
> +}

Move the locking in, or better, eliminate it, since it's only used in 
msm_gpio_direction_output.

[snip]

> +static struct platform_device msm_device_gpio = {
> +	.name = "msmgpio",
> +	.id   = 0,

Redundant.

> +};

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
