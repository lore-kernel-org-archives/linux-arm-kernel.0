From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 3 Jul 2017 18:23:26 +0100
Subject: [PATCH v4 4/5] drivers/perf: Add support for ARMv8.2 Statistical
 Profiling Extension
In-Reply-To: <1496676177-29356-5-git-send-email-will.deacon@arm.com>
References: <1496676177-29356-1-git-send-email-will.deacon@arm.com>
 <1496676177-29356-5-git-send-email-will.deacon@arm.com>
Message-ID: <20170703172326.GA13732@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 04:22:56PM +0100, Will Deacon wrote:
> +static const struct of_device_id arm_spe_pmu_of_match[] = {
> +	{ .compatible = "arm,statistical-profiling-extension-v1", .data = (void *)1 },
> +};

I just noticed that we're missing a sentinel entry here. Please could
you append one for v5?

Somehow we've been getting lucky with subsequent memory being zero, but
KASAN screams when it sees us accessing said memory:

[    5.451190] ==================================================================
[    5.459186] BUG: KASAN: global-out-of-bounds in __of_match_node+0x140/0x158
[    5.466595] Read of size 1 at addr ffff20000a504788 by task swapper/0/1
[    5.473615] 
[    5.475388] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.12.0-rc4-00010-g35b026e #2
[    5.483547] Hardware name: ARM Juno development board (r1) (DT)
[    5.489856] Call trace:
[    5.492629] [<ffff200008094540>] dump_backtrace+0x0/0x560
[    5.498445] [<ffff200008094ac0>] show_stack+0x20/0x30
[    5.503910] [<ffff200008ba4280>] dump_stack+0x11c/0x184
[    5.509555] [<ffff200008546a18>] print_address_description+0x40/0x388
[    5.516446] [<ffff200008547080>] kasan_report+0x138/0x398
[    5.522266] [<ffff2000085472f8>] __asan_report_load1_noabort+0x18/0x20
[    5.529238] [<ffff200009a90f00>] __of_match_node+0x140/0x158
[    5.535312] [<ffff200009a90f54>] of_match_node+0x3c/0x60
[    5.541032] [<ffff200009a95fa4>] of_match_device+0x54/0x98
[    5.546939] [<ffff2000091b39ac>] platform_match+0xc4/0x2e8
[    5.552841] [<ffff2000091ada40>] __driver_attach+0x70/0x218
[    5.558831] [<ffff2000091a7c2c>] bus_for_each_dev+0x13c/0x1d0
[    5.564999] [<ffff2000091ac590>] driver_attach+0x48/0x78
[    5.570720] [<ffff2000091ab514>] bus_add_driver+0x26c/0x5e0
[    5.576712] [<ffff2000091af86c>] driver_register+0x16c/0x398
[    5.582802] [<ffff2000091b33f8>] __platform_driver_register+0xd8/0x128
[    5.589775] [<ffff20000a89a18c>] arm_spe_pmu_init+0x60/0x8c
[    5.595766] [<ffff200008084acc>] do_one_initcall+0xcc/0x370
[    5.601762] [<ffff20000a7e1d3c>] kernel_init_freeable+0x5f8/0x6c4
[    5.608294] [<ffff200009f8f7a8>] kernel_init+0x18/0x190
[    5.613924] [<ffff200008084710>] ret_from_fork+0x10/0x40
[    5.619604] 
[    5.621346] The buggy address belongs to the variable:
[    5.626893]  arm_spe_pmu_of_match+0xc8/0x4c0
[    5.631496] 
[    5.633235] Memory state around the buggy address:
[    5.638413]  ffff20000a504680: 00 01 fa fa fa fa fa fa 00 00 00 00 00 00 00 00
[    5.646235]  ffff20000a504700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    5.654057] >ffff20000a504780: 00 fa fa fa fa fa fa fa 00 fa fa fa fa fa fa fa
[    5.661852]                       ^
[    5.665683]  ffff20000a504800: 07 fa fa fa fa fa fa fa 00 04 fa fa fa fa fa fa
[    5.673506]  ffff20000a504880: 00 05 fa fa fa fa fa fa 00 06 fa fa fa fa fa fa
[    5.681302] ==================================================================

Thanks,
Mark.
