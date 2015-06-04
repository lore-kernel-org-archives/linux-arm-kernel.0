From: jistone@redhat.com (Josh Stone)
Date: Thu, 04 Jun 2015 10:14:43 -0700
Subject: [PATCH] arm64: fix missing syscall trace exit
In-Reply-To: <20150604100625.GI7557@n2100.arm.linux.org.uk>
References: <20150601102448.GG1641@arm.com>
 <1433293304-26539-1-git-send-email-jistone@redhat.com>
 <556E5454.9080400@redhat.com> <20150604100625.GI7557@n2100.arm.linux.org.uk>
Message-ID: <55708783.2090909@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2015 03:06 AM, Russell King - ARM Linux wrote:
> On Tue, Jun 02, 2015 at 06:11:48PM -0700, Josh Stone wrote:
>> On 06/02/2015 06:01 PM, Josh Stone wrote:
>>> If a syscall is entered without TIF_SYSCALL_TRACE set, then it goes on
>>> the fast path.  It's then possible to have TIF_SYSCALL_TRACE added in
>>> the middle of the syscall, but ret_fast_syscall doesn't check this flag
>>> again.  This causes a ptrace syscall-exit-stop to be missed.
>>>
>>> For instance, from a PTRACE_EVENT_FORK reported during do_fork, the
>>> tracer might resume with PTRACE_SYSCALL, setting TIF_SYSCALL_TRACE.
>>> Now the completion of the fork should have a syscall-exit-stop.
>>>
>>> Russell King fixed this on arm by re-checking _TIF_SYSCALL_WORK in the
>>> fast exit path.  Do the same on arm64.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Russell King <rmk@arm.linux.org.uk>
>>> Signed-off-by: Josh Stone <jistone@redhat.com>
>>> ---
>>>  arch/arm64/kernel/entry.S | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>>> index 959fe8733560..a547a3e8a198 100644
>>> --- a/arch/arm64/kernel/entry.S
>>> +++ b/arch/arm64/kernel/entry.S
>>> @@ -608,7 +608,9 @@ ENDPROC(cpu_switch_to)
>>>   */
>>>  ret_fast_syscall:
>>>  	disable_irq				// disable interrupts
>>> -	ldr	x1, [tsk, #TI_FLAGS]
>>> +	ldr	x1, [tsk, #TI_FLAGS]		// re-check for syscall tracing
>>> +	and	x2, x1, #_TIF_SYSCALL_WORK
>>> +	cbnz	x2, __sys_trace_return
>>>  	and	x2, x1, #_TIF_WORK_MASK
>>>  	cbnz	x2, fast_work_pending
>>>  	enable_step_tsk x1, x2
>>
>> I do have one concern about this, also in Russell's ARM patch.  Is it
>> really ok to branch to __sys_trace_return with interrupts disabled?
> 
> I'm not that happy to hear that you have concerns over the patch after
> hurrying its submission into the -rc kernels.

I simply didn't notice before that disable_irq might be an issue.
Sorry.  I haven't actually encountered any problem, just in theory.

>> I didn't hit any issue from that, but my testcase only exercises this
>> path once each run.  So that might have just been lucky not to hit any
>> gross scenario...
> 
> It would've been good to have tested that _prior_ to me pushing the patch
> into mainline and having the stable trees pick it up.  This kind of thing
> can potentially de-stabilise the kernel.

I never said I tested ARM.  I did test ARM64 with my version of the
patch, and it had no issue that I could see at runtime.

But of course I agree destabilizing is bad -- this is why I spoke up
when I did notice this as a potential problem.

> I had thought you'd have tested with audit and other stuff enabled (I
> don't use that stuff, and I'm clueless about how to use it.)

If you have audit enabled, you'll *never* reach ret_fast_syscall, you'll
get to sys_trace on entry.  If you *ever* had audit enabled since boot,
audit_alloc() sets TIF_SYSCALL_AUDIT on every task that's not explicitly
filtered.  AFAICS, audit_alloc() is the only way to set that flag,
during copy_process(), so it'll never be mid-syscall anyway.

But TIF_SYSCALL_TRACE via PTRACE_SYSCALL is more dynamic, and that's
where I noticed the original problem and how I wrote my test.  See my
original mail attachment for that test if you want to try it.

> Surely, if you're tracing a child, and you start tracing on the exit
> path of a syscall, the child should sleep - and as sleeping with IRQs
> disabled is not allowed, there should've been a warning if this path
> was hit.  I think this brings into question whether that path was
> actually hit during testing.  I hope you tried running a kernel with
> the usual suite of debugging options enabled?

Surely it should sleep, yes -- in my test it hits a ptrace stop.

Whether that exact path is reached -- I think so.  I ran my test on a
distro kernel to see the failure, then applied only this fix and ran
again, could no longer see failure.

I can try a systemtap or ftrace kprobe on ret_fast_syscall to be sure
that path is reached.

Because I was working from a distro kernel, it didn't have debugging
options, no.  I'll go run that now, including both arm and arm64 if I
can find available systems...
