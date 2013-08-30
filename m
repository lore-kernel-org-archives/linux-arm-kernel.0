From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 30 Aug 2013 17:13:28 +0100
Subject: [PATCH] ARM: dts: vexpress: Add CCI node to TC2 device-tree
In-Reply-To: <1377872760.3655.48.camel@linaro1.home>
References: <1377872760.3655.48.camel@linaro1.home>
Message-ID: <20130830161327.GA10045@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 03:26:00PM +0100, Jon Medhurst (Tixy) wrote:
> The Versatile Express V2P-CA15_A7 (aka TC2) has a CCI-400 which is
> needed to get Multi-Cluster Power Management (MCPM) working.
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> ---
> 
> I was unsure if the devicetree list should be cc'd when making use of
> already agreed and documented bindings, so I erred on the side of
> caution and added it. Please say if this is unnecessary noise, or is
> expected for all device-tree changes, thanks.
> 
>  arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> index d2803be..12bd4ea 100644
> --- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> +++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
> @@ -37,30 +37,35 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a15";
>  			reg = <0>;
> +			cci-control-port = <&cci_control1>;
>  		};
>  
>  		cpu1: cpu at 1 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a15";
>  			reg = <1>;
> +			cci-control-port = <&cci_control1>;
>  		};
>  
>  		cpu2: cpu at 2 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a7";
>  			reg = <0x100>;
> +			cci-control-port = <&cci_control2>;
>  		};
>  
>  		cpu3: cpu at 3 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a7";
>  			reg = <0x101>;
> +			cci-control-port = <&cci_control2>;
>  		};
>  
>  		cpu4: cpu at 4 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a7";
>  			reg = <0x102>;
> +			cci-control-port = <&cci_control2>;
>  		};
>  	};
>  
> @@ -104,6 +109,26 @@
>  		interrupts = <1 9 0xf04>;
>  	};
>  
> +	cci at 2c090000 {
> +		compatible = "arm,cci-400";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0 0x2c090000 0 0x1000>;
> +		ranges = <0x0 0x0 0x2c090000 0x10000>;
> +
> +		cci_control1: slave-if at 4000 {
> +			compatible = "arm,cci-400-ctrl-if";
> +			interface-type = "ace";
> +			reg = <0x4000 0x1000>;
> +		};
> +
> +		cci_control2: slave-if at 5000 {
> +			compatible = "arm,cci-400-ctrl-if";
> +			interface-type = "ace";
> +			reg = <0x5000 0x1000>;
> +		};
> +	};
> +
>  	memory-controller at 7ffd0000 {
>  		compatible = "arm,pl354", "arm,primecell";
>  		reg = <0 0x7ffd0000 0 0x1000>;

Now that MCPM and CPU idle are heading to mainline, it should get queued asap,
thanks for that, probably as a fix at -rc1, since it is quite late now.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
