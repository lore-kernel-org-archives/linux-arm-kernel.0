From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Fri, 18 Sep 2015 21:57:56 +0900
Subject: [PATCH v2] arm64: Introduce IRQ stack
In-Reply-To: <20150917162110.GO25444@e104818-lin.cambridge.arm.com>
References: <1442155337-7020-1-git-send-email-jungseoklee85@gmail.com>
 <20150917111735.GN25444@e104818-lin.cambridge.arm.com>
 <3C2C78B3-4669-4DBA-98DC-362EB762FD9C@gmail.com>
 <CFF333D1-E771-4C50-902A-444DAE76C163@gmail.com>
 <20150917162110.GO25444@e104818-lin.cambridge.arm.com>
Message-ID: <6A6F7BF2-D75E-4D8D-B0F7-45294C4C4426@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sep 18, 2015, at 1:21 AM, Catalin Marinas wrote:
> On Thu, Sep 17, 2015 at 10:22:26PM +0900, Jungseok Lee wrote:
>> On Sep 17, 2015, at 10:17 PM, Jungseok Lee wrote:
>>> On Sep 17, 2015, at 8:17 PM, Catalin Marinas wrote:
>>>> On Sun, Sep 13, 2015 at 02:42:17PM +0000, Jungseok Lee wrote:
>>>>> Currently, kernel context and interrupts are handled using a single
>>>>> kernel stack navigated by sp_el1. This forces many systems to use
>>>>> 16KB stack, not 8KB one. Low memory platforms naturally suffer from
>>>>> memory pressure accompanied by performance degradation.
>>>>> 
>>>>> This patch addresses the issue as introducing a separate percpu IRQ
>>>>> stack to handle both hard and soft interrupts with two ground rules:
>>>>> 
>>>>> - Utilize sp_el0 in EL1 context, which is not used currently
>>>>> - Do not complicate current_thread_info calculation
>>>>> 
>>>>> It is a core concept to trace struct thread_info using sp_el0 instead
>>>>> of sp_el1. This approach helps arm64 align with other architectures
>>>>> regarding object_is_on_stack() without additional complexity.
>>>> 
>>>> I'm still trying to understand how this patch works. I initially thought
>>>> that we would set SPSel = 0 while in kernel thread mode to make use of
>>>> SP_EL0 but I can't find any such code. Do you still use SP_EL1 all the
>>>> time and SP_EL0 just for temporary saving the thread stack?
>>> 
>>> Exactly.
>>> 
>>> My first approach was to set SPSel = 0 and implement EL1t Sync and IRQ.
>>> This idea originally comes from your comment [1]. A kernel thread could
>>> be handled easily and neatly, but it complicated current_thread_info
>>> calculation due to a user process.
>>> 
>>> Let's assume that a kernel thread uses SP_EL0 by default. When an interrupt
>>> comes in, a core jumps to EL1t IRQ. In case of a user process, a CPU goes
>>> into EL1h IRQ when an interrupt raises. To handle this scenario correctly,
>>> SPSel or spsr_el1 should be referenced. This reaches to quite big overhead
>>> in current_thread_info function.
>> 
>> This statement is described incorrectly. In case of user process, a CPU goes
>> into EL0 IRQ. Under this context, another interrupt could come in. At this
>> time, a core jumps to EL1h IRQ.
> 
> I don't I entirely follow you here.

My description was not clear enough. It's my fault.

> First of all, we don't allow re-entrant IRQs, they are disabled during
> handling (there are patches for NMI via IRQ priorities but these would
> be a special case on a different code path; for the current code, let's
> just assume that IRQs are not re-entrant).
> 
> Second, SPSel is automatically set to 1 when taking an exception. So we
> are guaranteed that the kernel entry code always switches to SP_EL1
> (EL1h mode).
> 
> My initial thought was to populate SP_EL1 per CPU as a handler stack and
> never change it afterwards. The entry code may continue to use SP_EL1 if
> in interrupt or switch to SP_EL0 and SPSel = 0 if in thread context.
> What I didn't realise is that SP_EL0 cannot be accessed directly when
> SPSel == 0, only as SP. This indeed complicates current_thread_info
> slightly.
> 
> I did some tests with using SPSel in current_thread_info() to read SP or
> SP_EL0 and it doesn't look good, it increased the .text section by 132KB
> (I may have been able to optimise it a bit but it is still quite large).
> With your approach to always use sp_el0, I get about 4KB larger .text
> section.
> 
> So, without any better suggestion for current_thread_info(), I'm giving
> up the idea of using SPSel == 0 in the kernel. I'll look at your patch
> in more detail. BTW, I don't think we need the any count for the irq
> stack as we don't re-enter the same IRQ stack.

