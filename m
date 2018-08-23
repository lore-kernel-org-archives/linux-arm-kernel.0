From: vabhav.sharma@nxp.com (Vabhav Sharma)
Date: Thu, 23 Aug 2018 15:00:03 +0000
Subject: [PATCH 4/5] arm64: dts: add QorIQ LX2160A SoC support
In-Reply-To: <20180821101652.GA18139@e107155-lin>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-5-git-send-email-vabhav.sharma@nxp.com>
 <20180821101652.GA18139@e107155-lin>
Message-ID: <AM6PR04MB47899CE5F871731749E59636F3370@AM6PR04MB4789.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Tuesday, August 21, 2018 3:47 PM
> To: Vabhav Sharma <vabhav.sharma@nxp.com>
> Cc: linux-kernel at vger.kernel.org; devicetree at vger.kernel.org;
> robh+dt at kernel.org; mark.rutland at arm.com; linuxppc-dev at lists.ozlabs.org;
> linux-arm-kernel at lists.infradead.org; mturquette at baylibre.com;
> sboyd at kernel.org; rjw at rjwysocki.net; viresh.kumar at linaro.org; linux-
> clk at vger.kernel.org; linux-pm at vger.kernel.org; linux-kernel-
> owner at vger.kernel.org; catalin.marinas at arm.com; will.deacon at arm.com;
> gregkh at linuxfoundation.org; arnd at arndb.de;
> kstewart at linuxfoundation.org; yamada.masahiro at socionext.com;
> linux at armlinux.org.uk; Varun Sethi <V.Sethi@nxp.com>; Udit Kumar
> <udit.kumar@nxp.com>; Ramneek Mehresh <ramneek.mehresh@nxp.com>;
> Ying Zhang <ying.zhang22455@nxp.com>; Nipun Gupta
> <nipun.gupta@nxp.com>; Priyanka Jain <priyanka.jain@nxp.com>; Yogesh
> Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Sriram Dash
> <sriram.dash@nxp.com>; Sudeep Holla <sudeep.holla@arm.com>
> Subject: Re: [PATCH 4/5] arm64: dts: add QorIQ LX2160A SoC support
> 
> On Mon, Aug 20, 2018 at 12:17:15PM +0530, Vabhav Sharma wrote:
> > LX2160A SoC is based on Layerscape Chassis Generation 3.2 Architecture.
> >
> > LX2160A features an advanced 16 64-bit ARM v8 CortexA72 processor
> > cores in 8 cluster, CCN508, GICv3,two 64-bit DDR4 memory controller, 8
> > I2C controllers, 3 dspi, 2 esdhc,2 USB 3.0, mmu 500, 3 SATA, 4 PL011
> > SBSA UARTs etc.
> >
> > Signed-off-by: Ramneek Mehresh <ramneek.mehresh@nxp.com>
> > Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> > Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> > Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 572
> > +++++++++++++++++++++++++
> >  1 file changed, 572 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > new file mode 100644
> > index 0000000..e35e494
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > @@ -0,0 +1,572 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT) // // Device Tree
> > +Include file for Layerscape-LX2160A family SoC.
> > +//
> > +// Copyright 2018 NXP
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +/memreserve/ 0x80000000 0x00010000;
> > +
> > +/ {
> > +	compatible = "fsl,lx2160a";
> > +	interrupt-parent = <&gic>;
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		// 8 clusters having 2 Cortex-A72 cores each
> > +		cpu at 0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a72";
> > +			reg = <0x0>;
> > +			clocks = <&clockgen 1 0>;
> > +			next-level-cache = <&cluster0_l2>;
> 
> If you expect to get cache properties in sysfs entries, you need to populate
> them here and for each L2 cache.
Rather sysfs, If Entry is not present then print  "cacheinfo: Unable to detect cache hierarchy for CPU 0" appears in boot log which is bad saying something is not present.
Either this print is require change to debug instead of warning.
> 
> [...]
> 
> > +
> > +	rstcr: syscon at 1e60000 {
> > +		compatible = "syscon";
> > +		reg = <0x0 0x1e60000 0x0 0x4>;
> > +	};
> > +
> > +	reboot {
> > +		compatible ="syscon-reboot";
> > +		regmap = <&rstcr>;
> > +		offset = <0x0>;
> > +		mask = <0x2>;
> 
> Is this disabled in bootloader ? With PSCI, it's preferred to use
> SYSTEM_RESET/OFF. EL3 f/w may need to do some housekeeping on
> poweroff.
No, PSCIv0.2 is used and control passes to EL3 fw via smc call, psci node is present in the file.
This node is not required and keeping it in case PSCI is not used.
> 
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <1 13 4>, // Physical Secure PPI, active-low
> 
> The comment says active low but the value 4 indicates it's HIGH from
> "include/dt-bindings/interrupt-controller/irq.h"
Thanks, I will change the entries to existing definition IRQ_TYPE_LEVEL_LOW,GIC_PPI which is self-explanatory and not require comments
> 
> > +			     <1 14 4>, // Physical Non-Secure PPI, active-low
> > +			     <1 11 4>, // Virtual PPI, active-low
> > +			     <1 10 4>; // Hypervisor PPI, active-low
> > +	};
> > +
> > +	pmu {
> > +		compatible = "arm,armv8-pmuv3";
> 
> More specific compatible preferably "arm,cortex-a72-pmu" ?
Sure.
> 
> --
> Regards,
> Sudeep
