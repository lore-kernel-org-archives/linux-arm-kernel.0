From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 31 Aug 2014 13:15:05 -0700
Subject: [PATCH] ARM: Kirkwood: Fix DT based DSA.
In-Reply-To: <1409417668-7169-1-git-send-email-andrew@lunn.ch>
References: <1409417668-7169-1-git-send-email-andrew@lunn.ch>
Message-ID: <54038249.4080403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/14 09:54, Andrew Lunn wrote:
> During the conversion of boards to use DT to instantiate Distributed
> Switch Architecture, nobody volunteered to test. As to be expected,
> the conversion was flawed. Testers and access to hardware has now
> become available, and this patch hopefully fixes the problems.
>
> dsa,mii-bus must be a phandle to the top level mdio node, not the port
> specific subnode of the mdio device.
>
> dsa,ethernet must be a phandle to the port subnode within the ethernet
> DT node, not the ethernet node.
>
> Fixes: e2eaa339af441b3d51cdaa16870065c4154ce13c
> Fixes: e7c8f3808be854379c9784745663a55371cbf232

Your changes look good with respect to how the binding is defined.

>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---

[snip]

>   &eth0 {
> @@ -148,6 +142,7 @@
>   &eth1 {
>   	status = "okay";
>   	ethernet1-port at 0 {
> -		phy-handle = <&ethphy1>;
> +		speed = <1000>;
> +		duple = <1>;

Typo here: should be "duplex".

>   	};
>   };
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index afc640cd80c5..464f09a1a4a5 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -309,7 +309,7 @@
>   			marvell,tx-checksum-limit = <1600>;
>   			status = "disabled";
>
> -			ethernet0-port at 0 {
> +			eth0port: ethernet0-port at 0 {
>   				compatible = "marvell,kirkwood-eth-port";
>   				reg = <0>;
>   				interrupts = <11>;
> @@ -342,7 +342,7 @@
>   			pinctrl-names = "default";
>   			status = "disabled";
>
> -			ethernet1-port at 0 {
> +			eth1port: ethernet1-port at 0 {
>   				compatible = "marvell,kirkwood-eth-port";
>   				reg = <0>;
>   				interrupts = <15>;
>
