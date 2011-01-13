From: rabin@rab.in (Rabin Vincent)
Date: Fri, 14 Jan 2011 00:24:19 +0530
Subject: SMP: BUG() on cat /proc/$PID/stack
Message-ID: <AANLkTinSNPC7+m1Uie5hbUW_hgPecAK=RRGKkMx2AqOm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On SMP, this BUG() in save_stack_trace_tsk() can be easily triggered
from user space by reading /proc/$PID/stack, where $PID is any pid but
the current process:

        if (tsk != current) {
#ifdef CONFIG_SMP
                /*
                 * What guarantees do we have here that 'tsk'
                 * is not running on another CPU?
                 */
                BUG();
#else

x86 appears to go ahead in this case, but has its stack walking code
check at every step that the stack pointer it's reading from is valid --
is this what is needed in the ARM unwind code to get rid of this BUG()?

Also, get_wchan() does similar stack walking but there it just checks
for task->state != TASK_RUNNING before.  Is that a sufficient check
there?
