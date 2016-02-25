From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 25 Feb 2016 17:33:25 +0100
Subject: [PATCH v5sub2 1/8] arm64: add support for module PLTs
In-Reply-To: <20160225162622.GC16546@arm.com>
References: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454332178-4414-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160225160714.GA16546@arm.com>
 <CAKv+Gu94LAAwj2f9Sj9imn68V0VTF+NOtUPsE3tQnVzNDhAATw@mail.gmail.com>
 <20160225162622.GC16546@arm.com>
Message-ID: <CAKv+Gu8Qx21M=ymne1S4CQUFrXKHTnWFygGBLtXbxiUD9GkiWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 February 2016 at 17:26, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Feb 25, 2016 at 05:12:01PM +0100, Ard Biesheuvel wrote:
>> On 25 February 2016 at 17:07, Will Deacon <will.deacon@arm.com> wrote:
>> > On Mon, Feb 01, 2016 at 02:09:31PM +0100, Ard Biesheuvel wrote:
>> >> +struct plt_entry {
>> >> +     /*
>> >> +      * A program that conforms to the AArch64 Procedure Call Standard
>> >> +      * (AAPCS64) must assume that a veneer that alters IP0 (x16) and/or
>> >> +      * IP1 (x17) may be inserted at any branch instruction that is
>> >> +      * exposed to a relocation that supports long branches. Since that
>> >> +      * is exactly what we are dealing with here, we are free to use x16
>> >> +      * as a scratch register in the PLT veneers.
>> >> +      */
>> >> +     __le32  mov0;   /* movn x16, #0x....                    */
>> >> +     __le32  mov1;   /* movk x16, #0x...., lsl #16           */
>> >> +     __le32  mov2;   /* movk x16, #0x...., lsl #32           */
>> >> +     __le32  br;     /* br   x16                             */
>> >> +};
>> >
>> > I'm worried about this code when CONFIG_ARM64_LSE_ATOMICS=y, but we don't
>> > detect them on the CPU at runtime. In this case, all atomic operations
>> > are moved out-of-line and called using a bl instruction from inline asm.
>> >
>> > The out-of-line code is compiled with magic GCC options
>>
>> Which options are those exactly?
>
> # Tell the compiler to treat all general purpose registers as
> # callee-saved, which allows for efficient runtime patching of the bl
> # instruction in the caller with an atomic instruction when supported by
> # the CPU. Result and argument registers are handled correctly, based on
> # the function prototype.
> lib-$(CONFIG_ARM64_LSE_ATOMICS) += atomic_ll_sc.o
> CFLAGS_atomic_ll_sc.o   := -fcall-used-x0 -ffixed-x1 -ffixed-x2         \
>                    -ffixed-x3 -ffixed-x4 -ffixed-x5 -ffixed-x6          \
>                    -ffixed-x7 -fcall-saved-x8 -fcall-saved-x9           \
>                    -fcall-saved-x10 -fcall-saved-x11 -fcall-saved-x12   \
>                    -fcall-saved-x13 -fcall-saved-x14 -fcall-saved-x15   \
>                    -fcall-saved-x16 -fcall-saved-x17 -fcall-saved-x18
>

Yikes. Is that safe?

>> > to force the
>> > explicit save/restore of all used registers (see arch/arm64/lib/Makefile),
>> > otherwise we'd have to clutter the inline asm with constraints that
>> > wouldn't be needed had we managed to patch the bl with an LSE atomic
>> > instruction.
>> >
>> > If you're emitting a PLT, couldn't we end up with silent corruption of
>> > x16 for modules using out-of-line atomics like this?
>> >
>>
>> If you violate the AAPCS64 ABI, then obviously the claim above does not hold.
>
> Indeed, but this is what mainline is doing today and I'm not keen on
> breaking it. One way to fix it would be to generate a different type of
> plt for branches to the atomic functions that would use the stack
> instead of x16.
>

AFAIK, gcc never uses x18 (the platform register) so we may be able to
use that instead. We'd need confirmation from the toolchain guys,
though ...
