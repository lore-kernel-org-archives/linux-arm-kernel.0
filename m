From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 25 Jul 2017 11:45:23 +0100
Subject: ARM64 board Hikey960 boot failure due to f2545b2d4ce1
 (jump_label: Reorder hotplug lock and jump_label_lock)
In-Reply-To: <20170724143417.GA12788@leoy-ThinkPad-T440>
References: <20170724143417.GA12788@leoy-ThinkPad-T440>
Message-ID: <57e6c95f-a944-0dd5-437a-d7996ad19cf1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/07/17 15:34, Leo Yan wrote:
> Hi all,
> 
> We found the mainline arm64 kernel boot failure on Hikey960 board,
> this is caused by patch f2545b2d4ce1 (jump_label: Reorder hotplug lock
> and jump_label_lock), this patch adds locking cpus_read_lock() in
> function static_key_slow_inc() and introduce the dead lock issue by
> acquiring lock twice. Below are detailed flow:
> 
> arch_timer_register()
>  `> cpuhp_setup_state()
>      `> __cpuhp_setup_state()
>         cpus_read_lock()
>          `> __cpuhp_setup_state_cpuslocked()
>              `> cpuhp_issue_call()
>                  `> arch_timer_starting_cpu()
>                      `> __arch_timer_setup()
>                          `> arch_timer_check_ool_workaround()
>                              `> arch_timer_enable_workaround()
>                                  `> static_branch_enable()
>                                      `> static_key_enable()
>                                          `> static_key_slow_inc()
>                                              `> cpus_read_lock()
> 
> So finally there have called cpus_read_lock() twice, and kernel report
> log as below. So I am not sure what's the best way to fix this issue,
> could you give some suggestion for this? Thanks.

FWIW, I've reproduced this on Juno by hacking the erratum 858921
workaround to match Cortex-A53 or A57 instead - interestingly, when it's
applied for the boot CPU things seem OK; only when it's applied on
secondary bringup do I see the explosion as below.

Robin.

