From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Jan 2015 10:52:13 +0100
Subject: [PATCH 1/2] ARM: dts: sun6i: Add dts file for MSI Primo81 tablet
In-Reply-To: <1419665841-22629-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1419665841-22629-1-git-send-email-siarhei.siamashka@gmail.com>
Message-ID: <20150108095213.GR7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Siarhei,

On Sat, Dec 27, 2014 at 09:37:20AM +0200, Siarhei Siamashka wrote:
> The MSI Primo81 is an A31s based tablet, with 1G RAM, 16G NAND,
> 1024x768 IPS LCD display, mono speaker, 0.3 MP front camera, 2.0 MP
> rear camera, 3500 mAh battery, gt911 touchscreen, mma8452 accelerometer
> and rtl8188etv usb wifi. Has "power", "volume+" and "volume-" buttons
> (both volume buttons are also connected to the UBOOT_SEL pin). The
> external connectors are represented by MicroSD slot, MiniHDMI, MicroUSB
> OTG and 3.5mm headphone jack. More details are available at
>     http://linux-sunxi.org/MSI_Primo81
> 
> This initial dts file only provides support for mmc, wifi and uart
> (there is no external connector for uart though). Graphics can be used
> via simplefb. However, without usb otg, there are no reasonable means
> to handle user input yet.
> 
> Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile               |  3 +-
>  arch/arm/boot/dts/sun6i-a31s-primo81.dts | 95 ++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/sun6i-a31s-primo81.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index c486545..f363938 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -464,7 +464,8 @@ dtb-$(CONFIG_MACH_SUN6I) += \
>  	sun6i-a31-colombus.dtb \
>  	sun6i-a31-hummingbird.dtb \
>  	sun6i-a31-m9.dtb \
> -	sun6i-a31s-cs908.dtb
> +	sun6i-a31s-cs908.dtb \
> +	sun6i-a31s-primo81.dtb
>  dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-bananapi.dtb \
>  	sun7i-a20-bootsetup.dtb \
> diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
> new file mode 100644
> index 0000000..a5e8562
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
> @@ -0,0 +1,95 @@
> +/*
> + * Copyright 2014 Siarhei Siamashka <siarhei.siamashka@gmail.com>
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
> + *     You should have received a copy of the GNU General Public
> + *     License along with this library; if not, write to the Free
> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> + *     MA 02110-1301 USA
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
> + */
> +
> +/dts-v1/;
> +/include/ "sun6i-a31s.dtsi"
> +/include/ "sunxi-common-regulators.dtsi"
>
> +
> +/ {
> +	model = "MSI Primo81 tablet";
> +	compatible = "msi,primo81", "allwinner,sun6i-a31s";
> +
> +	chosen {
> +		bootargs = "earlyprintk console=ttyS0,115200";
> +	};
> +
> +	soc at 01c00000 {
> +		mmc0: mmc at 01c0f000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_primo81>;
> +			vmmc-supply = <&reg_vcc3v0>;
> +			bus-width = <4>;
> +			cd-gpios = <&pio 0 8 0>; /* PA8 */
> +			cd-inverted;
> +			status = "okay";
> +		};
> +
> +		usbphy: phy at 01c19400 {
> +			status = "okay";
> +		};
> +
> +		ehci0: usb at 01c1a000 {
> +			/* rtl8188etv wifi is connected here */
> +			status = "okay";
> +		};
> +
> +		pio: pinctrl at 01c20800 {
> +			mmc0_cd_pin_primo81: mmc0_cd_pin at 0 {
> +				allwinner,pins = "PA8";
> +				allwinner,function = "gpio_in";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <1>;
> +			};
> +		};
> +
> +		uart0: serial at 01c28000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart0_pins_a>;
> +			status = "okay";
> +		};
> +	};
> +};
> -- 
> 2.0.4
> 

These two patches look very good overall. 

There's two things about the two of them though:
  - We just switched to using the DT includes, please use them for
    your GPIO flags and pinctrl drive strength and pull
    configurations.
  - We will switch soon to using the kind of syntax used for example
    by TI in their DTSes (you can look at the beaglebone black for an
    good example.), it would be great if you could use that in your
    two DTSes, in order to avoid changing everything again in a near
    future.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/cca53a8b/attachment-0001.sig>
