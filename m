From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 18 Apr 2017 20:54:26 +0100
Subject: arm64: Question about warnings due to unspecified ASM operand
 width
In-Reply-To: <20170418192317.GC128305@google.com>
References: <20170418013156.GB105296@google.com>
 <CAKv+Gu-ThWK_OCO6A9+6wi3b52_UT5_Da3juO3N2f1PqrHDjFw@mail.gmail.com>
 <20170418192317.GC128305@google.com>
Message-ID: <CAKv+Gu93akm8UbxnGT6COmRTMcPJXnctzWKkBZgOnwUHXO1PTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 April 2017 at 20:23, Matthias Kaehlcke <mka@chromium.org> wrote:
> Hoi Ard,
>
> Thanks for your reply!
>
> El Tue, Apr 18, 2017 at 03:29:39PM +0100 Ard Biesheuvel ha dit:
>
>> On 18 April 2017 at 02:31, Matthias Kaehlcke <mka@chromium.org> wrote:
>> > Hi,
>> >
>> > During my work on improving support for kernel builds with clang I
>> > came across a bunch of warnings on arm64 builds about the width of
>> > operands in assembly not being specified:
>> >
>> > arch/arm64/include/asm/arch_timer.h:92:46: error: value size does
>> >       not match register size specified by the constraint and modifier [-Werror,-Wasm-operand-widths]
>> >         asm volatile("mrs %0,   cntfrq_el0" : "=r" (val));
>> >
>> > I understand that this is usually not a problem and might even be
>> > desired to give the compiler more flexiblity in the use of the
>> > available registers.
>> >
>> > My goal is to eventually build the kernel without warnings, not
>> > necessarily fixing all of them, warnings can also be disabled, e.g.
>> > in case of spurious warnings or a high number of occurrences that is
>> > too expensive to fix.
>> >
>> > Before delving into 'fixing' these 'asm-operand-widths' warnings I'd
>> > be interested to know if this is actually desirable or if it is
>> > preferred to keep the operand width unspecified in certain cases.
>> >
>>
>>
>> The root cause is that Clang infers the size of the register from the
>> size of the operand, while GCC always uses an xN register for a %
>> placeholder.
>>
>> With msr/mrs instructions, we can only use xN registers
>
> Good to know, thanks!
>
>> and so the only way to fix this is to ensure that we always use
>> 64-bit operands even for 32-bit system registers. This may be
>> possible in most cases, but assigning 32-bit struct fields becomes a
>> bit painful this way, and 'fixing' what is arguably not broken to
>> begin with may not be something Catalin is eager to accept.
>
> I'm not sure this would be an issue. Clang does not warn about 32-bit
> operands used with 64-bit registers, but about the register type not
> being specified at all. I think we should be fine with specifying xN
> registers for msr/mrs instructions.
>

It appears this was actually fixed in Clang. Formerly, it would
implicitly use %w for 32-bit operands, which breaks if the
instructions (such as msr/mrs, but there are more) don't support it.

Now it uses x registers for unqualified placeholders, and only issues a warning.

So we'd need to update all templates to use explicit qualifiers. I
don't think that should be a problem for anyone.
