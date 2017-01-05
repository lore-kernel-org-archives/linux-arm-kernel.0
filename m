From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 05 Jan 2017 13:57:42 +0100
Subject: [PATCH v3] ARM: dts: turris-omnia: add support for ethernet switch
In-Reply-To: <20170103193501.4827-1-uwe@kleine-koenig.org> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Tue, 3 Jan 2017 20:35:01
 +0100")
References: <20170103152107.GA32450@lunn.ch>
 <20170103193501.4827-1-uwe@kleine-koenig.org>
Message-ID: <87inptd5q1.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
 
 On mar., janv. 03 2017, Uwe Kleine-K?nig <uwe@kleine-koenig.org> wrote:

> The Turris Omnia features a Marvell MV88E6176 ethernet switch. Add it to
> the dts.
>
> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>

Applied on mvebu/dt with Reviewed-by flag from Andrew Lunn
<andrew@lunn.ch> and Tested-by flag from Andreas F?rber.

Thanks,

Gregory
> ---
> Changes since (implicit) v1:
>  - drop mdio bus and per port phy-handle as they match the default
>    setup.
>
> Changes since v2:
>  - Fix switch type in comment and commit log
>  - drop 2nd cpu port
>
>  arch/arm/boot/dts/armada-385-turris-omnia.dts | 58 +++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> index ab49acb2d452..28eede180e4f 100644
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
> @@ -273,7 +273,59 @@
>  		/* irq is connected to &pcawan pin 7 */
>  	};
>  
> -	/* Switch MV88E7176 at address 0x10 */
> +	/* Switch MV88E6176 at address 0x10 */
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
> +
> +			ports at 0 {
> +				reg = <0>;
> +				label = "lan0";
> +			};
> +
> +			ports at 1 {
> +				reg = <1>;
> +				label = "lan1";
> +			};
> +
> +			ports at 2 {
> +				reg = <2>;
> +				label = "lan2";
> +			};
> +
> +			ports at 3 {
> +				reg = <3>;
> +				label = "lan3";
> +			};
> +
> +			ports at 4 {
> +				reg = <4>;
> +				label = "lan4";
> +			};
> +
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
> +			/* port 6 is connected to eth0 */
> +		};
> +	};
>  };
>  
>  &pinctrl {
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
