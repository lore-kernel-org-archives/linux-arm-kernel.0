From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Dec 2014 12:59:32 +0000
Subject: [PATCH 3/4] arm64: dts: Add mediatek MT8173 SoC and evaluation
 board dts and Makefile
In-Reply-To: <1418371705.423.31.camel@mtksdaap41>
References: <1418208602-35584-1-git-send-email-eddie.huang@mediatek.com>
 <1418208602-35584-4-git-send-email-eddie.huang@mediatek.com>
 <20141211180245.GE28150@leverpostej>
 <1418371705.423.31.camel@mtksdaap41>
Message-ID: <20141215125932.GF462@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 12, 2014 at 08:08:25AM +0000, Eddie Huang wrote:
> Hi Mark,
> 
> On Thu, 2014-12-11 at 18:02 +0000, Mark Rutland wrote:
> > Hi,
> > 
> > On Wed, Dec 10, 2014 at 10:50:01AM +0000, Eddie Huang wrote:
> > > Add device tree support for MT8173 SoC and evalutaion board based on it.
> > > 
> > > +/ {
> > > +	model = "mediatek,mt8173-evb";
> > > +
> > > +	aliases {
> > > +		serial0 = &uart0;
> > > +		serial1 = &uart1;
> > > +		serial2 = &uart2;
> > > +		serial3 = &uart3;
> > 
> > Do any of these support earlycon?
> 
> Not yet
> 
> > 
> > > +	};
> > > +
> > > +	memory {
> > 
> > Nit: should be memory at 40000000 (and you'll need to add device_type =
> > "memory").
> > 
> > > +		reg = <0 0x40000000 0 0x40000000>;
> > > +	};
> 
> skeleton.dtsi already has /memory node with address-cells=2,
> size-cells=1, which will cause build warning if I change to use
> memory at 40000000, because we use size-cells=2. I will not include
> skeleton.dtsi and follow your suggestion in next version.

That sounds fine to me.

> 
> > > +
> > > +#include "skeleton.dtsi"
> > > +
> > > +/ {
> > > +	compatible = "mediatek,mt8173";
> > > +	interrupt-parent = <&sysirq>;
> > > +	#address-cells = <2>;
> > > +	#size-cells = <2>;
> > > +
> > > +	cpu-map {
> > 
> > This should live under /cpus, as documented in
> > Documentation/devicetree/bindings/arm/topology.txt.
> 
> Got it, fix next version
> 
> > > +
> > > +	psci {
> > > +		compatible = "arm,psci-0.2";
> > > +		method = "smc";
> > > +	};
> > 
> > What are you using as your PSCI 0.2 implementation?
> > 
> > Is it fully compliant? (e.g. are the reset and power off functions
> > implemented, may CPU0 be hotplugged)?
> > 
> > Given only portions of the GIC seem to be described below, what
> > exception level is your kernel entered at? Per the spec it should be
> > EL2, but given the brokenness below with the GIC I'm suspicious.
> > 
> 
> Currently we only implement CPU boot, no power off, no CPU0 hotplug
> either. And enter kernel at EL2. Actually, we run ATF in EL3, then
> switch to EL2 to run lk and kernel.

Ok. In the absence of CPU_OFF, this is not yet a conforming PSCI 0.2
implementation, so I'm wary of marking this as PSCI 0.2 until that is
the case. Any attempt to power of CPUs will hit a BUG() in cpu_die(),
and we don't want that.

Is CPU0 hotplug planned?

If not, does your PSCI implementation report CPU0 as
non-hotpluggable via MIGRATE_INFO_TYPE reporting a UP not migratable
trusted OS (and MIGRATE_INFO_UP_CPU reporting CPU0 as the resident CPU)?

Are SYSTEM_OFF and SYSTEM_RESET available?

Thanks,
Mark.
