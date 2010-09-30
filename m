From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 30 Sep 2010 23:33:43 +0900
Subject: [PATCH] spi/pl022: make sure the chip_info dev pointer is set
In-Reply-To: <1285839648-7368-1-git-send-email-linus.walleij@stericsson.com>
References: <1285839648-7368-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTimZXF-ntBSROV2pVN+Td1Bek7C5DtKZTQgXY=Wt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 6:40 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> We forgot to set the pointer back to the device if the user
> supplied all device settings, leading to crashing debug prints
> as controller data is verified.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> ?drivers/spi/amba-pl022.c | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 4c37c4e..90a7e5d 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -1574,6 +1574,8 @@ static int pl022_setup(struct spi_device *spi)
> ? ? ? ? ? ? ? ?chip_info->duplex = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX;
> ? ? ? ? ? ? ? ?chip_info->cs_control = null_cs_control;
> ? ? ? ?} else {
> + ? ? ? ? ? ? ? /* Users should not set this field */
> + ? ? ? ? ? ? ? chip_info->dev = &spi->dev;
> ? ? ? ? ? ? ? ?dev_dbg(&spi->dev,
> ? ? ? ? ? ? ? ? ? ? ? ?"using user supplied controller_data settings\n");
> ? ? ? ?}

Nack.  data passed to a driver via the controller_data must be
immutable as far as the device driver is concerned.  I realize that
this has been rather sloppy in the past; but I'm enforcing it now.
controller_data is static data passed to the driver, and the 'dev'
member of pl022_config_chip needs to be removed.

So, instead of setting the dev pointer here; this code should *remove*
the dev pointer from the structure and use spi->dev directly instead.
I've looked at the driver, and I don't see any significant locations
using chip_info that cannot get the chip_info directly from the struct
spi_device.

g.


> --
> 1.6.3.3
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
