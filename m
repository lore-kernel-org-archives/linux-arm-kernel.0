From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 23 Feb 2016 11:45:28 +0800
Subject: [PATCH V3 0/5] clk: support clocks which requires parent clock on
 during operation
In-Reply-To: <CAOMZO5ATOkkw3wCaBeyr7NaVPekuyPNkhDu3c1G3Wv=VtcydjA@mail.gmail.com>
References: <1438089585-30103-1-git-send-email-aisheng.dong@freescale.com>
 <20150728143824.GB16916@shlinux1.ap.freescale.net>
 <20150804094556.GE24870@shlinux1.ap.freescale.net>
 <20150813101702.GB19166@shlinux1.ap.freescale.net>
 <CAOMZO5ATOkkw3wCaBeyr7NaVPekuyPNkhDu3c1G3Wv=VtcydjA@mail.gmail.com>
Message-ID: <CAA+hA=QLEk6mwciX4nLfmAMYahtenoL9+zR_YJ4veSkh-3uLEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 10:55 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Mike,
>
> On Thu, Aug 13, 2015 at 7:17 AM, Dong Aisheng
> <aisheng.dong@freescale.com> wrote:
>
>> Hi Mike,
>>
>> It's been quite a long time.
>> Can you help pick this?
>
> Yes, we are still getting lots of clock warnings in mx7d in mainline
> without Dong's series:
>

Hi Mike & Stephen,

It's been pending a long time.

What's your fix plan?
Can we merge this patch series first?
I believe there're also other platforms need this fix too.

Regards
Dong Aisheng


> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:3382
> lock_release+0x2f8/0x334()
> [    0.000000] releasing a pinned lock
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 4.5.0-rc5-next-20160222 #256
> [    0.000000] Hardware name: Freescale i.MX7 Dual (Device Tree)
> [    0.000000] Backtrace:
> [    0.000000] [<c010b6f4>] (dump_backtrace) from [<c010b890>]
> (show_stack+0x18/0x1c)
> [    0.000000]  r6:600000d3 r5:ffffffff r4:00000000 r3:00000000
> [    0.000000] [<c010b878>] (show_stack) from [<c03dae8c>]
> (dump_stack+0xb0/0xe8)
> [    0.000000] [<c03daddc>] (dump_stack) from [<c012461c>]
> (warn_slowpath_common+0x80/0xbc)
> [    0.000000]  r8:c0ad86ec r7:00000009 r6:00000d36 r5:c0169e5c
> r4:c0d01ba0 r3:c0d064c0
> [    0.000000] [<c012459c>] (warn_slowpath_common) from [<c01246fc>]
> (warn_slowpath_fmt+0x38/0x40)
> [    0.000000]  r8:c0d06980 r7:00000002 r6:00000001 r5:c0d064c0 r4:ef7c2290
> [    0.000000] [<c01246c8>] (warn_slowpath_fmt) from [<c0169e5c>]
> (lock_release+0x2f8/0x334)
> [    0.000000]  r3:00000026 r2:c0ad9698
> [    0.000000] [<c0169b64>] (lock_release) from [<c08e31f8>]
> (_raw_spin_unlock_irq+0x20/0x34)
> [    0.000000]  r10:c0c75280 r9:ef7c2280 r8:00000000 r7:c0d02b10
> r6:00000001 r5:ef7c2280
> [    0.000000]  r4:ef7c2280
> [    0.000000] [<c08e31d8>] (_raw_spin_unlock_irq) from [<c015219c>]
> (dequeue_task_idle+0x14/0x30)
> [    0.000000]  r4:ef7c2280 r3:c0152188
> [    0.000000] [<c0152188>] (dequeue_task_idle) from [<c0149a50>]
> (deactivate_task+0x64/0x68)
> [    0.000000]  r4:c0d064c0 r3:c0152188
> [    0.000000] [<c01499ec>] (deactivate_task) from [<c08ddd68>]
> (__schedule+0x2cc/0x6d8)
> [    0.000000]  r6:c0d06804 r5:ef7c2290 r4:c0d064c0 r3:00000002
> [    0.000000] [<c08dda9c>] (__schedule) from [<c08de29c>] (schedule+0x3c/0xa0)
> [    0.000000]  r10:c0d064c0 r9:c1560db8 r8:00000001 r7:00000000
> r6:0006ddd0 r5:00000000
> [    0.000000]  r4:0007a120
> [    0.000000] [<c08de260>] (schedule) from [<c08e28b0>]
> (schedule_hrtimeout_range_clock+0xd4/0x13c)
> [    0.000000] [<c08e27dc>] (schedule_hrtimeout_range_clock) from
> [<c08e293c>] (schedule_hrtimeout_range+0x24/0x2c)
> [    0.000000]  r10:000006d8 r8:000000d8 r7:00000003 r6:ffff8ad1
> r5:c0d02100 r4:ef00c040
> [    0.000000] [<c08e2918>] (schedule_hrtimeout_range) from
> [<c08e2360>] (usleep_range+0x54/0x5c)
> [    0.000000] [<c08e230c>] (usleep_range) from [<c068b83c>]
> (clk_pllv3_wait_lock+0x7c/0xb4)
> [    0.000000] [<c068b7c0>] (clk_pllv3_wait_lock) from [<c068ba4c>]
> (clk_pllv3_prepare+0x2c/0x30)
> [    0.000000]  r6:c0d5c7f4 r5:00000000 r4:ef007680 r3:f08400f0
> [    0.000000] [<c068ba20>] (clk_pllv3_prepare) from [<c0685e08>]
> (clk_core_prepare+0xa0/0xcc)
> [    0.000000] [<c0685d68>] (clk_core_prepare) from [<c0685e54>]
> (clk_prepare+0x20/0x30)
> [    0.000000]  r5:00000000 r4:ef00c100
> [    0.000000] [<c0685e34>] (clk_prepare) from [<c0c4a700>]
> (imx7d_clocks_init+0x6114/0x6198)
> [    0.000000]  r4:ef00c100 r3:c0d064c0
> [    0.000000] [<c0c445ec>] (imx7d_clocks_init) from [<c0c30c08>]
> (of_clk_init+0x138/0x1e8)
> [    0.000000]  r10:c0d01f70 r9:00000001 r8:c0d01f68 r7:00000000
> r6:ef004340 r5:ef7e3d60
> [    0.000000]  r4:00000003
> [    0.000000] [<c0c30ad0>] (of_clk_init) from [<c0c049f0>]
> (time_init+0x2c/0x38)
> [    0.000000]  r10:00000001 r9:410fc075 r8:efffcb80 r7:c0c5ca48
> r6:c0d76000 r5:ffffffff
> [    0.000000]  r4:00000000
> [    0.000000] [<c0c049c4>] (time_init) from [<c0c00bcc>]
> (start_kernel+0x26c/0x400)
> [    0.000000] [<c0c00960>] (start_kernel) from [<8000807c>] (0x8000807c)
> [    0.000000]  r10:00000000 r8:8000406a r7:c0d07e4c r6:c0c5ca44
> r5:c0d0296c r4:c0d76294
> [    0.000000] ---[ end trace cb88537fdc8fa200 ]---
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:2576
> trace_hardirqs_on_caller+0x1ac/0x1f0()
> [    0.000000] DEBUG_LOCKS_WARN_ON(unlikely(early_boot_irqs_disabled))
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
> 4.5.0-rc5-next-20160222 #256
> [    0.000000] Hardware name: Freescale i.MX7 Dual (Device Tree)
> [    0.000000] Backtrace:
> [    0.000000] [<c010b6f4>] (dump_backtrace) from [<c010b890>]
> (show_stack+0x18/0x1c)
> [    0.000000]  r6:600000d3 r5:ffffffff r4:00000000 r3:00000000
> [    0.000000] [<c010b878>] (show_stack) from [<c03dae8c>]
> (dump_stack+0xb0/0xe8)
> [    0.000000] [<c03daddc>] (dump_stack) from [<c012461c>]
> (warn_slowpath_common+0x80/0xbc)
> [    0.000000]  r8:c0ad86ec r7:00000009 r6:00000a10 r5:c016a948
> r4:c0d01bc8 r3:c0d064c0
> [    0.000000] [<c012459c>] (warn_slowpath_common) from [<c01246fc>]
> (warn_slowpath_fmt+0x38/0x40)
> [    0.000000]  r8:00000000 r7:c0d02b10 r6:00000001 r5:ef7c2280 r4:c08e3204
> [    0.000000] [<c01246c8>] (warn_slowpath_fmt) from [<c016a948>]
> (trace_hardirqs_on_caller+0x1ac/0x1f0)
> [    0.000000]  r3:c0ad9700 r2:c0ad5cc8
> [    0.000000] [<c016a79c>] (trace_hardirqs_on_caller) from
> [<c016a9a0>] (trace_hardirqs_on+0x14/0x18)
> [    0.000000]  r6:00000001 r5:ef7c2280 r4:ef7c2280 r3:600000d3
> [    0.000000] [<c016a98c>] (trace_hardirqs_on) from [<c08e3204>]
> (_raw_spin_unlock_irq+0x2c/0x34)
> [    0.000000] [<c08e31d8>] (_raw_spin_unlock_irq) from [<c015219c>]
> (dequeue_task_idle+0x14/0x30)
> [    0.000000]  r4:ef7c2280 r3:c0152188
> [    0.000000] [<c0152188>] (dequeue_task_idle) from [<c0149a50>]
> (deactivate_task+0x64/0x68)
> [    0.000000]  r4:c0d064c0 r3:c0152188
> [    0.000000] [<c01499ec>] (deactivate_task) from [<c08ddd68>]
> (__schedule+0x2cc/0x6d8)
> [    0.000000]  r6:c0d06804 r5:ef7c2290 r4:c0d064c0 r3:00000002
> [    0.000000] [<c08dda9c>] (__schedule) from [<c08de29c>] (schedule+0x3c/0xa0)
> [    0.000000]  r10:c0d064c0 r9:c1560db8 r8:00000001 r7:00000000
> r6:0006ddd0 r5:00000000
> [    0.000000]  r4:0007a120
> [    0.000000] [<c08de260>] (schedule) from [<c08e28b0>]
> (schedule_hrtimeout_range_clock+0xd4/0x13c)
> [    0.000000] [<c08e27dc>] (schedule_hrtimeout_range_clock) from
> [<c08e293c>] (schedule_hrtimeout_range+0x24/0x2c)
> [    0.000000]  r10:000006d8 r8:000000d8 r7:00000003 r6:ffff8ad1
> r5:c0d02100 r4:ef00c040
> [    0.000000] [<c08e2918>] (schedule_hrtimeout_range) from
> [<c08e2360>] (usleep_range+0x54/0x5c)
> [    0.000000] [<c08e230c>] (usleep_range) from [<c068b83c>]
> (clk_pllv3_wait_lock+0x7c/0xb4)
> [    0.000000] [<c068b7c0>] (clk_pllv3_wait_lock) from [<c068ba4c>]
> (clk_pllv3_prepare+0x2c/0x30)
> [    0.000000]  r6:c0d5c7f4 r5:00000000 r4:ef007680 r3:f08400f0
> [    0.000000] [<c068ba20>] (clk_pllv3_prepare) from [<c0685e08>]
> (clk_core_prepare+0xa0/0xcc)
> [    0.000000] [<c0685d68>] (clk_core_prepare) from [<c0685e54>]
> (clk_prepare+0x20/0x30)
> [    0.000000]  r5:00000000 r4:ef00c100
> [    0.000000] [<c0685e34>] (clk_prepare) from [<c0c4a700>]
> (imx7d_clocks_init+0x6114/0x6198)
> [    0.000000]  r4:ef00c100 r3:c0d064c0
> [    0.000000] [<c0c445ec>] (imx7d_clocks_init) from [<c0c30c08>]
> (of_clk_init+0x138/0x1e8)
> [    0.000000]  r10:c0d01f70 r9:00000001 r8:c0d01f68 r7:00000000
> r6:ef004340 r5:ef7e3d60
> [    0.000000]  r4:00000003
> [    0.000000] [<c0c30ad0>] (of_clk_init) from [<c0c049f0>]
> (time_init+0x2c/0x38)
> [    0.000000]  r10:00000001 r9:410fc075 r8:efffcb80 r7:c0c5ca48
> r6:c0d76000 r5:ffffffff
> [    0.000000]  r4:00000000
> [    0.000000] [<c0c049c4>] (time_init) from [<c0c00bcc>]
> (start_kernel+0x26c/0x400)
> [    0.000000] [<c0c00960>] (start_kernel) from [<8000807c>] (0x8000807c)
> [    0.000000]  r10:00000000 r8:8000406a r7:c0d07e4c r6:c0c5ca44
> r5:c0d0296c r4:c0d76294
> [    0.000000] ---[ end trace cb88537fdc8fa201 ]---
> [    0.000000] bad: scheduling from the idle thread!
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
> 4.5.0-rc5-next-20160222 #256
> [    0.000000] Hardware name: Freescale i.MX7 Dual (Device Tree)
> [    0.000000] Backtrace:
> [    0.000000] [<c010b6f4>] (dump_backtrace) from [<c010b890>]
> (show_stack+0x18/0x1c)
> [    0.000000]  r6:60000053 r5:ffffffff r4:00000000 r3:00000000
> [    0.000000] [<c010b878>] (show_stack) from [<c03dae8c>]
> (dump_stack+0xb0/0xe8)
> [    0.000000] [<c03daddc>] (dump_stack) from [<c01521a8>]
> (dequeue_task_idle+0x20/0x30)
> [    0.000000]  r8:00000000 r7:c0d02b10 r6:00000001 r5:ef7c2280
> r4:ef7c2280 r3:c0d064c0
> [    0.000000] [<c0152188>] (dequeue_task_idle) from [<c0149a50>]
> (deactivate_task+0x64/0x68)
> [    0.000000]  r4:c0d064c0 r3:c0152188
> [    0.000000] [<c01499ec>] (deactivate_task) from [<c08ddd68>]
> (__schedule+0x2cc/0x6d8)
> [    0.000000]  r6:c0d06804 r5:ef7c2290 r4:c0d064c0 r3:00000002
> [    0.000000] [<c08dda9c>] (__schedule) from [<c08de29c>] (schedule+0x3c/0xa0)
> [    0.000000]  r10:c0d064c0 r9:c1560db8 r8:00000001 r7:00000000
> r6:0006ddd0 r5:00000000
> [    0.000000]  r4:0007a120
> [    0.000000] [<c08de260>] (schedule) from [<c08e28b0>]
> (schedule_hrtimeout_range_clock+0xd4/0x13c)
> [    0.000000] [<c08e27dc>] (schedule_hrtimeout_range_clock) from
> [<c08e293c>] (schedule_hrtimeout_range+0x24/0x2c)
> [    0.000000]  r10:000006d8 r8:000000d8 r7:00000003 r6:ffff8ad1
> r5:c0d02100 r4:ef00c040
> [    0.000000] [<c08e2918>] (schedule_hrtimeout_range) from
> [<c08e2360>] (usleep_range+0x54/0x5c)
> [    0.000000] [<c08e230c>] (usleep_range) from [<c068b83c>]
> (clk_pllv3_wait_lock+0x7c/0xb4)
> [    0.000000] [<c068b7c0>] (clk_pllv3_wait_lock) from [<c068ba4c>]
> (clk_pllv3_prepare+0x2c/0x30)
> [    0.000000]  r6:c0d5c7f4 r5:00000000 r4:ef007680 r3:f08400f0
> [    0.000000] [<c068ba20>] (clk_pllv3_prepare) from [<c0685e08>]
> (clk_core_prepare+0xa0/0xcc)
> [    0.000000] [<c0685d68>] (clk_core_prepare) from [<c0685e54>]
> (clk_prepare+0x20/0x30)
> [    0.000000]  r5:00000000 r4:ef00c100
> [    0.000000] [<c0685e34>] (clk_prepare) from [<c0c4a700>]
> (imx7d_clocks_init+0x6114/0x6198)
> [    0.000000]  r4:ef00c100 r3:c0d064c0
> [    0.000000] [<c0c445ec>] (imx7d_clocks_init) from [<c0c30c08>]
> (of_clk_init+0x138/0x1e8)
> [    0.000000]  r10:c0d01f70 r9:00000001 r8:c0d01f68 r7:00000000
> r6:ef004340 r5:ef7e3d60
> [    0.000000]  r4:00000003
> [    0.000000] [<c0c30ad0>] (of_clk_init) from [<c0c049f0>]
> (time_init+0x2c/0x38)
> [    0.000000]  r10:00000001 r9:410fc075 r8:efffcb80 r7:c0c5ca48
> r6:c0d76000 r5:ffffffff
> [    0.000000]  r4:00000000
> [    0.000000] [<c0c049c4>] (time_init) from [<c0c00bcc>]
> (start_kernel+0x26c/0x400)
> [    0.000000] [<c0c00960>] (start_kernel) from [<8000807c>] (0x8000807c)
> [    0.000000]  r10:00000000 r8:8000406a r7:c0d07e4c r6:c0c5ca44
> r5:c0d0296c r4:c0d76294
> [    0.000000] Architected cp15 timer(s) running at 8.00MHz (virt).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
> max_cycles: 0x1d854df40, max_idle_ns: 440795202120 ns
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/time/sched_clock.c:179
> sched_clock_register+0x44/0x1f8()
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
> 4.5.0-rc5-next-20160222 #256
> [    0.000000] Hardware name: Freescale i.MX7 Dual (Device Tree)
> [    0.000000] Backtrace:
> [    0.000000] [<c010b6f4>] (dump_backtrace) from [<c010b890>]
> (show_stack+0x18/0x1c)
> [    0.000000]  r6:60000053 r5:ffffffff r4:00000000 r3:00000000
> [    0.000000] [<c010b878>] (show_stack) from [<c03dae8c>]
> (dump_stack+0xb0/0xe8)
> [    0.000000] [<c03daddc>] (dump_stack) from [<c012461c>]
> (warn_slowpath_common+0x80/0xbc)
> [    0.000000]  r8:c0add580 r7:00000009 r6:000000b3 r5:c0c13a40
> r4:00000000 r3:c0d064c0
> [    0.000000] [<c012459c>] (warn_slowpath_common) from [<c012467c>]
> (warn_slowpath_null+0x24/0x2c)
> [    0.000000]  r8:007a1200 r7:c155f688 r6:c0d5b2c0 r5:9ffdbd98 r4:a3aaa0c5
> [    0.000000] [<c0124658>] (warn_slowpath_null) from [<c0c13a40>]
> (sched_clock_register+0x44/0x1f8)
> [    0.000000] [<c0c139fc>] (sched_clock_register) from [<c0c2de48>]
> (arch_timer_common_init+0x1d4/0x234)
> [    0.000000]  r10:c0b5a5b4 r9:00000008 r8:c0ae2f94 r7:c155f688
> r6:c0d5b2c0 r5:9ffdbd98
> [    0.000000]  r4:a3aaa0c5
> [    0.000000] [<c0c2dc74>] (arch_timer_common_init) from [<c0c2e174>]
> (arch_timer_of_init+0x2cc/0x30c)
> [    0.000000]  r10:00000001 r9:410fc075 r8:efffcb80 r7:c0c5ca48
> r6:00000001 r5:00000000
> [    0.000000]  r4:00000012
> [    0.000000] [<c0c2dea8>] (arch_timer_of_init) from [<c0c2db24>]
> (clocksource_probe+0x50/0x94)
> [    0.000000]  r6:00000001 r5:c0d01f84 r4:ef7dae9c r3:c0c2dea8
> [    0.000000] [<c0c2dad4>] (clocksource_probe) from [<c0c049f4>]
> (time_init+0x30/0x38)
> [    0.000000]  r6:c0d76000 r5:ffffffff r4:00000000
> [    0.000000] [<c0c049c4>] (time_init) from [<c0c00bcc>]
> (start_kernel+0x26c/0x400)
> [    0.000000] [<c0c00960>] (start_kernel) from [<8000807c>] (0x8000807c)
> [    0.000000]  r10:00000000 r8:8000406a r7:c0d07e4c r6:c0c5ca44
> r5:c0d0296c r4:c0d76294
> [    0.000000] ---[ end trace cb88537fdc8fa202 ]---
> [    0.000007] sched_clock: 56 bits at 8MHz, resolution 125ns, wraps
> every 2199023255500ns
> [    0.000023] Switching to timer-based delay loop, resolution 125ns
> [    0.000603] Switching to timer-based delay loop, resolution 41ns
> [    0.000614] ------------[ cut here ]------------
> [    0.000632] WARNING: CPU: 0 PID: 0 at kernel/time/sched_clock.c:179
> sched_clock_register+0x44/0x1f8()
> [    0.000641] Modules linked in:
> [    0.000658] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
> 4.5.0-rc5-next-20160222 #256
> [    0.000668] Hardware name: Freescale i.MX7 Dual (Device Tree)
> [    0.000676] Backtrace:
> [    0.000700] [<c010b6f4>] (dump_backtrace) from [<c010b890>]
> (show_stack+0x18/0x1c)
> [    0.000710]  r6:60000053 r5:ffffffff r4:00000000 r3:00000000
> [    0.000746] [<c010b878>] (show_stack) from [<c03dae8c>]
> (dump_stack+0xb0/0xe8)
> [    0.000763] [<c03daddc>] (dump_stack) from [<c012461c>]
> (warn_slowpath_common+0x80/0xbc)
> [    0.000773]  r8:c0add580 r7:00000009 r6:000000b3 r5:c0c13a40
> r4:00000000 r3:c0d064c0
> [    0.000813] [<c012459c>] (warn_slowpath_common) from [<c012467c>]
> (warn_slowpath_null+0x24/0x2c)
> [    0.000823]  r8:016e3600 r7:f0880024 r6:016e3600 r5:c155f6f0 r4:ef002400
> [    0.000863] [<c0124658>] (warn_slowpath_null) from [<c0c13a40>]
> (sched_clock_register+0x44/0x1f8)
> [    0.000881] [<c0c139fc>] (sched_clock_register) from [<c0c2e8a4>]
> (_mxc_timer_init+0x148/0x240)
> [    0.000891]  r10:00000001 r9:410fc075 r8:c0b5a984 r7:f0880024
> r6:016e3600 r5:c155f6f0
> [    0.000926]  r4:ef002400
> [    0.000945] [<c0c2e75c>] (_mxc_timer_init) from [<c0c2ea54>]
> (mxc_timer_init_dt+0xb8/0xe8)
> [    0.000955]  r8:efffcb80 r7:00000003 r6:00000000 r5:ef7e084c r4:ef002400
> [    0.000996] [<c0c2e99c>] (mxc_timer_init_dt) from [<c0c2ea98>]
> (imx6dl_timer_init_dt+0x14/0x18)
> [    0.001006]  r7:c0c5ca48 r6:00000002 r5:c0d01f84 r4:ef7e084c
> [    0.001041] [<c0c2ea84>] (imx6dl_timer_init_dt) from [<c0c2db24>]
> (clocksource_probe+0x50/0x94)
> [    0.001061] [<c0c2dad4>] (clocksource_probe) from [<c0c049f4>]
> (time_init+0x30/0x38)
> [    0.001071]  r6:c0d76000 r5:ffffffff r4:00000000
> [    0.001102] [<c0c049c4>] (time_init) from [<c0c00bcc>]
> (start_kernel+0x26c/0x400)
> [    0.001119] [<c0c00960>] (start_kernel) from [<8000807c>] (0x8000807c)
> [    0.001128]  r10:00000000 r8:8000406a r7:c0d07e4c r6:c0c5ca44
> r5:c0d0296c r4:c0d76294
> [    0.001164] ---[ end trace cb88537fdc8fa203 ]---
> [    0.001183] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps
> every 89478484971ns
> [    0.001201] clocksource: mxc_timer1: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 79635851949 ns
> [    0.002139] ------------[ cut here ]------------
> [    0.002161] WARNING: CPU: 0 PID: 0 at init/main.c:593
> start_kernel+0x298/0x400()
> [    0.002170] Interrupts were enabled early
> [    0.002179] Modules linked in:
> [    0.002195] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
> 4.5.0-rc5-next-20160222 #256
> [    0.002205] Hardware name: Freescale i.MX7 Dual (Device Tree)
> [    0.002214] Backtrace:
> [    0.002237] [<c010b6f4>] (dump_backtrace) from [<c010b890>]
> (show_stack+0x18/0x1c)
> [    0.002247]  r6:60000053 r5:ffffffff r4:00000000 r3:00000000
> [    0.002283] [<c010b878>] (show_stack) from [<c03dae8c>]
> (dump_stack+0xb0/0xe8)
> [    0.002300] [<c03daddc>] (dump_stack) from [<c012461c>]
> (warn_slowpath_common+0x80/0xbc)
> [    0.002310]  r8:c0ace4a0 r7:00000009 r6:00000251 r5:c0c00bf8
> r4:c0d01f98 r3:c0d064c0
> [    0.002351] [<c012459c>] (warn_slowpath_common) from [<c01246fc>]
> (warn_slowpath_fmt+0x38/0x40)
> [    0.002361]  r8:efffcb80 r7:c0c5ca48 r6:c0d76000 r5:ffffffff r4:00000000
> [    0.002402] [<c01246c8>] (warn_slowpath_fmt) from [<c0c00bf8>]
> (start_kernel+0x298/0x400)
> [    0.002413]  r3:60000053 r2:c0ace4e0
> [    0.002436] [<c0c00960>] (start_kernel) from [<8000807c>] (0x8000807c)
> [    0.002446]  r10:00000000 r8:8000406a r7:c0d07e4c r6:c0c5ca44
> r5:c0d0296c r4:c0d76294
> [    0.002482] ---[ end trace cb88537fdc8fa204 ]---
> [    0.002594] Console: colour dummy device 80x30
> [    0.002607] Lock dependency validator: Copyright (c) 2006 Red Hat,
> Inc., Ingo Molnar
> [    0.002616] ... MAX_LOCKDEP_SUBCLASSES:  8
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
