From: radu.pirea@microchip.com (Radu Pirea)
Date: Thu, 26 Jul 2018 13:57:35 +0300
Subject: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
In-Reply-To: <001b01d424c4$66e04230$34a0c690$@socionext.com>
References: <1532588943-19481-1-git-send-email-hayashibara.keiji@socionext.com>
 <1532588943-19481-3-git-send-email-hayashibara.keiji@socionext.com>
 <CAHp75VcEdxDEo0T5_9BzOPaeaqjbmbrWmaE9+ZuUDYhjh6jpVw@mail.gmail.com>
 <001b01d424c4$66e04230$34a0c690$@socionext.com>
Message-ID: <ab87c6a7-4ead-6492-9e47-42e6ab701d1c@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/26/2018 12:38 PM, Keiji Hayashibara wrote:
> Hello Andy,
> 
> Thank you for your check!
> 
> 
>> From: Andy Shevchenko [mailto:andy.shevchenko at gmail.com]
>> Sent: Thursday, July 26, 2018 5:46 PM
>> To: Hayashibara, Keiji/?? ?? <hayashibara.keiji@socionext.com>
>> Subject: Re: [PATCH v2 2/2] spi: add SPI controller driver for UniPhier SoC
>>
>> On Thu, Jul 26, 2018 at 10:09 AM, Keiji Hayashibara <hayashibara.keiji@socionext.com> wrote:
>>> Add SPI controller driver implemented in Socionext UniPhier SoCs.
>>>
>>> UniPhier SoCs have two types SPI controllers; SCSSI supports a single
>>> channel, and MCSSI supports multiple channels.
>>> This driver supports SCSSI only.
>>>
>>> This controller has 32bit TX/RX FIFO with depth of eight entry, and
>>> supports the SPI master mode only.
>>>
>>> This commit is implemented in PIO transfer mode, not DMA transfer.
>>
>> Few style realted comments.
>>
>>> +#include <asm/unaligned.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/bitfield.h>
>>> +#include <linux/bitops.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/io.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_platform.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/spi/spi.h>
>>
>> Slightly better to keep them in order and put asm/* at the last.
> 
> I see. I will modify this.
> 
> 
>>> +#define SSI_TIMEOUT            2000    /* ms */
>>
>> SSI_TIMEOUT_MS ?
>>
>>> +#define SSI_CTL                        0x0
>>
>> Slightly better to keep same width for the addresses, like 0x00 here.
>>
>>> +#define SSI_CKS                        0x4
>>
>>> +#define SSI_TXWDS              0x8
>>
>>> +#define SSI_RXWDS              0xc
>>
>> Ditto.
> 
> I will modify about above.
> 
>>
>>> +static int uniphier_spi_set_baudrate(struct spi_device *spi, unsigned
>>> +int speed) {
>>> +       struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
>>> +       u32 val, ckrat;
>>> +
>>> +       /*
>>> +        * the supported rates are even numbers from 4 to 254. (4,6,8...254)
>>> +        * round up as we look for equal or less speed
>>> +        */
>>> +       ckrat = DIV_ROUND_UP(clk_get_rate(priv->clk), speed);
>>
>>> +       ckrat = roundup(ckrat, 2);
>>
>> ckrat += ckrat & 1;
>>
>> ?
> 
> It's simple. I will modify.
> 
> 
>>> +       /* check if requested speed is too small */
>>> +       if (ckrat > SSI_MAX_CLK_DIVIDER)
>>
>>> +               return -EINVAL;
>>
>> So, does this critical?
> 
> If set the value to SSI_MAX_CLK_DIVIDER, the clock frequency will be set high.
> I don't change it to high frequency, and it is daringly an error.
> On the other hand, when changing to low frequency, I will change it automatically.
> 
>>> +
>>> +       if (ckrat < SSI_MIN_CLK_DIVIDER)
>>> +               ckrat = SSI_MIN_CLK_DIVIDER;

In fact you don't need this checks. You already set in probe function this.
master->max_speed_hz = DIV_ROUND_UP(clksrc, SSI_MIN_CLK_DIVIDER);
master->min_speed_hz = DIV_ROUND_UP(clksrc, SSI_MAX_CLK_DIVIDER);

The SPI core will check if transfer speed is higher than controller 
speed and if is, will set the transfer speed to master->max_speed_hz. In 
case of master->min_speed_hz, if transfer speed is lower than 
master->min_speed_hz __spi_validate(drivers/spi/spi.c) will return -EINVAL.

>>
>> clamp_val()  / max() ?
> 
> I will modify it to use max().
> 
>>
>>> +       val = readl(priv->base + SSI_CKS);
>>> +       val &= ~SSI_CKS_CKRAT_MASK;
>>> +       val |= ckrat & SSI_CKS_CKRAT_MASK;
>>> +       writel(val, priv->base + SSI_CKS);
>>> +
>>> +       return 0;
>>> +}
>>
>>> +       priv->irq = platform_get_irq(pdev, 0);
>>> +       if (priv->irq < 0) {
>>> +               dev_err(&pdev->dev, "failed to get IRQ\n");
>>
>>> +               ret = -ENXIO;
>>
>> What's wrong with
>>
>> ret = priv->irq;
>>
>> ?
> 
> I will modify it.
> 
>>> +               goto out_disable_clk;
>>> +       }
>>
>>> +static const struct of_device_id uniphier_spi_match[] = {
>>> +       { .compatible = "socionext,uniphier-scssi", },
>>
>>> +       { /* sentinel */ },
>>
>> Slightly better without comma.
> 
> OK. I will modify this.
> 
> -----------------
> Best Regards,
> Keiji Hayashibara
> 
> 
> 
>>> +};
>>> +MODULE_DEVICE_TABLE(of, uniphier_spi_match);
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
