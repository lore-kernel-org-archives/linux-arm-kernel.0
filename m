From: robh@kernel.org (Rob Herring)
Date: Thu, 23 Aug 2018 19:43:49 -0500
Subject: [PATCH 3/5] arm: dts: OpenPower Palmetto system can use
 coprocessor for FSI
In-Reply-To: <20180724042406.15374-4-benh@kernel.crashing.org>
References: <20180724042406.15374-1-benh@kernel.crashing.org>
 <20180724042406.15374-4-benh@kernel.crashing.org>
Message-ID: <CAL_JsqK_08Hq0pPGHAwL9NWWV4s66RpiTfvs+g3FV1FCkM_b2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 11:25 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> This switches away from userspace bitbanging to kernel FSI
> using the coprocessor.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 28 ++++++++++++++-----
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> index c7084a819dc6..e6cfdf3c1a67 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> @@ -26,6 +26,11 @@
>                         no-map;
>                         reg = <0x5f000000 0x01000000>; /* 16M */
>                 };
> +
> +               coldfire_memory: codefire_memory at 5ee00000 {

typo

> +                       reg = <0x5ee00000 0x00200000>;
> +                       no-map;
> +               };
>         };
>
>         leds {
> @@ -44,6 +49,22 @@
>                 };
>         };
>
> +       fsi: gpio-fsi {
> +               compatible = "aspeed,ast2400-cf-fsi-master", "fsi-master";
> +               #address-cells = <2>;
> +               #size-cells = <0>;
> +
> +               memory-region = <&coldfire_memory>;
> +               aspeed,sram = <&sram>;
> +               aspeed,cvic = <&cvic>;
> +
> +               clock-gpios = <&gpio ASPEED_GPIO(A, 4) GPIO_ACTIVE_HIGH>;
> +               data-gpios = <&gpio ASPEED_GPIO(A, 5) GPIO_ACTIVE_HIGH>;
> +               mux-gpios = <&gpio ASPEED_GPIO(A, 6) GPIO_ACTIVE_HIGH>;
> +               enable-gpios = <&gpio ASPEED_GPIO(D, 0) GPIO_ACTIVE_HIGH>;
> +               trans-gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_HIGH>;
> +       };
> +
>         gpio-keys {
>                 compatible = "gpio-keys";
>
> @@ -303,13 +324,6 @@
>                 line-name = "SYS_PWROK_BMC";
>         };
>
> -       pin_gpio_h6 {
> -               gpio-hog;
> -               gpios = <ASPEED_GPIO(H, 6) GPIO_ACTIVE_HIGH>;
> -               output-high;
> -               line-name = "SCM1_FSI0_DATA_EN";
> -       };
> -
>         pin_gpio_h7 {
>                 gpio-hog;
>                 gpios = <ASPEED_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
