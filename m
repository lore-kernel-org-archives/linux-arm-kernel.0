From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 4 Sep 2014 09:02:04 +0200
Subject: Autoloading of SPI/nor driver on kirkwood (qnap devices)
In-Reply-To: <1409796689.27524.34.camel@decadent.org.uk>
References: <1409673299.14324.43.camel@dagon.hellion.org.uk>
 <1409796689.27524.34.camel@decadent.org.uk>
Message-ID: <CAMuHMdWBr=B0_Xivti9K5ReryHHEunQj2P26FjhmzhO-L9t+9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Thu, Sep 4, 2014 at 4:11 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
>> I noticed that many platforms declare the flash chip as compatible =
>> "st,m25pXXX" whereas the ts219.dtsi just said m25p128 but I tried
>> changing that and it didn't help. In any case without spi-nor.ko being
>> autoloaded I don't support m25p80.ko ever would be.
>
> m25p80.c has:
>
> static struct spi_driver m25p80_driver = {
>         ...
>         .id_table       = spi_nor_ids,
>         ...
> };
>
> while spi_nor_ids is defined in spi-nor.c.  Since they end up as two
> separate modules, modpost can't read the ID table and add the device ID
> aliases to m25p80.ko.

Woops. This indeed doesn't work.
Note that the MODULE_DEVICE_TABLE() is also gone from m25p80.c

So m25p80.c needs to contain the IDs, while spi-nor.c also needs the IDs
because it's a framework/library.

A quick solution would be to move the ID table to a header file, and include
that by both, and re-add the lost MODULE_DEVICE_TABLE() to m25p80.c.
That duplicates the data, though.

Hmm, for the built-in case, we can avoid the duplication by letting m25p80.c
refer to the table in spi-nor.c if !MODULE.
Does anyone see a better solution?

> It looks like m25p80 has been split up in order that the new fsl-qspi
> driver can share its code (bypassing the SPI core and its device
> model!).  Why doesn't fsl-qspi implement an SPI controller device?  I
> think it is totally unacceptable to regress m25p80 in this way for the
> sake of a new driver.

Fsl-qspi is not a generic SPI driver, but a dedicated SPI NOR driver.
It's programmed using high-level SPI NOR commands, instead of low-level
SPI commands.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
