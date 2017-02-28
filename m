From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 28 Feb 2017 17:12:38 -0600
Subject: [PATCH 1/1] ARM64: dts: meson-gxl: improve support for the P212
 reference design
In-Reply-To: <20170219224114.17201-2-martin.blumenstingl@googlemail.com>
References: <20170219224114.17201-1-martin.blumenstingl@googlemail.com>
 <20170219224114.17201-2-martin.blumenstingl@googlemail.com>
Message-ID: <CAL_JsqJikyKx4-VbdeS6RjWiJT5R4RDcUGsYisdQ7FgokjKgCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 19, 2017 at 4:41 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> The Amlogic P212 reference design is used by other devices as well, such
> as (for example) the Khadas VIM boards. Thus this patch adds and moves
> all common entries from meson-gxl-s905x-p212.dts to a new, separate
> meson-gxl-s905x-p212.dtsi (which can be re-used on boards such as the
> Khadas VIM).
> Support for all boards based on the P212 reference design includes:
> - enabling IR support
> - enabling the SAR ADC (SARADC_CH1 is connected to a resistor which
>   indicates the hardware revision, a similar design is found on the
>   Khadas VIM boards)
> - all MMC controllers (which means that SDIO wifi, the SD card and the
>   eMMC are now supported)
> - pwm_ef as dependency for the SDIO wifi module
> - uart_A which is connected to the bluetooth module (the bluetooth
>   module itself is not enabled yet due to missing devicetree bindings
>   for the Broadcom serial bluetooth devices)
> - uart_AO is moved to the .dtsi (as all known devices use it as their
>   boot-console)
>
> Specific to the P212 board:
> - this also enables the CVBS connector (which is not available on the
>   Khadas VIM boards for example)
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../boot/dts/amlogic/meson-gxl-s905x-p212.dts      |  21 +-
>  .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     | 214 +++++++++++++++++++++
>  2 files changed, 226 insertions(+), 9 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> index 9639f012b02b..db31e093f40e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
> @@ -43,23 +43,26 @@
>
>  /dts-v1/;
>
> -#include "meson-gxl-s905x.dtsi"
> +#include "meson-gxl-s905x-p212.dtsi"
>
>  / {
>         compatible = "amlogic,p212", "amlogic,s905x", "amlogic,meson-gxl";
>         model = "Amlogic Meson GXL (S905X) P212 Development Board";
>
> -       aliases {
> -               serial0 = &uart_AO;
> -       };
> +       cvbs-connector {
> +               compatible = "composite-video-connector";
>
> -       chosen {
> -               stdout-path = "serial0:115200n8";
> +               port {
> +                       cvbs_connector_in: endpoint {
> +                               remote-endpoint = <&cvbs_vdac_out>;
> +                       };
> +               };
>         };
> +};
>
> -       memory at 0 {
> -               device_type = "memory";
> -               reg = <0x0 0x0 0x0 0x80000000>;
> +&cvbs_vdac_port {
> +       cvbs_vdac_out: endpoint {
> +               remote-endpoint = <&cvbs_connector_in>;
>         };
>  };
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> new file mode 100644
> index 000000000000..fb0e7c999cb6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> @@ -0,0 +1,214 @@
> +/*
> + * Copyright (c) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>.
> + * Based on meson-gx-p23x-q20x.dtsi:
> + * - Copyright (c) 2016 Endless Computers, Inc.
> + *   Author: Carlo Caione <carlo@endlessm.com>
> + * - Copyright (c) 2016 BayLibre, SAS.
> + *   Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.

Use SPDX tags here:

SPDX-License-Identifier: (GPL-2.0+ OR MIT)

While it says X11, this is really MIT license text.
