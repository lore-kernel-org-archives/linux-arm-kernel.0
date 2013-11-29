From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 29 Nov 2013 17:55:16 +0000
Subject: [PATCH 2/9] ARM: kprobes: fix instruction fetch order with
 <asm/opcodes.h>
In-Reply-To: <CAArO44sQAiz4nHd8LW6kpRg-jPgfr8dbiXfKi+sdjf8zRnE46g@mail.gmail.com>
References: <1383935832-20865-1-git-send-email-ben.dooks@codethink.co.uk>
 <1383935832-20865-3-git-send-email-ben.dooks@codethink.co.uk>
 <CAArO44sQAiz4nHd8LW6kpRg-jPgfr8dbiXfKi+sdjf8zRnE46g@mail.gmail.com>
Message-ID: <5298D504.5090304@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/11/13 13:01, Taras Kondratiuk wrote:
> On 8 November 2013 20:37, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> If we are running BE8, the data and instruction endian-ness do not
>> match, so use <asm/opcodes.h> to correctly translate memory accesses
>> into ARM instructions.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>y
>> ---
>>   arch/arm/kernel/kprobes-common.c | 14 ++++++++------
>>   arch/arm/kernel/kprobes.c        |  9 +++++----
>>   2 files changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/kernel/kprobes-common.c b/arch/arm/kernel/kprobes-common.c
>> index 18a7628..4954e0f 100644
>> --- a/arch/arm/kernel/kprobes-common.c
>> +++ b/arch/arm/kernel/kprobes-common.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/kprobes.h>
>>   #include <asm/system_info.h>
>> +#include <asm/opcodes.h>
>>
>>   #include "kprobes.h"
>>
>> @@ -305,7 +306,8 @@ kprobe_decode_ldmstm(kprobe_opcode_t insn, struct arch_specific_insn *asi)
>>
>>          if (handler) {
>>                  /* We can emulate the instruction in (possibly) modified form */
>> -               asi->insn[0] = (insn & 0xfff00000) | (rn << 16) | reglist;
>> +               asi->insn[0] = __opcode_to_mem_arm((insn & 0xfff00000) |
>> +                                                  (rn << 16) | reglist);
>>                  asi->insn_handler = handler;
>>                  return INSN_GOOD;
>>          }
>> @@ -338,9 +340,9 @@ prepare_emulated_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
>>                  thumb_insn[2] = 0x4770; /* Thumb bx lr */
>
> should be
> thumb_insn[1] = __opcode_to_mem_thumb16(0x4770);
> thumb_insn[2] = __opcode_to_mem_thumb16(0x4770);
>
>>                  return insn;
>>          }
>> -       asi->insn[1] = 0xe12fff1e; /* ARM bx lr */
>> +       asi->insn[1] = __opcode_to_mem_arm(0xe12fff1e); /* ARM bx lr */
>>   #else
>> -       asi->insn[1] = 0xe1a0f00e; /* mov pc, lr */
>> +       asi->insn[1] = __opcode_to_mem_arm(0xe1a0f00e); /* mov pc, lr */
>>   #endif
>>          /* Make an ARM instruction unconditional */
>>          if (insn < 0xe0000000)
>

Thanks, will re-do these patches.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
