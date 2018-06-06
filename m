From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 6 Jun 2018 10:25:53 +0200
Subject: [PATCH] arm: cntvoff: Add a function definition when !SMP
In-Reply-To: <20180528084016.9271-1-maxime.ripard@bootlin.com>
References: <20180528084016.9271-1-maxime.ripard@bootlin.com>
Message-ID: <CAMuHMdWqNur0cgMoyJL68TKFeg=OQXAfBC=eDdwSB6eFvFFBNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Mon, May 28, 2018 at 10:40 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> The secure_cntvoff_init function is only compiled if CONFIG_SMP is set to
> true. However, that will lead to linking errors if one uses this function
> without an ifdef CONFIG_SMP guard, which isn't ideal.
>
> Provide a dumb implementation when CONFIG_SMP is false so that we don't end
> up with a compilation error on our hands.
>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Myl?ne Josserand <mylene.josserand@bootlin.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Fixes: cad160ed0a94 ("ARM: shmobile: Convert file to use cntvoff")
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>
cfr. for Arnd's similar fix (https://patchwork.kernel.org/patch/10427931/)

At least R-Car E2 also needs it for the boot CPU, cfr. commit 9ce3fa6816c2fb59
("ARM: shmobile: rcar-gen2: Add CA7 arch_timer initialization for r8a7794").

The proper fix is to build arch/arm/common/secure_cntvoff.o
unconditionally.

> --- a/arch/arm/include/asm/secure_cntvoff.h
> +++ b/arch/arm/include/asm/secure_cntvoff.h
> @@ -3,6 +3,10 @@
>  #ifndef __ASMARM_ARCH_CNTVOFF_H
>  #define __ASMARM_ARCH_CNTVOFF_H
>
> +#ifdef CONFIG_SMP
>  extern void secure_cntvoff_init(void);
> +#else
> +static inline void secure_cntvoff_init(void) {};
> +#endif
>
>  #endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
