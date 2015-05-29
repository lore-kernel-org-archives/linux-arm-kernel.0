From: wcohen@redhat.com (William Cohen)
Date: Fri, 29 May 2015 11:50:15 -0400
Subject: Kernel oops on 32-bit arm with syscall with invalid sysno
In-Reply-To: <20150528214256.GF2067@n2100.arm.linux.org.uk>
References: <55677D6A.1060008@redhat.com>
 <20150528214256.GF2067@n2100.arm.linux.org.uk>
Message-ID: <55688AB7.7000101@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2015 05:42 PM, Russell King - ARM Linux wrote:
> On Thu, May 28, 2015 at 04:41:14PM -0400, William Cohen wrote:
>> When reviewing testsuite failures for systemtap I found that the
>> 32-bit arm kernels (both 4.1.0-rc5 and 3.19.8) were not handling the
>> libc syscall with invalid sysno in the manner described by
>> http://www.gnu.org/software/libc/manual/html_node/System-Calls.html.
>> Rather than returning -1 and setting errno to ENOSYS the invalid
>> syscall gives segfault and a kernel oops.
> 
> Looking at this, it seems that we're triggering this:
> 
>         BUG_ON(context->in_syscall || context->name_count);
> 
> which seems to imply that we've called audit_syscall_entry() twice
> without a call to audit_syscall_exit().  That is something we can
> fix - and something which only happens with the syscall of "-1"
> (which is our "syscall was cancelled" value.)

Hi Russell,

The patch below does eliminate the kernel oops for -1, but it breaks things for other invalid/unimplemented syscalls.  For the attached test, invalid_syscall_plus.c:


$ gcc -g -o invalid_syscall_plus invalid_syscall_plus.c
$ ./invalid_syscall_plus 
Illegal instruction (core dumped)

Previously this would print out the expected messages.

-Will
> 
> If I have diagnosed this correctly, the following patch should fix
> it.  However, as you're asking for the "cancelled" syscall value,
> what you'll get returned from the syscall is the r0 value preserved
> as the result of the syscall.  In other words, you won't get -1 and
> errno set to ENOSYS.  Not much can be done about that without breaking
> syscall cancelling, so expect your test case to continue failing.
> 
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index f8ccc21fa032..2c40c1214a72 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -241,11 +241,11 @@ __sys_trace:
>  	cmp	scno, #-1			@ skip the syscall?
>  	bne	2b
>  	add	sp, sp, #S_OFF			@ restore stack
> -	b	ret_slow_syscall
> +	b	3f
>  
>  __sys_trace_return:
>  	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
> -	mov	r0, sp
> +3:	mov	r0, sp
>  	bl	syscall_trace_exit
>  	b	ret_slow_syscall
>  
> 
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: invalid_syscall_plus.c
Type: text/x-csrc
Size: 586 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150529/c835618a/attachment.bin>
