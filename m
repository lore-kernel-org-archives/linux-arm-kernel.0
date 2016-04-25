From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 25 Apr 2016 11:47:46 +0100
Subject: [PATCH] ARM64: dts: rockchip: add core dtsi file for RK3399 SoCs
In-Reply-To: <571DEF30.90604@rock-chips.com>
References: <1461122150-9042-1-git-send-email-jay.xu@rock-chips.com>
 <1461211092-26331-1-git-send-email-jay.xu@rock-chips.com>
 <20160421101930.GG6879@leverpostej>
 <5718AFB8.5070004@rock-chips.com> <20160421123018.096d4a75@arm.com>
 <571DE803.3010902@rock-chips.com>
 <20160425100531.GC25087@leverpostej>
 <571DEF30.90604@rock-chips.com>
Message-ID: <20160425104746.GE25087@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 06:19:28PM +0800, Huang, Tao wrote:
> Hi, Mark:
> On 2016?04?25? 18:05, Mark Rutland wrote:
> > On Mon, Apr 25, 2016 at 05:48:51PM +0800, Huang, Tao wrote:
> >> and pmu define as:
> >>     pmu_a53 {
> >>         compatible = "arm,cortex-a53-pmu";
> >>         interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &part0>;
> >>         interrupt-affinity = <&cpu_l0>,
> >>                      <&cpu_l1>,
> >>                      <&cpu_l2>,
> >>                      <&cpu_l3>;
> >>     };
> >>
> >>     pmu_a72 {
> >>         compatible = "arm,cortex-a72-pmu", "arm,cortex-a57-pmu";
> > That Cortex-A57 PMU fallback should just go. We already have Cortex-A72
> > PMU support upstream, and I believe there are sufficient differences
> > such that the Cortex-A72 PMU is not a strict superset of the Cortex-A57
> > PMU.
> As I say, I tested on v4.4, I don't back port
> arch/arm64/kernel/perf_event.c, so I use "arm,cortex-a57-pmu". Upstream
> will use "arm,cortex-a72-pmu" only.
> BTW, I don't see any differences between A72/A57 in source code:

The PMU name is exposed to userspace, so the user will be told they have
a Cortex-A57 PMU, with all of the IMPLEMENTATION DEFINED events that
implies.

We don't handle those IMPLEMENTATION DEFINED events in the kernel, but
for the sake of the userspace ABI, we should not expose the Cortex-A72
PMU as a Cortex-A57 PMU.

Given the code is otherwise identical, it should be relatively simple to
backport the A72 support.

> >> It can boot. And I test with Android simpleperf stat and perf top, it works!
> >> So these patches work on RK3399.
> > There is still work to do in the driver, as Marc pointed out.
> >
> > While it may appear to work, it will be requesting percpu IRQs on wrong
> > CPUs (e.g. see how cpu_pmu_request_irq calls cpu_pmu_enable_percpu_irq,
> > on each CPU), and we will need to update the binding codument to cover
> > this case.
> I also set interrupt-affinity, maybe this avoid problem. I add some
> debug print on driver, I believe irq is request on right cpus.

Unfortunately, that's not entirely the case.

As I mentioned above, cpu_pmu_request_irq calls
cpu_pmu_enable_percpu_irq on each CPU (i.e. all CPUs in the system),
regardless of the affinity.

That may happen to work, but it's not something I'm keen on relying on.

Thanks,
Mark.
