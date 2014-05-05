From: linux@baker-net.org.uk (Adam Baker)
Date: Mon, 05 May 2014 23:20:28 +0100
Subject: [PATCH 01/15] ARM: dts: kirkwood: fix mislocated pcie-controller
 nodes
In-Reply-To: <1398862602-29595-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1398862602-29595-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <53680EAC.3090401@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/04/14 13:56, Sebastian Hesselbarth wrote:
> Commit 54397d85349f
>   ("ARM: kirkwood: Relocate PCIe device tree nodes")
>
> moved the pcie-controller nodes for the Kirkwood SoCs to the mbus
> bus node. For some reason, two boards were not properly converted
> and have their pci-controller nodes still in the ocp bus node.
>
> As the corresponding SoC pcie-controller does not exist anymore,
> it is likely that pcie is broken on those boards since above commit.
> Fix it by moving the pcie related nodes to the correct location.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>


I've tried this patch on NSA320, as expected it doesn't make any 
observable difference as there is nothing connected to the PCIe bus 
(hence not really worth a tested by). It matters more on the NSA310 as 
that uses PCIe for Ethernet.

Regards

Adam Baker

> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>   arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 18 ++++++++++--------
>   arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi  | 18 ++++++++++--------
>   2 files changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
> index 2cb0dc529165..4bf358c28be2 100644
> --- a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
> +++ b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
> @@ -30,6 +30,16 @@
>   		bootargs = "console=ttyS0,115200n8 earlyprintk";
>   	};
>
> +	mbus {
> +		pcie-controller {
> +			status = "okay";
> +
> +			pcie at 1,0 {
> +				status = "okay";
> +			};
> +		};
> +        };
> +
>   	ocp at f1000000 {
>   		pinctrl at 10000 {
>   			pmx_usb_led: pmx-usb-led {
> @@ -73,14 +83,6 @@
>   		ehci at 50000 {
>   			status = "okay";
>   		};
> -
> -		pcie-controller {
> -			status = "okay";
> -
> -			pcie at 1,0 {
> -				status = "okay";
> -			};
> -		};
>   	};
>
>   	gpio-leds {
> diff --git a/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi b/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
> index 843b8b561e5e..b88810df7ca2 100644
> --- a/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
> @@ -4,6 +4,16 @@
>   / {
>   	model = "ZyXEL NSA310";
>
> +	mbus {
> +		pcie-controller {
> +			status = "okay";
> +
> +			pcie at 1,0 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +
>   	ocp at f1000000 {
>   		pinctrl: pinctrl at 10000 {
>
> @@ -51,14 +61,6 @@
>   			status = "okay";
>   			nr-ports = <2>;
>   		};
> -
> -		pcie-controller {
> -			status = "okay";
> -
> -			pcie at 1,0 {
> -				status = "okay";
> -			};
> -		};
>   	};
>
>   	gpio_poweroff {
>
