From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 20 Jan 2016 18:21:43 +0100
Subject: [PATCH v2 6/7] ARM: dts: kirkwood: split lswxl dts to linkstation
 lswsxl and lswxl
In-Reply-To: <1453304038-28345-7-git-send-email-rogershimizu@gmail.com>
References: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
 <1453304038-28345-1-git-send-email-rogershimizu@gmail.com>
 <1453304038-28345-7-git-send-email-rogershimizu@gmail.com>
Message-ID: <569FC227.2040300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2016 04:33 PM, Roger Shimizu wrote:
> LS-WXL/WSXL are both kirkwood-6281 based 2-Bay NAS devices, which share
> many MPP pins. However they are slightly different:
>    - There're two red LED indicator on LS-WXL to show when HDD fails,
>      but there's no such on LS-WSXL.
>    - There's 4-level speed adjustable FAN on LS-WXL, but not LS-WSXL.
>
> So after the split, common part goes into .dtsi file:
>    - kirkwood-linkstation.dtsi
>    - kirkwood-linkstation-duo-6281.dtsi
> while all rest part goes into device specific .dts file:
>    - kirkwood-linkstation-lswsxl.dts
>    - kirkwood-linkstation-lswxl.dts
>
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
> ---
[...]
> diff --git a/arch/arm/boot/dts/kirkwood-linkstation-duo-6281.dtsi b/arch/arm/boot/dts/kirkwood-linkstation-duo-6281.dtsi
> new file mode 100644
> index 000000000000..47b8f185839d
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-linkstation-duo-6281.dtsi
> @@ -0,0 +1,185 @@
[...]
> +/ {
> +	ocp at f1000000 {
> +		pinctrl: pin-controller at 10000 {

Roger,

nice series! Mind to send another patch moving pinctrl stuff
and sata below to node references for both boards?

Kirkwood has &pinctrl and &sata labels, it helps to keep the bus
structure out of the board files. &mdio is an example for that.

I might be easier not to squash that into this series but
send another one later.

Sebastian

> +			pmx_power_hdd0: pmx-power-hdd0 {
> +				marvell,pins = "mpp28";
> +				marvell,function = "gpio";
> +			};
[...]
> +		};
> +
> +		sata at 80000 {
> +			nr-ports = <2>;
> +		};
> +	};
[...]
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy1: ethernet-phy at 8 {
> +		device_type = "ethernet-phy";
> +		reg = <8>;
> +	};
> +};
> +
> +&eth1 {
> +	status = "okay";
> +
> +	ethernet1-port at 0 {
> +		phy-handle = <&ethphy1>;
> +	};
> +};
