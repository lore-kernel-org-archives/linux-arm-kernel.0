From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 23 Nov 2018 10:21:39 +0100
Subject: [PATCH v2] arm64: dts: renesas: r8a77990: Add I2C-DVFS device node
In-Reply-To: <20181121121139.25493-1-horms+renesas@verge.net.au>
References: <20181121121139.25493-1-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdW1Kqmu3spuejDQH6Yv1CPTvmYjFQA8L1n3fHbECoYT9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Nov 21, 2018 at 1:12 PM Simon Horman <horms+renesas@verge.net.au> wrote:
>
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds I2C-DVFS device node for the R8A77990 SoC.
>
> v2
> * Drop aliases update as in upstream it is not required to configure the
>   BD9571 PMIC for DDR backup, nor is the use of i2c are aliases desired.
> * Do not describe the device as compatible with "renesas,rcar-gen3-iic" or
>   "renesas,rmobile-iic" fallback compat strings. The absence of automatic
>   transmission registers leads us to declare the r8a77990 IIC controller as
>   incompatible.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> [simon: drop aliases hunk and fallback compat string usage]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks for the update!

> --- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> @@ -357,6 +357,20 @@
>                         reg = <0 0xe6060000 0 0x508>;
>                 };
>
> +               i2c_dvfs: i2c at e60b0000 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       compatible = "renesas,iic-r8a77990";
> +                       reg = <0 0xe60b0000 0 0x34>;

... 0x15>;

> +                       interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpg CPG_MOD 926>;
> +                       power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
> +                       resets = <&cpg 926>;
> +                       dmas = <&dmac0 0x11>, <&dmac0 0x10>;
> +                       dma-names = "tx", "rx";
> +                       status = "disabled";
> +               };

With thwe above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
