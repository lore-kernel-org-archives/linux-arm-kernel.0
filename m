From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 7 Mar 2016 01:59:58 +0000
Subject: [PATCH 3/4] arm64: dts: Add dts files for LG Electronics's
 lg1312 SoC
In-Reply-To: <1457323800-26904-4-git-send-email-chanho.min@lge.com>
References: <1457323800-26904-1-git-send-email-chanho.min@lge.com>
 <1457323800-26904-4-git-send-email-chanho.min@lge.com>
Message-ID: <20160307015955.GA2410@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 07, 2016 at 01:09:59PM +0900, Chanho Min wrote:
> Add initial dtsi file to support lg1312 SoC which based on
> Cortex-A53. Also add dts file to support lg1312 reference board
> which based on lg1312 SoC.
> 
> Signed-off-by: Chanho Min <chanho.min@lge.com>

I have a few comments on this patch below.

> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <1>;

Is there definitely no reason to require a 64-bit size? e.g. ranges?

Generally I'd expect both address and size to be described as 64 bit quantities
in the root node, to make it less painful to extend in future.

> +
> +	model = "LG Electronics, DTV SoC LG1312 Reference Board";
> +	compatible = "lge,lg1312-ref", "lge,lg1312";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x00000000 0x20000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "root=/dev/nfs ip=dhcp";
> +	};
> +};

Drop these bootargs. This is specific to a particular developer's
configuration, and they make no sense alone given the lack of an nfsroot, so
they're evidently being overwritten anyway.

> +	psci {
> +		compatible  = "arm,psci";
> +		method = "smc";
> +		cpu_suspend = <0x84000001>;
> +		cpu_off = <0x84000002>;
> +		cpu_on = <0x84000003>;
> +	};

What are you using as your PSCI implementation?

Is it not PSCI 0.2+ compliant?

Which exception level are you booting at?

> +	gic: interrupt-controller at c0001000 {
> +		#interrupt-cells = <3>;
> +
> +		compatible = "arm,gic-400";
> +		interrupt-controller;
> +		reg = <0x0 0xc0001000 0x1000>,
> +		      <0x0 0xc0002000 0x1000>;
> +	};

I believe the CPU interface is too short (as GICC_DIR lives at 0x1000).

What about GICH and GICV?

> +	pmu {
> +		compatible = "arm,armv8-pmuv3";

Use "arm,cortex-a53-pmu".

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 ARMV8_TIMER_IRQ_TYPE>,
> +			     <GIC_PPI 14 ARMV8_TIMER_IRQ_TYPE>;
> +		clock-frequency = <24000000>;
> +	};

Please fix your firmware to program CNTFRQ. 

The clock-frequency property is at best a workaround for a broken system, and
is not sufficient in general.

> +	clocks {
> +		clk_bus: clk_bus {
> +			#clock-cells = <0>;
> +
> +			compatible = "fixed-clock";
> +			clock-frequency = <198000000>;
> +			clock-output-names = "BUSCLK";
> +		};
> +	};

Just put this fixed-clock under the root node. There is nothing special about
/clocks; it is not required to be probed and serves no purpose.

Thanks,
Mark.
