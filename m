From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 02 May 2017 18:53:14 +0100
Subject: [PATCH] arm: pmu: Get PMU working when the A53 is run in 32 bit
 mode
In-Reply-To: <e32b1d89-b349-5a45-565a-19463032adbc@gmail.com> (Florian
 Fainelli's message of "Tue, 2 May 2017 10:37:40 -0700")
References: <1493733691-43814-1-git-send-email-alcooperx@gmail.com>
 <0f716b0c-b9ac-29d9-2909-50906ad90bd3@arm.com>
 <3f44e99a-6ff1-23e5-52d5-59c662fd10c3@gmail.com>
 <87h913mcdy.fsf@on-the-bus.cambridge.arm.com>
 <e32b1d89-b349-5a45-565a-19463032adbc@gmail.com>
Message-ID: <87d1brm9h1.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 02 2017 at  6:37:40 pm BST, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 05/02/2017 09:50 AM, Marc Zyngier wrote:
>> On Tue, May 02 2017 at  4:51:55 pm BST, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> Hi Mark,
>>>
>>> On 05/02/2017 07:17 AM, Marc Zyngier wrote:
>>>> Hi Al,
>>>>
>>>> On 02/05/17 15:01, Al Cooper wrote:
>>>>> From: Al Cooper <al.cooper@broadcom.com>
>>>>>
>>>>> When the A53 is run in A15 (32 bit) mode, the registers used to
>>>>> access the counters are A15 style registers, but the actual
>>>>> counters are the A53 counters not A15 counters. This patch will
>>>>> select a PMU counters map for the A53 if the device tree pmu
>>>>> "compatible" property includes "arm,cortex-a53-pmu".
>>>>
>>>> I wasn't aware of an "A15 mode"! Is there an ARM3 mode, while we're at
>>>> it? ;-)
>>>
>>> This is referring to how our Device Tree and kernel end-up "viewing" the
>>> PMU (based on provided compatible strings) but this probably should be
>>> omitted for clarity.
>> 
>> That's certainly wrong from both an architectural and implementation
>> PoV. Although there is some level of compatibility between the ARMv7 and
>> ARMv8 PMU architectures, they are distinct beasts.
>
> Yes, we are well aware of that, which is why I don't think it's even
> relevant to this discussion here because it's a known implementation
> issue on our end.
>
>> 
>>>>
>>>> More seriously, you seem to take the problem from the wrong end. If you
>>>> have an ARMv8 core, you should use the PMUv3 driver (because that is
>>>> what your A53 has), and not the ARMv7 PMU.
>>>>
>>>> To that affect, I've posted this[1] a while ago. Can you please give it
>>>> a go?
>>>
>>> That seems to be the right direction, however don't you also need to
>>> possibly expose other PMU types as well? Cortex-A53 and Cortex-A57 PMUs
>>> (and possibly more) for instance because there are additional counters
>>> that can be defined specifically for those, e.g: LL = L2 cache on A53,
>>> see [1].
>> 
>> That's pretty much orthogonal. Once we have a common driver for PMUv3 on
>> both 32 and 64bit, adding implementation-specific events can be done for
>> both architecture.
>
> My comment was not so much about the PMU-specific events, but about the
> fact that if you make changes to the PMUv3 between 32-bit and 64-bit
> kernels, we might as well bring all other PMU models that have a
> potential for being shared between 32-bit and 64-bit in one go.

I'm only concerned about the CPU PMU so far, as my main goal is
virtualization (and I have no desire to expose any other form of PMU to
a guest). Non-CPU PMUs should be mostly architecture agnostic already,
and thus pretty easy to enable.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
