From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Sep 2016 21:37:19 +0200
Subject: [PATCH v2 3/4] ARM: dts: Add NextThing GR8 dtsi
In-Reply-To: <20160907145400.27192-4-maxime.ripard@free-electrons.com>
References: <20160907145400.27192-1-maxime.ripard@free-electrons.com>
 <20160907145400.27192-4-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdZsxA7avmO85R=-Quu7FQwSVMPhQMDmmgL+xbkVTB-2HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2016 at 4:53 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> From: Myl?ne Josserand <mylene.josserand@free-electrons.com>
>
> The GR8 is an SoC made by Nextthing loosely based on the sun5i family.
>
> Since it's not clear yet what we can factor out and merge with the A10s and
> A13 support, let's keep it out of the sun5i.dtsi include tree. We will
> figure out what can be shared when things settle down.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Linus Walleij <linus,walleij@linaro.org>

I was just thinking:

> +                       i2c0_pins_a: i2c0 at 0 {
> +                               allwinner,pins = "PB0", "PB1";
> +                               allwinner,function = "i2c0";
> +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +                       };

It would be *NICE* if the sunxi driver would start to support the new standard
bindings for this stuff, see
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt

So you could just use pins, function and the drive-strength and
bias-disable in this case.

Since I know the AllWinner support is a community project I have much higher
tolerance with this legacy binding sticking around for the new generation of
SoCs but still, if you find time.

I mean it like supporting these in *addition* to the custom ones, so there can
be a smooth phase-over.

Check for example Laurent's commit for SH-PFC:
commit 16ccaf5bb5a52372bfebd3dfbb79dd810ad49c09
"pinctrl: sh-pfc: Accept standard function, pins and groups properties"
It's awesome, and since, they have improved the looks of Renesas
DTS files a lot.

It could look a bit like this nice thing from
lpc4337-ciaa.dts:

&pinctrl {
        enet_rmii_pins: enet-rmii-pins {
                enet_rmii_rxd_cfg {
                        pins = "p1_15", "p0_0";
                        function = "enet";
                        slew-rate = <1>;
                        bias-disable;
                        input-enable;
                        input-schmitt-disable;
                };

                enet_rmii_txd_cfg {
                        pins = "p1_18", "p1_20";
                        function = "enet";
                        slew-rate = <1>;
                        bias-disable;
                        input-enable;
                        input-schmitt-disable;
                };
(etc)

Yours,
Linus Walleij