Another interrupt could come in since IRQ is enabled when handling softirq
according to the following information which are self-evident.

(Am I missing something?)

1) kernel/softirq.c

asmlinkage __visible void __do_softirq(void)
{
        unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
        unsigned long old_flags = current->flags;
        int max_restart = MAX_SOFTIRQ_RESTART;
        struct softirq_action *h;
        bool in_hardirq;
        __u32 pending;
        int softirq_bit;

        /*  
         * Mask out PF_MEMALLOC s current task context is borrowed for the
         * softirq. A softirq handled such as network RX might set PF_MEMALLOC
         * again if the socket is related to swap
         */
        current->flags &= ~PF_MEMALLOC;

        pending = local_softirq_pending();
        account_irq_enter_time(current);

        __local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
        in_hardirq = lockdep_softirq_start();

restart:
        /* Reset the pending bitmask before enabling irqs */
        set_softirq_pending(0);

        local_irq_enable();

2) Stack tracer on ftrace

        Depth    Size   Location    (49 entries)
        -----    ----   --------
  0)     4456      16   arch_counter_read+0xc/0x24
  1)     4440      16   ktime_get+0x44/0xb4
  2)     4424      48   get_drm_timestamp+0x30/0x40
  3)     4376      16   drm_get_last_vbltimestamp+0x94/0xb4
  4)     4360      80   drm_handle_vblank+0x84/0x3c0
  5)     4280     144   mdp5_irq+0x118/0x130
  6)     4136      80   msm_irq+0x2c/0x68
  7)     4056      32   handle_irq_event_percpu+0x60/0x210
  8)     4024      96   handle_irq_event+0x50/0x80
  9)     3928      64   handle_fasteoi_irq+0xb0/0x178
 10)     3864      48   generic_handle_irq+0x38/0x54
 11)     3816      32   __handle_domain_irq+0x68/0xbc
 12)     3784      64   gic_handle_irq+0x38/0x88
 13)     3720     280   el1_irq+0x64/0xd8
 14)     3440     168   ftrace_ops_no_ops+0xb4/0x16c
 15)     3272      64   ftrace_call+0x0/0x4
 16)     3208      16   _raw_spin_lock_irqsave+0x14/0x70
 17)     3192      32   msm_gpio_set+0x44/0xb4
 18)     3160      48   _gpiod_set_raw_value+0x68/0x148
 19)     3112      64   gpiod_set_value+0x40/0x70
 20)     3048      32   gpio_led_set+0x3c/0x94
 21)     3016      48   led_set_brightness+0x50/0xa4
 22)     2968      32   led_trigger_event+0x4c/0x78
 23)     2936      48   mmc_request_done+0x38/0x84
 24)     2888      32   sdhci_tasklet_finish+0xcc/0x12c
 25)     2856      48   tasklet_action+0x64/0x120
 26)     2808      48   __do_softirq+0x114/0x2f0
 27)     2760     128   irq_exit+0x98/0xd8
 28)     2632      32   __handle_domain_irq+0x6c/0xbc
 29)     2600      64   gic_handle_irq+0x38/0x88
 30)     2536     280   el1_irq+0x64/0xd8
 31)     2256     168   ftrace_ops_no_ops+0xb4/0x16c
 32)     2088      64   ftrace_call+0x0/0x4
 33)     2024      16   __schedule+0x1c/0x748
 34)     2008      80   schedule+0x38/0x94
 35)     1928      32   schedule_timeout+0x1a8/0x200
 36)     1896     128   wait_for_common+0xa8/0x150
 37)     1768     128   wait_for_completion+0x24/0x34
 38)     1640      32   mmc_wait_for_req_done+0x3c/0x104
 39)     1608      64   mmc_wait_for_cmd+0x68/0x94
 40)     1544     128   get_card_status.isra.25+0x6c/0x88
 41)     1416     112   card_busy_detect.isra.31+0x7c/0x154
 42)     1304     128   mmc_blk_err_check+0xd0/0x4f8
 43)     1176     192   mmc_start_req+0xe4/0x3a8
 44)      984     160   mmc_blk_issue_rw_rq+0xc4/0x9c0
 45)      824     176   mmc_blk_issue_rq+0x19c/0x450
 46)      648     112   mmc_queue_thread+0x134/0x17c
 47)      536      80   kthread+0xe0/0xf8
 48)      456     456   ret_from_fork+0xc/0x50

In my first approach using SPSel = 0, current_thread_info function was inefficient
in order to handle this case correctly.

BTW, in this context, it is only meaningful to decide whether a current interrupt
is re-enterrant or not. Its actual value is not important, but I could not figure
out a better implementation than this one yet. Any suggestions are welcome!

Best Regards
Jungseok Lee
