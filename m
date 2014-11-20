From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 20 Nov 2014 14:13:04 +0900
Subject: [PATCH v8 2/6] arm64: ptrace: allow tracer to skip a system call
In-Reply-To: <20141119190601.GM15985@arm.com>
References: <1416273038-15590-1-git-send-email-takahiro.akashi@linaro.org>
 <1416273038-15590-3-git-send-email-takahiro.akashi@linaro.org>
 <20141118140425.GM18842@arm.com> <546C58DB.5080204@linaro.org>
 <20141119190601.GM15985@arm.com>
Message-ID: <546D7860.2010300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2014 04:06 AM, Will Deacon wrote:
> On Wed, Nov 19, 2014 at 08:46:19AM +0000, AKASHI Takahiro wrote:
>> On 11/18/2014 11:04 PM, Will Deacon wrote:
>>> On Tue, Nov 18, 2014 at 01:10:34AM +0000, AKASHI Takahiro wrote:
>>>>
>>>> +	if (((int)regs->syscallno == -1) && (orig_syscallno == -1)) {
>>>> +		/*
>>>> +		 * user-issued syscall(-1):
>>>> +		 * RESTRICTION: We always return ENOSYS whatever value is
>>>> +		 *   stored in x0 (a return value) at this point.
>>>> +		 * Normally, with ptrace off, syscall(-1) returns -ENOSYS.
>>>> +		 * With ptrace on, however, if a tracer didn't pay any
>>>> +		 * attention to user-issued syscall(-1) and just let it go
>>>> +		 * without a hack here, it would return a value in x0 as in
>>>> +		 * other system call cases. This means that this system call
>>>> +		 * might succeed and see any bogus return value.
>>>> +		 * This should be definitely avoided.
>>>> +		 */
>>>> +		regs->regs[0] = -ENOSYS;
>>>> +	}
>>>
>>> I'm still really uncomfortable with this, and it doesn't seem to match what
>>> arch/arm/ does either.
>>
>> Yeah, I know but
>> as I mentioned before, syscall(-1) will be signaled on arm, and so we don't
>> have to care about a return value :)
>
> What does x86 do?

On x86, syscall(-1) returns -ENOSYS if not traced, and we can change a return
value if traced.

>>> Doesn't it also prevent a tracer from skipping syscall(-1)?
>>
>> Syscall(-1) will return -ENOSYS whether or not a syscallno is explicitly
>> replaced with -1 by a tracer, and, in this sense, it is *skipped*.
>
> Ok, but now userspace sees -ENOSYS for a skipped system call in that case,
> whereas it would usually see whatever the trace put in x0, right?

Yes.
If you don't really like this behavior, how about this patch instead of my [2/6] patch?

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 726b910..1ef57d0 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -668,8 +668,15 @@ ENDPROC(el0_svc)
          * switches, and waiting for our parent to respond.
          */
  __sys_trace:
+       cmp     w8, #-1                         // default errno for invalid
+       b.ne    1f                              // system call
+       mov     x0, #-ENOSYS
+       str     x0, [sp, #S_X0]
+1:
         mov     x0, sp
         bl      syscall_trace_enter
+       cmp     w0, #-1                         // skip the syscall?
+       b.eq    __sys_trace_return_skipped
         adr     lr, __sys_trace_return          // return address
         uxtw    scno, w0                        // syscall number (possibly new)
         mov     x1, sp                          // pointer to regs
@@ -684,6 +691,7 @@ __sys_trace:

  __sys_trace_return:
         str     x0, [sp]                        // save returned x0
+__sys_trace_return_skipped:
         mov     x0, sp
         bl      syscall_trace_exit
         b       ret_to_user

With this change, I believe, syscall(-1) returns -ENOSYS by default whether traced
or not, and still you can change a return value when tracing.
(But a drawback here is that a tracer will see -ENOSYS in x0 even at syscall entry
for syscall(-1).)


-Takahiro AKASHI



> Will
>
