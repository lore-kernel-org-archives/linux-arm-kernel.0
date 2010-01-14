From: jason.wessel@windriver.com (Jason Wessel)
Date: Thu, 14 Jan 2010 14:29:54 -0600
Subject: [PATCH 20/40] arm,
	kgdb: Add hook to catch an oops with debugger
In-Reply-To: <20100114174821.GB21385@n2100.arm.linux.org.uk>
References: <1263481176-1897-1-git-send-email-jason.wessel@windriver.com><1263481176-1897-21-git-send-email-jason.wessel@windriver.com>
	<20100114174821.GB21385@n2100.arm.linux.org.uk>
Message-ID: <4B4F7EC2.6030000@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> I have a similar patch which implements the hook properly - but
> with one caveat.  It needs a review to ensure that its safe to return
> from die().  Until that's established, this patch can not be merged.
> 

I completed the analysis on your patch and yes, it is safe to return
from __die() and die() the way you currently structured it, but it
doesn't work quite the same as on some other architectures.

After changing kgdb.c to register with the die notifier, I stepped
through your code with an ICE, as well as running my regression tests
which panic, oops, bad access etc...

While kernel execution does happen to continue to work, I don't know
that you really want to continue execution.

1) The kernel is marked tainted
2) bust_spinlocks() was toggled for a while

On x86 for example, the notifier is invoked prior to the
bust_spinlocks() etc... and then it can pass the exception along to
the rest of the system (which can result in something bad, but
remember the human behind the kernel debugger controls did it for some
reason or another).

I made the following addition to your patch, and then it behaved as
the other archs do with respect to passing along the result of the
exception.  Given this information, would you be willing to merge your
patch and possibly fold in the change below, or further comment?

Thanks,
Jason.

--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -273,6 +273,9 @@ void die(const char *str, struct pt_regs
 	bust_spinlocks(1);
 	ret = __die(str, err, thread, regs);
 
+	if (ret == NOTIFY_STOP)
+		return;
+
 	if (regs && kexec_should_crash(thread->task))
 		crash_kexec(regs);
 
@@ -285,8 +288,7 @@ void die(const char *str, struct pt_regs
 		panic("Fatal exception in interrupt");
 	if (panic_on_oops)
 		panic("Fatal exception");
-	if (ret != NOTIFY_STOP)
-		do_exit(SIGSEGV);
+	do_exit(SIGSEGV);
 }
 
 void arm_notify_die(const char *str, struct pt_regs *regs,
