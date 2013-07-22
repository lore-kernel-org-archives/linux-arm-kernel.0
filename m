From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 22 Jul 2013 21:26:35 +0100
Subject: [PATCH 4/4] ARM: set --be8 when linking modules
In-Reply-To: <alpine.LFD.2.03.1307221452210.15022@syhkavp.arg>
References: <1374510833-25716-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374510833-25716-5-git-send-email-ben.dooks@codethink.co.uk>
 <20130722170500.GC19639@codeaurora.org> <51ED69CA.3030501@codethink.co.uk>
 <alpine.LFD.2.03.1307221452210.15022@syhkavp.arg>
Message-ID: <51ED957B.80105@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/13 19:53, Nicolas Pitre wrote:
> On Mon, 22 Jul 2013, Ben Dooks wrote:
>
>> On 22/07/13 18:05, Stephen Boyd wrote:
>>> On 07/22, Ben Dooks wrote:
>>>> To avoid having to make every text section swap the instruction order
>>>> of all instructions, make sure modules are built also built with --be8
>>>> (as is the current kernel final link).
>>>>
>>>> If we do not do this, we would end up having to swap all instructions
>>>> when loading a module, instead of just the instructions that we are
>>>> applying ELF relocations to.
>>>>
>>>
>>> If someone tries to load a be8 module on a non-be8 kernel will it
>>> still work? Or should we add an extra version magic string in
>>> asm/module.h to prevent that?
>>
>> The ELF header changes the EI_DATA field in the ei_ident from
>> ELFDATA2LSB to ELFDATA2MSB when compiling so we should be able
>> to detect these when loading.
>>
>> I have not checked to see if the kernel correctly checks for this.
>>
>> I do not think it currently checks the ei_flags field for the
>> EF_ARM_BE8 in ABI 4 and 5. I am not sure if this is really important?
>
> If the information is already there and easily accessible, then it
> should be used.

I added this, which seems to actually work unlike my last effort.

I do not think it actually gets triggered, the ELF format contains
the endian-ness of the system it was built for and therefore fails
somewhere else.


diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
index d0d1e83..37c8e66 100644
--- a/arch/arm/kernel/elf.c
+++ b/arch/arm/kernel/elf.c
@@ -34,6 +34,17 @@ int elf_check_arch(const struct elf32_hdr *x)
                 if (flt_fmt == EF_ARM_VFP_FLOAT && !(elf_hwcap & 
HWCAP_VFP))
                         return 0;
         }
+
+       if ((eflags & EF_ARM_EABI_MASK) >= EF_ARM_EABI_VER4) {
+               bool is_be8 = IS_ENABLED(CONFIG_CPU_ENDIAN_BE8);
+
+               /* do some simple endian-ness verifications */
+               if (eflags & EF_ARM_BE8 && !is_be8)
+                       return 0;
+               if (eflags & EF_ARM_LE8 && is_be8)
+                       return 0;
+       }
+

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
