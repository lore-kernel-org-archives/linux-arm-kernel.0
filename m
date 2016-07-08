From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 8 Jul 2016 12:41:25 -0500
Subject: [RFC 1/4] arm64: dts: msm8992 SoC and LG Bullhead (Nexus 5X)
 support
In-Reply-To: <1467938467-21607-2-git-send-email-jmcnicol@redhat.com>
References: <1467938467-21607-1-git-send-email-jmcnicol@redhat.com>
 <1467938467-21607-2-git-send-email-jmcnicol@redhat.com>
Message-ID: <20160708174125.GC7896@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 05:41:04PM -0700, Jeremy McNicoll wrote:
> Initial device tree support for Qualcomm MSM8992 SoC and
> LG Bullhead / Google Nexus 5X support.
> 
> Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
> ---
>  arch/arm64/Kconfig.platforms                       |  12 +
>  arch/arm64/boot/dts/Makefile                       |   1 +
>  arch/arm64/boot/dts/lge/Makefile                   |   5 +
>  .../boot/dts/lge/msm8992-bullhead-rev-101.dts      |  41 +++
>  arch/arm64/boot/dts/qcom/msm8992-pins.dtsi         |  38 +++
>  arch/arm64/boot/dts/qcom/msm8992.dtsi              | 221 ++++++++++++
>  arch/arm64/configs/bullhead_defconfig              | 377 +++++++++++++++++++++
>  arch/arm64/configs/msm8992_defconfig               |   5 +
>  8 files changed, 700 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/lge/Makefile
>  create mode 100644 arch/arm64/boot/dts/lge/msm8992-bullhead-rev-101.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8992-pins.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8992.dtsi
>  create mode 100644 arch/arm64/configs/bullhead_defconfig
>  create mode 100644 arch/arm64/configs/msm8992_defconfig
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 7ef1d05..515e669 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -86,6 +86,18 @@ config ARCH_QCOM
>  	help
>  	  This enables support for the ARMv8 based Qualcomm chipsets.
>  
> +config ARCH_MSM8992
> +	bool "Qualcomm MSM8992"
> +	depends on ARCH_QCOM
> +	help
> +	  This enables support for the Qualcomm MSM8992 SoC.
> +
> +config MACH_LGE
> +	bool "LGE BullHead (MSM8992)"
> +	depends on ARCH_QCOM
> +	help
> +	  This enables support for the LGE Nexus 5X - BullHead MSM8992.

We don't add config options for End users.  Only for Soc Companies or people
actually producing the silicon.

> +
>  config ARCH_ROCKCHIP
>  	bool "Rockchip Platforms"
>  	select ARCH_HAS_RESET_CONTROLLER
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 6e199c9..bde90fb 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -13,6 +13,7 @@ dts-dirs += marvell
>  dts-dirs += mediatek
>  dts-dirs += nvidia
>  dts-dirs += qcom
> +dts-dirs += lge

No, please add the files to the qcom directory.

>  dts-dirs += renesas
>  dts-dirs += rockchip
>  dts-dirs += socionext
> diff --git a/arch/arm64/boot/dts/lge/Makefile b/arch/arm64/boot/dts/lge/Makefile
> new file mode 100644
> index 0000000..f4e7860
> --- /dev/null
> +++ b/arch/arm64/boot/dts/lge/Makefile
> @@ -0,0 +1,5 @@
> +dtb-$(CONFIG_MACH_LGE) += msm8992-bullhead-rev-101.dtb
> +
> +always          := $(dtb-y)
> +subdir-y        := $(dts-dirs)
> +clean-files     := *.dtb
> diff --git a/arch/arm64/boot/dts/lge/msm8992-bullhead-rev-101.dts b/arch/arm64/boot/dts/lge/msm8992-bullhead-rev-101.dts
> new file mode 100644
> index 0000000..860cded
> --- /dev/null
> +++ b/arch/arm64/boot/dts/lge/msm8992-bullhead-rev-101.dts
> @@ -0,0 +1,41 @@
> +/* Copyright (c) 2015, LGE Inc. All rights reserved.
> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/dts-v1/;
> +
> +#include "../qcom/msm8992.dtsi"
> +
> +/ {
> +	model = "LGE MSM8992 BULLHEAD rev-1.01";
> +	compatible = "qcom,msm8992";
> +	qcom,board-id = <0xb64 0>;

Please work with sboyd to add the board-id to the dtbTool.  We don't put
board-ids in the dts file.  We post-process the dtb file and add them then.


> +};
> +
> +/ {
> +	aliases {
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	soc {
> +		serial at f991e000 {
> +			status = "okay";
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&blsp1_uart2_default>;
> +			pinctrl-1 = <&blsp1_uart2_sleep>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi

<snip>

> diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
> new file mode 100644
> index 0000000..fa92a1a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
> @@ -0,0 +1,221 @@
> +/* Copyright (c) 2013-2016, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +/memreserve/ 0x00000000 0x00001000;

Please use reserved-memory{}.   And why are they setting aside 4k at the
beginning?  Trying to cover up corruption issues?

> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-msm8994.h>
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. MSM 8992";
> +	compatible = "qcom,msm8992";
> +	qcom,msm-id = <251 0>, <252 0>;
> +	qcom,pmic-id = <0x10009 0x1000A 0x0 0x0>;

See above comment on ids.

> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };
> +

<snip>

> +#include "msm8992-pins.dtsi"
> diff --git a/arch/arm64/configs/bullhead_defconfig b/arch/arm64/configs/bullhead_defconfig

Please add whatever config options you have to the default defconfig.  we don't
define board specific configs for ARM64 platforms.  Or I should say, they won't
be accepted into the kernel.

Also, please separate defconfig changes into separate patches.

<snip>

> diff --git a/arch/arm64/configs/msm8992_defconfig b/arch/arm64/configs/msm8992_defconfig
> new file mode 100644
> index 0000000..f673a27
> --- /dev/null
> +++ b/arch/arm64/configs/msm8992_defconfig

See above comment.
> @@ -0,0 +1,5 @@
> +CONFIG_NO_HZ=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_SCHED_HMP=y
> +CONFIG_NAMESPACES=y
> +# CONFIG_CORESIGHT is not set
> -- 
> 2.6.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
