From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 29 Jun 2018 14:53:02 -0700
Subject: [RfC v1 5/5] ARM64: dts: meson-gxl: add support for the Oranth
 Tanix TX3 Mini
In-Reply-To: <20180624182814.31691-6-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sun, 24 Jun 2018 20:28:14 +0200")
References: <20180624182814.31691-1-martin.blumenstingl@googlemail.com>
 <20180624182814.31691-6-martin.blumenstingl@googlemail.com>
Message-ID: <7hin61cla9.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> The Tanix TX3 Mini is a TV box based on the Amlogic S905W chipset.
> There are two variants:
> - 1 GiB or 2 GiB of DDR3 memory
> - 8 GB or 16 GB eMMC flash
>
> Both variants come with:
> - 802.11 b/g/n wifi (Silicon Valley Microelectronics SSV6051, does not
>   support Bluetooth)
> - an LED 7 segment display with an FD628 controller
> - HDMI and AV (CVBS) output
> - 2x USB (utilizing both USB ports provided by the SoC)
> - micro SD card slot
> - serial console (uart_AO) has to be soldered after opening the case
>
> The board seems to be very similar to the P23x and Q20x reference
> boards, which is why it includes meson-gx-p23x-q20x.dtsi:
> - eMMC reset routed to BOOT_9
> - the SDIO wifi chip's reset line is routed to GPIOX_6 and the reference
>   clock is 32.768KHz on PWM_E
> - SD card detection is routed to CARD_6
> - vqmmc of all MMC controllers is hard-wired to 1.8V (VDDIO_BOOT)
> - uart_AO can be accessed after opening the case and soldering RX, TX
>   and GND lines onto the exposed solder points (marked with RX, TX and
>   GND)
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>  .../dts/amlogic/meson-gxl-s905w-tx3-mini.dts  | 22 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
>
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 6de2e7f5a9cc..1b46affd376d 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -18,6 +18,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-khadas-vim2.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-nexbox-a1.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
> new file mode 100644
> index 000000000000..08aca8346b72
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2018 Martin Blumenstingl <martin.blumenstingl@googlemail.com>.
> + * Based on meson-gxl-s905d-p231.dts:
> + * - Copyright (c) 2016 Endless Computers, Inc.
> + *   Author: Carlo Caione <carlo@endlessm.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-gxl-s905w.dtsi"

Just use meson-gxl-s905x.dtsi

Kevin

> +#include "meson-gx-p23x-q20x.dtsi"
> +
> +/ {
> +	compatible = "oranth,tx3-mini", "amlogic,s905w", "amlogic,meson-gxl";
> +	model = "Oranth Tanix TX3 Mini";
> +
> +	memory at 0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x40000000>; /* 1 GiB or 2 GiB */
> +	};
> +};
