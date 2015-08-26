From: jogo@openwrt.org (Jonas Gorski)
Date: Wed, 26 Aug 2015 16:02:49 +0200
Subject: [PATCH linux-next v5 1/5] mtd: spi-nor: notify (Q)SPI controller
 about protocol change
In-Reply-To: <464fce12d75a5ba2105456cfd0a385b2d40305ba.1440580764.git.cyrille.pitchen@atmel.com>
References: <cover.1440580764.git.cyrille.pitchen@atmel.com>
 <464fce12d75a5ba2105456cfd0a385b2d40305ba.1440580764.git.cyrille.pitchen@atmel.com>
Message-ID: <CAOiHx=n+byfsbJNhnboqDEwhruOT8uKDJ+CcES7QBqPDLVAMsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 2:30 PM, Cyrille Pitchen
<cyrille.pitchen@atmel.com> wrote:
> Once the Quad SPI mode has been enabled on a Micron flash memory, this
> device expects ALL the following commands to use the SPI 4-4-4 protocol.
> The (Q)SPI controller needs to be notified about the protocol change so it
> can adapt and keep on dialoging with the Micron memory.

Doesn't that mean you need to disable quad mode on removal? Else the
following will break/fail:

insmod atmel-quadspi.ko ~> spi-nor attaches -> sees micron -> enables quad mode
rmmod atmel-quadspi.ko ~> spi-nor detaches
insmod atmel-quadspi.ko ~> spi-nor attaches -> fails to read the id
because flash is still in quad mode.

> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Acked-by: Marek Vasut <marex@denx.de>
> Acked-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 21 +++++++++++++++++++++
>  include/linux/mtd/spi-nor.h   | 13 +++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index c27d427fead4..c8810313a752 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -165,6 +165,22 @@ static inline int write_disable(struct spi_nor *nor)
>         return nor->write_reg(nor, SPINOR_OP_WRDI, NULL, 0, 0);
>  }
>
> +/*
> + * Let the spi-nor framework notify lower layers, especially the driver of the
> + * (Q)SPI controller, about the new protocol to be used. Indeed, once the
> + * spi-nor framework has sent manufacturer specific commands to a memory to
> + * enable its Quad SPI mode, it should immediately after tell the QSPI
> + * controller to use the very same Quad SPI protocol as expected by the memory.
> + */
> +static inline int spi_nor_set_protocol(struct spi_nor *nor,
> +                                      enum spi_protocol proto)
> +{
> +       if (nor->set_protocol)
> +               return nor->set_protocol(nor, proto);
> +
> +       return 0;

Shouldn't the default assumption be that it won't support it? Also it
might make sense to first check if it's supported before enabling it
in the chip, so that we don't enable something just to then find out
we can't back out of it.

I also wonder if we need an extra flag for that as at least SPI has
RX_{DUAL,QUAD} and TX_{DUAL,QUAD} separated, so in theory there could
be a controller that supports quad read, but not quad write, so we
shouldn't be using the quad mode in that case. m25p80 currently sets
SPI_NOR_{DUAL,QUAD} only based on SPI_RX_{DUAL,QUAD}, so that would
then fail.

At least the n25q32 seems to support the "boring" 1_1_2 and 1_1_4
commands, so these should work in case the spi controller does not
support quad tx, but quad rx.

So maybe an additional flag for the "full" dual/quad modes would be in order.

Last but not least, the protocol probably should be stored somewhere
in the nor struct, so that users don't have to store it themselves (I
assume they will need to check it for each command again to know if
the cmd/address should be send in serial or quad mode).


Jonas
