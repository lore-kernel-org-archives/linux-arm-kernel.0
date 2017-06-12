From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 12 Jun 2017 10:18:06 +0200
Subject: [PATCH 1/2] spi: rockchip: add support for "cs-gpios" dts property
In-Reply-To: <dfe87919-b2cc-37e8-1598-6b3c730ff356@rock-chips.com>
References: <1497248057-16550-1-git-send-email-jeffy.chen@rock-chips.com>
 <dfe87919-b2cc-37e8-1598-6b3c730ff356@rock-chips.com>
Message-ID: <CAMuHMdUDjtSNRiBxcBnAMdUEaCZbioPoRE1h=p9=BqHMGmQaEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 9:15 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2017/6/12 14:14, Jeffy Chen wrote:
>>
>> Support using "cs-gpios" property to specify cs gpios.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

>> index 83da493..02171b2 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
>> @@ -17,6 +17,7 @@ Required Properties:
>>          region.
>>   - interrupts: The interrupt number to the cpu. The interrupt specifier
>> format
>>                 depends on the interrupt controller.
>> +- cs-gpios : Specifies the gpio pins to be used for chipselects.
>
> It's not a required property, otherwise how other boards work as your
> patch 2 only add this for rk3399-gru.

>> --- a/drivers/spi/spi-rockchip.c
>> +++ b/drivers/spi/spi-rockchip.c

>> @@ -297,6 +302,50 @@ static void rockchip_spi_set_cs(struct spi_device
>> *spi, bool enable)
>>         pm_runtime_put_sync(rs->dev);
>>   }
>>   +static int rockchip_spi_setup(struct spi_device *spi)
>> +{
>> +       int ret = 0;
>> +       unsigned long flags = (spi->mode & SPI_CS_HIGH) ?
>> +                             GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
>> +       struct rockchip_spi_data *data = spi_get_ctldata(spi);
>> +
>> +       if (!gpio_is_valid(spi->cs_gpio))
>> +               return 0;

> return -EINVAL?

Isn't this check meant to fall back to hardware CS if no cs-gpios property
is present?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
