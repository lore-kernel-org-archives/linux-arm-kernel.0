From: david@lechnology.com (David Lechner)
Date: Sun, 20 Nov 2016 20:42:29 -0600
Subject: [PATCH v3 10/10] ARM: dts: da850: add usb device node
In-Reply-To: <20161107203948.28324-11-ahaslam@baylibre.com>
References: <20161107203948.28324-1-ahaslam@baylibre.com>
 <20161107203948.28324-11-ahaslam@baylibre.com>
Message-ID: <48d0c158-f7c8-0d1e-f06e-b7b28d6f2b93@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2016 02:39 PM, Axel Haslam wrote:
> This adds the ohci device node for the da850 soc.
> It also enables it for the omapl138 hawk board.
>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-lcdk.dts | 8 ++++++++
>  arch/arm/boot/dts/da850.dtsi     | 8 ++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
> index 7b8ab21..aaf533e 100644
> --- a/arch/arm/boot/dts/da850-lcdk.dts
> +++ b/arch/arm/boot/dts/da850-lcdk.dts
> @@ -86,6 +86,14 @@
>  	};
>  };
>
> +&usb_phy {
> +	status = "okay";
> +};
> +
> +&ohci {
> +	status = "okay";
> +};
> +
>  &serial2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&serial2_rxtx_pins>;
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 2534aab..50e86da 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -405,6 +405,14 @@
>  					>;
>  			status = "disabled";
>  		};
> +		ohci: usb at 0225000 {

In commit 2957e36e76c836b167e5e0c1edb578d8a9bd7af6 in the linux-davinci 
tree, the alias for the musb device is usb0. So, I think we should use 
usb1 here instead of ohci - or change the usb0 alias to musb.

https://git.kernel.org/cgit/linux/kernel/git/nsekhar/linux-davinci.git/commit/?h=v4.10/dt&id=2957e36e76c836b167e5e0c1edb578d8a9bd7af6

> +			compatible = "ti,da830-ohci";
> +			reg = <0x225000 0x1000>;
> +			interrupts = <59>;
> +			phys = <&usb_phy 1>;
> +			phy-names = "usb-phy";
> +			status = "disabled";
> +		};
>  		gpio: gpio at 226000 {
>  			compatible = "ti,dm6441-gpio";
>  			gpio-controller;
>
