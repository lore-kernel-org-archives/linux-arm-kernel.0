From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Sep 2014 13:21:48 +0200
Subject: [PATCH v2 2/4] arm64,
 thunder: Add initial dts for Cavium Thunder SoC
In-Reply-To: <1409903205-2762-3-git-send-email-rric@kernel.org>
References: <1409903205-2762-1-git-send-email-rric@kernel.org>
 <1409903205-2762-3-git-send-email-rric@kernel.org>
Message-ID: <5017180.kZRPNE71Sv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 September 2014 09:46:43 Robert Richter wrote:
> diff --git a/arch/arm64/boot/dts/thunder-88xx.dts b/arch/arm64/boot/dts/thunder-88xx.dts
> new file mode 100644
> index 000000000000..4cc1d059d2d9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/thunder-88xx.dts

Most people end up having a soc.dtsi file and a board.dsi file including
the former and adding the machine-specific properties.

It is likely that you will end up needing the same, so you might want to
start that way.

> +/ {
> +	model = "Cavium ThunderX CN88XX Family";
> +	compatible = "cavium,thunder-88xx";

As mentioned by Mark already, you should not include 'xx' in the
compatible string, but instead use the real soc ID.

Normally, each SoC has some slight differences anyway, so you would
override these in the specialized dtsi file.

The "model" property should go into the board specific file.

> +	interrupt-parent = <&gic0>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uaa0;
> +		serial1 = &uaa1;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};

The aliases node should go into the board file as well, since it's
possible that e.g. the first uart is not connected and you need
something like

	aliases {
		serial0 = &uaa1;
	};

The psci node (according to a discussion we just had for the freescale
dts files) should ideally get filled out by the boot loader that
implements the psci code, to ensure the version matches.

> +
> +	memory at 00000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x00000000 0x0 0x80000000>;
> +	};

memory should also go into the board specific file, or get filled by
the boot loader if it is detected at boot time and user serviceable.

I assume that your machines have NUMA properties, in that case it
makes sense to split up the memory device nodes by topology. I think
there are some standard properties to describe the topology further,
but I don't remember how it's done at the moment.

> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		refclk50mhz: refclk50mhz {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <50000000>;
> +			clock-output-names = "refclk50mhz";
> +		};

If the reference clock is generated outside of the SoC, I would put the device
node for it on the top level.

	Arnd
