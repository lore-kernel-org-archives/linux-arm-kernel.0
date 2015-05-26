From: jistone@redhat.com (Josh Stone)
Date: Tue, 26 May 2015 15:38:24 -0700
Subject: arm syscall fast path can miss a ptrace syscall-exit
In-Reply-To: <55550EBA.3050708@redhat.com>
References: <5554F3E4.8020307@redhat.com>
 <20150514193553.GD2067@n2100.arm.linux.org.uk> <55550EBA.3050708@redhat.com>
Message-ID: <5564F5E0.7080108@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Do you plan to commit this check for syscall flags?

On 05/14/2015 02:08 PM, Josh Stone wrote:
> On 05/14/2015 12:35 PM, Russell King - ARM Linux wrote:
>> On Thu, May 14, 2015 at 12:13:40PM -0700, Josh Stone wrote:
>>> I've discovered a case where both arm and arm64 will miss a ptrace
>>> syscall-exit that they should report.  If the syscall is entered without
>>> TIF_SYSCALL_TRACE set, then it goes on the fast path.  It's then
>>> possible to have TIF_SYSCALL_TRACE added in the middle of the syscall,
>>> but ret_fast_syscall doesn't check this flag again.
>>
>> Yes, we assume that if TIF_SYSCALL_TRACE was not set before the call, it
>> isn't set after.  That appears to be an invalid assumption.
>>
>> Here's a patch for ARM - untested atm.
> 
> Thanks!  The system I have at hand is arm64, so I made the similar
> change in arch/arm64/kernel/entry.S, and this passes my test.

FWIW, here's the arm64 change I tested following your example:

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 959fe8733560..a547a3e8a198 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -608,7 +608,9 @@ ENDPROC(cpu_switch_to)
  */
 ret_fast_syscall:
 	disable_irq				// disable interrupts
-	ldr	x1, [tsk, #TI_FLAGS]
+	ldr	x1, [tsk, #TI_FLAGS]		// re-check for syscall tracing
+	and	x2, x1, #_TIF_SYSCALL_WORK
+	cbnz	x2, __sys_trace_return
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, fast_work_pending
 	enable_step_tsk x1, x2


>> There's still a possible hole - if we exit the syscall, then do "work"
>> before returning (such as reschedling to another process), and _then_
>> have syscall tracing enabled, we won't trace the exit.  I think that's
>> acceptable as I see no difference between that and having restored
>> state for userspace, and then immediately processing an interrupt and
>> scheduling on the IRQ exit path.
> 
> Yeah, I think that's fine.  I don't think that hole is visible to
> ptrace, at least, and other tracers already have to accept this
> possibility anyway.
> 
>>
>>  arch/arm/kernel/entry-common.S | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
>> index f8ccc21fa032..4e7f40c577e6 100644
>> --- a/arch/arm/kernel/entry-common.S
>> +++ b/arch/arm/kernel/entry-common.S
>> @@ -33,7 +33,9 @@ ret_fast_syscall:
>>   UNWIND(.fnstart	)
>>   UNWIND(.cantunwind	)
>>  	disable_irq				@ disable interrupts
>> -	ldr	r1, [tsk, #TI_FLAGS]
>> +	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
>> +	tst	r1, #_TIF_SYSCALL_WORK
>> +	bne	__sys_trace_return
>>  	tst	r1, #_TIF_WORK_MASK
>>  	bne	fast_work_pending
>>  	asm_trace_hardirqs_on
>>
>>
> 
