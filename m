From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 5 Nov 2018 09:52:48 +0100
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77990: Add I2C-DVFS device
 node
In-Reply-To: <1540071349-27483-1-git-send-email-ykaneko0929@gmail.com>
References: <1540071349-27483-1-git-send-email-ykaneko0929@gmail.com>
Message-ID: <CAMuHMdV=ZinKOWZco9t4rGncYY5BqghXxGE6w9qCNW55UVSa+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kaneko-san,

On Sat, Oct 20, 2018 at 11:35 PM Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds I2C-DVFS device node for the R8A77990 SoC.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> @@ -22,7 +22,8 @@
>                 i2c4 = &i2c4;
>                 i2c5 = &i2c5;
>                 i2c6 = &i2c6;
> -               i2c7 = &i2c7;
> +               i2c7 = &i2c_dvfs;
> +               i2c8 = &i2c7;

Please don't change existing aliases.
While this makes the use of i2c7 for PMIC access uniform across the
range of R-Car Gen3 SoCs that have it, I think this is a bad idea, and that
it is better not to rely on I2C aliases at all.

I guess the BSP did this to configure the BD9571 PMIC for DDR backup
mode using i2cset? Upstream has another method, avoiding the need for
i2cset, cfr. Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator.

>         };
>
>         cpus {
> @@ -337,6 +338,22 @@
>                         reg = <0 0xe6060000 0 0x508>;
>                 };
>
> +               i2c_dvfs: i2c at e60b0000 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       compatible = "renesas,iic-r8a77990",

"renesas,iic-r8a77990" is not yet documented.

> +                                    "renesas,rcar-gen3-iic",
> +                                    "renesas,rmobile-iic";

Also, IIC on R-Car E3 does not have the automatic transmission registers.
Does this affect claiming compatibility with the family-specific or generic
compatible values?

> +                       reg = <0 0xe60b0000 0 0x34>;

Why 0x34? Last (byte-sized) register documented is at 0x14 => 0x15?

> +                       interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpg CPG_MOD 926>;
> +                       power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
> +                       resets = <&cpg 926>;
> +                       dmas = <&dmac0 0x11>, <&dmac0 0x10>;
> +                       dma-names = "tx", "rx";
> +                       status = "disabled";
> +               };
> +

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
