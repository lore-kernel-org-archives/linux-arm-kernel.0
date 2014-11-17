From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 17 Nov 2014 17:36:45 +0000
Subject: [PATCHv4 5/5] arm64: Trace emulation of AArch32 legacy
 instructions
In-Reply-To: <20141114171224.55e9fe54@gandalf.local.home> (Steven Rostedt's
 message of "Fri, 14 Nov 2014 17:12:24 -0500")
References: <1415792692-11189-1-git-send-email-punit.agrawal@arm.com>
 <1415792692-11189-6-git-send-email-punit.agrawal@arm.com>
 <20141114171224.55e9fe54@gandalf.local.home>
Message-ID: <9hhvbmdvidu.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steven,

Thanks for taking a look.

Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed, 12 Nov 2014 11:44:52 +0000
> Punit Agrawal <punit.agrawal@arm.com> wrote:
>
>> Introduce an event to trace the usage of emulated instructions. The
>> trace event is intended to help identify and encourage the migration
>> of legacy software using the emulation features.
>> 
>> Use this event to trace usage of swp and CP15 barrier emulation.
>> 
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> ---
>>  arch/arm64/kernel/Makefile                 |  1 +
>>  arch/arm64/kernel/armv8_deprecated.c       | 19 ++++++++++++--
>>  arch/arm64/kernel/trace-events-emulation.h | 40 ++++++++++++++++++++++++++++++
>>  3 files changed, 58 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/arm64/kernel/trace-events-emulation.h
>> 
>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>> index 84e9e51..b36ebd0 100644
>> --- a/arch/arm64/kernel/Makefile
>> +++ b/arch/arm64/kernel/Makefile
>> @@ -5,6 +5,7 @@
>>  CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>>  AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>>  CFLAGS_efi-stub.o 	:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>> +CFLAGS_armv8_deprecated.o := -I$(src)
>>  
>>  CFLAGS_REMOVE_ftrace.o = -pg
>>  CFLAGS_REMOVE_insn.o = -pg
>> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
>> index 248b222..62d0672 100644
>> --- a/arch/arm64/kernel/armv8_deprecated.c
>> +++ b/arch/arm64/kernel/armv8_deprecated.c
>> @@ -15,6 +15,9 @@
>>  #include <linux/slab.h>
>>  #include <linux/sysctl.h>
>>  
>> +#define CREATE_TRACE_POINTS
>> +#include "trace-events-emulation.h"
>> +
>
> Note, if possible, please put this include after all other includes.
> Sometimes a header file may include a trace events file and the
> CREATE_TRACE_POINTS define might cause issues.
>
> I'm sure it's fine now, but we don't want to debug this if someone does
> it in the future.

Makes sense. I've moved the include to the end of the list.

>
>
>>  #include <asm/insn.h>
>>  #include <asm/opcodes.h>
>>  #include <asm/system_misc.h>
>> @@ -203,6 +206,11 @@ static int swp_handler(struct pt_regs *regs, u32 instr)
>>  		regs->user_regs.regs[destreg] = data;
>>  
>>  ret:
>> +	if (type == TYPE_SWPB)
>> +		trace_instruction_emulation("swpb", regs->pc);
>> +	else
>> +		trace_instruction_emulation("swp", regs->pc);
>> +
>
> I don't know how critical a path the above is, but if you want to micro
> optimize this, you can make it so that the branch conditional only does
> the test if the tracepoint is enabled.
>
> Now, this makes a difference if jump labels are implemented in arm64 or
> not.
>
> 	if (trace_instruction_emulation_enabled()) {
> 		if (type == TYPE_SWPB)
> 			...
> 		else
> 			...
> 	}
>
> That trace_instruction_emulation_enabled() is a static key (jump label)
> that can turn the if into a unlikely "nop", making the code within it
> in the very slow path.

I don't think the path above is a fast path - SWP{B} emulation will be
slow as it is. Unless anybody thinks otherwise, I will leave the above
micro-optimisation out.

>
>
>>  	pr_warn_ratelimited("\"%s\" (%ld) uses obsolete SWP{B} instruction at 0x%llx\n",
>>  			current->comm, (unsigned long)current->pid, regs->pc);
>>  
>> @@ -260,10 +268,15 @@ static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
>>  		 * dmb - mcr p15, 0, Rt, c7, c10, 5
>>  		 * dsb - mcr p15, 0, Rt, c7, c10, 4
>>  		 */
>> -		if (aarch32_insn_mcr_extract_opc2(instr) == 5)
>> +		if (aarch32_insn_mcr_extract_opc2(instr) == 5) {
>>  			dmb(sy);
>> -		else
>> +			trace_instruction_emulation(
>> +				"mcr p15, 0, Rt, c7, c10, 5 ; dmb", regs->pc);
>> +		} else {
>>  			dsb(sy);
>> +			trace_instruction_emulation(
>> +				"mcr p15, 0, Rt, c7, c10, 4 ; dsb", regs->pc);
>> +		}
>>  		break;
>>  	case 5:
>>  		/*
>> @@ -272,6 +285,8 @@ static int cp15barrier_handler(struct pt_regs *regs, u32 instr)
>>  		 * Taking an exception or returning from one acts as an
>>  		 * instruction barrier. So no explicit barrier needed here.
>>  		 */
>> +		trace_instruction_emulation(
>> +			"mcr p15, 0, Rt, c7, c5, 4 ; isb", regs->pc);
>>  		break;
>>  	}
>>  
>> diff --git a/arch/arm64/kernel/trace-events-emulation.h b/arch/arm64/kernel/trace-events-emulation.h
>> new file mode 100644
>> index 0000000..2ba3882
>> --- /dev/null
>> +++ b/arch/arm64/kernel/trace-events-emulation.h
>> @@ -0,0 +1,40 @@
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM emulation
>> +
>> +#if !defined(_TRACE_EMULATION_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_EMULATION_H
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +TRACE_EVENT(instruction_emulation,
>> +
>> +	TP_PROTO(const char *instr, u64 addr),
>> +	TP_ARGS(instr, addr),
>> +
>> +	TP_STRUCT__entry(
>> +		__array(char, comm, TASK_COMM_LEN)
>
> Why do you save the comm? It gets saved by the tracer (most of the
> time, but we got better at saving it).
>
>> +		__field(pid_t, pid)
>
> Same here. The pid is already saved by the tracing infrastructure (the
> comm is stored in a table that matches pids with comms to which
> explains my comment above).

Good point. I'd forgotten about the comm and pid already reported by the
tracing infrastructure. The emulation should typically occur in
application context and should be accurate enough. I'll zap their
explict usage here.

Cheers,
Punit

>
>
> -- Steve
>
>> +		__string(instr, instr)
>> +		__field(u64, addr)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
>> +		__entry->pid = current->pid;
>> +		__assign_str(instr, instr);
>> +		__entry->addr = addr;
>> +	),
>> +
>> +	TP_printk("instr=\"%s\" comm=%s pid=%d addr=0x%llx", __get_str(instr),
>> +		__entry->comm, __entry->pid, __entry->addr)
>> +);
>> +
>> +#endif /* _TRACE_EMULATION_H */
>> +
>> +/* This part must be outside protection */
>> +#undef TRACE_INCLUDE_PATH
>> +#undef TRACE_INCLUDE_FILE
>> +#define TRACE_INCLUDE_PATH .
>> +
>> +#define TRACE_INCLUDE_FILE trace-events-emulation
>> +#include <trace/define_trace.h>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
