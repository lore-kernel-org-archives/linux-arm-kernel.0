From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 15 Sep 2014 09:55:36 +0200
Subject: [PATCH 5/5] m25p80, spi-nor: Share the list of supported chip type
 names again
In-Reply-To: <1410714708.3040.43.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
 <1410714708.3040.43.camel@decadent.org.uk>
Message-ID: <CAMuHMdUs+7uidcD6tivnq6+TbD4_piixLVqwuSa0Z1u3sF7EoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Sun, Sep 14, 2014 at 7:11 PM, Ben Hutchings <ben@decadent.org.uk> wrote:
> Move the list of chip type names to spi-nor.h.  To avoid putting all
> the chip type information there, we define this list as a macro
> SPI_NOR_ENUM_TYPES() that invokes another macro SPI_NOR_ENUM_TYPE()
> that must be defined to expand each name to whatever form it's needed.
>
> In spi-nor.c, use it to define enumerators, then use the enumerators
> as indices when defining spi_nor_info so that we cannot accidentally
> use a name that's not on the list.
>
> This is somewhat complicated by the fact that some names include
> hyphens.  SPI_NOR_ENUM_TYPE() therefore takes separate string and C
> identifier parameters.

Thanks for doing this!

However, the table generation still looks overly complicated to me, with
too much duplication which needs to be kept in sync.

> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -245,51 +245,10 @@ static int m25p_remove(struct spi_device *spi)
>  }
>
>
> -/*
> - * XXX This needs to be kept in sync with spi_nor_info.  We can't share
> - * it with spi-nor, because if this is built as a module then modpost
> - * won't be able to read it and add appropriate aliases.
> - */
>  static const struct spi_device_id m25p_ids[] = {

[...]

> +#define SPI_NOR_ENUM_TYPE(s, c) { s },
> +       SPI_NOR_ENUM_TYPES()
> +#undef SPI_NOR_ENUM_TYPE
>         { },

> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c

>  /* NOTE: double check command sets and memory organization when you add
>   * more nor chips.  This current list focusses on newer chips, which
>   * have been converging on command sets which including JEDEC ID.
> + *
> + * All chip type names must be added to __SPI_NOR_ENUM_TYPES in

Oops... These will get out of sync.

> + * spi-nor.h before they can be used here (enforced by using the
> + * names to index this array).
>   */
>  static const struct flash_info spi_nor_info[] = {
>         /* Atmel -- some are (confusingly) marketed as "DataFlash" */
> -       INFO("at25fs010",  0x1f6601, 0, 32 * 1024,   4, SECT_4K),
> -       INFO("at25fs040",  0x1f6604, 0, 64 * 1024,   8, SECT_4K),
> +       INFO(at25fs010,  0x1f6601, 0, 32 * 1024,   4, SECT_4K),
> +       INFO(at25fs040,  0x1f6604, 0, 64 * 1024,   8, SECT_4K),

[...]


> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -198,4 +198,76 @@ struct spi_nor {
>   */
>  int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode);
>
> +#define __SPI_NOR_ENUM_TYPES(c_id, str_and_c_id)                         \
> +       c_id(at25fs010)         c_id(at25fs040)         c_id(at25df041a)  \
> +       c_id(at25df321a)        c_id(at25df641)         c_id(at26f004)    \

Can't you just have the IDs in a header file only, and let the header file
generate either a struct flash_info or a struct spi_device_id table, using
a macro defined by the file that includes it?
Cfr. include/uapi/asm-generic/unistd.h and its use of __SYSCALL()?

Or am I missing something (e.g. this is impossible due to the hyphens in the
names?).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
