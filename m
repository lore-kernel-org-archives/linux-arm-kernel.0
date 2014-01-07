From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 07 Jan 2014 12:29:19 +0100
Subject: Boot crash on 5420 with latest linux-next
In-Reply-To: <CAK9yfHx0OcnchPE5gr-BQLD-qc2Xe9HrYH27xO7U1LFo5Kx4uw@mail.gmail.com>
References: <CAK9yfHx0OcnchPE5gr-BQLD-qc2Xe9HrYH27xO7U1LFo5Kx4uw@mail.gmail.com>
Message-ID: <52CBE50F.8070404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/14 08:01, Sachin Kamat wrote:
> Hi,
> 
> The latest linux-next (20140106 as well as 201401067) gives a boot
> crash on Exynos5420 based boards with exynos_defconfig. The crash log
> is as follows:
> 
> [    4.550000] gpiochip_add: registered GPIOs 225 to 231 on device: gpz
> [    4.560000] Unable to handle kernel NULL pointer dereference at
> virtual address 00000050
> [    4.565000] pgd = c0004000
> [    4.565000] [00000050] *pgd=00000000
> [    4.570000] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [    4.570000] Modules linked in:
> [    4.570000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 3.13.0-rc7-next-20140107 #279
> [    4.570000] task: ef0a8000 ti: ef0a6000 task.ti: ef0a6000
> [    4.570000] PC is at __clk_get+0x24/0x80
> [    4.570000] LR is at of_clk_get.part.6+0x54/0x6c
> [    4.570000] pc : [<c02ddf34>]    lr : [<c02db7c8>]    psr: 60000113
> [    4.570000] sp : ef0a7d90  ip : ef0a7da0  fp : 00000001
> [    4.570000] r10: ef22d000  r9 : f001a000  r8 : 00001000
> [    4.570000] r7 : 00000000  r6 : c078c414  r5 : ffffffea  r4 : 00000000
> [    4.570000] r3 : 00000050  r2 : 000001d9  r1 : c0569e80  r0 : 00000000
> [    4.570000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
> Segment kernel
> [    4.570000] Control: 10c5387d  Table: 2000406a  DAC: 00000015
> [    4.570000] Process swapper/0 (pid: 1, stack limit = 0xef0a6240)
> [    4.570000] Stack: (0xef0a7d90 to 0xef0a8000)
> [    4.570000] 7d80:                                     00000000
> c02db7c8 ef0a7da0 c02d738c
> [    4.570000] 7da0: c078afe4 00000001 000001d9 00000000 c04532a0
> c02d7bb8 c04532a0 ffffffea
> [    4.570000] 7dc0: c078c414 00000000 c04532a0 c02db864 00000022
> ef1f1040 c04532a0 ef22d128
> [    4.570000] 7de0: 00000000 c02db8c8 00000022 ef22d000 ef22d000
> c01eb5b0 00000022 ef22d000
> [    4.570000] 7e00: 00000000 c01eba10 00000000 00000009 ef22d024
> c078c414 00000000 ef22ca10
> [    4.570000] 7e20: 00000000 c02d93dc c0527ca8 c03aac00 c03aacc4
> c02d7a0c 60000113 c0527ca8
> [    4.570000] 7e40: c078c078 c078c2b4 ef22ca10 00000000 00000000
> 00000000 00000001 c078c078
> [    4.570000] 7e60: c078c414 ef22ca10 00000000 c03aac00 00000000
> c02d92c8 00000001 c0227f14
> [    4.570000] 7e80: 00000000 ef0a7ea8 60000113 c0527ca8 c03aac00
> 00000000 00000000 00000001
> [    4.570000] 7ea0: 00000000 c078c078 c078405c c03aac00 00000000
> 00000000 00000001 ef0a6038
> [    4.570000] 7ec0: 00000000 c02d955c 00000001 00000000 00000000
> c04f037c 00000003 c052dc40
> [    4.570000] 7ee0: c052dc40 c04bd218 c04ddb70 c04bd238 00000000
> c0008908 ef01c300 c043a894
> [    4.570000] 7f00: ef1d6900 c03855e8 60000100 c0501a80 60000113
> c0501a80 00000000 00000000
> [    4.570000] 7f20: 00000000 c0501a7c c078eade c0395c4c 00000079
> c0035d9c c049a768 00000003
> [    4.570000] 7f40: c078eaf0 00000003 00000000 c04f037c 00000003
> c052dc40 c052dc40 c04ba50c
> [    4.570000] 7f60: c04ddb70 00000079 c04ddb58 c04bac9c 00000003
> 00000003 c04ba50c c0381638
> [    4.570000] 7f80: c15d65c0 0000dc40 c0378d54 00000000 00000000
> 00000000 00000000 00000000
> [    4.570000] 7fa0: 00000000 c0378d60 00000000 c000e438 00000000
> 00000000 00000000 00000000
> [    4.570000] 7fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    4.570000] 7fe0: 00000000 00000000 00000000 00000000 00000013
> 00000000 00000000 00000000
> [    4.570000] [<c02ddf34>] (__clk_get) from [<c02db7c8>]
> (of_clk_get.part.6+0x54/0x6c)
> [    4.570000] [<c02db7c8>] (of_clk_get.part.6) from [<c02db864>]
> (of_clk_get_by_name+0x70/0xb0)
> [    4.570000] [<c02db864>] (of_clk_get_by_name) from [<c02db8c8>]
> (clk_get+0x24/0x44)
> [    4.570000] [<c02db8c8>] (clk_get) from [<c01eb5b0>]
> (amba_get_enable_pclk+0x14/0x68)
> [    4.570000] [<c01eb5b0>] (amba_get_enable_pclk) from [<c01eba10>]
> (amba_device_add+0xa0/0x1d0)
> [    4.570000] [<c01eba10>] (amba_device_add) from [<c02d93dc>]
> (of_platform_bus_create+0x248/0x2a0)
> [    4.570000] [<c02d93dc>] (of_platform_bus_create) from [<c02d92c8>]
> (of_platform_bus_create+0x134/0x2a0)
> [    4.570000] [<c02d92c8>] (of_platform_bus_create) from [<c02d955c>]
> (of_platform_populate+0x5c/0xa0)
> [    4.570000] [<c02d955c>] (of_platform_populate) from [<c04bd238>]
> (customize_machine+0x20/0x40)
> [    4.570000] [<c04bd238>] (customize_machine) from [<c0008908>]
> (do_one_initcall+0xf8/0x144)
> [    4.570000] [<c0008908>] (do_one_initcall) from [<c04bac9c>]
> (kernel_init_freeable+0x13c/0x1dc)
> [    4.570000] [<c04bac9c>] (kernel_init_freeable) from [<c0378d60>]
> (kernel_init+0xc/0x118)
> [    4.570000] [<c0378d60>] (kernel_init) from [<c000e438>]
> (ret_from_fork+0x14/0x3c)
> [    4.570000] Code: e3500000 0a00000b e2843050 f57ff05b (e1932f9f)
> [    4.575000] ---[ end trace e07e345daa061b93 ]---
> [    4.580000] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    4.580000]
> [    4.580000] CPU3: stopping
> [    4.580000] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D
> 3.13.0-rc7-next-20140107 #279
> [    4.580000] [<c0013e5c>] (unwind_backtrace) from [<c0011230>]
> (show_stack+0x10/0x14)
> [    4.580000] [<c0011230>] (show_stack) from [<c037c600>]
> (dump_stack+0x7c/0xbc)
> [    4.580000] [<c037c600>] (dump_stack) from [<c00131bc>]
> (handle_IPI+0x148/0x158)
> [    4.580000] [<c00131bc>] (handle_IPI) from [<c00085c8>]
> (gic_handle_irq+0x64/0x68)
> [    4.580000] [<c00085c8>] (gic_handle_irq) from [<c0011d80>]
> (__irq_svc+0x40/0x70)
> [    4.580000] Exception stack(0xef0d9f98 to 0xef0d9fe0)
> [    4.580000] 9f80:
>     00000003 00000000
> [    4.580000] 9fa0: 00000001 00000000 ef0d8000 c04fc494 c0384b74
> c052db19 00000001 c052db19
> [    4.580000] 9fc0: ef0d8000 ef0d8000 4c4b4000 ef0d9fe0 c000ef64
> c000ef68 60000113 ffffffff
> [    4.580000] [<c0011d80>] (__irq_svc) from [<c000ef68>]
> (arch_cpu_idle+0x2c/0x30)
> [    4.580000] [<c000ef68>] (arch_cpu_idle) from [<c00572e0>]
> (cpu_startup_entry+0x108/0x150)
> [    4.580000] [<c00572e0>] (cpu_startup_entry) from [<20008664>] (0x20008664)
> [    4.580000] CPU1: stopping
> [    4.580000] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D
> 3.13.0-rc7-next-20140107 #279
> [    4.580000] [<c0013e5c>] (unwind_backtrace) from [<c0011230>]
> (show_stack+0x10/0x14)
> [    4.580000] [<c0011230>] (show_stack) from [<c037c600>]
> (dump_stack+0x7c/0xbc)
> [    4.580000] SMP: failed to stop secondary CPUs
> [    4.590000] [<c037c600>] (dump_stack) from [<c00131bc>]
> (handle_IPI+0x148/0x158)
> [    4.600000] [<c00131bc>] (handle_IPI) from [<c00085c8>]
> (gic_handle_irq+0x64/0x68)
> [    4.605000] [<c00085c8>] (gic_handle_irq) from [<c0011d80>]
> (__irq_svc+0x40/0x70)
> [    4.615000] Exception stack(0xef0d5f98 to 0xef0d5fe0)
> [    4.620000] 5f80:
>     00000001 00000000
> [    4.630000] 5fa0: 00000001 00000000 ef0d4000 c04fc494 c0384b74
> c052db19 00000001 c052db19
> [    4.635000] 5fc0: ef0d4000 ef0d4000 4c4b4000 ef0d5fe0 c000ef64
> c000ef68 60000113 ffffffff
> [    4.645000] [<c0011d80>] (__irq_svc) from [<c000ef68>]
> (arch_cpu_idle+0x2c/0x30)
> [    4.650000] [<c000ef68>] (arch_cpu_idle) from [<c00572e0>]
> (cpu_startup_entry+0x108/0x150)
> [    4.660000] [<c00572e0>] (cpu_startup_entry) from [<20008664>] (0x20008664)
> [    4.670000] CPU2: stopping
> [    4.670000] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D
> 3.13.0-rc7-next-20140107 #279
> [    4.680000] [<c0013e5c>] (unwind_backtrace) from [<c0011230>]
> (show_stack+0x10/0x14)
> [    4.685000] [<c0011230>] (show_stack) from [<c037c600>]
> (dump_stack+0x7c/0xbc)
> [    4.695000] [<c037c600>] (dump_stack) from [<c00131bc>]
> (handle_IPI+0x148/0x158)
> [    4.700000] [<c00131bc>] (handle_IPI) from [<c00085c8>]
> (gic_handle_irq+0x64/0x68)
> [    4.710000] [<c00085c8>] (gic_handle_irq) from [<c0011d80>]
> (__irq_svc+0x40/0x70)
> [    4.715000] Exception stack(0xef0d7f98 to 0xef0d7fe0)
> [    4.720000] 7f80:
>     00000002 00000000
> [    4.730000] 7fa0: 00000001 00000000 ef0d6000 c04fc494 c0384b74
> c052db19 00000001 c052db19
> [    4.740000] 7fc0: ef0d6000 ef0d6000 4c4b4000 ef0d7fe0 c000ef64
> c000ef68 60000113 ffffffff
> [    4.745000] [<c0011d80>] (__irq_svc) from [<c000ef68>]
> (arch_cpu_idle+0x2c/0x30)
> [    4.755000] [<c000ef68>] (arch_cpu_idle) from [<c00572e0>]
> (cpu_startup_entry+0x108/0x150)
> [    4.760000] [<c00572e0>] (cpu_startup_entry) from [<20008664>] (0x20008664)
> ******************************
> 
> git bisect points to a merge commit 6ea578da5acf ("Merge
> remote-tracking branch 'clk/clk-next'").
> Couldn't make much out of it though. PC: c02ddf34 points to
> arch/arm/include/asm/atomic.h:64 and
> c02db7c8 points to drivers/clk/clkdev.c:47
> 
> There is however no such problem observed on Exynos4210 and 5250 based
> boards. They boot fine.

Thanks for the bug report. It seems there are two problems here:

1. NULL clk pointers are not handled correctly, after my patch:
   fcb0ee6 clk: Implement clk_unregister
   Sorry about that, I will post a fixup patch soon, please try if it
   eliminates the boot crash.

2. Exynos5250 clocks driver seems to be returning NULL clk for device's
  "apb_pclk" clocks, i.e. __of_clk_get_from_provider() returns a pointer
  to an entry in its clocks table where no registered clock has been
  stored previously.

--
Regards,
Sylwester
