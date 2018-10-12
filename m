From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 12 Oct 2018 14:19:38 +0200
Subject: [PATCH v4 1/2] arm64: dts: allwinner: new board - Emlid Neutis N5
In-Reply-To: <1539339841-22235-2-git-send-email-aleksandr.aleksandrov@emlid.com>
References: <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539339841-22235-1-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539339841-22235-2-git-send-email-aleksandr.aleksandrov@emlid.com>
Message-ID: <b47c5458-683e-3e96-0bbe-f9db84579c77@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 12.10.18 um 12:23 schrieb Aleksandr Aleksandrov:
> Emlid Neutis N5 is a SoM based on Allwinner H5, has a WiFi & BT
> module, DDR3 RAM and eMMC.
> 
> - add neutis n5 dtsi file for SoM needs
> - add neutis devboard dts file
> - add neutis devboard target to dtb makefile
> 
> Signed-off-by: Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>  .../sun50i-h5-emlid-neutis-n5-devboard.dts         | 147 +++++++++++++++++++++
>  .../dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi   |  59 +++++++++
>  3 files changed, 207 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> index 9ffa7a0..eefe74c 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinebook.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-emlid-neutis-n5-devboard.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-libretech-all-h3-cc.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo-plus2.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
> new file mode 100644
> index 0000000..1086029
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
> @@ -0,0 +1,147 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR X11)

Note that the new SPDX identifier would be "GPL-2.0-or-later", but both
are still valid.

I stumbled over "X11", should that be "MIT" instead?

Also, is this combined comment style of SPDX + copyright acceptable?

Same nits in the .dtsi file.

> + *
> + * Copyright (C) 2018 Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h5-emlid-neutis-n5.dtsi"
> +
> +/ {
> +	model = "Emlid Neutis N5 Developer board";
> +	compatible = "emlid,neutis-n5-devboard",
> +		     "emlid,neutis-n5",

You are lacking bindings definitions for these new identifiers. The
vendor prefix should be patch 1/3, the SoM/board compatibles 2/3 and
this .dts[i] patch 3/3, so that only vendor prefixes and compatibles
that are defined and don't result in checkpatch.pl warnings get used.

One more nit below...

> +		     "allwinner,sun50i-h5";
[...]
> +&de {
> +	status = "okay";
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&ehci2 {
> +	status = "okay";
> +};
> +
> +&ehci3 {
> +	status = "okay";
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&ohci2 {
> +	status = "okay";
> +};
> +
> +&ohci3 {
> +	status = "okay";
> +};

'o' is out of alphabetical order here.

Otherwise looks okay to me.

Regards,
Andreas

> +
> +&emac {
> +	phy-handle = <&int_mii_phy>;
> +	phy-mode = "mii";
> +	allwinner,leds-active-low;
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_vcc3v3>;
> +	bus-width = <4>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins_a>;
> +	status = "okay";
> +};
> +
> +&usb_otg {
> +	dr_mode = "otg";
> +	status = "okay";
> +};
> +
> +&usbphy {
> +	usb0_id_det-gpios = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
> +	usb0_vbus-supply = <&reg_usb0_vbus>;
> +	status = "okay";
> +};
[snip]


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
