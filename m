From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 May 2015 22:42:56 +0100
Subject: Kernel oops on 32-bit arm with syscall with invalid sysno
In-Reply-To: <55677D6A.1060008@redhat.com>
References: <55677D6A.1060008@redhat.com>
Message-ID: <20150528214256.GF2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 04:41:14PM -0400, William Cohen wrote:
> When reviewing testsuite failures for systemtap I found that the
> 32-bit arm kernels (both 4.1.0-rc5 and 3.19.8) were not handling the
> libc syscall with invalid sysno in the manner described by
> http://www.gnu.org/software/libc/manual/html_node/System-Calls.html.
> Rather than returning -1 and setting errno to ENOSYS the invalid
> syscall gives segfault and a kernel oops.

Looking at this, it seems that we're triggering this:

        BUG_ON(context->in_syscall || context->name_count);

which seems to imply that we've called audit_syscall_entry() twice
without a call to audit_syscall_exit().  That is something we can
fix - and something which only happens with the syscall of "-1"
(which is our "syscall was cancelled" value.)

If I have diagnosed this correctly, the following patch should fix
it.  However, as you're asking for the "cancelled" syscall value,
what you'll get returned from the syscall is the r0 value preserved
as the result of the syscall.  In other words, you won't get -1 and
errno set to ENOSYS.  Not much can be done about that without breaking
syscall cancelling, so expect your test case to continue failing.

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index f8ccc21fa032..2c40c1214a72 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -241,11 +241,11 @@ __sys_trace:
 	cmp	scno, #-1			@ skip the syscall?
 	bne	2b
 	add	sp, sp, #S_OFF			@ restore stack
-	b	ret_slow_syscall
+	b	3f
 
 __sys_trace_return:
 	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
-	mov	r0, sp
+3:	mov	r0, sp
 	bl	syscall_trace_exit
 	b	ret_slow_syscall
 


-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
