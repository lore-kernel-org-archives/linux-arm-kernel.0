From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 17 Apr 2015 22:30:38 +0900
Subject: [PATCH 2/2] ARM: dts: Fix pinctrl settings for S2MPS11 RTC alarm
 IRQ on Arndale Octa
In-Reply-To: <1427985376-20420-3-git-send-email-k.kozlowski@samsung.com>
References: <1427985376-20420-1-git-send-email-k.kozlowski@samsung.com>
 <1427985376-20420-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CAJKOXPfbsrkvXT_CBxZeDTLYdbwGMH=+5mnBLoy9Yfyp4thVQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-02 23:36 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> On Arndale Octa the S2MPS11 RTC alarm interrupt was not handled at all
> because of wrong configuration of interrupt and gpx3-2.
> 1. Interrupt is signaled by falling edge.
> 2. This GPIO line is hard-wired on the board to PVDD_APIO_1V8 through a
>    resistor so pull-up/down must be disabled.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Dear Kukjin,

Any comments  on this and other patches. A lot of emails waits for
your opinion. Is there anything I could do to help you in smooth
review or applying?

Best regards,
Krzysztof

>
> diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> index d78fcd997ce6..97346df31d41 100644
> --- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> +++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
> @@ -87,7 +87,9 @@
>                         s2mps11,buck4-ramp-enable = <1>;
>
>                         interrupt-parent = <&gpx3>;
> -                       interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&s2mps11_irq>;
>
>                         s2mps11_osc: clocks {
>                                 #clock-cells = <1>;
> @@ -379,3 +381,12 @@
>         clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
>         clock-names = "rtc", "rtc_src";
>  };
> +
> +&pinctrl_0 {
> +       s2mps11_irq: s2mps11-irq {
> +               samsung,pins = "gpx3-2";
> +               samsung,pin-function = <0xf>;
> +               samsung,pin-pud = <0>;
> +               samsung,pin-drv = <0>;
> +       };
> +};
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
