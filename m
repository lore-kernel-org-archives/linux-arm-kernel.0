From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 15 Apr 2012 08:11:26 +0800
Subject: [PATCH] ARM: dts: Add basic support for imx6q-sabresd
In-Reply-To: <1334238933-32281-1-git-send-email-fabio.estevam@freescale.com>
References: <1334238933-32281-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120415001122.GA24997@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 10:55:33AM -0300, Fabio Estevam wrote:
> Add basic support for imx6q-sabresd board.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-sabresd.dts |   61 +++++++++++++++++++++++++++++++++++
>  1 files changed, 61 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6q-sabresd.dts

Add imx6q-sabresd.dtb into target dtb-$(CONFIG_SOC_IMX6Q) in
arch/arm/mach-imx/Makefile.boot.

> 
> diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
> new file mode 100644
> index 0000000..77a6f92
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-sabresd.dts
> @@ -0,0 +1,61 @@
> +/*
> + * Copyright 2011 Freescale Semiconductor, Inc.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +/include/ "imx6q.dtsi"
> +
> +/ {
> +	model = "Freescale i.MX6Q SabreSD Board";

I would expect "SabreSD" be "SABRE Smart Device".

> +	compatible = "fsl,imx6q-sabresd", "fsl,imx6q";

The compatible needs to be documented in
Documentation/devicetree/bindings/arm/fsl.txt.

> +
> +	memory {
> +		reg = <0x10000000 0x80000000>;
> +	};
> +
> +	soc {
> +
> +		aips-bus at 02000000 { /* AIPS1 */
> +			spba-bus at 02000000 {
> +				uart1: uart at 02020000 {
> +				status = "okay";
> +				};
> +			};
> +		};
> +
> +		aips-bus at 02100000 { /* AIPS2 */
> +			enet at 02188000 {
> +				phy-mode = "rgmii";
> +				phy-reset-gpios = <&gpio1 25 0>;

Have you tested fec driver with this setting?  I see the following.

PHY: 2188000.enet-1:01 - Link is Up - 100/Full
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Sending DHCP requests ...
eth0: no IPv6 routers present
... timed out!
IP-Config: Reopening network devices...
eth0: Freescale FEC PHY driver [Generic PHY] (mii_bus:phy_addr=2188000.enet-1:01, irq=-1)
Sending DHCP requests .
PHY: 2188000.enet-1:01 - Link is Up - 100/Full
..
eth0: no IPv6 routers present
.

But fec seems working fine with above line removed.

> +				status = "okay";
> +			};
> +
> +			usdhc at 02198000 { /* uSDHC3 */
> +				cd-gpios = <&gpio2 0 0>;
> +				wp-gpios = <&gpio2 1 0>;
> +				vmmc-supply = <&reg_3p3v>;
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_3p3v: 3p3v {
> +			compatible = "regulator-fixed";

Are you sure the regulator supplying SD is fixed-voltage?  I'm seeing
it comes from a PMIC.

Regards,
Shawn

> +			regulator-name = "3P3V";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +	};
> +};
> -- 
> 1.7.1
