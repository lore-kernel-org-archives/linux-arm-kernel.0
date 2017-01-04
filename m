From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 04 Jan 2017 18:23:48 +0100
Subject: [PATCH 3/8] ARM: dts: armada-388-clearfog: Utilize new DSA binding
In-Reply-To: <20170102022249.10657-4-f.fainelli@gmail.com> (Florian Fainelli's
 message of "Sun, 1 Jan 2017 18:22:44 -0800")
References: <20170102022249.10657-1-f.fainelli@gmail.com>
 <20170102022249.10657-4-f.fainelli@gmail.com>
Message-ID: <87shoyeo2j.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,
 
 On lun., janv. 02 2017, Florian Fainelli <f.fainelli@gmail.com> wrote:

> Utilize the new DSA binding, introduced with commit 8c5ad1d6179d ("net:
> dsa: Document new binding"). The legacy binding node is kept included, but is
> marked disabled.
>

I tested this patch on mvebu/dt (I needed to reduce the context to apply
the patch due to the changes made by Russell King on this file). I also
set the status of the old binding to "disable" (instead of "okay").

It seems to work with the limited test did:
ifconfig eth1 up
udhcpc -i lan1
iperf -c mylaptop

(same for lan4)

However is there a way to be sure that the new binding is used?

Gregory

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/boot/dts/armada-388-clearfog.dts | 65 +++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
> index 71ce201c903e..35207aa1f4ec 100644
> --- a/arch/arm/boot/dts/armada-388-clearfog.dts
> +++ b/arch/arm/boot/dts/armada-388-clearfog.dts
> @@ -351,6 +351,8 @@
>  	};
>  
>  	dsa at 0 {
> +		status = "okay";
> +
>  		compatible = "marvell,dsa";
>  		dsa,ethernet = <&eth1>;
>  		dsa,mii-bus = <&mdio>;
> @@ -444,3 +446,66 @@
>  		status = "disabled";
>  	};
>  };
> +
> +&mdio {
> +	status = "okay";
> +
> +	switch at 4 {
> +		compatible = "marvell,mv88e6085";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <4>;
> +		pinctrl-0 = <&clearfog_dsa0_clk_pins &clearfog_dsa0_pins>;
> +		pinctrl-names = "default";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <0>;
> +				label = "lan5";
> +			};
> +
> +			port at 1 {
> +				reg = <1>;
> +				label = "lan4";
> +			};
> +
> +			port at 2 {
> +				reg = <2>;
> +				label = "lan3";
> +			};
> +
> +			port at 3 {
> +				reg = <3>;
> +				label = "lan2";
> +			};
> +
> +			port at 4 {
> +				reg = <4>;
> +				label = "lan1";
> +			};
> +
> +			port at 5 {
> +				reg = <5>;
> +				label = "cpu";
> +				ethernet = <&eth1>;
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};
> +
> +			port at 6 {
> +				/* 88E1512 external phy */
> +				reg = <6>;
> +				label = "lan6";
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};
> +		};
> +	};
> +};
> -- 
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
