From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 2 May 2017 08:51:55 -0700
Subject: [PATCH] arm: pmu: Get PMU working when the A53 is run in 32 bit
 mode
In-Reply-To: <0f716b0c-b9ac-29d9-2909-50906ad90bd3@arm.com>
References: <1493733691-43814-1-git-send-email-alcooperx@gmail.com>
 <0f716b0c-b9ac-29d9-2909-50906ad90bd3@arm.com>
Message-ID: <3f44e99a-6ff1-23e5-52d5-59c662fd10c3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 05/02/2017 07:17 AM, Marc Zyngier wrote:
> Hi Al,
> 
> On 02/05/17 15:01, Al Cooper wrote:
>> From: Al Cooper <al.cooper@broadcom.com>
>>
>> When the A53 is run in A15 (32 bit) mode, the registers used to
>> access the counters are A15 style registers, but the actual
>> counters are the A53 counters not A15 counters. This patch will
>> select a PMU counters map for the A53 if the device tree pmu
>> "compatible" property includes "arm,cortex-a53-pmu".
> 
> I wasn't aware of an "A15 mode"! Is there an ARM3 mode, while we're at
> it? ;-)

This is referring to how our Device Tree and kernel end-up "viewing" the
PMU (based on provided compatible strings) but this probably should be
omitted for clarity.

> 
> More seriously, you seem to take the problem from the wrong end. If you
> have an ARMv8 core, you should use the PMUv3 driver (because that is
> what your A53 has), and not the ARMv7 PMU.
> 
> To that affect, I've posted this[1] a while ago. Can you please give it
> a go?

That seems to be the right direction, however don't you also need to
possibly expose other PMU types as well? Cortex-A53 and Cortex-A57 PMUs
(and possibly more) for instance because there are additional counters
that can be defined specifically for those, e.g: LL = L2 cache on A53,
see [1].

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/core&id=f5337346cd8fe1b105f319b4b7fb06fe25c54480

Thanks!

> 
> Thanks,
> 
> 	M.
> 
> [1]: https://www.spinics.net/lists/arm-kernel/msg571476.html
> 


-- 
Florian
