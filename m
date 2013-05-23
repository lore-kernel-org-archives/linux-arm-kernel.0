From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 23 May 2013 22:15:39 +0200
Subject: [PATCH, RFC 19/22] staging/solo6x10: depend on CONFIG_FONTS
In-Reply-To: <1367507786-505303-20-git-send-email-arnd@arndb.de>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-20-git-send-email-arnd@arndb.de>
Message-ID: <CAMuHMdWrVCndJ=Cre5LUgTSyQMxn_XkHUCFa2qCz-ETUO+T-ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 2, 2013 at 5:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The new SOLO6X10 driver needs the built-in console fonts, specifically
> the VGA8x16 font and building it without console support results in
> a link error error.
>
> drivers/built-in.o: In function `solo_osd_print':
>  :(.text+0x7d3424): undefined reference to `find_font'
>
> This adds a dependency on the CONFIG_FONTS symbol and changes the
> console code to always build the base driver even if there are
> no specific fonts built-in.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sorry for only noticing this now, but CONFIG_FONTS is not about font support.
It's about allowing the user to override the default list of builtin fonts.
I know it's a bad name, but changing this would break make oldconfig.
Or is this allowed?

My fix for the solo6x10 build breakage is
http://marc.info/?l=linux-kernel&m=136861809223875

> ---
>  drivers/staging/media/solo6x10/Kconfig | 1 +
>  drivers/video/console/Makefile         | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/staging/media/solo6x10/Kconfig b/drivers/staging/media/solo6x10/Kconfig
> index ec32776..df6569b 100644
> --- a/drivers/staging/media/solo6x10/Kconfig
> +++ b/drivers/staging/media/solo6x10/Kconfig
> @@ -1,6 +1,7 @@
>  config SOLO6X10
>         tristate "Softlogic 6x10 MPEG codec cards"
>         depends on PCI && VIDEO_DEV && SND && I2C
> +       depends on FONTS
>         select VIDEOBUF2_DMA_SG
>         select VIDEOBUF2_DMA_CONTIG
>         select SND_PCM
> diff --git a/drivers/video/console/Makefile b/drivers/video/console/Makefile
> index a862e91..48da25c 100644
> --- a/drivers/video/console/Makefile
> +++ b/drivers/video/console/Makefile
> @@ -18,6 +18,8 @@ font-objs-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
>
>  font-objs += $(font-objs-y)
>
> +obj-$(CONFIG_FONTS) += font.o
> +
>  # Each configuration option enables a list of files.
>
>  obj-$(CONFIG_DUMMY_CONSOLE)       += dummycon.o

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
