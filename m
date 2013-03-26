From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 25 Mar 2013 17:28:21 -0700
Subject: [PATCH 1/4] ARM: context tracking: add exception support
In-Reply-To: <20130321214908.GU4977@n2100.arm.linux.org.uk> (Russell King's
 message of "Thu, 21 Mar 2013 21:49:08 +0000")
References: <1363824121-26169-1-git-send-email-khilman@linaro.org>
 <1363824121-26169-2-git-send-email-khilman@linaro.org>
 <20130321214908.GU4977@n2100.arm.linux.org.uk>
Message-ID: <871ub39f8a.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Wed, Mar 20, 2013 at 05:01:58PM -0700, Kevin Hilman wrote:
>> Add ARM support for the context tracking subsystem by instrumenting
>> exception entry/exit points.
>> 
>> Special thanks to Mats Liljegren for testing, collaboration and adding
>> support for exceptions/faults that were missing in early test versions.

[...]

>> @@ -405,7 +406,9 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
>>  	unsigned int instr;
>>  	siginfo_t info;
>>  	void __user *pc;
>> +	enum ctx_state prev_state;
>>  
>> +	prev_state = exception_enter();
>>  	pc = (void __user *)instruction_pointer(regs);
>>  
>>  	if (processor_mode(regs) == SVC_MODE) {
>> @@ -433,8 +436,10 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
>>  		goto die_sig;
>>  	}
>>  
>> -	if (call_undef_hook(regs, instr) == 0)
>> +	if (call_undef_hook(regs, instr) == 0) {
>> +		exception_exit(prev_state);
>>  		return;
>> +	}
>>  
>>  die_sig:
>>  #ifdef CONFIG_DEBUG_USER
>> @@ -451,12 +456,17 @@ die_sig:
>>  	info.si_addr  = pc;
>>  
>>  	arm_notify_die("Oops - undefined instruction", regs, &info, 0, 6);
>> +	exception_exit(prev_state);
>
> So, FP emulation and VFP support happens via a separate path.  Does this
> also need to be instrumented?

Looking a little closer at how FP/VFP support are handled along with the
rest of the exceptions, I wondered if it might be simpler to do
something like the patch below.  It instruments the assembly directly
using the existing usr_entry macro, and the ret_to_user path.

Doing that would replace instrumenting the various handlers
(do_DataAbort/do_PrefetchAbort), and would handle the FP emulation VFP
support as well.

If this looks OK, I can probably rework the syscall support as well.
This approach covers the slow syscall return path already.  Instead of
forcing the slowpath on all syscalls, I would just need to instrument
the syscall entry and fast syscall return.

Kevin


diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 0f82098..050472c 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -396,6 +396,9 @@ ENDPROC(__pabt_svc)
 #ifdef CONFIG_IRQSOFF_TRACER
 	bl	trace_hardirqs_off
 #endif
+#ifdef CONFIG_CONTEXT_TRACKING
+	bl	user_exit
+#endif	
 	.endm
 
 	.macro	kuser_cmpxchg_check
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 3248cde..3bef99b 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -74,6 +74,9 @@ no_work_pending:
 #if defined(CONFIG_IRQSOFF_TRACER)
 	asm_trace_hardirqs_on
 #endif
+#if defined(CONFIG_CONTEXT_TRACKING)
+	bl user_enter
+#endif	
 	/* perform architecture specific actions before user return */
 	arch_ret_to_user r1, lr
