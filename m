From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 25 Mar 2013 11:21:13 +0100
Subject: [PATCH] ARM: dove: add more hardware description in the DT
In-Reply-To: <20130325103159.0c1b4f17@armhf>
References: <20130325103159.0c1b4f17@armhf>
Message-ID: <CABJ1b_RrFpKdH3w=v4gvRQ-8UniKOz9o9VVJ8Q=AQz5WaN0NRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 10:31 AM, Jean-Francois Moine <moinejf@free.fr> wrote:
> The 88AP510 chip (Marvell Dove) contains a LCD and display controler
> and two audio controlers.
>
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  arch/arm/boot/dts/dove.dtsi |   31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index f7509ca..6bd36b0 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -253,5 +253,36 @@
>                                 dmacap,xor;
>                         };
>                 };
> +
> +               lcd0: lcd0 at 820000 {

Jean-Francois,

please choose a more informative node names like

lcd0: lcd-controller at 820000 and
i2s0: audio-controller at b0000

Besides lcd and i2s there is also

dcon: display-controller at 830000 and
ire: image-rotation-engine at 831000

I am not yet 100% sure how to hook them up in dove-drm that I am
writing on but I want to have them in somehow. DCON will allow to
mux lcd0/lcd1 data streams, i.e. clone or pan lcd0 to lcd1. IRE allows
to rotate the memory buffer loaded by -90/90deg.

I also checked Armada 160 datasheets and they have LCD that looks
quite compatible with Dove's LCD, while DCON and IRE are not available.
I also guess there is some more Marvell SoCs out there that also share
LCD with Dove/Armada 160.

> +                       compatible = "marvell,dove-lcd";
> +                       reg = <0x820000 0x1c8>;
> +                       interrupts = <47>;
> +                       status = "disabled";
> +               };
> +
> +               lcd1: lcd1 at 810000 {
> +                       compatible = "marvell,dove-lcd";
> +                       reg = <0x810000 0x1c8>;
> +                       interrupts = <46>;
> +                       status = "disabled";
> +               };
> +
> +               i2s0: i2s0 at b0000 {
> +                       compatible = "marvell,kirkwood-i2s";
> +                       reg = <0xb0000 0x4000>;
> +                       interrupt-parent = <&gpio0>;
> +                       interrupts = <19 2>;

Why did you choose gpio interrupt-parent for i2s?

>From Dove datasheet I can see that, Audio0 has irqs 19, 20
and Audio1 has irqs 21, 22 on the main irq controller.
The corresponding nodes for i2s0 and i2s1 should look like

i2s0: audio-controller at b0000 {
        compatible = "marvell,kirkwood-i2s";
        reg = <0xb0000 0x4000>;
        interrupts = <19>, <20>;
        clocks = <&gate_clk 12>;
        status = "disabled";
}

Sebastian

> +                       clocks = <&gate_clk 12>;
> +                       status = "disabled";
> +               };
> +               i2s1: i2s1 at b4000 {
> +                       compatible = "marvell,kirkwood-i2s";
> +                       reg = <0xb4000 0x4000>;
> +                       interrupt-parent = <&gpio0>;
> +                       interrupts = <21 2>;
> +                       clocks = <&gate_clk 13>;
> +                       status = "disabled";
> +               };
>         };
>  };
> --
> 1.7.10.4
