From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 26 Jul 2018 11:46:12 +0300
Subject: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
In-Reply-To: <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
 <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 10:09 AM, Keiji Hayashibara
<hayashibara.keiji@socionext.com> wrote:
> Add SPI controller driver implemented in Socionext UniPhier SoCs.
>
> UniPhier SoCs have two types SPI controllers; SCSSI supports a
> single channel, and MCSSI supports multiple channels.
> This driver supports SCSSI only.
>
> This controller has 32bit TX/RX FIFO with depth of eight entry,
> and supports the SPI master mode only.
>
> This commit is implemented in PIO transfer mode, not DMA transfer.

Few style realted comments.

> +#include <asm/unaligned.h>
> +#include <linux/kernel.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>

Slightly better to keep them in order and put asm/* at the last.

> +#define SSI_TIMEOUT            2000    /* ms */

SSI_TIMEOUT_MS ?

> +#define SSI_CTL                        0x0

Slightly better to keep same width for the addresses, like 0x00 here.

> +#define SSI_CKS                        0x4

> +#define SSI_TXWDS              0x8

> +#define SSI_RXWDS              0xc

Ditto.


> +static int uniphier_spi_set_baudrate(struct spi_device *spi, unsigned int speed)
> +{
> +       struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> +       u32 val, ckrat;
> +
> +       /*
> +        * the supported rates are even numbers from 4 to 254. (4,6,8...254)
> +        * round up as we look for equal or less speed
> +        */
> +       ckrat = DIV_ROUND_UP(clk_get_rate(priv->clk), speed);

> +       ckrat = roundup(ckrat, 2);

ckrat += ckrat & 1;

?

> +       /* check if requested speed is too small */
> +       if (ckrat > SSI_MAX_CLK_DIVIDER)

> +               return -EINVAL;

So, does this critical?

> +
> +       if (ckrat < SSI_MIN_CLK_DIVIDER)
> +               ckrat = SSI_MIN_CLK_DIVIDER;

clamp_val()  / max() ?

> +       val = readl(priv->base + SSI_CKS);
> +       val &= ~SSI_CKS_CKRAT_MASK;
> +       val |= ckrat & SSI_CKS_CKRAT_MASK;
> +       writel(val, priv->base + SSI_CKS);
> +
> +       return 0;
> +}

> +       priv->irq = platform_get_irq(pdev, 0);
> +       if (priv->irq < 0) {
> +               dev_err(&pdev->dev, "failed to get IRQ\n");

> +               ret = -ENXIO;

What's wrong with

ret = priv->irq;

?

> +               goto out_disable_clk;
> +       }

> +static const struct of_device_id uniphier_spi_match[] = {
> +       { .compatible = "socionext,uniphier-scssi", },

> +       { /* sentinel */ },

Slightly better without comma.

> +};
> +MODULE_DEVICE_TABLE(of, uniphier_spi_match);

-- 
With Best Regards,
Andy Shevchenko
