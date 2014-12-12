From: eddie.huang@mediatek.com (Eddie Huang)
Date: Fri, 12 Dec 2014 16:08:25 +0800
Subject: [PATCH 3/4] arm64: dts: Add mediatek MT8173 SoC and evaluation
 board dts and Makefile
In-Reply-To: <20141211180245.GE28150@leverpostej>
References: <1418208602-35584-1-git-send-email-eddie.huang@mediatek.com>
 <1418208602-35584-4-git-send-email-eddie.huang@mediatek.com>
 <20141211180245.GE28150@leverpostej>
Message-ID: <1418371705.423.31.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, 2014-12-11 at 18:02 +0000, Mark Rutland wrote:
> Hi,
> 
> On Wed, Dec 10, 2014 at 10:50:01AM +0000, Eddie Huang wrote:
> > Add device tree support for MT8173 SoC and evalutaion board based on it.
> > 
> > +/ {
> > +	model = "mediatek,mt8173-evb";
> > +
> > +	aliases {
> > +		serial0 = &uart0;
> > +		serial1 = &uart1;
> > +		serial2 = &uart2;
> > +		serial3 = &uart3;
> 
> Do any of these support earlycon?

Not yet

> 
> > +	};
> > +
> > +	memory {
> 
> Nit: should be memory at 40000000 (and you'll need to add device_type =
> "memory").
> 
> > +		reg = <0 0x40000000 0 0x40000000>;
> > +	};

skeleton.dtsi already has /memory node with address-cells=2,
size-cells=1, which will cause build warning if I change to use
memory at 40000000, because we use size-cells=2. I will not include
skeleton.dtsi and follow your suggestion in next version.

> > +
> > +#include "skeleton.dtsi"
> > +
> > +/ {
> > +	compatible = "mediatek,mt8173";
> > +	interrupt-parent = <&sysirq>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	cpu-map {
> 
> This should live under /cpus, as documented in
> Documentation/devicetree/bindings/arm/topology.txt.

Got it, fix next version

> > +
> > +	psci {
> > +		compatible = "arm,psci-0.2";
> > +		method = "smc";
> > +	};
> 
> What are you using as your PSCI 0.2 implementation?
> 
> Is it fully compliant? (e.g. are the reset and power off functions
> implemented, may CPU0 be hotplugged)?
> 
> Given only portions of the GIC seem to be described below, what
> exception level is your kernel entered at? Per the spec it should be
> EL2, but given the brokenness below with the GIC I'm suspicious.
> 

Currently we only implement CPU boot, no power off, no CPU0 hotplug
either. And enter kernel at EL2. Actually, we run ATF in EL3, then
switch to EL2 to run lk and kernel.

> > +
> > +	clocks {
> 
> Please remove the clock container node. It serves no purpose whatsoever.
> 
> Just put these clocks directly under the root.

Got it, fix next version

> > +
> > +		uart_clk: dummy26m {
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <26000000>;
> > +			#clock-cells = <0>;
> > +		};
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <1 13 0x8>,
> > +			     <1 14 0x8>,
> > +			     <1 11 0x8>,
> > +			     <1 10 0x8>;
> 
> Shouldn't these have a non-zero cpu mask?

Yes, should have non-zero cpu mask

> 
> > +		clock-frequency = <13000000>;
> 
> Your firmware should be programming CNTFREQ_EL0, so you shouldn't need
> this (PSCI 0.2 requires CNTFREQ_EL0 to be programmed correctly on all
> CPUs).

Yes, I remove and test ok in my platform

> 
> > +	};
> > +
> > +	soc {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		compatible = "simple-bus";
> > +		ranges;
> > +
> > +		sysirq: intpol-controller at 10200620 {
> > +			compatible = "mediatek,mt8173-sysirq", "mediatek,mt6577-sysirq";
> > +			interrupt-controller;
> > +			#interrupt-cells = <3>;
> > +			interrupt-parent = <&gic>;
> > +			reg = <0 0x10200620 0 0x20>;
> > +		};
> > +
> > +		gic: interrupt-controller at 10220000 {
> > +			compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
> 
> Surely this should be "arm,gic-400"?

Yes, it should be "arm,gic-400", sorry for my mistake.

> 
> > +			#interrupt-cells = <3>;
> > +			interrupt-parent = <&gic>;
> > +			interrupt-controller;
> > +			reg = <0 0x10221000 0 0x1000>,
> > +			      <0 0x10222000 0 0x1000>,
> > +			      <0 0x10200620 0 0x1000>;
> 
> You're missing GICV here, and that GICH address is fundamentally wrong
> (it _must_ be page aligned). 
> 
> The CPU interface (and virtual CPU interface) should be 0x2000 long.
> 
> The GIC maintenance interrupt also seems to be missing.

I will fix in next version
