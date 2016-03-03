From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 3 Mar 2016 15:32:47 +0000
Subject: [PATCH v10 6/9] arm64: kprobes instruction simulation support
In-Reply-To: <56D854EE.4000801@linaro.org>
References: <1456801047-29014-1-git-send-email-dave.long@linaro.org>
 <1456801047-29014-7-git-send-email-dave.long@linaro.org>
 <56D5D9A0.9090205@arm.com> <56D7C573.8030401@linaro.org>
 <20160303080139.3d415d17@arm.com> <56D854EE.4000801@linaro.org>
Message-ID: <56D8591F.7070909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/16 15:14, David Long wrote:
> On 03/03/2016 03:01 AM, Marc Zyngier wrote:
>> On Thu, 3 Mar 2016 00:02:43 -0500
>> David Long <dave.long@linaro.org> wrote:
>>
>>> On 03/01/2016 01:04 PM, Marc Zyngier wrote:
>>>> On 01/03/16 02:57, David Long wrote:
>>>>> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>>>>>
>>>>> Kprobes needs simulation of instructions that cannot be stepped
>>>>> from different memory location, e.g.: those instructions
>>>>> that uses PC-relative addressing. In simulation, the behaviour
>>>>> of the instruction is implemented using a copy of pt_regs.
>>>>>
>>>>> Following instruction catagories are simulated:
>>>>>    - All branching instructions(conditional, register, and immediate)
>>>>>    - Literal access instructions(load-literal, adr/adrp)
>>>>>
>>>>> Conditional execution is limited to branching instructions in
>>>>> ARM v8. If conditions at PSTATE do not match the condition fields
>>>>> of opcode, the instruction is effectively NOP. Kprobes considers
>>>>> this case as 'miss'.
>>>>>
>>>>> This code also replaces the use of arch/arm/opcodes.c for
>>>>> arm_check_condition().
>>>>
>>>> Outdated comment?
>>>>
>>>
>>> Yeah.  I'll remove it.
>>>
>>>>>
>>>>> Thanks to Will Cohen for assorted suggested changes.
>>>>>
>>>>> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>>>>> Signed-off-by: William Cohen <wcohen@redhat.com>
>>>>> Signed-off-by: David A. Long <dave.long@linaro.org>
>>>>> ---
>>>>>    arch/arm64/include/asm/insn.h            |   1 +
>>>>>    arch/arm64/include/asm/probes.h          |   5 +-
>>>>>    arch/arm64/kernel/Makefile               |   3 +-
>>>>>    arch/arm64/kernel/insn.c                 |   1 +
>>>>>    arch/arm64/kernel/kprobes-arm64.c        |  29 +++++
>>>>>    arch/arm64/kernel/kprobes.c              |  32 +++++-
>>>>>    arch/arm64/kernel/probes-simulate-insn.c | 187 +++++++++++++++++++++++++++++++
>>>>>    arch/arm64/kernel/probes-simulate-insn.h |  28 +++++
>>>>>    8 files changed, 280 insertions(+), 6 deletions(-)
>>>>>    create mode 100644 arch/arm64/kernel/probes-simulate-insn.c
>>>>>    create mode 100644 arch/arm64/kernel/probes-simulate-insn.h
>>>>>
>>
>> [...]
>>
>>>>> +/*
>>>>> + * instruction simulation functions
>>>>> + */
>>>>> +void __kprobes
>>>>> +simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs)
>>>>> +{
>>>>> +	long imm, xn, val;
>>>>> +
>>>>> +	xn = opcode & 0x1f;
>>>>> +	imm = ((opcode >> 3) & 0x1ffffc) | ((opcode >> 29) & 0x3);
>>>>> +	imm = sign_extend(imm, 20);
>>>>> +	if (opcode & 0x80000000)
>>>>> +		val = (imm<<12) + (addr & 0xfffffffffffff000);
>>>>> +	else
>>>>> +		val = imm + addr;
>>>>> +
>>>>> +	regs->regs[xn] = val;
>>>>
>>>> What happens when you have something like "adr xzr, blah"? I haven't
>>>> found out where you are writing that back yet, but that could be really
>>>> fun for SP...
>>>>
>>>
>>> It hadn't occurred to me that xzr could be an output register. Sigh.
>>> That could mean a bit of repeated code to handle this special case.  I
>>> wonder what the implications would be of adding xzr to the pt_regs
>>> structure to avoid that.
>>
>> xzr is not a register. It is an encoding that tells the CPU to discard
>> the result of an operation. As such, there is no need to store it.
>>
> 
> I get that, I was just thinking about extra safety for code that gets it 
> wrong. But on second thought maybe that's a little ugly.
> 
>> An easy fix for this would be to have an accessor that actually checks
>> for the register number, and only allows the range 0-30. We've used
>> similar things in KVM for the same reasons (vcpu_get_reg/vcpu_set_reg).
>>
> 
> That makes sense although for at least some of this code it looks like 
> explicitly checking for it allows skipping unneeded calculations.  I 
> don't think the accessor is warranted just for this.

You can expect code that writes back to xzr to be pretty rare (it took
us 3 years to spot the bug in KVM), so any form of optimization around
the fact that xzr behaves like a RO register is a bit pointless (just
like the code that does it is).

It is even arguable that any form of optimization here is fairly
pointless: you just took a trap, saved your register file on the stack,
are *emulating* an instruction - an extra arithmetic operation is never
going to show up anywhere.

On the other hand, having a safe accessor to the register file is pretty
high on my checklist of things that I'd like to see in code that is
aimed at mainline.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
