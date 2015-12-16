From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 16 Dec 2015 11:11:30 +0100
Subject: [PATCH 5/6] pinctrl: sh-pfc: r8a7795: add SATA0 pin conf to DT
In-Reply-To: <1450107758-2544-6-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1450107758-2544-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <CAMuHMdW3ZtvWkhZW1Locmu3WL1YixGrVAdiy7nKywkTiDB+X1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulrich,

On Mon, Dec 14, 2015 at 4:42 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> index 297c9f0..3d6c1e0 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> @@ -140,6 +140,10 @@
>         pinctrl-0 = <&scif_clk_pins>;
>         pinctrl-names = "default";
>
> +       sata0_pins: sata0 {
> +               renesas,groups = "sata0_devslp_a";

This pin is GP6_16, which is used for USB-OTG on Salvator-X, according to the
schematics?
It looks like the SATA DEVSLP feature is not used at all on Salvator-X.

Upon closer look, using the feature (on a board where the pin is connected)
would need a driver update, as the SATAEDEVSLPR register is not present on
R-Car Gen2, and thus not yet handled by the driver.

Hence I expect SATA to work fine without any pinctrl, and this patch should
just be dropped?

Can you please check? Thanks!

> +               renesas,function = "sata0";
> +       };
>         scif1_pins: scif1 {
>                 renesas,groups = "scif1_data_a", "scif1_ctrl";
>                 renesas,function = "scif1";
> @@ -269,6 +273,9 @@
>  };
>
>  &sata {
> +       pinctrl-0 = <&sata0_pins>;
> +       pinctrl-names = "default";
> +
>         status = "okay";
>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
