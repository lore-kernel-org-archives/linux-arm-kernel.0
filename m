From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 25 Apr 2016 11:05:32 +0100
Subject: [PATCH] ARM64: dts: rockchip: add core dtsi file for RK3399 SoCs
In-Reply-To: <571DE803.3010902@rock-chips.com>
References: <1461122150-9042-1-git-send-email-jay.xu@rock-chips.com>
 <1461211092-26331-1-git-send-email-jay.xu@rock-chips.com>
 <20160421101930.GG6879@leverpostej>
 <5718AFB8.5070004@rock-chips.com> <20160421123018.096d4a75@arm.com>
 <571DE803.3010902@rock-chips.com>
Message-ID: <20160425100531.GC25087@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 05:48:51PM +0800, Huang, Tao wrote:
> Hi, Marc:
> On 2016?04?21? 19:30, Marc Zyngier wrote:
> > On Thu, 21 Apr 2016 18:47:20 +0800
> > "Huang, Tao" <huangtao@rock-chips.com> wrote:
> >
> >> Hi, Mark:
> >> On 2016?04?21? 18:19, Mark Rutland wrote:
> >>> On Thu, Apr 21, 2016 at 11:58:12AM +0800, Jianqun Xu wrote:
> >>>> +		cpu_l0: cpu at 0 {
> >>>> +			device_type = "cpu";
> >>>> +			compatible = "arm,cortex-a53", "arm,armv8";
> >>>> +			reg = <0x0 0x0>;
> >>>> +			enable-method = "psci";
> >>>> +			#cooling-cells = <2>; /* min followed by max */
> >>>> +			clocks = <&cru ARMCLKL>;
> >>>> +		};
> >>>> +		cpu_b0: cpu at 100 {
> >>>> +			device_type = "cpu";
> >>>> +			compatible = "arm,cortex-a72", "arm,armv8";
> >>>> +			reg = <0x0 0x100>;
> >>>> +			enable-method = "psci";
> >>>> +			#cooling-cells = <2>; /* min followed by max */
> >>>> +			clocks = <&cru ARMCLKB>;
> >>>> +		};
> >>>> +
> >>>> +	arm-pmu {
> >>>> +		compatible = "arm,armv8-pmuv3";
> >>>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> >>>> +	};
> >>> This is wrong, and must go. There should be a separate node for the PMU
> >>> of each microarchitecture, with the appropriate compatible string to
> >>> represent that (see the juno dts).
> >> You are right. The first version we wrote is:
> >>     pmu_a53 {
> >>         compatible = "arm,cortex-a53-pmu";
> >>         interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> >>         interrupt-affinity = <&cpu_l0>,
> >>                      <&cpu_l1>,
> >>                      <&cpu_l2>,
> >>                      <&cpu_l3>;
> >>     };
> >>
> >>     pmu_a72 {
> >>         compatible = "arm,cortex-a72-pmu";
> >>         interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> >>         interrupt-affinity = <&cpu_b0>,
> >>                      <&cpu_b1>;
> >>     };
> >> but unfortunately, the arm pmu driver do not support PPI in two cluster
> >> well,
> >> so we have to replace with this implementation.
> >>> In this case things are messier as the same PPI number is being used
> >>> across clusters. Marc (Cc'd) has been working on PPI partitions, which
> >>> should allow us to support that.
> >> Great! So what we can do right now? Wait this feature, and delete
> >> arm-pmu node?
> > I'd rather you have a look at the patches, test them with your HW,
> > and comment on what doesn't work!
> >
> > You can find the patches over there:
> >
> > https://lkml.org/lkml/2016/4/11/182
> >
> > and on the following branch:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> > irq/percpu-partition
> 
> I tested these patches. Because our kernel is based on v4.4, so I back
> port most changes about
> include/linux/irqdomain.h
> kernel/irq/irqdomain.c
> drivers/irqchip/irq-gic-v3.c
> and change rk3399.dtsi base on your arm,gic-v3.txt:
> 
>      gic: interrupt-controller at fee00000 {
>          compatible = "arm,gic-v3";
> -        #interrupt-cells = <3>;
> +        #interrupt-cells = <4>;
>          #address-cells = <2>;
>          #size-cells = <2>;
> ...
> +
> +        ppi-partitions {
> +            part0: interrupt-partition-0 {
> +                affinity = <&cpu_l0 &cpu_l1 &cpu_l2 &cpu_l3>;
> +            };
> +
> +            part1: interrupt-partition-1 {
> +                affinity = <&cpu_b0 &cpu_b1>;
> +            };
> +        };
> 
> and change every interrupts from three cells to four cells, such as
>      saradc: saradc at ff100000 {
>          compatible = "rockchip,rk3399-saradc";
>          reg = <0x0 0xff100000 0x0 0x100>;
> -        interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH 0>;
>          #io-channel-cells = <1>;
>          clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
>          clock-names = "saradc", "apb_pclk";
> 
> and pmu define as:
>     pmu_a53 {
>         compatible = "arm,cortex-a53-pmu";
>         interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &part0>;
>         interrupt-affinity = <&cpu_l0>,
>                      <&cpu_l1>,
>                      <&cpu_l2>,
>                      <&cpu_l3>;
>     };
> 
>     pmu_a72 {
>         compatible = "arm,cortex-a72-pmu", "arm,cortex-a57-pmu";

That Cortex-A57 PMU fallback should just go. We already have Cortex-A72
PMU support upstream, and I believe there are sufficient differences
such that the Cortex-A72 PMU is not a strict superset of the Cortex-A57
PMU.

>         interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &part1>;
>         interrupt-affinity = <&cpu_b0>,
>                      <&cpu_b1>;
>     };
> 
> It can boot. And I test with Android simpleperf stat and perf top, it works!
> So these patches work on RK3399.

There is still work to do in the driver, as Marc pointed out.

While it may appear to work, it will be requesting percpu IRQs on wrong
CPUs (e.g. see how cpu_pmu_request_irq calls cpu_pmu_enable_percpu_irq,
on each CPU), and we will need to update the binding codument to cover
this case.

Thanks,
Mark.
