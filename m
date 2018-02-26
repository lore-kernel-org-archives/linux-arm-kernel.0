From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 26 Feb 2018 11:37:02 +0000
Subject: [PATCH -stable] arm64: mm: don't write garbage into TTBR1_EL1
 register
In-Reply-To: <20180226113050.GE8736@arm.com>
References: <20180223182902.24873-1-ard.biesheuvel@linaro.org>
 <20180224083424.GC9681@kroah.com>
 <CAKv+Gu9rZEAk1RMUEk=7XCVVkLQ-chDu7GTGArCG0YeYcmx52w@mail.gmail.com>
 <20180226113050.GE8736@arm.com>
Message-ID: <CAKv+Gu-CghL6V7mVqh59mjqWZqj2w8UpYwotEMJmOeT0KGWuxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2018 at 11:30, Will Deacon <will.deacon@arm.com> wrote:
> On Sat, Feb 24, 2018 at 08:50:42AM +0000, Ard Biesheuvel wrote:
>> On 24 February 2018 at 08:34, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Fri, Feb 23, 2018 at 06:29:02PM +0000, Ard Biesheuvel wrote:
>> >> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> >> index 08572f95bd8a..2b473ddeb7a3 100644
>> >> --- a/arch/arm64/mm/proc.S
>> >> +++ b/arch/arm64/mm/proc.S
>> >> @@ -155,7 +155,7 @@ ENDPROC(cpu_do_switch_mm)
>> >>
>> >>  .macro       __idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
>> >>       adrp    \tmp1, empty_zero_page
>> >> -     msr     ttbr1_el1, \tmp2
>> >> +     msr     ttbr1_el1, \tmp1
>> >
>> > I don't understand why this isn't also needed in Linus's tree.  What
>> > commit there prevents this from being required?
>> >
>>
>> Linus's tree has
>>
>>  +.macro __idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
>> +     adrp \tmp1, empty_zero_page
>> +     phys_to_ttbr \tmp1, \tmp2
>> +     msr ttbr1_el1, \tmp2
>> +     isb
>> +     tlbi vmalle1
>> +     dsb nsh
>> +     isb
>> +.endm
>>
>> but phys_to_ttbr does not exist in the v4.15 and earlier trees (it is
>> related to 52-bit physical address support which landed in v4.16), so
>> it was removed for the backport. However, that means tmp2 is never
>> assigned, and whatever was there is poked into the translation table
>> base register.
>
> Damnit, sorry again. I changed the argument order of phys_to_ttbr along
> the way, so must've confused myself during the backporting exercise. It's
> also one of those things that will lead to potential TLB corruption in rare
> circumstances where the junk in TTBR1 ends up giving a valid translation,
> so it didn't crop up in my testing. How did Nicolas see this? The bug
> report I saw didn't look related.
>

This broke the boot on the Dragonboard 410c, but the bisect identified
another unrelated commit initially.


>> But let's wait for team-ARM to ack this in any case.
>
> Acked-by: Will Deacon <will.deacon@arm.com>
>
> Greg -- please can you apply this to the 4.14 and 4.15 stable trees?
>
> Will
