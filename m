From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 17 May 2018 12:59:28 -0700
Subject: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <alpine.DEB.2.21.1805171530080.8529@macbook-air>
References: <20180517131727.29263-1-eric@anholt.net>
 <1412187220.62585.1526572780332@email.1und1.de>
 <alpine.DEB.2.21.1805171233500.7984@macbook-air>
 <307323036.63872.1526576126537@email.1und1.de>
 <20180517180758.GK12198@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1805171422450.8529@macbook-air>
 <alpine.DEB.2.21.1805171530080.8529@macbook-air>
Message-ID: <0a643984-1586-8c56-6627-430f0c2a4ba8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2018 12:31 PM, Vince Weaver wrote:
> On Thu, 17 May 2018, Vince Weaver wrote:
> 
>> On Thu, 17 May 2018, Peter Zijlstra wrote:
>> with cortex-a7 now, would it be possible to later drop that if proper 
>> cortex-a53 support is added to the armv7 pmu driver?  Or would that lead 
>> to all kinds of back-compatability mess?
> 
> For what it's worth, the pi-foundation kernel bcm2710 device tree file 
> does:
> 
> 		arm-pmu {
> #ifdef RPI364
> 			compatible = "arm,armv8-pmuv3", "arm,cortex-a7-pmu";
> #else
> 			compatible = "arm,cortex-a7-pmu";
> #endif
> 			interrupt-parent = <&local_intc>;
> 			interrupts = <9>;
> 		};
> 
> 
> Which is probably where I was getting the arm,armv8-pmuv3 from in my 
> original patch.

I thought somehow that Marc Z. had unified
arch/arm/kernel/perf_event_v7.c and arch/arm64/kernel/perf_event.c into
a common driver entry point under drivers/perf/arm_pmu.c but I don't see
it and after about 15 minutes looking at it, it does not look as trivial
as I though to separate out those files so the ARMv8 PMU description can
be moved into a generic location for instance.

FWIW, Broadcom STB chips, even when 64-bit capable or often used with an
32-bit ARM kernel, so having the ARMv8 PMUs work under a 32-bit ARM
kernel would be great. The downstream solution we have sued thus far is
to find the closest compatible string to represent those, which is not
great...
-- 
Florian
