From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 6 Jun 2017 12:04:12 +0900
Subject: [PATCH 4/4] arm64: dts: uniphier: add nodes of thermal monitor
 and thermal zone for LD20
In-Reply-To: <1496049345-14649-5-git-send-email-hayashi.kunihiko@socionext.com>
References: <1496049345-14649-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1496049345-14649-5-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK7LNATm5wbz07_Ny8QkvhgN7kvi-X9o+zrY+-00BK9O__vrxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-05-29 18:15 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> Add nodes of thermal monitor and thermal zone for UniPhier LD20 SoC.
> The thermal monitor is included in sysctrl.
>
> Furthermore, since SoC installed in the reference board doesn't have a
> calibrated value of thermal monitor, this patch gives the default value
> for LD20 Reference board via device-tree property.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts | 25 ++++++++++++++++++++++
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |  6 ++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
> index 609162a..79e1363 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
> @@ -73,6 +73,27 @@
>                 i2c4 = &i2c4;
>                 i2c5 = &i2c5;
>         };
> +
> +       thermal-zones {
> +               cpu_thermal {
> +                       polling-delay-passive = <250>;  /* 250ms */
> +                       polling-delay = <1000>;         /* 1000ms */
> +                       thermal-sensors = <&pvtctl>;
> +
> +                       trips {
> +                               cpu_crit: cpu_crit {
> +                                       temperature = <95000>;  /* 95C */
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                               cpu_alert: cpu_alert {
> +                                       temperature = <85000>;  /* 85C */
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +                       };
> +               };
> +       };
>  };
>
>  &ethsc {
> @@ -86,3 +107,7 @@
>  &i2c0 {
>         status = "okay";
>  };
> +
> +&pvtctl {
> +       socionext,tmod-calibration = <0x0f22 0x68ee>;
> +};
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> index a6b3a70..effa2e3 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> @@ -417,6 +417,12 @@
>                                 compatible = "socionext,uniphier-ld20-reset";
>                                 #reset-cells = <1>;
>                         };
> +
> +                       pvtctl: pvtctl {
> +                               compatible = "socionext,uniphier-ld20-thermal";
> +                               interrupts = <0 3 1>;
> +                               #thermal-sensor-cells = <0>;
> +                       };


The 3rd cell of the interrupts is 1.
So, you mean the interrupt is edge-triggered.
(Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt)

However, in your driver code, the interrupt is explicitly cleared in
the IRQ handler.

I checked the SoC implementation document and
the PVT IRQ seems to be level-triggered.


-- 
Best Regards
Masahiro Yamada
