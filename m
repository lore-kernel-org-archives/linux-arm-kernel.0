From: dave.long@linaro.org (David Long)
Date: Mon, 03 Feb 2014 21:06:16 -0500
Subject: [PATCH v5 05/16] ARM: use a function table for determining
 instruction interpreter action
In-Reply-To: <1391437498.3509.11.camel@linaro1.home>
References: <1390507559-4697-1-git-send-email-dave.long@linaro.org>
 <1390507559-4697-6-git-send-email-dave.long@linaro.org>
 <1391437498.3509.11.camel@linaro1.home>
Message-ID: <52F04B18.4020905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/14 09:24, Jon Medhurst (Tixy) wrote:
> On Thu, 2014-01-23 at 15:05 -0500, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Make the instruction interpreter call back to semantic action functions
>> through a function pointer array provided by the invoker.  The interpreter
>> decodes the instructions into groups and uses the group number to index
>> into the supplied array.  kprobes and uprobes code will each supply their
>> own array of functions.
>>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>
> [...]
>
>> --- a/arch/arm/kernel/probes.c
>> +++ b/arch/arm/kernel/probes.c
>> @@ -378,10 +378,11 @@ static const int decode_struct_sizes[NUM_DECODE_TYPES] = {
>>    */
>>   int __kprobes
>>   kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi,
>> -		   const union decode_item *table, bool thumb)
>> +		   const union decode_item *table, bool thumb,
>> +		   const union decode_action *actions)
>>   {
>> -	const struct decode_header *h = (struct decode_header *)table;
>> -	const struct decode_header *next;
>> +	struct decode_header *h = (struct decode_header *)table;
>> +	struct decode_header *next;
>
> The decode tables are fixed structures which nothing should want to
> modify, so I think the const's above should be kept. I believe that
> you've had to resort to changing them because the following typedef
> lacks a 'const' on the final argument....
>

I've made the change.

> [...]
>> diff --git a/arch/arm/kernel/probes.h b/arch/arm/kernel/probes.h
>> index c610fa9..81b6e61 100644
> [...]
>>
>> +typedef enum kprobe_insn (probes_custom_decode_t)(kprobe_opcode_t,
>> +						  struct arch_specific_insn *,
>> +						  struct decode_header *);
>> +
>
> Adding 'const' above will also have the knock on effect of requiring
> const on all the 'custom decode' functions as well.
>

I've made those numerous changes as well.

-dl
