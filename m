From: jbaron@akamai.com (Jason Baron)
Date: Mon, 27 Feb 2017 14:18:54 -0500
Subject: [PATCH] jump_label: align jump_entry table to at least 4-bytes
In-Reply-To: <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
Message-ID: <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/27/2017 01:57 PM, David Daney wrote:
> On 02/27/2017 10:49 AM, Jason Baron wrote:
>> The core jump_label code makes use of the 2 lower bits of the
>> static_key::[type|entries|next] field. Thus, ensure that the jump_entry
>> table is at least 4-byte aligned.
>>
> [...]
>> diff --git a/arch/mips/include/asm/jump_label.h
>> b/arch/mips/include/asm/jump_label.h
>> index e77672539e8e..243791f3ae71 100644
>> --- a/arch/mips/include/asm/jump_label.h
>> +++ b/arch/mips/include/asm/jump_label.h
>> @@ -31,6 +31,7 @@ static __always_inline bool
>> arch_static_branch(struct static_key *key, bool bran
>>      asm_volatile_goto("1:\t" NOP_INSN "\n\t"
>>          "nop\n\t"
>>          ".pushsection __jump_table,  \"aw\"\n\t"
>> +        ".balign 4\n\t"
>>          WORD_INSN " 1b, %l[l_yes], %0\n\t"
>>          ".popsection\n\t"
>>          : :  "i" (&((char *)key)[branch]) : : l_yes);
>> @@ -45,6 +46,7 @@ static __always_inline bool
>> arch_static_branch_jump(struct static_key *key, bool
>>      asm_volatile_goto("1:\tj %l[l_yes]\n\t"
>>          "nop\n\t"
>>          ".pushsection __jump_table,  \"aw\"\n\t"
>> +        ".balign 4\n\t"
>>          WORD_INSN " 1b, %l[l_yes], %0\n\t"
>>          ".popsection\n\t"
>>          : :  "i" (&((char *)key)[branch]) : : l_yes);
>
>
> I will speak only for the MIPS part.
>
> If the section is not already properly aligned, this change will add
> padding, which is probably not what we want.
>
> Have you ever seen a problem with misalignment in the real world?
>

Hi,

Yes, there was a WARN_ON() reported on POWER here:

https://lkml.org/lkml/2017/2/19/85

The WARN_ON() triggers if either of the 2 lsb are set. More 
specifically, its coming from 'static_key_set_entries()' from the 
following patch, which was recently added to linux-next:

https://lkml.org/lkml/2017/2/3/558

So this was not seen on mips, but I included all arches in this patch 
that I though might be affected.

> If so, I think a better approach might be to set properties on the
> __jump_table section to force the proper alignment, or do something in
> the linker script.
>

So in include/asm-generic/vmlinux.lds.h, we are already setting 
'ALIGN(8)', but that does not appear to be sufficient for POWER...

Also, I checked the size of the vmlinux generated after this change on 
all 4 arches, and it was rather minimal. I think POWER increased the 
most, but the other arches increased by only a few bytes.

Thanks,

-Jason
