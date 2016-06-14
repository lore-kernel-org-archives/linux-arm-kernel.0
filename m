From: julian.calaby@gmail.com (Julian Calaby)
Date: Tue, 14 Jun 2016 14:47:24 +1000
Subject: [linux-sunxi] [PATCH v3 10/13] spi: sunxi: merge sun4i and sun6i
 SPI driver
In-Reply-To: <CAOMqctQD=o6YBk-QRiqbE9Cj+ZAH1nAM33rW6ZHefV8dU3aucQ@mail.gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com>
 <ad0ec30ef6b01f58e1b3b92da06e6cbd5c947354.1465490774.git.hramrach@gmail.com>
 <CAGRGNgVONS+i=57D52VeW8J6SvfmX=iG+3VpxNS8=kJOV+WSLw@mail.gmail.com>
 <CAOMqctQD=o6YBk-QRiqbE9Cj+ZAH1nAM33rW6ZHefV8dU3aucQ@mail.gmail.com>
Message-ID: <CAGRGNgWPBh03zQrM=OMF24ezJvC-K0TMw2oqPhuNLj-nZ=mZQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Tue, Jun 14, 2016 at 2:34 PM, Michal Suchanek <hramrach@gmail.com> wrote:
> Hello,
>
> On 14 June 2016 at 01:43, Julian Calaby <julian.calaby@gmail.com> wrote:
>> Hi Michal,
>>
>> On Tue, Jun 14, 2016 at 3:46 AM, Michal Suchanek <hramrach@gmail.com> wrote:
>>> The drivers are very similar and share multiple flaws which needed
>>> separate fixes for both drivers.
>>>
>>> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>>> ---
>>>  drivers/spi/Kconfig     |   8 +-
>>>  drivers/spi/Makefile    |   1 -
>>>  drivers/spi/spi-sun4i.c | 156 +++++++++++--
>>>  drivers/spi/spi-sun6i.c | 598 ------------------------------------------------
>>>  4 files changed, 143 insertions(+), 620 deletions(-)
>>>  delete mode 100644 drivers/spi/spi-sun6i.c
>>>
>>> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
>>> index 0b8e6c6..c76f8e4 100644
>>> --- a/drivers/spi/spi-sun4i.c
>>> +++ b/drivers/spi/spi-sun4i.c
>>> @@ -279,9 +321,14 @@ static int sunxi_spi_transfer_one(struct spi_master *master,
>>>         reg = sunxi_spi_read(sspi, SUNXI_TFR_CTL_REG);
>>>
>>>         /* Reset FIFOs */
>>> -       sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG,
>>> -                       reg | sspi_bits(sspi, SUNXI_CTL_RF_RST) |
>>> -                       sspi_bits(sspi, SUNXI_CTL_TF_RST));
>>> +       if (sspi->type == SPI_SUN4I)
>>> +               sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG,
>>> +                               reg | sspi_bits(sspi, SUNXI_CTL_RF_RST) |
>>> +                               sspi_bits(sspi, SUNXI_CTL_TF_RST));
>>> +       else
>>> +               sunxi_spi_write(sspi, SUNXI_FIFO_CTL_REG,
>>> +                               sspi_bits(sspi, SUNXI_CTL_RF_RST) |
>>> +                               sspi_bits(sspi, SUNXI_CTL_TF_RST));
>>
>> If we're already doing different stuff for each generation of the IP,
>> why not just use the register offsets and bit definitions directly?
>
> Because having (*sspi->regmap)[SUNXI_FIFO_CTL_REG] all over the place
> makes my eyes bleed and you cannot use the check that you are
> accessing a register that actually exists.

I mean removing SUNXI_CTL_RF_RST and SUNXI_CTL_TF_RST from all of the
indirection you added and using them directly, i.e.

#define SUN4I_TFR_CTL_RF_RST BIT(x)
#define SUN4I_TFR_CTL_TF_RST BIT(x)
#define SUN6I_FIFO_CTL_RF_RST BIT(x)
#define SUN6I_FIFO_CTL_TF_RST BIT(x)

then

if (sspi->type == SPI_SUN4I)
    sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG, reg |
SUN4I_TFR_CTL_RF_RST | SUN4I_TFR_CTL_TF_RST);
else
    sunxi_spi_write(sspi, SUNXI_FIFO_CTL_REG, reg |
SUN6I_FIFO_CTL_RF_RST | SUN6I_FIFO_CTL_TF_RST);

I.e. the bits that need setting are in different registers, so you
have to have an if statement and separate calls. Therefore there's no
real benefit from the indirection you've introduced here, unless
you're expecting the SUN8I variant to use different bits in one of
those two registers.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
