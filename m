From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Thu, 26 Jul 2018 18:38:25 +0900
Subject: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
In-Reply-To: <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
 <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>
 <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
Message-ID: <001b01d424c4$66e04230$34a0c690$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andy,

Thank you for your check!


> From: Andy Shevchenko [mailto:andy.shevchenko at gmail.com]
> Sent: Thursday, July 26, 2018 5:46 PM
> To: Hayashibara, Keiji/?? ?? <hayashibara.keiji@socionext.com>
> Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
> 
> On Thu, Jul 26, 2018 at 10:09 AM, Keiji Hayashibara <hayashibara.keiji@socionext.com> wrote:
> > Add SPI controller driver implemented in Socionext UniPhier SoCs.
> >
> > UniPhier SoCs have two types SPI controllers; SCSSI supports a single
> > channel, and MCSSI supports multiple channels.
> > This driver supports SCSSI only.
> >
> > This controller has 32bit TX/RX FIFO with depth of eight entry, and
> > supports the SPI master mode only.
> >
> > This commit is implemented in PIO transfer mode, not DMA transfer.
> 
> Few style realted comments.
> 
> > +#include <asm/unaligned.h>
> > +#include <linux/kernel.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/spi/spi.h>
> 
> Slightly better to keep them in order and put asm/* at the last.

I see. I will modify this.


> > +#define SSI_TIMEOUT            2000    /* ms */
> 
> SSI_TIMEOUT_MS ?
> 
> > +#define SSI_CTL                        0x0
> 
> Slightly better to keep same width for the addresses, like 0x00 here.
> 
> > +#define SSI_CKS                        0x4
> 
> > +#define SSI_TXWDS              0x8
> 
> > +#define SSI_RXWDS              0xc
> 
> Ditto.

I will modify about above.

> 
> > +static int uniphier_spi_set_baudrate(struct spi_device *spi, unsigned
> > +int speed) {
> > +       struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
> > +       u32 val, ckrat;
> > +
> > +       /*
> > +        * the supported rates are even numbers from 4 to 254. (4,6,8...254)
> > +        * round up as we look for equal or less speed
> > +        */
> > +       ckrat = DIV_ROUND_UP(clk_get_rate(priv->clk), speed);
> 
> > +       ckrat = roundup(ckrat, 2);
> 
> ckrat += ckrat & 1;
> 
> ?

It's simple. I will modify.


> > +       /* check if requested speed is too small */
> > +       if (ckrat > SSI_MAX_CLK_DIVIDER)
> 
> > +               return -EINVAL;
> 
> So, does this critical?

If set the value to SSI_MAX_CLK_DIVIDER, the clock frequency will be set high.
I don't change it to high frequency, and it is daringly an error.
On the other hand, when changing to low frequency, I will change it automatically.

> > +
> > +       if (ckrat < SSI_MIN_CLK_DIVIDER)
> > +               ckrat = SSI_MIN_CLK_DIVIDER;
> 
> clamp_val()  / max() ?

I will modify it to use max().

> 
> > +       val = readl(priv->base + SSI_CKS);
> > +       val &= ~SSI_CKS_CKRAT_MASK;
> > +       val |= ckrat & SSI_CKS_CKRAT_MASK;
> > +       writel(val, priv->base + SSI_CKS);
> > +
> > +       return 0;
> > +}
> 
> > +       priv->irq = platform_get_irq(pdev, 0);
> > +       if (priv->irq < 0) {
> > +               dev_err(&pdev->dev, "failed to get IRQ\n");
> 
> > +               ret = -ENXIO;
> 
> What's wrong with
> 
> ret = priv->irq;
> 
> ?

I will modify it.

> > +               goto out_disable_clk;
> > +       }
> 
> > +static const struct of_device_id uniphier_spi_match[] = {
> > +       { .compatible = "socionext,uniphier-scssi", },
> 
> > +       { /* sentinel */ },
> 
> Slightly better without comma.

OK. I will modify this.

-----------------
Best Regards,
Keiji Hayashibara



> > +};
> > +MODULE_DEVICE_TABLE(of, uniphier_spi_match);
> 
> --
> With Best Regards,
> Andy Shevchenko
