From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 28 Aug 2017 23:18:25 +0200
Subject: [PATCH 1/2] mtd: spi-nor: add an option to force 3byte adressing
 mode
In-Reply-To: <1503954854-30963-2-git-send-email-mw@semihalf.com>
References: <1503954854-30963-1-git-send-email-mw@semihalf.com>
 <1503954854-30963-2-git-send-email-mw@semihalf.com>
Message-ID: <CAMuHMdX0b=J9AuPAvdRXGGVXvc7f9n7TJ0_VKR13P05toq9REw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 11:14 PM, Marcin Wojtas <mw@semihalf.com> wrote:
> Hitherto code set 4B addressing mode for all SPI flashes whose
> size exceeds 16MB. However, changing the default 3B access
> in some cases may be harmful - it may happen that the Boot ROM
> is not capable of handling non-default state of the SPI NOR
> (e.g. after soft reset). Some flash devices allow to access the
> memory above 128Mib without changing mode to 4byte thanks
> to special op codes (see SPI_NOR_4B_OPCODES flag). Unfortunately
> for those which don't support them, the problem persists.
>
> This patch adds optional property that can be added to the
> SPI flash node and which will force to use 3B addressing mode,
> limiting the accessible memory size to 16MiB.
> Binding documentation is updated accordingly.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt |  2 ++
>  drivers/mtd/spi-nor/spi-nor.c                     | 12 +++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> index 1f6e86f..f13b773 100644
> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> @@ -77,6 +77,8 @@ All slave nodes can contain the following optional properties:
>                     Defaults to 1 if not present.
>  - spi-rx-delay-us - Microsecond delay after a read transfer.
>  - spi-tx-delay-us - Microsecond delay after a write transfer.
> +- spi-3byte-addressing - Empty property indicating device access to be done
> +                   only in 3byte addressing mode.

spi-force-3byte-addressing?

>  Some SPI controllers and devices support Dual and Quad SPI transfer mode.
>  It allows data in the SPI system to be transferred using 2 wires (DUAL) or 4
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 1413828..029c87d 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2002,7 +2002,17 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>                 if (JEDEC_MFR(info) == SNOR_MFR_SPANSION ||
>                     info->flags & SPI_NOR_4B_OPCODES)
>                         spi_nor_set_4byte_opcodes(nor, info);
> -               else
> +               else if (of_property_read_bool(np, "spi-3byte-addressing")) {
> +                       /*
> +                        * Do not enter 4byte mode in order to prevent
> +                        * the early bootloader to come up on non-default
> +                        * SPI NOR memory during boot. Limit accessible
> +                        * size to 16MiB.
> +                        */
> +                       nor->addr_width = 3;
> +                       mtd->size = 0x1000000;

What if the device is smaller than 16 MiB?

mtd->size = min(mtd->size, 0x1000000);

> +                       dev_info(dev, "Force 3B addressing mode\n");
> +               } else
>                         set_4byte(nor, info, 1);
>         } else {
>                 nor->addr_width = 3;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
