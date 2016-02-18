From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 18 Feb 2016 09:06:36 +0100
Subject: KASAN issues with idle / hotplug area (was: Re: [PATCH v5sub1
 7/8] arm64: move kernel image to base of vmalloc area)
In-Reply-To: <20160217191643.GK32647@leverpostej>
References: <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
 <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
 <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
 <56C31D1D.50708@virtuozzo.com> <20160217143950.GC32647@leverpostej>
 <20160217170110.GE32647@leverpostej>
 <20160217175656.GJ32647@leverpostej>
 <20160217191643.GK32647@leverpostej>
Message-ID: <CAKv+Gu8t6FBeK5FgEcXrDBtJn-9rht=ocZCO0ZAKa887te0veg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 February 2016 at 20:16, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Feb 17, 2016 at 05:56:56PM +0000, Mark Rutland wrote:
>> On Wed, Feb 17, 2016 at 05:01:11PM +0000, Mark Rutland wrote:
>> > On Wed, Feb 17, 2016 at 02:39:51PM +0000, Mark Rutland wrote:
>> > > Perhaps the simplest option is to not instrument invoke_psci_fn_* and
>> > > psci_suspend_finisher. Do we have a per-function annotation to avoid
>> > > KASAN instrumentation, like notrace? I need to investigate, but we may
>> > > also need notrace for similar reasons.
>> >
>> > I came up with the patch below, per the reasoning above.
>> >
>> > It _changes_ the KASAN splats (I see errors in tick_program_event rather
>> > than find_busiest_group), but doesn't seem to get rid of them. I'm not
>> > sure if I've missed something, or if we also have another latent issue.
>> >
>> > Ideas?
>>
>> I'd missed annotating __cpu_suspend_save. I've fixed that up locally
>> (along with s/virt_to_phys/__virt_to_phys due to the inlining issue).
>
> Thinking about it more, I shouldn't have to annotate __cpu_suspend_save,
> as it returns (and hence should have cleaned up after itself).
>
> Looking at the assembly, functions seem to get instrumented regardless
> of the __no_sanitize_address annotation. The assembly of
> __invoke_psci_fn_{smc,hvc} look identical, even if one has the
> annotation and one does not.
>
> In the case below, it looks like __invoke_psci_fn_hvc is storing to the
> shadow area even though it's anotated with __no_sanitize_address.  Note
> that the adrp symbol resolution is bogus; psci_to_linux_errno happens to
> be at offset 0 in the as-yet unlinked psci.o object.
>
> 0000000000000420 <__invoke_psci_fn_hvc>:
>  420:   d10283ff        sub     sp, sp, #0xa0
>  424:   90000004        adrp    x4, 0 <psci_to_linux_errno>
>  428:   91000084        add     x4, x4, #0x0
>  42c:   90000005        adrp    x5, 0 <psci_to_linux_errno>
>  430:   910000a5        add     x5, x5, #0x0
>  434:   d2800007        mov     x7, #0x0                        // #0
>  438:   a9017bfd        stp     x29, x30, [sp,#16]
>  43c:   910043fd        add     x29, sp, #0x10
>  440:   d2800006        mov     x6, #0x0                        // #0
>  444:   a90253f3        stp     x19, x20, [sp,#32]
>  448:   9100c3b3        add     x19, x29, #0x30
>  44c:   d2dff214        mov     x20, #0xff9000000000            // #280993940373504
>  450:   a90393a5        stp     x5, x4, [x29,#56]
>  454:   f2fbfff4        movk    x20, #0xdfff, lsl #48
>  458:   d343fe73        lsr     x19, x19, #3
>  45c:   d2915664        mov     x4, #0x8ab3                     // #35507
>  460:   f9001bf5        str     x21, [sp,#48]
>  464:   f2a836a4        movk    x4, #0x41b5, lsl #16
>  468:   8b140275        add     x21, x19, x20
>  46c:   f9001ba4        str     x4, [x29,#48]
>  470:   3204d3e4        mov     w4, #0xf1f1f1f1                 // #-235802127
>  474:   b8346a64        str     w4, [x19,x20]
>  478:   3204d7e4        mov     w4, #0xf3f3f3f3                 // #-202116109
>  47c:   b9000aa4        str     w4, [x21,#8]
>  480:   910143a4        add     x4, x29, #0x50
>  484:   d2800005        mov     x5, #0x0                        // #0
>  488:   f90003e4        str     x4, [sp]
>  48c:   d2800004        mov     x4, #0x0                        // #0
>  490:   94000000        bl      0 <arm_smccc_hvc>
>  494:   f9402ba0        ldr     x0, [x29,#80]
>  498:   910003bf        mov     sp, x29
>  49c:   b8346a7f        str     wzr, [x19,x20]
>  4a0:   b9000abf        str     wzr, [x21,#8]
>  4a4:   a94153f3        ldp     x19, x20, [sp,#16]
>  4a8:   f94013f5        ldr     x21, [sp,#32]
>  4ac:   a8c97bfd        ldp     x29, x30, [sp],#144
>  4b0:   d65f03c0        ret
>  4b4:   d503201f        nop
>
> For comparison, without KASAN __incoke_psci_fn_hvc looks like:
>
> 0000000000000280 <__invoke_psci_fn_hvc>:
>  280:   d10103ff        sub     sp, sp, #0x40
>  284:   d2800007        mov     x7, #0x0                        // #0
>  288:   d2800006        mov     x6, #0x0                        // #0
>  28c:   d2800005        mov     x5, #0x0                        // #0
>  290:   a9017bfd        stp     x29, x30, [sp,#16]
>  294:   910043fd        add     x29, sp, #0x10
>  298:   910043a4        add     x4, x29, #0x10
>  29c:   f90003e4        str     x4, [sp]
>  2a0:   d2800004        mov     x4, #0x0                        // #0
>  2a4:   94000000        bl      0 <arm_smccc_hvc>
>  2a8:   910003bf        mov     sp, x29
>  2ac:   f9400ba0        ldr     x0, [x29,#16]
>  2b0:   a8c37bfd        ldp     x29, x30, [sp],#48
>  2b4:   d65f03c0        ret
>
> I also tried using __attribute__((no_sanitize_address)) directly, in
> case there was some header issue, but that doesn't seem to be the case.
>
> I'm using the Linaro 15.08 AArch64 GCC 5.1. Is anyone else able to
> confirm whether they see the same? Does the same happen for x86?
>

I am seeing the same problem with  GCC 5.2.1. Replacing the attribute with

__attribute__((optimize("-fno-sanitize=address")))

works, but appears to affect the whole object file, not just the
function to which it is attached.
