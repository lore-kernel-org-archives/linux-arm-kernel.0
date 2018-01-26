From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 26 Jan 2018 11:00:11 +0100
Subject: [RFC 09/37] soc: renesas: rcar-rst: Add generic compatible strings
In-Reply-To: <1516903391-30467-10-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1516903391-30467-10-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <CAMuHMdVpM42_D+2ZCyUCCq4QZKbM_xUwivby=5Ujqg_WDz4smA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrizio,

On Thu, Jan 25, 2018 at 7:02 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> This commit introduces generic compatible strings to use as fallback,
> so that devices compatible with the generic implementation may avoid
> changing the driver.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Thanks for your patch!

>From commit 527c02f66d263d2e ("soc: renesas: Add R-Car RST driver"):

    Despite the current simple and almost identical handling for all
    supported SoCs, the driver matches against SoC-specific compatible
    values, as the features provided by the hardware module differ a lot
    across the various SoC families and members.

In fact the only commonalities are the presence of the MODEMR register
(the mode bits differ), and the Watchdog Timer Reset Control Register.
All other registers and bits depend on the SoC's CPU core configuration.

Hence that's why I did not add generic compatible values.
So unless you really need them (from this series, it looks like you
don't?), I wouldn't add them.

> --- a/drivers/soc/renesas/rcar-rst.c
> +++ b/drivers/soc/renesas/rcar-rst.c
> @@ -25,8 +25,16 @@ static const struct rst_config rcar_rst_gen2 __initconst = {
>         .modemr = 0x60,
>  };
>
> +static const struct rst_config rcar_rst_gen3 __initconst = {
> +       .modemr = 0x60,
> +};
> +
>  static const struct of_device_id rcar_rst_matches[] __initconst = {
> -       /* RZ/G is handled like R-Car Gen2 */
> +       /* generic compatible strings */
> +       { .compatible = "renesas,rcar-gen1-rst", .data = &rcar_rst_gen1 },
> +       { .compatible = "renesas,rcar-gen2-rst", .data = &rcar_rst_gen2 },
> +       { .compatible = "renesas,rcar-gen3-rst", .data = &rcar_rst_gen3 },

Usually we put generic compatible values at the bottom.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
