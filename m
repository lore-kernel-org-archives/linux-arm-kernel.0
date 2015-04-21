From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 21 Apr 2015 13:19:47 +0200
Subject: [PATCH v2 2/2] ARM: Thumb2: use "bx reg" not "mov pc, reg" for
 all registers
In-Reply-To: <20150421111542.GC3996@e103592.cambridge.arm.com>
References: <1429613983-22739-1-git-send-email-ard.biesheuvel@linaro.org>
 <1429613983-22739-3-git-send-email-ard.biesheuvel@linaro.org>
 <20150421111542.GC3996@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu93TOkEoSSsyRDj1ARhMBqjROEVXODzmgn6Aumj85+hfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 April 2015 at 13:15, Dave P Martin <Dave.Martin@arm.com> wrote:
> On Tue, Apr 21, 2015 at 11:59:43AM +0100, Ard Biesheuvel wrote:
>> Commit 6ebbf2ce437b (ARM: convert all "mov.* pc, reg" to "bx reg"
>> for ARMv6+) replaced all occurrences of 'mov pc, <reg>' with the
>> 'ret' macro. However, this macro only emits the 'bx' instruction
>> when used with the 'lr' register, but still uses 'mov pc, <reg>'
>> for everything else.
>>
>> Since ARM/Thumb2 interworking is allowed in the static kernel
>> (i.e., inside vmlinux), this is potentially unsafe, since the
>> Thumb mov instruction T1 variant that allows PC as the target will
>> not switch modes based on the Thumb bit
>>
>> So when building a Thumb2 kernel, emit the 'bx' instruction for
>> all registers, not just the 'lr' register.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm/include/asm/assembler.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
>> index 186270b3e194..1c057f923258 100644
>> --- a/arch/arm/include/asm/assembler.h
>> +++ b/arch/arm/include/asm/assembler.h
>> @@ -434,6 +434,8 @@ THUMB(    orr     \reg , \reg , #PSR_T_BIT        )
>>       .macro  ret\c, reg
>>  #if __LINUX_ARM_ARCH__ < 6
>>       mov\c   pc, \reg
>> +#elif defined(CONFIG_THUMB2_KERNEL)
>> +     bx\c    \reg
>>  #else
>
> In v7, !THUMB_KERNEL builds, we now do this:
>
>>       .ifeqs  "\reg", "lr"
>>       bx\c    \reg
>
> Why?  A !THUMB2 kernel should not contain any Thumb code in general.
>

AFAIK 'bx lr' is the recommended return sequence, and using anything
else may interfere with the return address prediction or whatever it
is called.
