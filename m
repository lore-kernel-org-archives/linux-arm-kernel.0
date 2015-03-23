From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 23 Mar 2015 07:07:06 +0100
Subject: [PATCH 5/7] ARM: dts: enable regulator support for i.MX23/i.MX28
In-Reply-To: <1426984203-9133-6-git-send-email-stefan.wahren@i2se.com>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-6-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20150323060706.GB4946@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 22, 2015 at 12:30:01AM +0000, Stefan Wahren wrote:
> This patch enables the on-chip regulator support for all i.MX23 and
> i.MX28 boards.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/imx23.dtsi |   67 +++++++++++++++++++++++++++++++++++++++++-
>  arch/arm/boot/dts/imx28.dtsi |   67 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 132 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> index bbcfb5a..be0aee8 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -404,8 +404,73 @@
>  			};
>  
>  			power at 80044000 {
> +				compatible = "fsl,imx23-power";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
>  				reg = <0x80044000 0x2000>;
> -				status = "disabled";
> +				interrupts = <3>;
> +				ranges;
> +
> +				dcdc: regulator at 80044010 {
> +					reg = <0x80044010 0x10>,
> +					      <0x80044090 0x10>,
> +					      <0x800440c0 0x10>;
> +					reg-names = "base-address",
> +						    "misc-address",
> +						    "status-address";
> +					compatible = "fsl,imx23-dcdc";
> +					regulator-name = "dcdc";
> +					regulator-boot-on;
> +					regulator-always-on;
> +				};

It is very unusual to describe the regulators of a device on a register
level like this and to iomemap each register individually. I think you
should drop the registers here and put this knowledge into the driver
like (nearly?) all others do.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
