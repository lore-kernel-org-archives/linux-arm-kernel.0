From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:29:56 +0800
Subject: [PATCH 05/20] ARM: dts: sun4i: Change pinctrl nodes to avoid
 warning
In-Reply-To: <5ed70f11299554e43f575aaf3b0bbe76991d8373.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <5ed70f11299554e43f575aaf3b0bbe76991d8373.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65wmkHvibm8pLBkrD3h_TySoiV605=6VW+pJN3xgoEbKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> All our pinctrl nodes were using a node name convention with a unit-address
> to differentiate the different muxing options. However, since those nodes
> didn't have a reg property, they were generating warnings in DTC.
>
> In order to accomodate for this, convert the old nodes to the syntax we've
> been using for the new SoCs, including removing the letter suffix of the
> node labels to the bank of those pins to make things more readable.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun4i-a10-a1000.dts                | 12 +-
>  arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts           | 10 +-
>  arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts      | 10 +-
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts           | 16 +--
>  arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts     | 12 +-
>  arch/arm/boot/dts/sun4i-a10-gemei-g9.dts             |  8 +-
>  arch/arm/boot/dts/sun4i-a10-hackberry.dts            |  8 +-
>  arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts         |  6 +-
>  arch/arm/boot/dts/sun4i-a10-inet1.dts                | 12 +-
>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts            | 10 +-
>  arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts         | 10 +-
>  arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts | 21 ++--
>  arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts           | 10 +-
>  arch/arm/boot/dts/sun4i-a10-marsboard.dts            | 16 +--
>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts           | 10 +-
>  arch/arm/boot/dts/sun4i-a10-mk802.dts                |  4 +-
>  arch/arm/boot/dts/sun4i-a10-mk802ii.dts              |  6 +-
>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts       | 10 +-
>  arch/arm/boot/dts/sun4i-a10-pcduino.dts              |  8 +-
>  arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts     | 12 +-
>  arch/arm/boot/dts/sun4i-a10.dtsi                     | 64 ++++++-------
>  21 files changed, 141 insertions(+), 134 deletions(-)

[...]

> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 9671ac72fae9..b6e89de4c092 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi

[...]

> @@ -531,83 +531,83 @@
>                                 bias-pull-up;
>                         };
>
> -                       ps20_pins_a: ps20 at 0 {
> -                               pins = "PI20", "PI21";
> +                       ps2_ph_pins: ps2-ph-pins {
> +                               pins = "PH12", "PH13";
>                                 function = "ps2";
>                         };
>
> -                       ps21_pins_a: ps21 at 0 {
> -                               pins = "PH12", "PH13";
> +                       ps2_pi_pins: ps2-pi-pins {
> +                               pins = "PI20", "PI21";
>                                 function = "ps2";
>                         };

This part is slightly incorrect. The PS/2 block has 2 inputs.
The first channel, or ps2-0, has only one muxing option, on
pins PI20 and PI21. The second channel has two options, either
PH12 + PH13 or PI14 + PI15. The names should encode which channel
the muxing option is for.

ChenYu
