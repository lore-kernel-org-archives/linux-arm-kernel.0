From: wcohen@redhat.com (William Cohen)
Date: Fri, 29 May 2015 14:43:14 -0400
Subject: Kernel oops on 32-bit arm with syscall with invalid sysno
In-Reply-To: <20150529161030.GJ2067@n2100.arm.linux.org.uk>
References: <55677D6A.1060008@redhat.com>
 <20150528214256.GF2067@n2100.arm.linux.org.uk> <55688AB7.7000101@redhat.com>
 <20150529161030.GJ2067@n2100.arm.linux.org.uk>
Message-ID: <5568B342.1070708@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/2015 12:10 PM, Russell King - ARM Linux wrote:
> On Fri, May 29, 2015 at 11:50:15AM -0400, William Cohen wrote:
>> On 05/28/2015 05:42 PM, Russell King - ARM Linux wrote:
>>> On Thu, May 28, 2015 at 04:41:14PM -0400, William Cohen wrote:
>>>> When reviewing testsuite failures for systemtap I found that the
>>>> 32-bit arm kernels (both 4.1.0-rc5 and 3.19.8) were not handling the
>>>> libc syscall with invalid sysno in the manner described by
>>>> http://www.gnu.org/software/libc/manual/html_node/System-Calls.html.
>>>> Rather than returning -1 and setting errno to ENOSYS the invalid
>>>> syscall gives segfault and a kernel oops.
>>>
>>> Looking at this, it seems that we're triggering this:
>>>
>>>         BUG_ON(context->in_syscall || context->name_count);
>>>
>>> which seems to imply that we've called audit_syscall_entry() twice
>>> without a call to audit_syscall_exit().  That is something we can
>>> fix - and something which only happens with the syscall of "-1"
>>> (which is our "syscall was cancelled" value.)
>>
>> Hi Russell,
>>
>> The patch below does eliminate the kernel oops for -1, but it breaks things for other invalid/unimplemented syscalls.  For the attached test, invalid_syscall_plus.c:
>>
>>
>> $ gcc -g -o invalid_syscall_plus invalid_syscall_plus.c
>> $ ./invalid_syscall_plus 
>> Illegal instruction (core dumped)
>>
>> Previously this would print out the expected messages.
> 
> The patch /doesn't/ change that behaviour at all.

You are correct. I was looking at previous results on the wrong machine/architecture.  Sorry.


> 
>>> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
>>> index f8ccc21fa032..2c40c1214a72 100644
>>> --- a/arch/arm/kernel/entry-common.S
>>> +++ b/arch/arm/kernel/entry-common.S
>>> @@ -241,11 +241,11 @@ __sys_trace:
>>>  	cmp	scno, #-1			@ skip the syscall?
> 
> If the system call number was not -1 (in your case it isn't, it's 0xdeadbeef)
> 
>>>  	bne	2b
> 
> Branch to the "2" label backwards, otherwise execute this code:
> 
>>>  	add	sp, sp, #S_OFF			@ restore stack
>>> -	b	ret_slow_syscall
>>> +	b	3f
>>>  
>>>  __sys_trace_return:
>>>  	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
>>> -	mov	r0, sp
>>> +3:	mov	r0, sp
>>>  	bl	syscall_trace_exit
>>>  	b	ret_slow_syscall
> 
> The code at the referenced local "2" is:
> 
> 2:      cmp     scno, #(__ARM_NR_BASE - __NR_SYSCALL_BASE)
>         eor     r0, scno, #__NR_SYSCALL_BASE    @ put OS number back
>         bcs     arm_syscall
>         mov     why, #0                         @ no longer a real syscall
>         b       sys_ni_syscall                  @ not private func
> 
> __NR_SYSCALL_BASE will be zero for your kernel.
> 
> What this says is that if the system call number is greater than
> __ARM_NR_BASE, then branch to arm_syscall(), otherwise call
> sys_ni_syscall().
>
> sys_ni_syscall() will return the -1 / ENOSYS you're expecting.
> 
> However, __ARM_NR_BASE is:
> 
> #define __ARM_NR_BASE                   (__NR_SYSCALL_BASE+0x0f0000)
> 
> which, I fully described in my previous email.
> 
> arm_syscall() intentionally gives a SIGILL for cases it doesn't handle.
> 
> Your case you are now reporting is behaviour that it's always had going
> back more than 15 years, and is most definitely a WONTFIX.  Sorry.
> 

0xdeadbeef is a negative number, so arm_syscall will be called rather than sys_ni_syscall.  What it looks like is that the systemtap testsuite should be using some large (but not too large) positive number such as 0xffff to get the desired unimplemented syscall

-Will
