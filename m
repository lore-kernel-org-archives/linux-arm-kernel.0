From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Thu, 25 Apr 2013 16:39:38 +0200
Subject: [PATCH] ARM: add unwind annotations to ftrace asm
In-Reply-To: <1364076649-16841-1-git-send-email-rabin@rab.in>
References: <1364076649-16841-1-git-send-email-rabin@rab.in>
Message-ID: <1366900778.4158.124.camel@coredoba.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-03-23 at 23:10 +0100, Rabin Vincent wrote:
> Add unwind annotations to the ftrace assembly code so that the function
> tracer's stacktracing options (func_stack_trace, etc.) work when
> CONFIG_ARM_UNWIND is enabled.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>

In my test this fixes func_stack_trace:

== without patch ==
# tracer: function
#
# entries-in-buffer/entries-written: 318/318   #P:1
#
#                              _-------=> irqs-off          
#                            /  _------=> need-resched      
#                            |/  _-----=> need-resched_lazy 
#                            ||/  _----=> hardirq/softirq   
#                            |||/  _---=> preempt-depth     
#                            ||||/  _--=> preempt-lazy-depth
#                            ||||| / _-=> migrate-disable   
#                            |||||| /     delay
#           TASK-PID   CPU#  |||||||    TIMESTAMP  FUNCTION
#              | |       |   |||||||       |         |
              sh-829   [000] d..h1..   838.966903: ktime_get <-tick_sched_timer
              sh-829   [000] d..h1..   838.966933: <stack trace>
 => ftrace_ops_no_ops
 => ftrace_graph_call
              sh-829   [000] d..h1..   838.966979: ktime_get <-clockevents_program_event
              sh-829   [000] d..h1..   838.966990: <stack trace>

== with patch ==
# tracer: function
#
# entries-in-buffer/entries-written: 678/678   #P:1
#
#                              _-------=> irqs-off          
#                            /  _------=> need-resched      
#                            |/  _-----=> need-resched_lazy 
#                            ||/  _----=> hardirq/softirq   
#                            |||/  _---=> preempt-depth     
#                            ||||/  _--=> preempt-lazy-depth
#                            ||||| / _-=> migrate-disable   
#                            |||||| /     delay
#           TASK-PID   CPU#  |||||||    TIMESTAMP  FUNCTION
#              | |       |   |||||||       |         |
              sh-828   [000] d..h2..   108.367156: ktime_get <-tick_sched_timer
              sh-828   [000] d..h2..   108.367224: <stack trace>
 => ftrace_ops_no_ops
 => ftrace_graph_call
 => ktime_get
 => tick_sched_timer
 => __run_hrtimer
 => hrtimer_interrupt
 => omap2_gp_timer_interrupt
 => handle_irq_event_percpu
 => handle_irq_event
 => handle_level_irq
 => generic_handle_irq
 => handle_IRQ
 => omap3_intc_handle_irq
 => __irq_svc
 => sub_preempt_count
 => cap_vm_enough_memory
 => security_vm_enough_memory_mm
 => mmap_region
 => do_mmap_pgoff
 => vm_mmap_pgoff
 => sys_mmap_pgoff
 => ret_fast_syscall

Thanks for this fix!

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
