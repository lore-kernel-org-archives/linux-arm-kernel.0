From: dave.long@linaro.org (David Long)
Date: Wed, 7 Sep 2016 10:12:14 -0400
Subject: [PATCH v2] arm64: Improve kprobes test for atomic sequence
In-Reply-To: <20160907145244.ea997984134c15c12793ca74@kernel.org>
References: <1473184499-6018-1-git-send-email-dave.long@linaro.org>
 <20160907145244.ea997984134c15c12793ca74@kernel.org>
Message-ID: <57D0203E.1070901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/2016 01:52 AM, Masami Hiramatsu wrote:
> On Tue,  6 Sep 2016 13:54:59 -0400
> David Long <dave.long@linaro.org> wrote:
>
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Kprobes searches backwards a finite number of instructions to determine if
>> there is an attempt to probe a load/store exclusive sequence. It stops when
>> it hits the maximum number of instructions or a load or store exclusive.
>> However this means it can run up past the beginning of the function and
>> start looking at literal constants. This has been shown to cause a false
>> positive and blocks insertion of the probe. To fix this, further limit the
>> backwards search to stop if it hits a symbol address from kallsyms. The
>> presumption is that this is the entry point to this code (particularly for
>> the common case of placing probes at the beginning of functions).
>>
>> This also improves efficiency by not searching code that is not part of the
>> function. There may be some possibility that the label might not denote the
>> entry path to the probed instruction but the likelihood seems low and this
>> is just another example of how the kprobes user really needs to be
>> careful about what they are doing.
>
> Hi Dave,
>
> kallsyms_lookup_size_offset() part looks good to me. By the way,
> is there any reason we'll check the _text and module's base address
> boundary?
> I think those are already searced by kallsyms_lookup_size_offset(),
> so you don't need to check those. If the address is not found by
> kallsyms_lookup_size_offset(), that address maybe out-of-text.
>

CONFIG KPROBES does currently select CONFIG_KALLSYMS, but is it wise for 
this code to depend on that?  Perhaps the text boundary checking should 
be moved under an else clause for the case of 
kallsyms_lookup_size_offset() failing?

> Thank you,
>>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>>   arch/arm64/kernel/probes/decode-insn.c | 48 +++++++++++++++++++++++-----------
>>   1 file changed, 33 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
>> index 37e47a9..356ee52 100644
>> --- a/arch/arm64/kernel/probes/decode-insn.c
>> +++ b/arch/arm64/kernel/probes/decode-insn.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/kprobes.h>
>>   #include <linux/module.h>
>> +#include <linux/kallsyms.h>
>>   #include <asm/kprobes.h>
>>   #include <asm/insn.h>
>>   #include <asm/sections.h>
>> @@ -122,7 +123,7 @@ arm_probe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
>>   static bool __kprobes
>>   is_probed_address_atomic(kprobe_opcode_t *scan_start, kprobe_opcode_t *scan_end)
>>   {
>> -	while (scan_start > scan_end) {
>> +	while (scan_start >= scan_end) {
>>   		/*
>>   		 * atomic region starts from exclusive load and ends with
>>   		 * exclusive store.
>> @@ -144,26 +145,43 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
>>   	kprobe_opcode_t insn = le32_to_cpu(*addr);
>>   	kprobe_opcode_t *scan_start = addr - 1;
>>   	kprobe_opcode_t *scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
>> +	unsigned long size = 0, offset = 0;
>>   #if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
>>   	struct module *mod;
>>   #endif
>>
>> -	if (addr >= (kprobe_opcode_t *)_text &&
>> -	    scan_end < (kprobe_opcode_t *)_text)
>> -		scan_end = (kprobe_opcode_t *)_text;
>> +	/*
>> +	 * If there's a symbol defined in front of and near enough to
>> +	 * the probe address assume it is the entry point to this
>> +	 * code and use it to further limit how far back we search
>> +	 * when determining if we're in an atomic sequence.
>> +	 */
>> +	if (kallsyms_lookup_size_offset((unsigned long) addr, &size, &offset))
>> +		if (offset < (MAX_ATOMIC_CONTEXT_SIZE*sizeof(kprobe_opcode_t)))
>> +			scan_end = addr - (offset / sizeof(kprobe_opcode_t));
>> +
>> +	if (scan_end <= scan_start) {
>> +		if (addr >= (kprobe_opcode_t *)_text &&
>> +		    scan_end < (kprobe_opcode_t *)_text)
>> +			scan_end = (kprobe_opcode_t *)_text;
>>   #if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
>> -	else {
>> -		preempt_disable();
>> -		mod = __module_address((unsigned long)addr);
>> -		if (mod && within_module_init((unsigned long)addr, mod) &&
>> -			!within_module_init((unsigned long)scan_end, mod))
>> -			scan_end = (kprobe_opcode_t *)mod->init_layout.base;
>> -		else if (mod && within_module_core((unsigned long)addr, mod) &&
>> -			!within_module_core((unsigned long)scan_end, mod))
>> -			scan_end = (kprobe_opcode_t *)mod->core_layout.base;
>> -		preempt_enable();
>> -	}
>> +		else {
>> +			preempt_disable();
>> +			mod = __module_address((unsigned long)addr);
>> +			if (mod &&
>> +			    within_module_init((unsigned long)addr, mod) &&
>> +			    !within_module_init((unsigned long)scan_end, mod))
>> +				scan_end =
>> +				    (kprobe_opcode_t *)mod->init_layout.base;
>> +			else if (mod &&
>> +			    within_module_core((unsigned long)addr, mod) &&
>> +			    !within_module_core((unsigned long)scan_end, mod))
>> +				scan_end =
>> +				    (kprobe_opcode_t *)mod->core_layout.base;
>> +			preempt_enable();
>> +		}
>>   #endif
>> +	}
>>   	decoded = arm_probe_decode_insn(insn, asi);
>>
>>   	if (decoded == INSN_REJECTED ||
>> --
>> 2.5.0
>>

Thanks,
-dl
