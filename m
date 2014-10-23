From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Oct 2014 10:41:48 +0100
Subject: [PATCH 5/7] ARM: mvebu: Enable Performance Monitor Unit on
 Armada 375 SoC
In-Reply-To: <54482CCA.9010002@free-electrons.com>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1413985427-20918-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022140421.GL22642@leverpostej>
 <54482CCA.9010002@free-electrons.com>
Message-ID: <20141023094148.GA13690@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 11:16:42PM +0100, Ezequiel Garcia wrote:
> Hi Mark,
> 
> Thanks for the reply. You made me research and test this in depth :)
> 
> On 10/22/2014 11:04 AM, Mark Rutland wrote:
> > On Wed, Oct 22, 2014 at 02:43:45PM +0100, Ezequiel Garcia wrote:
> >> The Armada 375 SoC has a Cortex-A9 CPU, and so the PMU is available
> >> to be used. This commit enables it in the devicetree.
> >>
> >> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> >> ---
> >>  arch/arm/boot/dts/armada-375.dtsi | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
> >> index de65714..f131cd2 100644
> >> --- a/arch/arm/boot/dts/armada-375.dtsi
> >> +++ b/arch/arm/boot/dts/armada-375.dtsi
> >> @@ -55,6 +55,11 @@
> >>  		};
> >>  	};
> >>  
> >> +	pmu {
> >> +		compatible = "arm,cortex-a9-pmu";
> >> +		interrupts-extended = <&mpic 3>;
> >> +	};
> > 
> > Just to check - the interrupts from both CPUs are muxed into a single
> > line into the interrupt controller?
> > 
> > This isn't gonig to work at the moment -- the perf code will associate
> > this interrupt with CPU0 and you'll lose events on CPU1.
> > 
> > Hopefully there's a separate interrupt for CPU1?
> > 
> 
> The <mpic 3> is a per CPU interrupt.

Ah, ok. I hadn't realised that was the case. That should be fine, then.

> Actually, the interrupt contains more than just PMU events, it contains
> a summary of several CPU events: Perf counters for each CPU, Power
> management interrupts for each CPU, L2 cache interrupt, among others.
> 
> The interrupt cause can be read from a banked register called "CPU
> subsystem local cause". Conversely, each of these must be enabled from
> another (banked) register.

I think that as Thomas said in his reply that it would make sense to
expose these as separate interrupts out of the mpic, given we have the
capability to distinguish them at the mpic. That will prevent a lot of
pain (e.g. percpu interrupts can't currently be shared), and would get
rid of the need to hack armada_xp_mpic_secondary_init to enable a
particular interrupt.

> As far as I understand, this works (or should work) because the irqchip
> driver enables *just* the perf counter interrupt for the running CPU in
> the armada_xp_mpic_secondary_init(). Then, the ARM perf code requests
> the interrupt as per cpu and things just work, right?

That would probably work currently, but I haven't thought about it in
great detail.

It would be nicer if we enabled the perf counter interrupt only in
response to an enable_percpu_irq though.

> However:
> 
> 1) In the Armada 375 SoC case, the MPIC is chained and the code does not
> register the cpu notifier, so armada_xp_mpic_secondary_init is not
> called on CPU1.
> 
> 2) Even when ensuring armada_xp_mpic_secondary_init is called on each
> CPU, and thus each perf counter interrupt is enabled, I can't see the
> PMU interrupt for CPU1, but just the one for the boot CPU.
> 
> I'll check with the hardware designer about this.

Ok. It would be nice to get to the bottom of that. It doesn't seem like
a great idea to add the PMU node with a potential dodgy interrupt -- you
could get misleading output from perf in the case of overflows.

Thanks,
Mark.