> ---8<---
> 
> ** 510118 printk messages dropped ** [    1.299405] [<ffff000008831140>] arch_timer_check_ool_workaround+0xc8/0x1fc
> ** 5516 printk messages dropped ** [    1.309965] [<ffff00000899d3a4>] schedule+0x38/0x9c
> ** 4289 printk messages dropped ** [    1.317961] [<ffff00000899d3a4>] schedule+0x38/0x9c
> ** 4293 printk messages dropped ** [    1.325961] [<ffff000008172370>] static_key_slow_inc+0xc8/0x124
> ** 4857 printk messages dropped ** [    1.335010] [<ffff00000899d3a4>] schedule+0x38/0x9c
> ** 4290 printk messages dropped ** [    1.343008] [<ffff0000089a0260>] rwsem_down_read_failed+0xdc/0x108
> ** 4999 printk messages dropped ** [    1.352325] [<ffff000008831584>] arch_timer_starting_cpu+0xf8/0x2c4
> ** 5048 printk messages dropped ** [    1.361726] [<ffff000008989e70>] dump_stack+0x90/0xb0
> ** 4381 printk messages dropped ** [    1.369892] [<ffff00000899d3a4>] schedule+0x38/0x9c
> ** 4291 printk messages dropped ** [    1.377895] [<ffff0000080ffe60>] __percpu_down_read+0xfc/0x110
> ** 4811 printk messages dropped ** [    1.386856] [<ffff000008989e70>] dump_stack+0x90/0xb0
> ** 4384 printk messages dropped ** [    1.395026] [<ffff0000080c1e44>] cpus_read_lock+0x70/0x74
> ** 4575 printk messages dropped ** [    1.403553] [<ffff0000080c1e44>] cpus_read_lock+0x70/0x74
> ** 4572 printk messages dropped ** [    1.412071] [<ffff00000899d3a4>] schedule+0x38/0x9c
> ** 4291 printk messages dropped ** [    1.420070] [<ffff0000080ffe60>] __percpu_down_read+0xfc/0x110
> ** 4812 printk messages dropped ** [    1.429034] [<ffff0000080eacb4>] dequeue_task_idle+0x24/0x38
> ** 4714 printk messages dropped ** [    1.437821] [<ffff000008172370>] static_key_slow_inc+0xc8/0x124
> ** 4855 printk messages dropped ** [    1.446871] [<ffff0000080e53f8>] deactivate_task+0x70/0xac
> ** 4620 printk messages dropped ** [    1.455480] [<ffff00000899cfec>] __schedule+0x244/0x5c4
> ** 4480 printk messages dropped ** [    1.463828] Hardware name: HiKey960 (DT)
> ** 3771 printk messages dropped ** [    1.470855] [<ffff0000080ffe60>] __percpu_down_read+0xfc/0x110
> ** 4808 printk messages dropped ** [    1.479815] Call trace:
> ** 2965 printk messages dropped ** [    1.485352] [<00000000009a81b4>] 0x9a81b4
> ** 3818 printk messages dropped ** [    1.492473] [<ffff0000080ffe60>] __percpu_down_read+0xfc/0x110
> ** 4808 printk messages dropped ** [    1.501436] Call trace:
> ** 2968 printk messages dropped ** [    1.506971] Hardware name: HiKey960 (DT)
> ** 3769 printk messages dropped ** [    1.514005] [<ffff00000899d3a4>] schedule+0x38/0x9c
> ** 4288 printk messages dropped ** [    1.522001] [<ffff00000899cfec>] __schedule+0x244/0x5c4
> ** 4473 printk messages dropped ** [    1.530347] [<ffff000008831584>] arch_timer_starting_cpu+0xf8/0x2c4
> ** 5041 printk messages dropped ** [    1.539747] [<00000000009a81b4>] 0x9a81b4
> ** 3819 printk messages dropped ** [    1.546867] [<ffff0000080c1e44>] cpus_read_lock+0x70/0x74
> ** 4572 printk messages dropped ** [    1.555393] [<ffff00000899d3a4>] schedule+0x38/0x9c
> ** 4288 printk messages dropped ** [    1.563390] [<ffff00000899cfec>] __schedule+0x244/0x5c4
> ** 4473 printk messages dropped ** [    1.571734] [<ffff000008831584>] arch_timer_starting_cpu+0xf8/0x2c4
> ** 5043 printk messages dropped ** [    1.581138] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S      W       4.13.0-rc1-linaro-hikey960+ #30
> ** 6551 printk messages dropped ** [    1.593352] [<ffff0000080c3640>] notify_cpu_starting+0x68/0x88
> ** 4807 printk messages dropped ** [    1.602312] [<ffff00000899cfec>] __schedule+0x244/0x5c4
> ** 4476 printk messages dropped ** [    1.610663] [<ffff00000808e9d0>] secondary_start_kernel+0xb0/0x118
> ** 4996 printk messages dropped ** [    1.619972] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G S      W       4.13.0-rc1-linaro-hikey960+ #30
> ** 6553 printk messages dropped ** [    1.632182] [<00000000009a81b4>] 0x9a81b4
> ** 3820 printk messages dropped ** [    1.639301] [<ffff000008172370>] static_key_slow_inc+0xc8/0x124
> ** 4854 printk messages dropped ** [    1.648349] [<ffff0000080eacb4>] dequeue_task_idle+0x24/0x38
> ** 4712 printk messages dropped ** [    1.657139] [<ffff0000080ffe60>] __percpu_down_read+0xfc/0x110
> ** 4804 printk messages dropped ** [    1.666098] [<00000000009a81b4>] 0x9a81b4
> ** 3821 printk messages dropped ** [    1.673223] [<ffff0000081723ec>] static_key_enable+0x20/0x34
> ** 4713 printk messages dropped ** [    1.682006] [<00000000009a81b4>] 0x9a81b4
> ** 3821 printk messages dropped ** [    1.689128] [<ffff0000081723ec>] static_key_enable+0x20/0x34
> ** 4713 printk messages dropped ** [    1.697911] [<00000000009a81b4>] 0x9a81b4
> ** 3820 printk messages dropped ** [    1.705033] [<ffff000008172370>] static_key_slow_inc+0xc8/0x124
> ** 4854 printk messages dropped ** [    1.714082] [<ffff0000080eacb4>] dequeue_task_idle+0x24/0x38
> ** 4711 printk messages dropped ** [    1.722868] [<ffff0000089a0260>] rwsem_down_read_failed+0xdc/0x108
> ** 4998 printk messages dropped ** [    1.732185] [<ffff000008831140>] arch_timer_check_ool_workaround+0xc8/0x1fc
> ** 5419 printk messages dropped ** [    1.742283] Hardware name: HiKey960 (DT)
> ** 3773 printk messages dropped ** [    1.749320] [<ffff000008172370>] static_key_slow_inc+0xc8/0x124
> ** 4856 printk messages dropped ** [    1.758369] [<ffff00000899cfec>] __schedule+0x244/0x5c4
> ** 4477 printk messages dropped ** [    1.766714] [<00000000009a81b4>] 0x9a81b4
> ** 3821 printk messages dropped ** [    1.773834] [<ffff0000081723ec>] static_key_enable+0x20/0x34
> ** 4713 printk messages dropped ** [    1.782619] [<00000000009a81b4>] 0x9a81b4
> ** 3820 printk messages dropped ** [    1.789743] [<ffff000008172370>] static_key_slow_inc+0xc8/0x124
> ** 4857 printk messages dropped ** [    1.798790] [<ffff00000899d3a4>] schedule+0x38/0x9c
> ** 4290 printk messages dropped ** [    1.806785] [<ffff0000089a0260>] rwsem_down_read_failed+0xdc/0x108
> ** 4995 printk messages dropped ** [    1.816100] [<ffff0000080c1e44>] cpus_read_lock+0x70/0x74
> ** 4574 printk messages dropped ** [    1.824627] [<ffff0000080ffe60>] __percpu_down_read+0xfc/0x110
> ** 4811 printk messages dropped ** [    1.833590] [<ffff000008989e70>] dump_stack+0x90/0xb0
> ** 4385 printk messages dropped ** [    1.841760] [<ffff000008172370>] static_key_slow_inc+0xc8/0x124
> ** 4856 printk messages dropped ** [    1.850811] [<ffff00000899cfec>] __schedule+0x244/0x5c4
> ** 4476 printk messages dropped ** [    1.859155] [<ffff00000808e9d0>] secondary_start_kernel+0xb0/0x118
> ** 4997 printk messages dropped ** [    1.868468] Hardware name: HiKey960 (DT)
> ** 3771 printk messages dropped ** [    1.875501] [<ffff0000080ffe60>] __percpu_down_read+0xfc/0x110
> ** 4810 printk messages dropped ** [    1.884467] [<ffff000008088590>] show_stack+0x14/0x1c
> ** 4383 printk messages dropped ** [    1.892638] [<ffff0000089a0260>] rwsem_down_read_failed+0xdc/0x108
> ** 4997 printk messages dropped ** [    1.901951] [<ffff0000081723ec>] static_key_enable+0x20/0x34
> ** 4713 printk messages dropped ** [    1.910736] [<00000000009a81b4>] 0x9a81b4
> ** 3822 printk messages dropped ** [    1.917857] [<ffff000008831140>] arch_timer_check_ool_workaround+0xc8/0x1fc
> ** 5423 printk messages dropped ** [    1.927961] [<ffff000008989e70>] dump_stack+0x90/0xb0
> ** 4386 printk messages dropped ** [    1.936135] [<ffff0000081723ec>] static_key_enable+0x20/0x34
> ** 4713 printk messages dropped ** [    1.944918] [<00000000009a81b4>] 0x9a81b4
> ** 3819 printk messages dropped ** [    1.952036] [<ffff0000080c1e44>] cpus_read_lock+0x70/0x74
> ** 4575 printk messages dropped ** [    1.960563] [<ffff0000080c1e44>] cpus_read_lock+0x70/0x74
> ** 4569 printk messages dropped ** [    1.969080] [<ffff0000080eacb4>] dequeue_task_idle+0x24/0x38
> ** 4713 printk messages dropped ** [    1.977869] [<ffff0000080c1e44>] cpus_read_lock+0x70/0x74
> ** 4572 printk messages dropped ** [    1.986395] [<ffff00000899d3a4>] schedule+0x38/0x9c
> ** 4291 printk messages dropped ** [    1.994392] [<ffff0000080ffe60>] __percpu_down_read+0xfc/0x110
> ** 4810 printk messages dropped ** [    2.003355] [<ffff000008088590>] show_stack+0x14/0x1c
> ** 4385 printk messages dropped ** [    2.011528] [<ffff0000080c1e44>] cpus_read_lock+0x70/0x74
> ** 4572 printk messages dropped ** [    2.020048] [<ffff00000899d3a4>] schedule+0x38/0x9c
> ** 4291 printk messages dropped ** [    2.028045] [<ffff0000080ffe60>] __percpu_down_read+0xfc/0x110
> ** 4810 printk messages dropped ** [    2.037012] [<ffff000008088590>] show_stack+0x14/0x1c
> ** 4385 printk messages dropped ** [    2.045184] [<ffff0000080c1e44>] cpus_read_lock+0x70/0x74
> ** 4573 printk messages dropped ** [    2.053709] [<ffff0000089a0260>] rwsem_down_read_failed+0xdc/0x108
> ** 4998 printk messages dropped ** [    2.063026] [<ffff000008831140>] arch_timer_check_ool_workaround+0xc8/0x1fc
> ** 5425 printk messages dropped ** [    2.073128] [<ffff0000080e53f8>] deactivate_task+0x70/0xac
> ** 4620 printk messages dropped ** [    2.081738] [<ffff00000899cfec>] __schedule+0x244/0x5c4
> ** 4478 printk messages dropped ** [    2.090083] bad: scheduling from the idle thread!
> ** 4196 printk messages dropped ** [    2.097910] [<ffff000008831584>] arch_timer_starting_cpu+0xf8/0x2c4
> ** 5044 printk messages dropped ** [    2.107306] Hardware name: HiKey960 (DT)
> ** 3771 printk messages dropped ** [    2.114340] [<ffff0000080ffe60>] __percpu_down_read+0xfc/0x110
> ** 4810 printk messages dropped ** [    2.123304] [<ffff000008088590>] show_stack+0x14/0x1c
> ** 4383 printk messages dropped ** [    2.131475] [<ffff0000089a0260>] rwsem_down_read_failed+0xdc/0x108
> ** 4998 printk messages dropped ** [    2.140793] [<ffff000008831140>] arch_timer_check_ool_workaround+0xc8/0x1fc
> ** 5424 printk messages dropped ** [    2.150895] [<ffff0000080eacb4>] dequeue_task_idle+0x24/0x38
> ** 4715 printk messages dropped ** [    2.159680] [<ffff0000081723ec>] static_key_enable+0x20/0x34
> ** 4716 printk messages dropped ** [    2.168467] Hardware name: HiKey960 (DT)
> ** 3771 printk messages dropped ** [    2.175497] [<ffff0000080ffe60>] __percpu_down_read+0xfc/0x110
> ** 4804 printk messages dropped ** [    2.184458] [<00000000009a81b4>] 0x9a81b4
> ** 3823 printk messages dropped ** [    2.191583] [<ffff000008831584>] arch_timer_starting_cpu+0xf8/0x2c4
> ** 5041 printk messages dropped ** [    2.200979] [<00000000009a81b4>] 0x9a81b4
> ** 3821 printk messages dropped ** [    2.208105] [<ffff0000081723ec>] static_key_enable+0x20/0x34
> ** 4713 printk messages dropped ** [    2.216886] [<00000000009a81b4>] 0x9a81b4
> ** 3819 printk messages dropped ** [    2.224004] [<ffff0000080c1e44>] cpus_read_lock+0x70/0x74
> ** 4574 printk messages dropped ** [    2.232530] [<ffff0000080ffe60>] __percpu_down_read+0xfc/0x110
> ** 4807 printk messages dropped ** [    2.241489] Hardware name: HiKey960 (DT
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
