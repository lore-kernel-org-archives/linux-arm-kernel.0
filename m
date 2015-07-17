From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 17 Jul 2015 10:41:44 -0400
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <77EA0F10-D5F6-48BD-8652-3B979A978659@gmail.com>
References: <55A646EE.6030402@linaro.org>
 <20150715105536.42949ea9@gandalf.local.home>
 <20150715121337.3b31aa84@gandalf.local.home>
 <55A6FA82.9000901@linaro.org> <55A703F3.8050203@linaro.org>
 <A601CC3C-4B09-4D8B-8564-558349D45815@gmail.com>
 <20150716102405.2cc8c406@gandalf.local.home>
 <12F47692-3010-4886-B87D-3D7820609177@gmail.com>
 <20150716113115.45a17f17@gandalf.local.home>
 <20150716121658.7982fdf5@gandalf.local.home>
 <20150717124054.GE26091@leverpostej>
 <20150717090009.720f6bd0@gandalf.local.home>
 <77EA0F10-D5F6-48BD-8652-3B979A978659@gmail.com>
Message-ID: <20150717104144.6588b2f7@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Jul 2015 23:28:13 +0900
Jungseok Lee <jungseoklee85@gmail.com> wrote:


> 
> I have reviewed and tested the kernel including this patch and only [RFC 1/3].

Thanks! Can you repost patch 1 with the changes I recommended, so that
I can get an Acked-by from the arm64 maintainers and pull all the
changes in together. This is fine for a 4.3 release, right? That is, it
doesn't need to go into 4.2-rcs.

> 
> Now, the number of entries and max_stack_size are always okay, but unexpected functions,
> such as ftrace_ops_no_ops and ftrace_call, are *sometimes* listed as follows.
> 
> $ cat /sys/kernel/debug/tracing/stack_trace 
> 
>         Depth    Size   Location    (49 entries)
>         -----    ----   --------
>   0)     4456      16   arch_counter_read+0xc/0x24
>   1)     4440      16   ktime_get+0x44/0xb4
>   2)     4424      48   get_drm_timestamp+0x30/0x40
>   3)     4376      16   drm_get_last_vbltimestamp+0x94/0xb4
>   4)     4360      80   drm_handle_vblank+0x84/0x3c0
>   5)     4280     144   mdp5_irq+0x118/0x130
>   6)     4136      80   msm_irq+0x2c/0x68
>   7)     4056      32   handle_irq_event_percpu+0x60/0x210
>   8)     4024      96   handle_irq_event+0x50/0x80
>   9)     3928      64   handle_fasteoi_irq+0xb0/0x178
>  10)     3864      48   generic_handle_irq+0x38/0x54
>  11)     3816      32   __handle_domain_irq+0x68/0xbc
>  12)     3784      64   gic_handle_irq+0x38/0x88
>  13)     3720     280   el1_irq+0x64/0xd8
>  14)     3440     168   ftrace_ops_no_ops+0xb4/0x16c
>  15)     3272      64   ftrace_call+0x0/0x4
>  16)     3208      16   _raw_spin_lock_irqsave+0x14/0x70
>  17)     3192      32   msm_gpio_set+0x44/0xb4
>  18)     3160      48   _gpiod_set_raw_value+0x68/0x148
>  19)     3112      64   gpiod_set_value+0x40/0x70
>  20)     3048      32   gpio_led_set+0x3c/0x94
>  21)     3016      48   led_set_brightness+0x50/0xa4
>  22)     2968      32   led_trigger_event+0x4c/0x78
>  23)     2936      48   mmc_request_done+0x38/0x84
>  24)     2888      32   sdhci_tasklet_finish+0xcc/0x12c
>  25)     2856      48   tasklet_action+0x64/0x120
>  26)     2808      48   __do_softirq+0x114/0x2f0
>  27)     2760     128   irq_exit+0x98/0xd8
>  28)     2632      32   __handle_domain_irq+0x6c/0xbc
>  29)     2600      64   gic_handle_irq+0x38/0x88
>  30)     2536     280   el1_irq+0x64/0xd8
>  31)     2256     168   ftrace_ops_no_ops+0xb4/0x16c
>  32)     2088      64   ftrace_call+0x0/0x4

Like I stated before, the above looks to be an interrupt coming in
while the tracing was happening. This looks legitimate to me. I'm
guessing that arm64 uses one stack for normal context and interrupt
context, where as x86 uses a separate stack for interrupt context.

-- Steve


>  33)     2024      16   __schedule+0x1c/0x748
>  34)     2008      80   schedule+0x38/0x94
>  35)     1928      32   schedule_timeout+0x1a8/0x200
>  36)     1896     128   wait_for_common+0xa8/0x150
>  37)     1768     128   wait_for_completion+0x24/0x34
>  38)     1640      32   mmc_wait_for_req_done+0x3c/0x104
>  39)     1608      64   mmc_wait_for_cmd+0x68/0x94
>  40)     1544     128   get_card_status.isra.25+0x6c/0x88
>  41)     1416     112   card_busy_detect.isra.31+0x7c/0x154
>  42)     1304     128   mmc_blk_err_check+0xd0/0x4f8
>  43)     1176     192   mmc_start_req+0xe4/0x3a8
>  44)      984     160   mmc_blk_issue_rw_rq+0xc4/0x9c0
>  45)      824     176   mmc_blk_issue_rq+0x19c/0x450
>  46)      648     112   mmc_queue_thread+0x134/0x17c
>  47)      536      80   kthread+0xe0/0xf8
>  48)      456     456   ret_from_fork+0xc/0x50
> 
> $ cat /sys/kernel/debug/tracing/stack_max_size
> 4456
> 
> This issue might be related to arch code, not this change.
> IMHO, this patch look settled now.
> 
> Best Regards
> Jungseok Lee
