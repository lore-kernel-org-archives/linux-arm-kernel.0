From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 9 May 2015 22:10:56 +0200
Subject: [PATCH 1/2] ARM: kvm: fix a bad BSYM() usage
In-Reply-To: <20150509200717.GA30634@cbox>
References: <E1YqkpO-0006zB-QJ@rmk-PC.arm.linux.org.uk>
 <20150509200717.GA30634@cbox>
Message-ID: <CAKv+Gu922cZLGUJ3-g8CJiUCuL-5L=XHPfgXUMo-jrdPKAuokA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 May 2015 at 22:07, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Fri, May 08, 2015 at 05:08:42PM +0100, Russell King wrote:
>> BSYM() should only be used when refering to local symbols in the same
>> assembly file which are resolved by the assembler, and not for
>> linker-fixed up symbols.  The use of BSYM() with panic is incorrect as
>> the linker is involved in fixing up this relocation, and it knows
>> whether panic() is ARM or Thumb.
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
>>  arch/arm/kvm/interrupts.S | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
>> index 79caf79b304a..87847d2c5f99 100644
>> --- a/arch/arm/kvm/interrupts.S
>> +++ b/arch/arm/kvm/interrupts.S
>> @@ -309,7 +309,7 @@ ENTRY(kvm_call_hyp)
>>  THUMB(       orr     r2, r2, #PSR_T_BIT      )
>>       msr     spsr_cxsf, r2
>>       mrs     r1, ELR_hyp
>> -     ldr     r2, =BSYM(panic)
>> +     ldr     r2, =panic
>>       msr     ELR_hyp, r2
>>       ldr     r0, =\panic_str
>>       clrex                           @ Clear exclusive monitor
>> --
>> 1.8.3.1
>>
> Indeed, the linker figures it out as it should.  It does seem like the
> right result is produced with the BSYM() macro as well so not sure what
> the harm is.
>

BSYM() is defined as 'sym + 1' not 'sym | 1', so if the symbol has the
thumb bit set already, the result is incorrect.

> Anyway, I've queued this to merge via the KVM tree.
>
> Thanks,
> -Christoffer
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
