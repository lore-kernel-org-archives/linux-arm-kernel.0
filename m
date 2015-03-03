From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 03 Mar 2015 10:09:21 +0100
Subject: [PATCH] ARM: ARMADA XP: WRT1900AC: Add support for the Ethernet
 switch
In-Reply-To: <1425154848-15441-1-git-send-email-andrew@lunn.ch>
References: <1425154848-15441-1-git-send-email-andrew@lunn.ch>
Message-ID: <54F57A41.1040102@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 28/02/2015 21:20, Andrew Lunn wrote:
> Add a DSA section to the DT blob representing the Ethernet switch.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> This patch requires at runtime patches in net-next,
> 4c732668f98b96a0fa2645ac220fd9bbc17838c4

This dts fragment looks sane. The dependencies is only at runtime so
it is less annoying for bissectability. So I tend applying it, however
what happens if patch 4c732668f98b96a0fa2645ac220fd9bbc17838c4 is not
present. Does the kernel crash? Or does it only make the Ethernet
switch not available?


Thanks,

Gregory


> ---
>  arch/arm/boot/dts/armada-xp-linksys-mamba.dts | 45 +++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
> index 485a6eb86910..a2cf2154dcdb 100644
> --- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
> +++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
> @@ -327,6 +327,51 @@
>  		gpio-fan,speed-map = <0    0
>  				      4500 1>;
>  	};
> +
> +	dsa at 0 {
> +		compatible = "marvell,dsa";
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		dsa,ethernet = <&eth0>;
> +		dsa,mii-bus = <&mdio>;
> +
> +		switch at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0>;	/* MDIO address 0, switch 0 in tree */
> +
> +			port at 0 {
> +				reg = <0>;
> +				label = "lan4";
> +			};
> +
> +			port at 1 {
> +				reg = <1>;
> +				label = "lan3";
> +			};
> +
> +			port at 2 {
> +				reg = <2>;
> +				label = "lan2";
> +			};
> +
> +			port at 3 {
> +				reg = <3>;
> +				label = "lan1";
> +			};
> +
> +			port at 4 {
> +				reg = <4>;
> +				label = "internet";
> +			};
> +
> +			port at 5 {
> +				reg = <5>;
> +				label = "cpu";
> +			};
> +		};
> +	};
>  };
>  
>  &pinctrl {
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
