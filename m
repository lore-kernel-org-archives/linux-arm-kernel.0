From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 7 Jun 2013 21:49:53 +0200
Subject: [PATCH 0/5] Kernel mode NEON for XOR and RAID6
In-Reply-To: <20130607175007.GH8111@mudshark.cambridge.arm.com>
References: <1370530985-20619-1-git-send-email-ard.biesheuvel@linaro.org>
 <20130606151705.GG16794@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1306061156330.18597@syhkavp.arg>
 <20130607175007.GH8111@mudshark.cambridge.arm.com>
Message-ID: <CAKv+Gu8ybHDVbg+2oUB0WKpGiQH31XaS=755PmX1324PJsv77w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 7 June 2013 19:50, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Jun 06, 2013 at 05:17:39PM +0100, Nicolas Pitre wrote:
>> On Thu, 6 Jun 2013, Will Deacon wrote:
>> > On Thu, Jun 06, 2013 at 04:03:00PM +0100, Ard Biesheuvel wrote:
>> > > This time, I have included two use cases that I have been using, XOR and RAID-6
>> > > checksumming. The former gets a 60% performance boost on the NEON, the latter
>> > > over 400%.
>> >
>> > Whilst that sounds impressive, can you achieve similar results across all
>> > NEON-capable CPUs? In particular, we need to make sure this doesn't cause
>> > performance regressions on some cores.
>>
>> Note that the kernel performs runtime benchmarking of all the different
>> implementations it has available at boot time and selects the best one.
>> So if this would turn out to make things worse on some cores then the
>> Neon code would simply not be used.
>
> That will be all sorts of fun if we try to run this on big.LITTLE...
> Perhaps we don't care about that either.
>

Doesn't that apply equally with and without NEON? I mean, there are
several non-NEON flavors of the RAID6 and XOR algorithms already, and
the benchmark at boot time decides which one gets used until the next
reboot.

>> > Furthermore, do you have any power figures to complement your
>> > findings?
>>
>> This is going to be most useful in server type environments where a bit
>> more power is not such an issue but throughput is ... unless you start
>> using RAID6 arrays on your phone that is.  :-)  Otherwise this can be
>> left configured out for mobile targets.
>
> Agreed, but this patch series also sets a precedent for using NEON in the
> kernel. Whilst I'd love to hook up some SCSI arrays to my Nexus 4 (!), much
> more likely is that people might start reworking some of the crypto algorithms
> to use the NEON/SIMD register file (especially with the crypto extensions in
> ARMv8) so it would be good to have *some* feel of the power impact off the
> bat.
>

Why would the kernel be any different from userland in this respect?

>> > The increased context-switch overhead
>> > is also worth measuring if you can (i.e. run some userspace NEON-based
>> > benchmarks in parallel with NEON and non-NEON implementations of the
>> > checksumming).
>>
>> Do we know the context switch cost of normal task scheduling between
>> tasks using FP operations?  The in-kernel Neon usage should bring about
>> the same cost.  Measuring it would be interesting albeit probably
>> difficult.
>
> Sure, this stuff is hard to measure and we don't have a feel for the normal
> context-switch penalities. I just think it would be useful to try and get a
> feel for the increased overhead of saving/restoring this state if userspace
> is trying to use the registers in parallel with the kernel.
>

With NEON only supported outside interrupt context, and no preemption
(as the patch proposes), I don't expect the context switch overhead to
be substantially worse than with as many userland processes competing
for the NEON(s). Perhaps the increased latency is more of a concern
here.

>> > We support building the kernel with older toolchains, so I don't see the
>> > benefit of using intrinsics here.
>>
>> These days the compiler tends to do a better job than humans at properly
>> scheduling instructions for some code.  We shouldn't deprive ourselves
>> from it when a recent enough gcc is available.
>
> What's the earliest toolchain we claim to support nowadays? If that can't
> deal with the intrinsics then we either need to bump the requirement, or
> write this using hand-coded asm. In the case of the latter, I don't think
> the maintenance overhead of having two implementations is worth it.
>

I agree that maintaining an intrinsics version side by side with an
assembly version makes no sense. The same applies to the XOR patch, it
uses -ftree-vectorize, and requires 4.6 (and issues a #warning if your
gcc is older), so if we feel that is not appropriate, I will happily
replace it with a plain assembly version.

However, the main point of this discussion is whether
a) allowing NEON in kernel mode is a good idea in the first place
b) whether the way I propose to do it is an acceptable one.

Any comments/questions on that part?

Regards,
Ard.
