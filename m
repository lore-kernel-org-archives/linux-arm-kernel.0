From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 6 Jun 2013 17:52:56 +0200
Subject: [PATCH 0/5] Kernel mode NEON for XOR and RAID6
In-Reply-To: <20130606151705.GG16794@mudshark.cambridge.arm.com>
References: <1370530985-20619-1-git-send-email-ard.biesheuvel@linaro.org>
 <20130606151705.GG16794@mudshark.cambridge.arm.com>
Message-ID: <CAKv+Gu9NW6mpcCJvv1YFND_LrOs6DcnLsX1hDOvfEUBLw4darw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 June 2013 17:17, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Jun 06, 2013 at 04:03:00PM +0100, Ard Biesheuvel wrote:
>> This time, I have included two use cases that I have been using, XOR and RAID-6
>> checksumming. The former gets a 60% performance boost on the NEON, the latter
>> over 400%.
>
> Whilst that sounds impressive, can you achieve similar results across all
> NEON-capable CPUs? In particular, we need to make sure this doesn't cause
> performance regressions on some cores. Furthermore, do you have any power

I don't expect A8 or A9 to be on par. However, the two examples I have
included perform a quick benchmark at boot to decide which one to
pick, so unless the benchmark is a very poor predictor of the
performance at run time, we should be ok here.

> figures to complement your findings? The increased context-switch overhead
> is also worth measuring if you can (i.e. run some userspace NEON-based
> benchmarks in parallel with NEON and non-NEON implementations of the
> checksumming).
>

Good point. I will follow up on that later.

>> lib/raid6: add ARM-NEON accelerated syndrome calculation
>>
>> This is a port of the RAID-6 checksumming code in altivec.uc ported to use NEON
>> intrinsics. It is about 4x faster than the sequential code. As this code does
>> not live under arch/arm, I will send this patch separately to the appropriate
>> list if/when the prerequisite patches from this series have been accepted.
>
> We support building the kernel with older toolchains, so I don't see the
> benefit of using intrinsics here. Have you tried writing an implementation
> with NEON instructions directly?
>

I have tried an alternate version coded in assembly that was
contributed by Vladimir Murzin. But obviously, compiling to an .S file
should also do the trick if this is a concern.
However, there are two reasons I have chosen these particular examples:
- they can be built for both v7 and v8;
- they illustrate the need to be careful about when GCC might generate
NEON instructions.

I am also working on bit sliced AES which is in fact NEON assembly,
and is about 50% faster in CTR mode (on A15)

-- 
Ard.
