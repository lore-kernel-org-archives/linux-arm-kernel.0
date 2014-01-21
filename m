From: dave.long@linaro.org (David Long)
Date: Tue, 21 Jan 2014 11:51:22 -0500
Subject: [PATCH v4 15/16] ARM: add uprobes support
In-Reply-To: <1387564464.3404.106.camel@linaro1.home>
References: <1387166930-13182-1-git-send-email-dave.long@linaro.org>
 <1387166930-13182-16-git-send-email-dave.long@linaro.org>
 <1387564464.3404.106.camel@linaro1.home>
Message-ID: <52DEA58A.9050406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/13 13:34, Jon Medhurst (Tixy) wrote:
> On Sun, 2013-12-15 at 23:08 -0500, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Using Rabin Vincent's ARM uprobes patches as a base, enable uprobes
>> support on ARM.
>>
>> Caveats:
>>
>>   - Thumb is not supported
>>   - XOL abort/trap handling is not implemented
>
> I shall repeat my comment from version one of the patch...
>
> What are the consequences of this, e.g. is it possible for a probe to
> get stuck in an infinite loop of faulting? I hope there are no integrity
> issues for the kernel itself.
>
> Would be good if someone familiar with uprobes working could answer
> that.

Testing shows it does indeed get stuck continuously trapping. The 
process is killable.  Fortunately all the infrastructure is already 
there for fixing this.  I've patched the code to detect the trap and 
allow it to be processed, using the powerpc uprobes code as a model. 
The changes required are fairly small and entirely in the 
architecture-specific code.

As mentioned before, thumb support is a follow-on project.

> I've a few other comments...

[snip]

>
>
>> +const union decode_item uprobes_probes_actions[] = {
>> +	[PROBES_EMULATE_NONE] {.handler = probes_simulate_nop},
>
> There is a missing '=' in the line above. Interesting that GCC doesn't
> complain (I tried compiling this patch and it didn't).
>

That is indeed odd.  I have fixed it (my code, not the compiler).

[snip]

>> +bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
>> +{
>> +	void *addr;
>
> 'addr' is not used so this line can be deleted
>
>> +	probes_opcode_t opcode;
>> +
>> +	if (!auprobe->simulate)
>> +		return false;
>> +
>> +	addr = (void *) regs->ARM_pc;
>
> and so can this line ^^^

Fixed.

>
>> +	opcode = __mem_to_opcode_arm(*(unsigned int *) auprobe->insn);
>> +
>> +	auprobe->asi.insn_singlestep(opcode, &auprobe->asi, regs);
>> +
>> +	return true;
>> +}
>> +
>

Fixed.

> [rest of patch snipped]
>


-dl
