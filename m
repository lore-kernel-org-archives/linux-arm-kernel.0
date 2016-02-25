From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 25 Feb 2016 17:13:07 +0100
Subject: [PATCH v5sub2 1/8] arm64: add support for module PLTs
In-Reply-To: <CAKv+Gu94LAAwj2f9Sj9imn68V0VTF+NOtUPsE3tQnVzNDhAATw@mail.gmail.com>
References: <1454332178-4414-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454332178-4414-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160225160714.GA16546@arm.com>
 <CAKv+Gu94LAAwj2f9Sj9imn68V0VTF+NOtUPsE3tQnVzNDhAATw@mail.gmail.com>
Message-ID: <CAKv+Gu93wj9P8Bxie7Yry5HO3pM2dL=-mLgd9tV=0UhdCbpVBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 February 2016 at 17:12, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 25 February 2016 at 17:07, Will Deacon <will.deacon@arm.com> wrote:
>> Hi Ard,
>>
>> On Mon, Feb 01, 2016 at 02:09:31PM +0100, Ard Biesheuvel wrote:
>>> This adds support for emitting PLTs at module load time for relative
>>> branches that are out of range. This is a prerequisite for KASLR, which
>>> may place the kernel and the modules anywhere in the vmalloc area,
>>> making it more likely that branch target offsets exceed the maximum
>>> range of +/- 128 MB.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>>
>>> In this version, I removed the distinction between relocations against
>>> .init executable sections and ordinary executable sections. The reason
>>> is that it is hardly worth the trouble, given that .init.text usually
>>> does not contain that many far branches, and this version now only
>>> reserves PLT entry space for jump and call relocations against undefined
>>> symbols (since symbols defined in the same module can be assumed to be
>>> within +/- 128 MB)
>>>
>>> For example, the mac80211.ko module (which is fairly sizable at ~400 KB)
>>> built with -mcmodel=large gives the following relocation counts:
>>>
>>>                     relocs    branches   unique     !local
>>>   .text              3925       3347       518        219
>>>   .init.text           11          8         7          1
>>>   .exit.text            4          4         4          1
>>>   .text.unlikely       81         67        36         17
>>>
>>> ('unique' means branches to unique type/symbol/addend combos, of which
>>> !local is the subset referring to undefined symbols)
>>>
>>> IOW, we are only emitting a single PLT entry for the .init sections, and
>>> we are better off just adding it to the core PLT section instead.
>>> ---
>>>  arch/arm64/Kconfig              |   9 +
>>>  arch/arm64/Makefile             |   6 +-
>>>  arch/arm64/include/asm/module.h |  11 ++
>>>  arch/arm64/kernel/Makefile      |   1 +
>>>  arch/arm64/kernel/module-plts.c | 201 ++++++++++++++++++++
>>>  arch/arm64/kernel/module.c      |  12 ++
>>>  arch/arm64/kernel/module.lds    |   3 +
>>>  7 files changed, 242 insertions(+), 1 deletion(-)
>>
>> [...]
>>
>>> +struct plt_entry {
>>> +     /*
>>> +      * A program that conforms to the AArch64 Procedure Call Standard
>>> +      * (AAPCS64) must assume that a veneer that alters IP0 (x16) and/or
>>> +      * IP1 (x17) may be inserted at any branch instruction that is
>>> +      * exposed to a relocation that supports long branches. Since that
>>> +      * is exactly what we are dealing with here, we are free to use x16
>>> +      * as a scratch register in the PLT veneers.
>>> +      */
>>> +     __le32  mov0;   /* movn x16, #0x....                    */
>>> +     __le32  mov1;   /* movk x16, #0x...., lsl #16           */
>>> +     __le32  mov2;   /* movk x16, #0x...., lsl #32           */
>>> +     __le32  br;     /* br   x16                             */
>>> +};
>>
>> I'm worried about this code when CONFIG_ARM64_LSE_ATOMICS=y, but we don't
>> detect them on the CPU at runtime. In this case, all atomic operations
>> are moved out-of-line and called using a bl instruction from inline asm.
>>
>> The out-of-line code is compiled with magic GCC options
>
> Which options are those exactly?
>
>> to force the
>> explicit save/restore of all used registers (see arch/arm64/lib/Makefile),
>> otherwise we'd have to clutter the inline asm with constraints that
>> wouldn't be needed had we managed to patch the bl with an LSE atomic
>> instruction.
>>
>> If you're emitting a PLT, couldn't we end up with silent corruption of
>> x16 for modules using out-of-line atomics like this?
>>
>
> If you violate the AAPCS64 ABI, then obviously the claim above does not hold.

IOW, yes, x16 will be corrupted unexpectedly if it you are expecting
it to be preserved across a bl or b instruction that is exposed to a
jump/call relocation
