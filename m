From: dave.long@linaro.org (David Long)
Date: Mon, 12 Sep 2016 21:07:40 -0400
Subject: [PATCH v4] arm64: Improve kprobes test for atomic sequence
In-Reply-To: <20160913094629.6e8ca789f90ee7f2c80f33db@kernel.org>
References: <1473704487-6069-1-git-send-email-dave.long@linaro.org>
 <20160913094629.6e8ca789f90ee7f2c80f33db@kernel.org>
Message-ID: <57D7515C.30704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2016 08:46 PM, Masami Hiramatsu wrote:
> On Mon, 12 Sep 2016 14:21:27 -0400
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
>>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>>   arch/arm64/kernel/probes/decode-insn.c | 48 ++++++++++++++++------------------
>>   1 file changed, 23 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
>> index 37e47a9..d1731bf 100644
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
>> @@ -142,33 +143,30 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
>>   {
>>   	enum kprobe_insn decoded;
>>   	kprobe_opcode_t insn = le32_to_cpu(*addr);
>> -	kprobe_opcode_t *scan_start = addr - 1;
>> -	kprobe_opcode_t *scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
>> -#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
>> -	struct module *mod;
>> -#endif
>> -
>> -	if (addr >= (kprobe_opcode_t *)_text &&
>> -	    scan_end < (kprobe_opcode_t *)_text)
>> -		scan_end = (kprobe_opcode_t *)_text;
>> -#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
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
>> +	kprobe_opcode_t *scan_end = NULL;
>> +	unsigned long size = 0, offset = 0;
>> +
>> +	/*
>> +	 * If there's a symbol defined in front of and near enough to
>> +	 * the probe address assume it is the entry point to this
>> +	 * code and use it to further limit how far back we search
>> +	 * when determining if we're in an atomic sequence. If we could
>> +	 * not find any symbol skip the atomic test altogether as we
>> +	 * could otherwise end up searching irrelevant text/literals.
>> +	 * KPROBES depends on KALLSYMS so this last case should never
>> +	 * happen.
>> +	 */
>> +	if (kallsyms_lookup_size_offset((unsigned long) addr, &size, &offset)) {
>> +		if (offset < (MAX_ATOMIC_CONTEXT_SIZE*sizeof(kprobe_opcode_t)))
>> +			scan_end = addr - (offset / sizeof(kprobe_opcode_t));
>> +		else
>> +			scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
>>   	}
>
> Hmm, could you tell me what will happen if kallsyms_lookup_size_offset()
> failed here?
>
> Thanks,
>
>> -#endif
>>   	decoded = arm_probe_decode_insn(insn, asi);
>>
>> -	if (decoded == INSN_REJECTED ||
>> -			is_probed_address_atomic(scan_start, scan_end))
>> -		return INSN_REJECTED;
>> +	if (decoded != INSN_REJECTED && scan_end)
>> +		if (is_probed_address_atomic(addr - 1, scan_end))
>> +			return INSN_REJECTED;
>>
>>   	return decoded;
>>   }
>> --
>> 2.5.0
>>
>
>

After the patch the function reads as follows:

> enum kprobe_insn __kprobes
> arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
> {
> 	enum kprobe_insn decoded;
> 	kprobe_opcode_t insn = le32_to_cpu(*addr);
> 	kprobe_opcode_t *scan_end = NULL;
> 	unsigned long size = 0, offset = 0;
>
> 	/*
> 	 * If there's a symbol defined in front of and near enough to
> 	 * the probe address assume it is the entry point to this
> 	 * code and use it to further limit how far back we search
> 	 * when determining if we're in an atomic sequence. If we could
> 	 * not find any symbol skip the atomic test altogether as we
> 	 * could otherwise end up searching irrelevant text/literals.
> 	 * KPROBES depends on KALLSYMS so this last case should never
> 	 * happen.
> 	 */
> 	if (kallsyms_lookup_size_offset((unsigned long) addr, &size, &offset)) {
> 		if (offset < (MAX_ATOMIC_CONTEXT_SIZE*sizeof(kprobe_opcode_t)))
> 			scan_end = addr - (offset / sizeof(kprobe_opcode_t));
> 		else
> 			scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
> 	}
> 	decoded = arm_probe_decode_insn(insn, asi);
>
> 	if (decoded != INSN_REJECTED && scan_end)
> 		if (is_probed_address_atomic(addr - 1, scan_end))
> 			return INSN_REJECTED;
>
> 	return decoded;
> }

A failed kallsyms_lookup_size_offset() call means scan_end will be left 
as NULL, which in turn means arm_kprobe_decode_insn() will simply return 
the result of the arm_probe_decode_insn() call.  In other words it does 
the normal analysis of the instruction to be probed, but does not do the 
atomic sequence search that normally follows that (since it doesn't 
really know how far back to search).

Thanks,
-dl
