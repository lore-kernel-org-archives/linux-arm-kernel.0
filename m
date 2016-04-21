From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 21 Apr 2016 12:30:18 +0100
Subject: [PATCH] ARM64: dts: rockchip: add core dtsi file for RK3399 SoCs
In-Reply-To: <5718AFB8.5070004@rock-chips.com>
References: <1461122150-9042-1-git-send-email-jay.xu@rock-chips.com>
 <1461211092-26331-1-git-send-email-jay.xu@rock-chips.com>
 <20160421101930.GG6879@leverpostej>
 <5718AFB8.5070004@rock-chips.com>
Message-ID: <20160421123018.096d4a75@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2016 18:47:20 +0800
"Huang, Tao" <huangtao@rock-chips.com> wrote:

> Hi, Mark:
> On 2016?04?21? 18:19, Mark Rutland wrote:
> > On Thu, Apr 21, 2016 at 11:58:12AM +0800, Jianqun Xu wrote:
> >> +		cpu_l0: cpu at 0 {
> >> +			device_type = "cpu";
> >> +			compatible = "arm,cortex-a53", "arm,armv8";
> >> +			reg = <0x0 0x0>;
> >> +			enable-method = "psci";
> >> +			#cooling-cells = <2>; /* min followed by max */
> >> +			clocks = <&cru ARMCLKL>;
> >> +		};
> >> +		cpu_b0: cpu at 100 {
> >> +			device_type = "cpu";
> >> +			compatible = "arm,cortex-a72", "arm,armv8";
> >> +			reg = <0x0 0x100>;
> >> +			enable-method = "psci";
> >> +			#cooling-cells = <2>; /* min followed by max */
> >> +			clocks = <&cru ARMCLKB>;
> >> +		};
> >> +
> >> +	arm-pmu {
> >> +		compatible = "arm,armv8-pmuv3";
> >> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> >> +	};
> > This is wrong, and must go. There should be a separate node for the PMU
> > of each microarchitecture, with the appropriate compatible string to
> > represent that (see the juno dts).
> You are right. The first version we wrote is:
>     pmu_a53 {
>         compatible = "arm,cortex-a53-pmu";
>         interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>         interrupt-affinity = <&cpu_l0>,
>                      <&cpu_l1>,
>                      <&cpu_l2>,
>                      <&cpu_l3>;
>     };
> 
>     pmu_a72 {
>         compatible = "arm,cortex-a72-pmu";
>         interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>         interrupt-affinity = <&cpu_b0>,
>                      <&cpu_b1>;
>     };
> but unfortunately, the arm pmu driver do not support PPI in two cluster
> well,
> so we have to replace with this implementation.
> > In this case things are messier as the same PPI number is being used
> > across clusters. Marc (Cc'd) has been working on PPI partitions, which
> > should allow us to support that.
> Great! So what we can do right now? Wait this feature, and delete
> arm-pmu node?

I'd rather you have a look at the patches, test them with your HW,
and comment on what doesn't work!

You can find the patches over there:

https://lkml.org/lkml/2016/4/11/182

and on the following branch:

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
irq/percpu-partition

Of course, you'll have to hack a bit in the PMU code to make it
understand per-PMU affinity together with percpu interrupts, but it
wouldn't be fun if there was nothing to do...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
