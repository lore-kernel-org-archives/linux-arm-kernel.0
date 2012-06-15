From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 15 Jun 2012 12:56:41 +0100
Subject: ARM syscall restarting with TIF_SYSCALL_RESTARTSYS
Message-ID: <20120615115641.GA11507@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

With the recent changes the syscall restarting on ARM is done via the
TIF_SYSCALL_RESTARTSYS flag which causes the override of the syscall
number in syscall_trace(). I think there is a scenario where this could
fail:

1. app does a syscall
2. syscall interrupted and returns -ERESTART_RESTARTBLOCK. There is no
   signal to deliver
3. do_signal() sets TIF_SYSCALL_RESTARTSYS and ARM_pc to restart_addr
4. Linux returns to the SVC instruction (restart_addr) in user space
   but, before SVC is re-executed, it gets an interrupt
5. When returning from interrupt, a signal is to be delivered.
   do_signal() does not clear TIF_SYSCALL_RESTARTSYS since it is
   returning from interrupt
6. Signal handler calls sigreturn() but the syscall number gets
   overridden by syscall_trace() since TIF_SYSCALL_RESTARTSYS is set

The solution I see is to do the restarting within the kernel without
returning to user and risk getting another signal (I think Russell
mentioned this in the past).

Are my assumptions above correct or did I miss anything?

Thanks.

-- 
Catalin
