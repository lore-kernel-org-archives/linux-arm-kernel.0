From: olof@lixom.net (Olof Johansson)
Date: Thu, 28 Aug 2014 10:19:00 -0700
Subject: [PATCH 11/14] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <20140828170306.GQ14650@leverpostej>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <1409132660-1898-3-git-send-email-ch.naveen@samsung.com>
 <20140828035639.GB4972@localhost>
 <20140828094846.GD14650@leverpostej>
 <CAOesGMjY8wfAcq2fLgs=ZWHdiWtFqxr+ncUKTje0SnXqO-CCgQ@mail.gmail.com>
 <20140828170306.GQ14650@leverpostej>
Message-ID: <CAOesGMgYeFObKHA9znzBq9t2mLv8WWT1QaKugQ6yf7RgV09Qyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 10:03 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Aug 28, 2014 at 05:28:22PM +0100, Olof Johansson wrote:
>> On Thu, Aug 28, 2014 at 2:48 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > Hi,
>> >
>> >> > +   cpus {
>> >> > +           #address-cells = <2>;
>> >> > +           #size-cells = <0>;
>> >>
>> >> Why size-cells=2? Can you not fit a cpuid in 32 bits?
>> >
>> > As of commit 72aea393a2e7 (arm64: smp: honour #address-size when parsing
>> > CPU reg property) Linux can handle single-cell cpu node reg entries
>> > where /cpus/#address-cells = <1>.
>> >
>> > I can't make any guarantees about other code (e.g. bootloaders) which
>> > might try to do things with cpu nodes, YMMV.
>>
>> Ok. If address-cells is kept at 2 the unit address needs to be changed
>> to "0,0". So one or the other has to be changed.
>
> I'm happy either way.
>
> I'm not sure the rest of the tree had "0," prefixes on all of the
> unit-addresses for 64-bit addresses that were under 4GB, and I'm not
> sure that existing dts consistently do that either.
>
> Do we want to enforce that for all 64-bit unit-addresses?

Yeah, I believe that's the only valid format for a 2-address-cell unit address.

>> > [...]
>> >
>> >> > +   hsi2c_2: hsi2c at 14E60000 {
>> >>
>> >> I much prefer lowercase hex in unit addresses (and reg entries) below. I
>> >> know 32-bit uses uppercase, but let's switch going forward here.
>> >
>> > My preference also; I'm happy to enforce that on new dts.
>> >
>> > [...]
>> >
>> >> > +   timer {
>> >> > +           compatible = "arm,armv8-timer";
>> >> > +           interrupts = <1 13 0xff01>,
>> >> > +                        <1 14 0xff01>,
>> >> > +                        <1 11 0xff01>,
>> >> > +                        <1 10 0xff01>;
>> >> > +           clock-frequency = <24000000>;
>> >> > +           use-clocksource-only;
>> >> > +           use-physical-timer;
>> >>
>> >> These two properties are not standard, and I would expect any 64-bit
>> >> platform to come with PSCI such that you have a way to initialize the
>> >> virtual timers.
>> >
>> > Likewise with clock-frequency. It's not a full workaround, and it's not
>> > hard to initialise CNTFRQ on each CPU.
>>
>> Technically clock-frequency is documented, but not recommended to be
>> used unless needed for working around firmware that doesn't setup the
>> register value. :)
>
> True.
>
>> In this case it's likely a cargo cult carry over from 5250 where the
>> CNTFRQ requirement happened around the same time as we were working on
>> it so that generation firmware lacked support for it -- it should
>> since then have been fixed properly.
>
> It's probably unhelpful that the documentation isn't explicit about
> that. On that front, how about the patch below?
>
> Mark.
>
> ---->8----
> From 67104ad5a56e4c18f9c41f06af028b7561740afd Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Thu, 28 Aug 2014 17:41:03 +0100
> Subject: [PATCH] Doc: dt: arch_timer: discourage clock-frequency use
>
> The ARM Generic Timer (AKA the architected timer, arm_arch_timer)
> features a CPU register (CNTFRQ) which firmware is intended to
> initialize, and non-secure software can read to determine the frequency
> of the timer. On CPUs with secure state, this register cannot be written
> from non-secure states.
>
> The firmware of early SoCs featuring the timer did not correctly
> initialize CNTFRQ correctly on all CPUs, requiring the frequency to be
> described in DT as a workaround. This workaround is not complete however
> as CNTFRQ is exposed to all software in a privileged non-secure mode,
> including KVM guests. The firmware and DTs for recent SoCs have followed
> the example set by these early SoCs.
>
> This patch updates the arch timer binding documentation to make it
> clearer that the use of the clock-frequency property is a poor
> work-around. The MMIO generic timer binding is similarly updated, though
> this is less of a concern as there is generally no need to expose the
> MMIO timers to guest OSs.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

With caps fixed:

Acked-by: Olof Johansson <olof@lixom.net>


> ---
>  Documentation/devicetree/bindings/arm/arch_timer.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/arch_timer.txt b/Documentation/devicetree/bindings/arm/arch_timer.txt
> index 37b2caf..5ca3f95 100644
> --- a/Documentation/devicetree/bindings/arm/arch_timer.txt
> +++ b/Documentation/devicetree/bindings/arm/arch_timer.txt
> @@ -17,7 +17,10 @@ to deliver its interrupts via SPIs.
>  - interrupts : Interrupt list for secure, non-secure, virtual and
>    hypervisor timers, in that order.
>
> -- clock-frequency : The frequency of the main counter, in Hz. Optional.
> +- clock-frequency : The frequency of the main counter, in Hz. Should be present
> +  only where necessary to work around BROKEN firmware which does not configure

No need to do broken in all caps. In reality I don't expect it to make
a difference on people complying or not. :)

> +  CNTFRQ on all CPUs to a uniform correct value. Use of this property is
> +  STRONGLY DISCOURAGED; fix your firmware unless absolutely impossible.

Same here.

>
>  - always-on : a boolean property. If present, the timer is powered through an
>    always-on power domain, therefore it never loses context.
> @@ -38,7 +41,8 @@ Example:
>
>  - compatible : Should at least contain "arm,armv7-timer-mem".
>
> -- clock-frequency : The frequency of the main counter, in Hz. Optional.
> +- clock-frequency : The frequency of the main counter, in Hz. Should be present
> +  only when firmware has not configured the MMIO CNTFRQ registers.
>
>  - reg : The control frame base address.
>
> --
> 1.9.1
>
