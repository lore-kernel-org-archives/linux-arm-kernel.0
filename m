From: raj.khem@gmail.com (Khem Raj)
Date: Wed, 16 Feb 2011 19:17:47 -0800
Subject: [klibc] fwd: fix up ARM assembly to use 'bx lr' in place of 'mov
	pc, lr'.
In-Reply-To: <AANLkTimF6ppk1RHXJnZ+pT1Xwb02idKr5dsFFXsW0Nqr@mail.gmail.com>
References: <20110216230648.GA7649@stro.at>
	<20110216235019.GA17674@shutemov.name>
	<AANLkTimF6ppk1RHXJnZ+pT1Xwb02idKr5dsFFXsW0Nqr@mail.gmail.com>
Message-ID: <AANLkTikOEdrkU_14QK+Fs=9zQ7kvJeJNZRkD0_1stW3R@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 4:03 PM, Khem Raj <raj.khem@gmail.com> wrote:
> On Wed, Feb 16, 2011 at 3:50 PM, Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
>> On Thu, Feb 17, 2011 at 12:06:48AM +0100, maximilian attems wrote:
>>> hello vorlon,
>>>
>>> got notified of your patch,
>>> will apply next days upstream unless some critiques are voiced on ml.
>>> thanks.
>>>
>>> --
>>> maks
>>>
>>>
>>> ----- Forwarded message from Steve Langasek <steve.langasek@canonical.com> -----
>>>
>>> Date: Wed, 16 Feb 2011 22:05:42 -0000
>>> From: Steve Langasek <steve.langasek@canonical.com>
>>> Subject: [Bug 527720] Re: thumb2 porting issues identified: klibc uses mov.*pc
>>>
>>>
>>> I've also touched it up to be mergeable with Debian (support v4t builds
>>> with #ifdef).
>>>
>>> Confirmed that installing the resulting klibc packages on my beagleboard
>>> gives me a successfully-booting initramfs with klibc; and the
>>> vfork/setjmptest test cases all pass in the klibc package tree.
>>>
>>> Fixes: https://bugs.launchpad.net/ubuntu/+source/klibc/+bug/527720
>>>
>>> --- klibc-1.5.20.orig/usr/klibc/arch/arm/vfork.S
>>> +++ klibc-1.5.20/usr/klibc/arch/arm/vfork.S
>>> @@ -25,7 +25,11 @@ vfork:
>>> ? ? ? ? ?ldrcs ? ? ? ?r3, 1f
>>> ? ? ? ? ?mvncs ? ? ? ?r0, #0
>>> ? ? ? ? ?strcs ? ? ? ?r2, [r3]
>>> +#if defined (___ARM_ARCH_4T__) || defined (__ARM_ARCH_4__)
>>
>> NAK. ARMv4T supports bx intruction. ARMv4 doesn't.
>
> Does ARMv4t support BX lr ?

hmm yes it does. I confused it with blx <Rm> which is unpredictable in
thumb mode on architectures < armv5t

>
>
>>
>>> ? ? ? mov ? ? pc, lr
>>> +#else
>>> + ? ? bx ? ? ?lr
>>> +#endif
>>>
>>> ? ? ? .balign 4
>>> ?1:
>>> @@ -49,7 +53,11 @@ vfork:
>>> ? ? ? str ? ? r2, [r1]
>>> ? ? ? neg ? ? r0, r0
>>> ?1:
>>> +#if defined (___ARM_ARCH_4T__) || defined (__ARM_ARCH_4__)
>>> ? ? ? mov ? ? pc, lr
>>> +#else
>>> + ? ? bx ? ? ?lr
>>> +#endif
>>>
>>> ? ? ? .balign 4
>>> ?2:
>>> --- klibc-1.5.20.orig/usr/klibc/arch/arm/setjmp.S
>>> +++ klibc-1.5.20/usr/klibc/arch/arm/setjmp.S
>>> @@ -29,7 +29,11 @@
>>> ?setjmp:
>>> ? ? ? stmia ? r0, {r4, r5, r6, r7, r8, r9, r10, fp, sp, lr}
>>> ? ? ? mov ? ? r0, #0
>>> +#if defined (___ARM_ARCH_4T__) || defined (__ARM_ARCH_4__)
>>> ? ? ? mov ? ? pc, lr
>>> +#else
>>> + ? ? bx ? ? ?lr
>>> +#endif
>>> ? ? ? .size setjmp,.-setjmp
>>>
>>> ? ? ? .text
>>> @@ -39,7 +43,11 @@ setjmp:
>>> ?longjmp:
>>> ? ? ? ldmia ? r0, {r4, r5, r6, r7, r8, r9, r10, fp, sp, lr}
>>> ? ? ? mov ? ? r0, r1
>>> +#if defined (___ARM_ARCH_4T__) || defined (__ARM_ARCH_4__)
>>> ? ? ? mov ? ? pc, lr
>>> +#else
>>> + ? ? bx ? ? ?lr
>>> +#endif
>>> ? ? ? .size longjmp,.-longjmp
>>>
>>> ?#else /* __thumb__ */
>>> @@ -75,7 +83,11 @@ setjmp:
>>> ? ? ? mov ? ? r7, sp
>>> ? ? ? stmia ? r0!, {r3, r4, r5, r6, r7}
>>> ? ? ? mov ? ? r0, #0
>>> +#if defined (___ARM_ARCH_4T__) || defined (__ARM_ARCH_4__)
>>> ? ? ? mov ? ? pc, lr
>>> +#else
>>> + ? ? bx ? ? ?lr
>>> +#endif
>>> ? ? ? .size setjmp,.-setjmp
>>>
>>> ? ? ? .text
>>> @@ -96,7 +108,11 @@ longjmp:
>>> ? ? ? mov ? ? r0, r1
>>> ? ? ? bne ? ? 1f
>>> ? ? ? mov ? ? r0, #1
>>> +#if defined (___ARM_ARCH_4T__) || defined (__ARM_ARCH_4__)
>>> ?1: ? mov ? ? pc, r3
>>> +#else
>>> +1: ? bx ? ? ?r3
>>> +#endif
>>> ? ? ? .size longjmp,.-longjmp
>>>
>>> ?#endif /* __thumb__ */
>>>
>>> _______________________________________________
>>> klibc mailing list
>>> klibc at zytor.com
>>> http://www.zytor.com/mailman/listinfo/klibc
>>
>> --
>> ?Kirill A. Shutemov
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
