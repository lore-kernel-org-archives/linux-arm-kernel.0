From: wangnan0@huawei.com (Wangnan (F))
Date: Mon, 21 Dec 2015 20:56:03 +0800
Subject: [BUG REPORT]: ARM64: perf: System hung in perf test
Message-ID: <5677F6E3.9050902@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

System hung can be reproduced on qemu and real hardware using:

  # perf test -v signal

If qemu is started with '-smp 1', system hung. In real hardware and in
qemu with smp > 1, the result is:

  # /perf test -v signal
  17: Test breakpoint overflow signal handler                  :
  --- start ---
  test child forked, pid 792
  count1 11, count2 11, overflow 11
  failed: RF EFLAG recursion issue detected
  failed: wrong overflow hit
  failed: wrong count for bp2
  test child finished with -1
  ---- end ----
  Test breakpoint overflow signal handler: FAILED!

Looks like something like [1] is required for ARM64.

Some analysis is done with qemu:

This testcase tests the intertaction between breakpoint, perf_event
and signal handling. It installs a breakpoint at the enter of a
function and makes the corresponding perf_event generate SIGIO when
the event raise.

When perf_event on a async perf_event is triggered:

         if (*perf_event_fasync(event) && event->pending_kill) {
                 event->pending_wakeup = 1;
                 irq_work_queue(&event->pending);
         }

it calls irq_work_queue(&event->pending), which is used to fire a
poll event and SIGIO. Later when perf_event is closed, in _free_event
irq_work_sync(&event->pending) is called to ensure all irq_work is done.
On ARM64, if we have only 1 cpu, the system hung at irq_work_sync().

Using gdb attached, I see:
  1. IRQ is not disabled. Inside irq_work_sync, result of 
arch_local_save_flags()
     is 0x140.

  2. hrtimer_interrupt() is still generated. The system is not dead.

  3. In irq_work_tick, we have a chance to process irq_work. However,
     llist_empty(raised) is false but arch_irq_work_has_interrupt()
     is true, so kernel only process lazy_list.

  4. handle_IPI() is never called, so I guess the IPI is disabled by 
breakpoint
     and not restored in this case.

[1] 
http://lkml.kernel.org/r/1362940871-24486-1-git-send-email-jolsa at redhat.com
