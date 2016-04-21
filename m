From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 21 Apr 2016 22:12:28 +0100
Subject: [PATCH] ARM64: dts: rockchip: add core dtsi file for RK3399 SoCs
In-Reply-To: <2131452.5tyGOfVRfi@diego>
References: <1461122150-9042-1-git-send-email-jay.xu@rock-chips.com>
 <5718AFB8.5070004@rock-chips.com> <20160421123018.096d4a75@arm.com>
 <2131452.5tyGOfVRfi@diego>
Message-ID: <20160421221228.359fab3c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2016 22:24:09 +0200
Heiko St?bner <heiko@sntech.de> wrote:

> Am Donnerstag, 21. April 2016, 12:30:18 schrieb Marc Zyngier:
> > On Thu, 21 Apr 2016 18:47:20 +0800
> > 
> > "Huang, Tao" <huangtao@rock-chips.com> wrote:
> > > Hi, Mark:
> > > 
> > > On 2016?04?21? 18:19, Mark Rutland wrote:
> > > > On Thu, Apr 21, 2016 at 11:58:12AM +0800, Jianqun Xu wrote:
> > > >> +		cpu_l0: cpu at 0 {
> > > >> +			device_type = "cpu";
> > > >> +			compatible = "arm,cortex-a53", "arm,armv8";
> > > >> +			reg = <0x0 0x0>;
> > > >> +			enable-method = "psci";
> > > >> +			#cooling-cells = <2>; /* min followed by max */
> > > >> +			clocks = <&cru ARMCLKL>;
> > > >> +		};
> > > >> +		cpu_b0: cpu at 100 {
> > > >> +			device_type = "cpu";
> > > >> +			compatible = "arm,cortex-a72", "arm,armv8";
> > > >> +			reg = <0x0 0x100>;
> > > >> +			enable-method = "psci";
> > > >> +			#cooling-cells = <2>; /* min followed by max */
> > > >> +			clocks = <&cru ARMCLKB>;
> > > >> +		};
> > > >> +
> > > >> +	arm-pmu {
> > > >> +		compatible = "arm,armv8-pmuv3";
> > > >> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> > > >> +	};
> > > > 
> > > > This is wrong, and must go. There should be a separate node for the PMU
> > > > of each microarchitecture, with the appropriate compatible string to
> > > > represent that (see the juno dts).
> > > 
> > > You are right. The first version we wrote is:
> > >     pmu_a53 {
> > >     
> > >         compatible = "arm,cortex-a53-pmu";
> > >         interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> > >         interrupt-affinity = <&cpu_l0>,
> > >         
> > >                      <&cpu_l1>,
> > >                      <&cpu_l2>,
> > >                      <&cpu_l3>;
> > >     
> > >     };
> > >     
> > >     pmu_a72 {
> > >     
> > >         compatible = "arm,cortex-a72-pmu";
> > >         interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> > >         interrupt-affinity = <&cpu_b0>,
> > >         
> > >                      <&cpu_b1>;
> > >     
> > >     };
> > > 
> > > but unfortunately, the arm pmu driver do not support PPI in two cluster
> > > well,
> > > so we have to replace with this implementation.
> > > 
> > > > In this case things are messier as the same PPI number is being used
> > > > across clusters. Marc (Cc'd) has been working on PPI partitions, which
> > > > should allow us to support that.
> > > 
> > > Great! So what we can do right now? Wait this feature, and delete
> > > arm-pmu node?
> > 
> > I'd rather you have a look at the patches, test them with your HW,
> > and comment on what doesn't work!
> 
> I would think we could do it in two tracks, testing and fixing but also letting 
> the rk3399 devicetrees move forward without the pmu at first :-) .

Where would the fun be then? ;-)

	M.
-- 
Jazz is not dead. It just smells funny.
