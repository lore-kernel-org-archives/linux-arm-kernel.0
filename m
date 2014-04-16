From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 16 Apr 2014 09:29:33 +0200
Subject: [PATCH v5 08/20] ARM: shmobile: r8a7779: Add helper to read mode
 pins
In-Reply-To: <1397613454-7522-9-git-send-email-horms+renesas@verge.net.au>
References: <1397613454-7522-1-git-send-email-horms+renesas@verge.net.au>
 <1397613454-7522-9-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdXVAaU=eEBr4hwfbz3TGL+k0NHxGtzh-uuzFwuUqeNA9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 3:57 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add and use helper to read mode pins.
> This will be re-used when moving marzen-reference to
> the common clock framework.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -802,6 +802,20 @@ void __init r8a7779_add_standard_devices_dt(void)
>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>
> +#define MODEMR         0xffcc0020
> +
> +u32 __init r8a7779_read_mode_pins(void)
> +{
> +       void __iomem *modemr = ioremap_nocache(MODEMR, PAGE_SIZE);
> +       u32 mode;
> +
> +       BUG_ON(!modemr);
> +       mode = ioread32(modemr);
> +       iounmap(modemr);
> +
> +       return mode;
> +}

No caching, cfr. rcar_gen2_read_mode_pins()?

BTW, I know you don't trust "R-Car Gen1" similarities, but the code for
r8a7778 is identical. And this is code, not DT, so perhaps this can be
rcar_gen_read_mode_pins() in arch/arm/mach-shmobile/setup-rcar-gen1.c?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
