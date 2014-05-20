From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 May 2014 23:18:03 -0700
Subject: [PATCH v4 6/6] ARM: dts: STiH407: Add B2120 board support
In-Reply-To: <1394614210-15698-7-git-send-email-maxime.coquelin@st.com>
References: <1394614210-15698-1-git-send-email-maxime.coquelin@st.com>
 <1394614210-15698-7-git-send-email-maxime.coquelin@st.com>
Message-ID: <CAOesGMg5Jk_XB3zdfKz8VxRObYbFO8OMuRyo7Ba-kavANbci1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just a quick drive-by review since I was looking at these patches in
the pull request you sent.



On Wed, Mar 12, 2014 at 1:50 AM, Maxime COQUELIN <maxime.coquelin@st.com> wrote:
> B2120 HDK is the reference board for STiH407 SoC.
> It has the following characteristics:
>  - 1GB DDR3
>  - 8GB eMMC / SD-Card slot
>  - 32MB NOR Flash
>  - 1 x Gbit Ethernet
>  - 1 x USB 3.0 port
>  - 1 x Mini-PCIe
>  - 1 x SATA
>  - 1 x HDMI output
>  - 1 x HDMI input
>  - 1 x SPDIF
>
> This patch only introduces basic functionnalities, such as I2C and UART.
>
> Acked-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
>  arch/arm/boot/dts/Makefile          |  3 +-
>  arch/arm/boot/dts/stih407-b2120.dts | 78 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/stih407-b2120.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 12455cf..f760a88 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -317,7 +317,8 @@ dtb-$(CONFIG_ARCH_SPEAR6XX)+= spear600-evb.dtb
>  dtb-$(CONFIG_ARCH_STI)+= stih415-b2000.dtb \
>         stih416-b2000.dtb \
>         stih415-b2020.dtb \
> -       stih416-b2020.dtb
> +       stih416-b2020.dtb \
> +       stih407-b2120.dtb

These should be in alphanumerical order. 407 comes before 415. You've
been out of order with others as well.

>  dtb-$(CONFIG_ARCH_SUNXI) += \
>         sun4i-a10-a1000.dtb \
>         sun4i-a10-cubieboard.dtb \
> diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
> new file mode 100644
> index 0000000..9c97da4
> --- /dev/null
> +++ b/arch/arm/boot/dts/stih407-b2120.dts
> @@ -0,0 +1,78 @@
> +/*
> + * Copyright (C) 2014 STMicroelectronics (R&D) Limited.
> + * Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +#include "stih407.dtsi"
> +/ {
> +       model = "STiH407 B2120";
> +       compatible = "st,stih407", "st,stih407-b2120";

This should go from specific to generic, so the order needs to be the other way.

Please check other dts files for the same (I didn't).

> +
> +       chosen {
> +               bootargs = "console=ttyAS0,115200";
> +               linux,stdout-path = &sbc_serial0;
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x40000000 0x80000000>;
> +       };
> +
> +       aliases {
> +               ttyAS0 = &sbc_serial0;
> +       };
> +
> +       soc {
> +               sbc_serial0: serial at 9530000 {
> +                       status = "okay";
> +               };

You might want to consider reference-based syntax here instead, so you
don't have to mimic the hierarchy. That'd be (at the root level of the
file, below this secion:

&sbc_serial0: {
        status = "okay";
};

Same for others.


-Olof
