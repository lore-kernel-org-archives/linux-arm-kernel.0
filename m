From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 14 Feb 2018 11:25:19 +0100
Subject: [PATCH 1/5] soc: renesas: Add symbols for R-Car Gen3 register
 offsets
In-Reply-To: <20180212154422.13900-2-horms+renesas@verge.net.au>
References: <20180212154422.13900-1-horms+renesas@verge.net.au>
 <20180212154422.13900-2-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVN6YhY5Qp1toDeAh8N44EayAQrsz-je96NVZgkz12=ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Feb 12, 2018 at 4:44 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add symbols for Gen3 register offsets.
> These may be used to improve readability of users of these offsets.
>
> This does not introduce any functional change.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks for your patch!

> --- a/drivers/soc/renesas/rcar-sysc.h
> +++ b/drivers/soc/renesas/rcar-sysc.h
> @@ -24,6 +24,25 @@
>  #define PD_CPU_NOCR    PD_CPU | PD_NO_CR /* CPU area lacks CR (R-Car Gen2/3) */
>  #define PD_ALWAYS_ON   PD_NO_CR          /* Always-on area */
>
> +/*
> + * R-Car Gen3 register offsets
> + */
> +
> +#define RCAR_GEN3_SYSCSR  0

Please drop this. The "always-on" domains use 0 to indicate "no register
block", not as a reference to the SYSCSR register.

> +#define RCAR_GEN3_PWRSR0  0x80
> +#define RCAR_GEN3_PWRSR2  0x100
> +#define RCAR_GEN3_PWRSR3  0x140
> +#define RCAR_GEN3_PWRSR4  0x180
> +#define RCAR_GEN3_PWRSR5  0x1c0
> +#define RCAR_GEN3_PWRSR6  0x200
> +#define RCAR_GEN3_PWRSR7  0x240
> +#define RCAR_GEN3_PWRSR8  0x340
> +#define RCAR_GEN3_PWRSR9  0x380
> +#define RCAR_GEN3_PWRSR10 0x3c0
> +#define RCAR_GEN3_PWRSR11 0x400
> +#define RCAR_GEN3_PWRSR12 0x2c0
> +#define RCAR_GEN3_PWRSR13 0x300
> +#define RCAR_GEN3_PWRSR14 0x280

What about

    #define RCAR_GEN3_PWRSR(n) (0x80 + (n) * 0x40)

instead?
Bummer, they have a hole between 0x240 and 0x340, which they filled later :-(
So I don't know how stable the PWRSRx indices are...

For R-Car H1 and Gen2 you can use the following, though:

    #define RCAR_H1_PWRSR(n) (0x40 + (n) * 0x40)
    #define RCAR_GEN2_PWRSR(n) (0x40 + (n) * 0x40)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
