From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 23 May 2013 11:57:21 +0200
Subject: [PATCH 2/2] ARM: move VFP init to an earlier boot stage
In-Reply-To: <20130523084126.GI18614@n2100.arm.linux.org.uk>
References: <1369294104-3849-1-git-send-email-ard.biesheuvel@linaro.org>
 <1369294104-3849-2-git-send-email-ard.biesheuvel@linaro.org>
 <20130523084126.GI18614@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu_1aJiD_QB1HfvKRKDE1kCtf=fEiqQ=7UbL+je5meFvow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 May 2013 10:41, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, May 23, 2013 at 09:28:24AM +0200, Ard Biesheuvel wrote:
>> In order to use the NEON/VFP unit in the kernel, we should
>> initialize it a bit earlier in the boot process so NEON users
>> that like to do a quick benchmark at load time (like the
>> xor_blocks or RAID-6 code) find the NEON/VFP unit already
>> enabled.
>
> So what are the results of those benchmarks that the RAID-6 code does?
>

Output captured from a Cortex-A15 @ 1.7 GHz:

    xor: measuring software checksum speed
       arm4regs  :  2261.600 MB/sec
       8regs     :  1771.600 MB/sec
       32regs    :  1441.600 MB/sec
       neon      :  3619.600 MB/sec
    xor: using function: neon (3619.600 MB/sec)

Output captured from a Cortex-A15 @ 1.7 GHz:

    raid6: int32x1    200 MB/s
    raid6: int32x2    304 MB/s
    raid6: int32x4    388 MB/s
    raid6: int32x8    423 MB/s
    raid6: neonx1     799 MB/s
    raid6: neonx2    1364 MB/s
    raid6: neonx4    1731 MB/s
    raid6: neonx8    1676 MB/s
    raid6: using algorithm neonx4 (1731 MB/s)
    raid6: using intx1 recovery algorithm

I can put up both patches for RFC if you like.

> This isn't something which will get accepted without there being a very
> strong case for it; firstly, we've always said "no FP in the kernel".
> Secondly, it makes it too easy for people to start thinking that FP is
> safe in the kernel.  It isn't - this will go horribly wrong if the VFP
> hardware bounces an instruction to the support code.
>

That is clear. In the two cases I have been playing with, the
begin/end calls are in distinct compilation units from the actual
functions containing the NEON code. Perhaps we should enforce this by
conditionally turning kernel_vfp_begin() into a macro which errors out
(i.e., if __ARM_NEON__ is defined)?

> Lastly, what happens if you sleep between kernel_vfp_start() and
> kernel_vfp_end() ?  That's a context switch which will mess up your
> VFP state.  I think you need to take a spinlock (not _bh nor _irqsave
> versions) in here to ensure that people don't get the idea that they
> _can_ sleep between these two.
>

So generally, sleeping under preempt_disable() (or get cpu()) in this
case) is not currently handled in that way?
That is a misunderstanding on my part, I will address it in the code.

Regards,
-- 
Ard.



> So, good attempt, but I think you need to think about this more, and
> also justify the need for it.
