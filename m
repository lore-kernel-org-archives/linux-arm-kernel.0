From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 25 Jul 2013 12:17:59 +0100
Subject: [PATCH 2/4] ARM: traps: use <asm/opcodes.h> to get correct
 instruction order
In-Reply-To: <20130724173435.GC4610@localhost.localdomain>
References: <1374510833-25716-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374510833-25716-3-git-send-email-ben.dooks@codethink.co.uk>
 <20130724173435.GC4610@localhost.localdomain>
Message-ID: <51F10967.1090302@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/13 18:34, Dave Martin wrote:
> On Mon, Jul 22, 2013 at 05:33:51PM +0100, Ben Dooks wrote:
>> The trap handler needs to take into account the endian configuration of
>> the system when loading instructions. Use<asm/opcodes.h>  to provide the
>> necessary conversion functions.
>>
>> Signed-off-by: Ben Dooks<ben.dooks@codethink.co.uk>
>> ---
>>   arch/arm/kernel/traps.c |   10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
>> index 1c08911..0a56e13 100644
>> --- a/arch/arm/kernel/traps.c
>> +++ b/arch/arm/kernel/traps.c
>> @@ -34,6 +34,7 @@
>>   #include<asm/unwind.h>
>>   #include<asm/tls.h>
>>   #include<asm/system_misc.h>
>> +#include<asm/opcodes.h>
>>
>>   #include "signal.h"
>
> Looks like is_valid_bugaddr() might need fixing too?
>
> That will need __mem_to_opcode_thumb16() or __mem_to_opcode_arm()
> depending on CONFIG_THUMB2_KERNEL.

I was looking at that, and was considering if this is the right
thing to do or to change the value of BUG_INSTR_VALUE depending
on this.

It is possible the linker may try and change the ordering of the
BUG() instruction as it is being placed in the output with either
a .hword or .word value. I will go and check this as soon as possible.

>> @@ -411,23 +412,24 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
>>   	if (processor_mode(regs) == SVC_MODE) {
>>   #ifdef CONFIG_THUMB2_KERNEL
>>   		if (thumb_mode(regs)) {
>> -			instr = ((u16 *)pc)[0];
>> +			instr = __mem_to_opcode_thumb16(((u16 *)pc)[0]);
>>   			if (is_wide_instruction(instr)) {
>>   				instr<<= 16;
>> -				instr |= ((u16 *)pc)[1];
>> +				instr |= __mem_to_opcode_thumb16(((u16 *)pc)[1]);
>
> Could use __opcode_thumb32_compose(), in which case it might look like
>
> 			if (is_wide_instruction(instr)) {
> 				unsigned int instr2 = __mem_to_opcode_thumb16(
> 					((u16 *)pc)[1]);
> 				instr = __opcode_thumb32_compose(instr, instr2);
>
> (Hmmm, I just noticed that is_wide_instruction and __opcode_is_thumb16()
> kinda duplicate each other.  Could change that too, but it would look
> more like pointless churn...  is_wide_instruction() is used in a fair
> few places already.)

It is possible that it could be changed, but I will avoid that for this
particular patch

>>   			}
>>   		} else
>>   #endif
>> -			instr = *(u32 *) pc;
>> +			instr = __mem_to_opcode_arm(*(u32 *) pc);
>>   	} else if (thumb_mode(regs)) {
>>   		if (get_user(instr, (u16 __user *)pc))
>>   			goto die_sig;
>> +		instr = __mem_to_opcode_thumb16(instr);
>>   		if (is_wide_instruction(instr)) {
>>   			unsigned int instr2;
>>   			if (get_user(instr2, (u16 __user *)pc+1))
>>   				goto die_sig;
>>   			instr<<= 16;
>> -			instr |= instr2;
>> +			instr |= __mem_to_opcode_thumb16(instr2);
>>   		}
>>   	} else if (get_user(instr, (u32 __user *)pc)) {
>
> This also needs mem-to-opcode'ing.

Thanks, will check.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
