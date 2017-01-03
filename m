From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Jan 2017 16:21:07 +0100
Subject: [PATCH v2] ARM: dts: turris-omnia: add support for ethernet switch
In-Reply-To: <20161222094327.24051-1-uwe@kleine-koenig.org>
References: <20161222094327.24051-1-uwe@kleine-koenig.org>
Message-ID: <20170103152107.GA32450@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2016 at 10:43:27AM +0100, Uwe Kleine-K?nig wrote:
> The Turris Omnia features a Marvell MV88E7176 ethernet switch. Add it to
> the dts.
> 
> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> ---
> Changes since (implicit) v1:
>  - drop mdio bus and per port phy-handle as they match the default
>    setup.
> 
> One thing I was surprised is that the mv88e6xxx module isn't autoloaded
> by udev. Is this expected?
> 
> Best regards
> Uwe
> 
>  arch/arm/boot/dts/armada-385-turris-omnia.dts | 66 ++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> index ab49acb2d452..f8e55fa7f0fa 100644
> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> @@ -122,7 +122,7 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&ge0_rgmii_pins>;
>  	status = "okay";
> -	phy-mode = "rgmii-id";
> +	phy-mode = "rgmii";
>  
>  	fixed-link {
>  		speed = <1000>;
> @@ -135,7 +135,7 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&ge1_rgmii_pins>;
>  	status = "okay";
> -	phy-mode = "rgmii-id";
> +	phy-mode = "rgmii";
>  
>  	fixed-link {
>  		speed = <1000>;
> @@ -274,6 +274,68 @@
>  	};
>  
>  	/* Switch MV88E7176 at address 0x10 */

Hi Uwe

You probably have the switch model wrong in this comment. 6176 not
7176?

> +	switch at 10 {
> +		compatible = "marvell,mv88e6085";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		dsa,member = <0 0>;
> +
> +		reg = <0x10>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;

...

> +			ports at 5 {
> +				reg = <5>;
> +				label = "cpu";
> +				ethernet = <&eth1>;
> +				phy-mode = "rgmii-id";
> +
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};
> +
> +			ports at 6 {
> +				reg = <6>;
> +				label = "cpu";
> +				ethernet = <&eth0>;
> +				phy-mode = "rgmii-id";
> +
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};

Humm, we need to be careful here. I hope multi CPU will come soon. But
we have not yet defined how the binding will look. I expect it does
look a lot like this, but there are probably additional properties,
like linking user ports to cpu ports.

What i'm worried about is future backwards compatibility. There is a
danger that this DT will trigger some of the multi CPU code, but it is
missing other required properties, and so stops working.

It would be safer if you just had a comment about the second CPU port.

   Thanks
	Andrew
