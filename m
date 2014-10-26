From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 26 Oct 2014 17:53:11 -0200
Subject: [PATCH v3 2/2] ARM: dts: add initial support for TBS2910 Matrix
 ARM mini PC
In-Reply-To: <1414300502-6511-3-git-send-email-smoch@web.de>
References: <1414300502-6511-1-git-send-email-smoch@web.de>
 <1414300502-6511-3-git-send-email-smoch@web.de>
Message-ID: <CAOMZO5At_mZmcxR_hdG_rd858yHyu0W81QAFSCgNnVj1utV8yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 26, 2014 at 3:15 AM, Soeren Moch <smoch@web.de> wrote:

> +       regulators {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               reg_2p5v: regulator at 0 {
> +                       compatible = "regulator-fixed";
> +                       reg = <0>;
> +                       regulator-name = "2P5V";
> +                       regulator-min-microvolt = <2500000>;
> +                       regulator-max-microvolt = <2500000>;
> +                       regulator-always-on;

You can drop the 'regulator-always-on' property as this not controlled
by a GPIO.


> +               };
> +
> +               reg_3p3v: regulator at 1 {
> +                       compatible = "regulator-fixed";
> +                       reg = <1>;
> +                       regulator-name = "3P3V";
> +                       regulator-min-microvolt = <3300000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       regulator-always-on;

Same here.

> +               };
> +
> +               reg_5p0v: regulator at 2 {
> +                       compatible = "regulator-fixed";
> +                       reg = <2>;
> +                       regulator-name = "5P0V";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +                       regulator-always-on;

Same here.

> +&iomuxc {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_hog>;
> +
> +       imx6q-tbs2910 {
> +               pinctrl_hog: hoggrp {

Is this hog group really needed? We prefer to add the IOMUX into the
respective peripheral nodes.

> +                       fsl,pins = <
> +                               MX6QDL_PAD_NANDF_D0__GPIO2_IO00       0x80000000

For example: gpio2 0 is the card detection pin for usdhc3. You could
add its definition into the pinctrl_usdhc3 node instead of putting it
into the hog group.

> +                               MX6QDL_PAD_NANDF_D1__GPIO2_IO01       0x80000000

Also, about the 0x80000000: this means that the pad settings come from
the bootloader. It is usually safer not to rely in the bootloader and
configure it in the kernel.

You can read the pad settings value for each pin and replace the
0x80000000 with the real value instead.
