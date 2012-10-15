From: shijie8@gmail.com (Huang Shijie)
Date: Mon, 15 Oct 2012 08:45:48 -0400
Subject: [PATCH] ARM: dts: imx6q-arm2: move NANDF_CS pins out of 'hog'
In-Reply-To: <1350290884-26594-1-git-send-email-shawn.guo@linaro.org>
References: <1350290884-26594-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAMiH66EdFW7JrCD+NVtJnn-dYan0U_QyhOoRKvsQHV5g0u7pqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 4:48 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Commit 9e3c0066 (ARM: dts: imx6q-arm2: add pinctrl for uart and enet)
> defines NANDF_CS pins as gpio in 'hog', assuming these two pins are
> always used by usdhc3 in gpio mode as card-detection and
> write-protection on ARM2 board.  But it's not true.  These pins are
> shared by usdhc3 and gpmi-nand.  We should have the pins functional
> for gpmi-nand when usdhc3 is disabled.
>
> Move the pins out of 'hog', so that pins only work in gpio mode as CD
> and WP when usdhc3 is enabled, and otherwise they are available for
> gpmi-nand.
>
> Reported-by: Huang Shijie <b32955@freescale.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Huang,
>
> Please help test the patch to see if it fixes your problem, thanks.

yes, this patch fixes the problem.
thanks a lot.

Tested-by: Huang Shijie <shijie8@gmail.com>

Huang Shijie

>
> Shawn
>
>  arch/arm/boot/dts/imx6q-arm2.dts |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
> index 15df4c1..5bfa02a 100644
> --- a/arch/arm/boot/dts/imx6q-arm2.dts
> +++ b/arch/arm/boot/dts/imx6q-arm2.dts
> @@ -37,6 +37,13 @@
>                                         pinctrl_hog: hoggrp {
>                                                 fsl,pins = <
>                                                         176  0x80000000 /* MX6Q_PAD_EIM_D25__GPIO_3_25 */
> +                                               >;
> +                                       };
> +                               };
> +
> +                               arm2 {
> +                                       pinctrl_usdhc3_arm2: usdhc3grp-arm2 {
> +                                               fsl,pins = <
>                                                         1363 0x80000000 /* MX6Q_PAD_NANDF_CS0__GPIO_6_11 */
>                                                         1369 0x80000000 /* MX6Q_PAD_NANDF_CS1__GPIO_6_14 */
>                                                 >;
> @@ -58,7 +65,8 @@
>                                 wp-gpios = <&gpio6 14 0>;
>                                 vmmc-supply = <&reg_3p3v>;
>                                 pinctrl-names = "default";
> -                               pinctrl-0 = <&pinctrl_usdhc3_1>;
> +                               pinctrl-0 = <&pinctrl_usdhc3_1
> +                                            &pinctrl_usdhc3_arm2>;
>                                 status = "okay";
>                         };
>
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
