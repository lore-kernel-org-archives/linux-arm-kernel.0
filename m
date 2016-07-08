From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 8 Jul 2016 20:18:44 -0300
Subject: [PATCH] ARM: dts: imx: fix polarity of fec reset gpios
In-Reply-To: <1468017684-3179-1-git-send-email-uwe@kleine-koenig.org>
References: <1468017684-3179-1-git-send-email-uwe@kleine-koenig.org>
Message-ID: <CAOMZO5CMn6-wn39i0phj-UGweK4R2mpQcp3pj5xLKRpQHhdwkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2016-07-08 19:41 GMT-03:00 Uwe Kleine-K?nig <uwe@kleine-koenig.org>:
> The fec driver ignores the polarity flags of the references in
> phy-reset-gpios and assumes them to be active low unlesss there is a
> property phy-reset-active-high.
>
> So fix all device trees that specify (maybe implicitly) an active high
> gpio without the phy-reset-active-high property.
>
> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>

Patch looks good,

> diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
> index ef7fa62b9898..794547ecdc4b 100644
> --- a/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
> @@ -18,17 +18,17 @@
>                 pinctrl_hog: hoggrp {
>                         fsl,pins = <
>                                 MX6QDL_PAD_GPIO_0__CCM_CLKO1            0x130b0         /* GPIO_0_CLKO */
> -                               MX6QDL_PAD_GPIO_2__GPIO1_IO02           0x80000000      /* uSDHC1 CD */
> -                               MX6QDL_PAD_EIM_DA9__GPIO3_IO09          0x80000000      /* uSDHC3 CD */
> +                               MX6QDL_PAD_GPIO_2__GPIO1_IO02           0x1b0b0         /* uSDHC1 CD */
> +                               MX6QDL_PAD_EIM_DA9__GPIO3_IO09          0x0b0b1         /* uSDHC3 CD */
>                                 MX6QDL_PAD_EIM_EB1__GPIO2_IO29          0x0f0b0         /* WL_REF_ON */
>                                 MX6QDL_PAD_EIM_A25__GPIO5_IO02          0x0f0b0         /* WL_RST_N */
>                                 MX6QDL_PAD_ENET_RXD1__GPIO1_IO26        0x000b0         /* WL_REG_ON */
> -                               MX6QDL_PAD_ENET_TXD1__GPIO1_IO29        0x80000000      /* WL_HOST_WAKE */
> -                               MX6QDL_PAD_ENET_TXD0__GPIO1_IO30        0x80000000      /* WL_WAKE */
> -                               MX6QDL_PAD_EIM_D29__GPIO3_IO29          0x80000000      /* RGMII_nRST */
> -                               MX6QDL_PAD_EIM_DA13__GPIO3_IO13         0x80000000      /* BT_ON */
> -                               MX6QDL_PAD_EIM_DA14__GPIO3_IO14         0x80000000      /* BT_WAKE */
> -                               MX6QDL_PAD_EIM_DA15__GPIO3_IO15         0x80000000      /* BT_HOST_WAKE */
> +                               MX6QDL_PAD_ENET_TXD1__GPIO1_IO29        0x1b0b0         /* WL_HOST_WAKE */
> +                               MX6QDL_PAD_ENET_TXD0__GPIO1_IO30        0x1b0b0         /* WL_WAKE */
> +                               MX6QDL_PAD_EIM_D29__GPIO3_IO29          0x1b0b0         /* RGMII_nRST */
> +                               MX6QDL_PAD_EIM_DA13__GPIO3_IO13         0x0b0b1         /* BT_ON */
> +                               MX6QDL_PAD_EIM_DA14__GPIO3_IO14         0x0b0b1         /* BT_WAKE */
> +                               MX6QDL_PAD_EIM_DA15__GPIO3_IO15         0x0b0b1         /* BT_HOST_WAKE */
>                         >;

,but this should be part of a separate patch.

> diff --git a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
> index 8d893a78cdf0..159a6579c693 100644
> --- a/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
> @@ -18,17 +18,17 @@
>                 pinctrl_hog: hoggrp {
>                         fsl,pins = <
>                                 MX6QDL_PAD_GPIO_0__CCM_CLKO1            0x130b0         /* GPIO_0_CLKO */
> -                               MX6QDL_PAD_GPIO_2__GPIO1_IO02           0x80000000      /* uSDHC1 CD */
> -                               MX6QDL_PAD_EIM_DA9__GPIO3_IO09          0x80000000      /* uSDHC3 CD */
> +                               MX6QDL_PAD_GPIO_2__GPIO1_IO02           0x1b0b0         /* uSDHC1 CD */
> +                               MX6QDL_PAD_EIM_DA9__GPIO3_IO09          0x0b0b1         /* uSDHC3 CD */
>                                 MX6QDL_PAD_CSI0_DAT14__GPIO6_IO00       0x0f0b0         /* WIFI_ON (reset, active low) */
>                                 MX6QDL_PAD_ENET_RXD1__GPIO1_IO26        0x000b0         /* WL_REG_ON (unused) */
> -                               MX6QDL_PAD_ENET_TXD1__GPIO1_IO29        0x80000000      /* WL_HOST_WAKE, input */
> +                               MX6QDL_PAD_ENET_TXD1__GPIO1_IO29        0x1b0b0         /* WL_HOST_WAKE, input */
>                                 MX6QDL_PAD_CSI0_DAT13__GPIO5_IO31       0x0f0b0         /* GPIO5_IO31 (Wifi Power Enable) */
> -                               MX6QDL_PAD_ENET_TXD0__GPIO1_IO30        0x80000000      /* WL_WAKE (unused) */
> -                               MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21       0x80000000      /* BT_ON */
> -                               MX6QDL_PAD_CSI0_DAT12__GPIO5_IO30       0x80000000      /* BT_WAKE */
> -                               MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20     0x80000000      /* BT_HOST_WAKE */
> -                               MX6QDL_PAD_EIM_D29__GPIO3_IO29          0x80000000      /* RGMII_nRST */
> +                               MX6QDL_PAD_ENET_TXD0__GPIO1_IO30        0x1b0b0         /* WL_WAKE (unused) */
> +                               MX6QDL_PAD_CSI0_VSYNC__GPIO5_IO21       0x1b0b0         /* BT_ON */
> +                               MX6QDL_PAD_CSI0_DAT12__GPIO5_IO30       0x1b0b0         /* BT_WAKE */
> +                               MX6QDL_PAD_CSI0_DATA_EN__GPIO5_IO20     0x1b0b0         /* BT_HOST_WAKE */
> +                               MX6QDL_PAD_EIM_D29__GPIO3_IO29          0x1b0b0         /* RGMII_nRST */

same here.
