From: jistone@redhat.com (Josh Stone)
Date: Wed, 03 Jun 2015 13:03:49 -0700
Subject: [PATCH] arm64: fix missing syscall trace exit
In-Reply-To: <20150603095241.GD17581@arm.com>
References: <20150601102448.GG1641@arm.com>
 <1433293304-26539-1-git-send-email-jistone@redhat.com>
 <556E5454.9080400@redhat.com> <20150603095241.GD17581@arm.com>
Message-ID: <556F5DA5.2050207@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2015 02:52 AM, Will Deacon wrote:
> On Wed, Jun 03, 2015 at 02:11:48AM +0100, Josh Stone wrote:
>> On 06/02/2015 06:01 PM, Josh Stone wrote:
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
> I think you're right to be concerned!
> 
>> I didn't hit any issue from that, but my testcase only exercises this
>> path once each run.  So that might have just been lucky not to hit any
>> gross scenario...
> 
> Did you try enabling all the audit stuff? It looks like that can call
> into the scheduler, so I think we should be running the tracing callbacks
> with interrupts enabled (and it looks like x86 do this on the exit path).

This particular path only applies if you entered the syscall *without*
any tracing, which is what makes it pretty much a oneshot.  You'd have
to arrange for audit enabling in the middle of a syscall to see it.  My
ptrace test is easier because working from PTRACE_EVENT_FORK is always
in the middle of the fork syscall.

But anyway, I agree interrupts should be enabled -- I'll work on this.
Then after __sys_trace_return jumps to ret_from_user, they'll be
disabled again.  Likewise for arm32 jumping to ret_slow_syscall.
