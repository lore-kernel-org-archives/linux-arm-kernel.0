From: hramrach@gmail.com (Michal Suchanek)
Date: Tue, 14 Jun 2016 06:34:45 +0200
Subject: [linux-sunxi] [PATCH v3 10/13] spi: sunxi: merge sun4i and sun6i
 SPI driver
In-Reply-To: <CAGRGNgVONS+i=57D52VeW8J6SvfmX=iG+3VpxNS8=kJOV+WSLw@mail.gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
 <ad0ec30ef6b01f58e1b3b92da06e6cbd5c947354.1465490774.git.hramrach@gmail.com>
 <CAGRGNgVONS+i=57D52VeW8J6SvfmX=iG+3VpxNS8=kJOV+WSLw@mail.gmail.com>
Message-ID: <CAOMqctQD=o6YBk-QRiqbE9Cj+ZAH1nAM33rW6ZHefV8dU3aucQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 14 June 2016 at 01:43, Julian Calaby <julian.calaby@gmail.com> wrote:
> Hi Michal,
>
> On Tue, Jun 14, 2016 at 3:46 AM, Michal Suchanek <hramrach@gmail.com> wrote:
>> The drivers are very similar and share multiple flaws which needed
>> separate fixes for both drivers.
>>
>> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>> ---
>>  drivers/spi/Kconfig     |   8 +-
>>  drivers/spi/Makefile    |   1 -
>>  drivers/spi/spi-sun4i.c | 156 +++++++++++--
>>  drivers/spi/spi-sun6i.c | 598 ------------------------------------------------
>>  4 files changed, 143 insertions(+), 620 deletions(-)
>>  delete mode 100644 drivers/spi/spi-sun6i.c
>>
>> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
>> index 0b8e6c6..c76f8e4 100644
>> --- a/drivers/spi/spi-sun4i.c
>> +++ b/drivers/spi/spi-sun4i.c
>> @@ -279,9 +321,14 @@ static int sunxi_spi_transfer_one(struct spi_master *master,
>>         reg = sunxi_spi_read(sspi, SUNXI_TFR_CTL_REG);
>>
>>         /* Reset FIFOs */
>> -       sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG,
>> -                       reg | sspi_bits(sspi, SUNXI_CTL_RF_RST) |
>> -                       sspi_bits(sspi, SUNXI_CTL_TF_RST));
>> +       if (sspi->type == SPI_SUN4I)
>> +               sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG,
>> +                               reg | sspi_bits(sspi, SUNXI_CTL_RF_RST) |
>> +                               sspi_bits(sspi, SUNXI_CTL_TF_RST));
>> +       else
>> +               sunxi_spi_write(sspi, SUNXI_FIFO_CTL_REG,
>> +                               sspi_bits(sspi, SUNXI_CTL_RF_RST) |
>> +                               sspi_bits(sspi, SUNXI_CTL_TF_RST));
>
> If we're already doing different stuff for each generation of the IP,
> why not just use the register offsets and bit definitions directly?

Because having (*sspi->regmap)[SUNXI_FIFO_CTL_REG] all over the place
makes my eyes bleed and you cannot use the check that you are
accessing a register that actually exists.

>> @@ -491,10 +558,37 @@ static int sunxi_spi_probe(struct platform_device *pdev)
>>         }
>>
>>         sspi->master = master;
>> -       sspi->fifo_depth = SUN4I_FIFO_DEPTH;
>> -       sspi->type = SPI_SUN4I;
>> -       sspi->regmap = &sun4i_regmap;
>> -       sspi->bitmap = &sun4i_bitmap;
>> +       if (of_device_is_compatible(pdev->dev.of_node, SUN4I_COMPATIBLE)) {
>> +               sspi->fifo_depth = SUN4I_FIFO_DEPTH;
>> +               sspi->type = SPI_SUN4I;
>> +               sspi->regmap = &sun4i_regmap;
>> +               sspi->bitmap = &sun4i_bitmap;
>> +       } else if (of_device_is_compatible(pdev->dev.of_node,
>> +                                          SUN6I_COMPATIBLE)) {
>> +               sspi->fifo_depth = SUN6I_FIFO_DEPTH;
>> +               sspi->type = SPI_SUN6I;
>> +               sspi->regmap = &sun6i_regmap;
>> +               sspi->bitmap = &sun6i_bitmap;
>
> Can you store data in the match table instead of doing this?

That might be nicer. Will look into this.

Thanks

Michal
