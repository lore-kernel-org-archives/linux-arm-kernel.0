From: cyril@ti.com (Cyril Chemparathy)
Date: Sun, 12 Aug 2012 14:13:57 -0400
Subject: [PATCH v2 01/22] ARM: add mechanism for late code patching
In-Reply-To: <alpine.LFD.2.02.1208112220400.5231@xanadu.home>
References: <1344648306-15619-1-git-send-email-cyril@ti.com>
 <1344648306-15619-2-git-send-email-cyril@ti.com>
 <alpine.LFD.2.02.1208112220400.5231@xanadu.home>
Message-ID: <5027F265.4030501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/12 22:22, Nicolas Pitre wrote:
> On Fri, 10 Aug 2012, Cyril Chemparathy wrote:
>
>> The original phys_to_virt/virt_to_phys patching implementation relied on early
>> patching prior to MMU initialization.  On PAE systems running out of >4G
>> address space, this would have entailed an additional round of patching after
>> switching over to the high address space.
>>
>> The approach implemented here conceptually extends the original PHYS_OFFSET
>> patching implementation with the introduction of "early" patch stubs.  Early
>> patch code is required to be functional out of the box, even before the patch
>> is applied.  This is implemented by inserting functional (but inefficient)
>> load code into the .runtime.patch.code init section.  Having functional code
>> out of the box then allows us to defer the init time patch application until
>> later in the init sequence.
>>
>> In addition to fitting better with our need for physical address-space
>> switch-over, this implementation should be somewhat more extensible by virtue
>> of its more readable (and hackable) C implementation.  This should prove
>> useful for other similar init time specialization needs, especially in light
>> of our multi-platform kernel initiative.
>>
>> This code has been boot tested in both ARM and Thumb-2 modes on an ARMv7
>> (Cortex-A8) device.
>>
>> Note: the obtuse use of stringified symbols in patch_stub() and
>> early_patch_stub() is intentional.  Theoretically this should have been
>> accomplished with formal operands passed into the asm block, but this requires
>> the use of the 'c' modifier for instantiating the long (e.g. .long %c0).
>> However, the 'c' modifier has been found to ICE certain versions of GCC, and
>> therefore we resort to stringified symbols here.
>>
>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
>
> Reviewed-by: Nicolas Pitre <nico@linaro.org>
>

Thanks.

I've been looking at the compiler emitted code, and had to make a couple 
of changes to keep things streamlined...

[...]
>> +#define early_patch_imm8(insn, to, from, sym, offset)			\
>> +	early_patch_stub(PATCH_IMM8,					\
>> +			 /* code */					\
>> +			 "ldr	%0, =" __stringify(sym + offset) "\n"	\
>> +			 "ldr	%0, [%0]\n"				\
>> +			 insn " %0, %1, %0\n",				\
>> +			 /* patch_data */				\
>> +			 ".long " __stringify(sym + offset) "\n"	\
>> +			 insn " %0, %1, %2\n",				\
>> +			 : "=&r" (to)					\
>> +			 : "r" (from), "I" (__IMM8), "m" (sym)		\
>> +			 : "cc")

First, the "m" operand modifier for "sym" forces GCC to emit code to 
load the address of the symbol into a register.  I've replaced this with 
"i" (&(sym) to make that go away.  With this, the emitted code doesn't 
contain any such unexpected nonsense.

Second, marking the "to" operand as early clobber makes the compiler 
generate horrid register moves around the assembly block, even when it 
has registers to spare.  Simply adding a temporary variable does a much 
much better job, especially since this temporary register is used only 
in the patched-out "early" code.

Thanks
-- Cyril.
