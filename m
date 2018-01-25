From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 25 Jan 2018 11:22:03 -0200
Subject: [PATCH V3 10/10] add imx7ulp support
In-Reply-To: <1516367470-24340-11-git-send-email-aisheng.dong@nxp.com>
References: <1516367470-24340-1-git-send-email-aisheng.dong@nxp.com>
 <1516367470-24340-11-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAOMZO5D-qfdeMHuRWfZk9+tLoSNP6GLbMG4_t2V0bM-xJJDZ8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 19, 2018 at 11:11 AM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

Please always add a commit log.

> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

> ---
>  arch/arm/boot/dts/Makefile           |   2 +
>  arch/arm/boot/dts/imx7ulp-evk.dts    |  87 +++++++++++++++
>  arch/arm/boot/dts/imx7ulp.dtsi       | 202 +++++++++++++++++++++++++++++++++++
>  arch/arm/configs/imx_v6_v7_defconfig |  16 ++-
>  arch/arm/mach-imx/Kconfig            |   9 ++
>  arch/arm/mach-imx/Makefile           |   1 +
>  arch/arm/mach-imx/common.h           |   1 +
>  arch/arm/mach-imx/cpu.c              |   3 +
>  arch/arm/mach-imx/mach-imx7ulp.c     |  37 +++++++
>  arch/arm/mach-imx/mxc.h              |   1 +
>  arch/arm/mach-imx/pm-imx7ulp.c       |  32 ++++++
>  11 files changed, 381 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx7ulp-evk.dts
>  create mode 100644 arch/arm/boot/dts/imx7ulp.dtsi
>  create mode 100644 arch/arm/mach-imx/mach-imx7ulp.c
>  create mode 100644 arch/arm/mach-imx/pm-imx7ulp.c
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d0381e9..3257e71 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -519,6 +519,8 @@ dtb-$(CONFIG_SOC_IMX7D) += \
>         imx7d-sdb-sht11.dtb \
>         imx7s-colibri-eval-v3.dtb \
>         imx7s-warp.dtb
> +dtb-$(CONFIG_SOC_IMX7ULP) += \
> +       imx7ulp-evk.dtb
>  dtb-$(CONFIG_SOC_LS1021A) += \
>         ls1021a-qds.dtb \
>         ls1021a-twr.dtb
> diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-evk.dts
> new file mode 100644
> index 0000000..cc4e6ef
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7ulp-evk.dts
> @@ -0,0 +1,87 @@
> +/*
> + * Copyright 2017 NXP
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Please use SPDX identifier.


> + */
> +
> +/dts-v1/;
> +
> +#include "imx7ulp.dtsi"
> +
> +/ {
> +       model = "NXP i.MX7ULP EVK";
> +       compatible = "fsl,imx7ulp-evk", "fsl,imx7ulp", "Generic DT based system";

Please remove the '"Generic DT based system" entry.


> +
> +       chosen {
> +               bootargs = "console=ttyLP0,115200 earlycon=lpuart32,0x402D0010,115200";
> +               stdout-path = &lpuart4;

Better remove bootargs.


> +       };
> +
> +       memory {

memory at 60000000 , otherwise building with W=1 will give you warning.

Please make sure that you don't get dtc warnings with W=1.

> +               device_type = "memory";
> +               reg = <0x60000000 0x40000000>;
> +       };
> +};
> +
> +&lpuart4 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_lpuart4>;
> +       status = "okay";
> +};
> +
> +&usdhc0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <>;
> +       pinctrl-0 = <&pinctrl_usdhc0_cmd_data>, <&pinctrl_usdhc0_clk>;
> +//                 <&pinctrl_usdhc0_cd>, <&pinctrl_usdhc0_rst>;

Just remove the line instead of commenting it.

> diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
> new file mode 100644
> index 0000000..05410ba
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7ulp.dtsi
> @@ -0,0 +1,202 @@
> +/*
> + * Copyright NXP

No year information?


> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.


Please use SPDX identifier instead.

> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 0d44949..3ce8ff6 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -41,6 +41,7 @@ CONFIG_SOC_IMX6SL=y
>  CONFIG_SOC_IMX6SX=y
>  CONFIG_SOC_IMX6UL=y
>  CONFIG_SOC_IMX7D=y
> +CONFIG_SOC_IMX7ULP=y

This should be part of a separate patch.


>  CONFIG_SOC_VF610=y
>  CONFIG_PCI=y
>  CONFIG_PCI_MSI=y
> @@ -48,9 +49,7 @@ CONFIG_PCI_IMX6=y
>  CONFIG_SMP=y
>  CONFIG_ARM_PSCI=y
>  CONFIG_PREEMPT_VOLUNTARY=y
> -CONFIG_AEABI=y
>  CONFIG_HIGHMEM=y
> -CONFIG_CMA=y
>  CONFIG_FORCE_MAX_ZONEORDER=14
>  CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
>  CONFIG_KEXEC=y
> @@ -81,7 +80,6 @@ CONFIG_CAN_FLEXCAN=y
>  CONFIG_BT=y
>  CONFIG_BT_HCIUART=y
>  CONFIG_BT_HCIUART_H4=y
> -CONFIG_BT_HCIUART_LL=y
>  CONFIG_CFG80211=y
>  CONFIG_CFG80211_WEXT=y
>  CONFIG_MAC80211=y
> @@ -90,7 +88,6 @@ CONFIG_RFKILL_INPUT=y
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  # CONFIG_STANDALONE is not set
> -CONFIG_DMA_CMA=y
>  CONFIG_CMA_SIZE_MBYTES=64
>  CONFIG_IMX_WEIM=y
>  CONFIG_CONNECTOR=y
> @@ -167,9 +164,9 @@ CONFIG_MOUSE_PS2_ELANTECH=y
>  CONFIG_INPUT_TOUCHSCREEN=y
>  CONFIG_TOUCHSCREEN_ADS7846=y
>  CONFIG_TOUCHSCREEN_EGALAX=y
> +CONFIG_TOUCHSCREEN_MAX11801=y
>  CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
>  CONFIG_TOUCHSCREEN_EDT_FT5X06=y
> -CONFIG_TOUCHSCREEN_MAX11801=y
>  CONFIG_TOUCHSCREEN_MC13783=y
>  CONFIG_TOUCHSCREEN_TSC2004=y
>  CONFIG_TOUCHSCREEN_TSC2007=y
> @@ -178,7 +175,6 @@ CONFIG_TOUCHSCREEN_SX8654=y
>  CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
>  CONFIG_INPUT_MISC=y
>  CONFIG_INPUT_MMA8450=y
> -CONFIG_HID_MULTITOUCH=y
>  CONFIG_SERIO_SERPORT=m
>  # CONFIG_LEGACY_PTYS is not set
>  CONFIG_SERIAL_IMX=y
> @@ -228,13 +224,13 @@ CONFIG_REGULATOR_GPIO=y
>  CONFIG_REGULATOR_MC13783=y
>  CONFIG_REGULATOR_MC13892=y
>  CONFIG_REGULATOR_PFUZE100=y
> +CONFIG_RC_CORE=y
> +CONFIG_RC_DEVICES=y
> +CONFIG_IR_GPIO_CIR=y
>  CONFIG_MEDIA_SUPPORT=y
>  CONFIG_MEDIA_CAMERA_SUPPORT=y
> -CONFIG_RC_CORE=y
>  CONFIG_MEDIA_CONTROLLER=y
>  CONFIG_VIDEO_V4L2_SUBDEV_API=y
> -CONFIG_RC_DEVICES=y
> -CONFIG_IR_GPIO_CIR=y
>  CONFIG_MEDIA_USB_SUPPORT=y
>  CONFIG_USB_VIDEO_CLASS=m
>  CONFIG_V4L_PLATFORM_DRIVERS=y
> @@ -245,7 +241,6 @@ CONFIG_VIDEO_CODA=m
>  # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
>  CONFIG_VIDEO_ADV7180=m
>  CONFIG_VIDEO_OV5640=m
> -CONFIG_SOC_CAMERA_OV2640=y
>  CONFIG_IMX_IPUV3_CORE=y
>  CONFIG_DRM=y
>  CONFIG_DRM_PANEL_SIMPLE=y
> @@ -283,6 +278,7 @@ CONFIG_SND_SOC_CS42XX8_I2C=y
>  CONFIG_SND_SOC_TLV320AIC3X=y
>  CONFIG_SND_SOC_WM8960=y
>  CONFIG_SND_SIMPLE_CARD=y
> +CONFIG_HID_MULTITOUCH=y

Don't do the defconfig cleanup in the same patch.

>  CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_MXC=y
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 782699e..54002c3 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -554,6 +554,15 @@ comment "Cortex-A/Cortex-M asymmetric multiprocessing platforms"
>
>  if ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
>
> +config SOC_IMX7ULP
> +       bool "i.MX7ULP support"
> +       select ARM_GIC
> +       select CLKSRC_IMX_TPM
> +       select HAVE_ARM_ARCH_TIMER
> +       select PINCTRL_IMX7ULP
> +       help
> +         This enables support for Freescale i.MX7 Ultra Low Power processor.
> +
>  config SOC_VF610
>         bool "Vybrid Family VF610 support"
>         select ARM_GIC if ARCH_MULTI_V7
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 8ff7105..69c2517 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile

arch/arm/mach-imx changes can also go in a different patch.
