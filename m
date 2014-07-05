From: jogo@openwrt.org (Jonas Gorski)
Date: Sat, 5 Jul 2014 20:56:16 +0200
Subject: [PATCH v2 2/2] spi: add driver for Rockchip RK3xxx SoCs
 integrated SPI
In-Reply-To: <20140704183249.GC14896@sirena.org.uk>
References: <1403582852-9751-1-git-send-email-addy.ke@rock-chips.com>
 <1404176639-3315-1-git-send-email-addy.ke@rock-chips.com>
 <20140704183249.GC14896@sirena.org.uk>
Message-ID: <CAOiHx=msQraNEiVoAZOoFS0Bf-R65nAN3FXL7qUvuaU-a=PqGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 4, 2014 at 8:32 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 01, 2014 at 09:03:59AM +0800, addy ke wrote:
>> In order to facilitate understanding, rockchip SPI controller IP design
>> looks similar in its registers to designware. But IC implementation
>> is different from designware, So we need a dedicated driver for Rockchip
>> RK3XXX SoCs integrated SPI. The main differences:
>
> This looks good overall, a nice clean driver.  I've applied it but there
> are a few small issues that need fixing up which I've noted below, can
> you please send followup patches dealing with these?
>
>> +      * static void spi_set_cs(struct spi_device *spi, bool enable)
>> +      * {
>> +      *              if (spi->mode & SPI_CS_HIGH)
>> +      *                      enable = !enable;
>> +      *
>> +      *              if (spi->cs_gpio >= 0)
>> +      *                      gpio_set_value(spi->cs_gpio, !enable);
>> +      *              else if (spi->master->set_cs)
>> +      *              spi->master->set_cs(spi, !enable);
>> +      * }
>> +      *
>> +      * Note: enable(rockchip_spi_set_cs) = !enable(spi_set_cs)
>> +      */
>
> So, the point here is that chip select is an active low signal by
> default which means that if chip select is asserted we have a low logic
> level and the parameter means "asserted" not "logic level for the
> output".  It doesn't really matter but it might be clearer to say so
> directly.
>
>> +     if (spi->mode & SPI_CS_HIGH) {
>> +             dev_err(rs->dev, "spi_cs_hign: not support\n");
>> +             return -EINVAL;
>
> Typo here (high).

This whole check looks bogus and should probably be removed. Either
the driver/hardware does not support SPI_CS_HIGH, then the
master->mode_bits set in rockchip_spi_probe are wrong and SPI_CS_HIGH
should be removed. The common code already ensures that spi_device's
mode match the master's mode_bits, so the condition then could never
be true.
Or the driver/hardware does actually support it as it claims with it
mode_bits, then the check is wrong and it will wrongfully rejects
spi_devices using/requiring SPI_CS_HIGH.

Going that the rockchip_spi_set_cs has this extra explanation about
enable being inverted with CS_HIGH, I would guess the latter.


Jonas
