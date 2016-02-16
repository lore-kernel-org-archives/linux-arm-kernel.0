From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 Feb 2016 17:38:40 +0100
Subject: [PATCH 5/5] arm64: marvell: add Device Tree files for Armada 7K/8K
In-Reply-To: <20160216134219.00045b5b@xhacker>
References: <1455526065-7307-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1455526065-7307-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160216134219.00045b5b@xhacker>
Message-ID: <20160216173840.7f93896f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 16 Feb 2016 13:42:19 +0800, Jisheng Zhang wrote:

> > +/ {
> > +	model = "Marvell Armada AP806";
> > +	compatible = "marvell,armada-ap806";
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	psci {
> > +		compatible = "arm,psci-0.2";
> 
> I guess the firmware is also psci-1.0 compatible.

At boot time, the kernel queries the PSCI firmware, and it says:

[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv0.2 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs

So I think psci-0.2 is correct here. Should this change for the
production revision of the chip, we'll send an update to the Device
Tree accordingly.

> > +	ap806 {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		compatible = "simple-bus";
> > +		interrupt-parent = <&gic>;
> > +		ranges;
> > +
> > +		config-space {
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			compatible = "simple-bus";
> > +			ranges = <0x0 0x0 0xf0000000 0x1000000>;
> > +
> > +			gic: interrupt-controller at 210000 {
> > +				compatible = "arm,cortex-a15-gic",
> > +					     "arm,cortex-a9-gic";
> 
> I guess the GIC is neither the one in cortex-a15 or cortex-a9. 

What makes you think this?

The GIC is a GIC400, which is GICv2 compliant, and arm-cortex-a15-gic /
arm-cortex-a9-gic are valid compatible strings to identify a GICv2
compliant interrupt controller.

See:

arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi:              compatible = "arm,gic-400", "arm,cortex-a15-gic";
arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi:           compatible = "arm,gic-400", "arm,cortex-a15-gic";
arch/arm64/boot/dts/apm/apm-shadowcat.dtsi:             compatible = "arm,cortex-a15-gic";
arch/arm64/boot/dts/apm/apm-storm.dtsi:         compatible = "arm,cortex-a15-gic";
arch/arm64/boot/dts/arm/foundation-v8.dts:              compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
arch/arm64/boot/dts/arm/juno-base.dtsi:         compatible = "arm,gic-400", "arm,cortex-a15-gic";
arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts:             compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
arch/arm64/boot/dts/marvell/armada-ap806.dtsi:                          compatible = "arm,cortex-a15-gic",
arch/arm64/boot/dts/nvidia/tegra132.dtsi:               compatible = "arm,cortex-a15-gic";
arch/arm64/boot/dts/xilinx/zynqmp.dtsi:                 compatible = "arm,gic-400", "arm,cortex-a15-gic";

Or do you have a more specific reason to think that this compatible
string is wrong?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
