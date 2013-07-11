From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 11 Jul 2013 23:10:51 +0800
Subject: [RFC PATCH 0/5] arm64: initial CPU_HOTPLUG support
In-Reply-To: <1373494279-24712-1-git-send-email-mark.rutland@arm.com>
References: <1373494279-24712-1-git-send-email-mark.rutland@arm.com>
Message-ID: <51DECAFB.4010800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

I tested this patch set on the armv8 foundation model, it's panic.

I seems that we need to do something more, I'll also checkout
what's going on here.

Thanks
Hanjun

dump formation:
root at genericarmv8:/sys/devices/system/cpu/cpu3# echo 0 > online
CPU3: Booted secondary processor
CPU3: shutdown
BUG: failure at kernel/time/clockevents.c:284/clockevents_register_device()!
Kernel panic - not syncing: BUG!
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 3.10.0+ #2
Call trace:
[<ffffffc0000873e0>] dump_backtrace+0x0/0x12c
[<ffffffc000087520>] show_stack+0x14/0x1c
[<ffffffc0003f2e7c>] dump_stack+0x20/0x28
[<ffffffc0003efd24>] panic+0xe8/0x214
[<ffffffc0000d049c>] clockevents_set_mode+0x0/0x6c
[<ffffffc0000d074c>] clockevents_config_and_register+0x24/0x30
[<ffffffc0003ef840>] arch_timer_setup+0xd8/0x140
[<ffffffc0003ef8f0>] arch_timer_cpu_notify+0x48/0xc8
[<ffffffc0000b83e4>] notifier_call_chain+0x48/0x88
[<ffffffc0000b8500>] __raw_notifier_call_chain+0xc/0x14
[<ffffffc0000973f0>] __cpu_notify+0x30/0x58
[<ffffffc00009742c>] cpu_notify+0x14/0x1c
[<ffffffc0003ed46c>] notify_cpu_starting+0x14/0x1c
[<ffffffc0003ece74>] secondary_start_kernel+0xc0/0xf4
CPU2: stopping
CPU: 2 PID: 0 Comm: swapper/2 Not tainted 3.10.0+ #2
Call trace:
[<ffffffc0000873e0>] dump_backtrace+0x0/0x12c
[<ffffffc000087520>] show_stack+0x14/0x1c
[<ffffffc0003f2e7c>] dump_stack+0x20/0x28
[<ffffffc00008da8c>] handle_IPI+0x120/0x130
[<ffffffc0000812e0>] gic_handle_irq+0x7c/0x80
Exception stack(0xffffffc87fc8de30 to 0xffffffc87fc8df50)
de20: 7fc8c000 ffffffc8 005a1c8b ffffffc0
de40: 7fc8df70 ffffffc8 00084540 ffffffc0 00000e90 00000000 00000000 
00000000
de60: 3ffbb9ec ffffffc0 00010000 00000000 00000020 00000000 00000000 
00000000
de80: 3ffbb7f8 ffffffc0 00000000 00000000 7fc5ddd0 ffffffc8 7fc8dd80 
ffffffc8
dea0: 003fb8e4 ffffffc0 03ee8b1d 00000000 003fb8e8 ffffffc0 00000000 
00000000
dec0: 1f7458e8 ffffffbc 00001000 00000000 00000001 00000000 00002000 
00000000
dee0: 00000000 00000000 7fc8c000 ffffffc8 005a1c8b ffffffc0 00000001 
00000000
df00: 004dc3f0 ffffffc0 005adf00 ffffffc0 003faca0 ffffffc0 8007b000 
00000000
df20: 8007d000 00000000 000801a0 ffffffc0 80080188 00000000 7fc8df70 
ffffffc8
df40: 0008453c ffffffc0 7fc8df70 ffffffc8
[<ffffffc0000835ac>] el1_irq+0x6c/0xc0
[<ffffffc0000ca4f4>] cpu_startup_entry+0xf0/0x138
[<ffffffc0003ece9c>] secondary_start_kernel+0xe8/0xf4
CPU1: stopping
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.10.0+ #2
Call trace:
[<ffffffc0000873e0>] dump_backtrace+0x0/0x12c
[<ffffffc000087520>] show_stack+0x14/0x1c
[<ffffffc0003f2e7c>] dump_stack+0x20/0x28
[<ffffffc00008da8c>] handle_IPI+0x120/0x130
[<ffffffc0000812e0>] gic_handle_irq+0x7c/0x80
Exception stack(0xffffffc87fc8be30 to 0xffffffc87fc8bf50)
be20: 7fc8a000 ffffffc8 005a1c8b ffffffc0
be40: 7fc8bf70 ffffffc8 00084540 ffffffc0 00002088 00000000 00000000 
00000000
be60: 3ffb19ec ffffffc0 00010000 00000000 00000010 00000000 0fcf5932 
0000274b
be80: aba36180 0000008d 7f7bd8b0 ffffffc8 7fc5d4d0 ffffffc8 7fc8bd80 
ffffffc8
bea0: 00004d30 00000001 00000020 00000000 003fb8e8 ffffffc0 ae892f33 
ffffffff
bec0: 46000000 0021a0f7 00000000 003b9aca 0016dae4 ffffffc0 94294800 
0000007f
bee0: f0587350 0000007f 7fc8a000 ffffffc8 005a1c8b ffffffc0 00000001 
00000000
bf00: 004dc3f0 ffffffc0 005adf00 ffffffc0 003faca0 ffffffc0 8007b000 
00000000
bf20: 8007d000 00000000 000801a0 ffffffc0 80080188 00000000 7fc8bf70 
ffffffc8
bf40: 0008453c ffffffc0 7fc8bf70 ffffffc8
[<ffffffc0000835ac>] el1_irq+0x6c/0xc0
[<ffffffc0000ca4f4>] cpu_startup_entry+0xf0/0x138
[<ffffffc0003ece9c>] secondary_start_kernel+0xe8/0xf4
CPU: 0 PID: 957 Comm: sh Not tainted 3.10.0+ #2
Call trace:
[<ffffffc0000873e0>] dump_backtrace+0x0/0x12c
[<ffffffc000087520>] show_stack+0x14/0x1c
[<ffffffc0003f2e7c>] dump_stack+0x20/0x28
[<ffffffc00008da8c>] handle_IPI+0x120/0x130
[<ffffffc0000812e0>] gic_handle_irq+0x7c/0x80
Exception stack(0xffffffc87e1e7a70 to 0xffffffc87e1e7b90)
7a60: 00000007 00000000 0057b000 ffffffc0
7a80: 7e1e7bb0 ffffffc8 00096044 ffffffc0 00000000 00000000 3fa41000 
00000000
7aa0: 00000000 00000000 3ffa73d8 ffffffc0 00000000 00000000 00000000 
00000000
7ac0: 005b1000 ffffffc0 7e1e6000 ffffffc8 00000002 00000000 0057b000 
ffffffc0
7ae0: 00000001 00000000 00000030 00000000 000012b0 00000000 00000000 
00000000
7b00: 000000a6 00000000 00000006 00000000 005a8000 ffffffc0 b62e09b8 
0000007f
7b20: c32ba320 0000007f 00000007 00000000 0057b000 ffffffc0 00000005 
00000000
7b40: 005a4758 ffffffc0 00000140 00000000 0000000e 00000000 00000000 
00000000
7b60: 00000000 00000000 0000000e 00000000 00000006 00000000 7e1e7bb0 
ffffffc8
7b80: 000960f8 ffffffc0 7e1e7bb0 ffffffc8
[<ffffffc0000835ac>] el1_irq+0x6c/0xc0
[<ffffffc0003efec4>] printk+0x74/0x7c
[<ffffffc0003ecf68>] __cpu_die+0x50/0x8c
[<ffffffc0003eacd4>] _cpu_down.constprop.2+0xec/0x280
[<ffffffc0003eae8c>] cpu_down+0x24/0x40
[<ffffffc0003ebca4>] store_online+0x40/0xa4
[<ffffffc0002f1bf4>] dev_attr_store+0x18/0x28
[<ffffffc00018c0ec>] sysfs_write_file+0xdc/0x154
[<ffffffc00012fefc>] vfs_write+0xac/0x1a4
[<ffffffc00013032c>] SyS_write+0x44/0x8c


On 2013?07?11? 06:11, Mark Rutland wrote:
> The following patches add basic CPU_HOTPLUG support to arm64, which
> combined with appropriate firmware (e.g. [1]) can be used to power CPUs
> up and down dynamically. From discussions at connect it seemed that
> several people were interested in working in this area, so I thought I'd
> make my current implementation public now that I've managed to regain
> access to my inbox.
>
> I've tested this series with the bootwrapper PSCI implementation I've
> placed on linux-arm.org [1] and a modified foundation model dts with a
> psci node and each CPU's enable-method set to "psci", using a shell
> while repeatedly cycling all cpus off and on:
>
> for C in $(seq 0 3); do
> 	./cyclichotplug.sh $C >/dev/null 2>&1 &
> done
>
> ---->8----
> #!/bin/sh
> # cyclichotplug.sh
>
> CPU=$1;
>
> if [ -z "$CPU" ]; then
> 	printf "Usage: $0 <cpu id>\n";
> 	exit 1;
> fi
>
> ONLINEFILE=/sys/devices/system/cpu/cpu$CPU/online;
>
> while true; do
> 	echo 0 > $ONLINEFILE;
> 	echo 1 > $ONLINEFILE;
> done
> ---->8----
>
> Patches are based on v3.10.
>
> Thanks,
> Mark.
>
> [1] http://linux-arm.org/git?p=boot-wrapper-aarch64.git;a=shortlog;h=refs/tags/simple-psci
>
> Mark Rutland (5):
>    arm64: reorganise smp_enable_ops
>    arm64: factor out spin-table boot method
>    arm64: read enable-method for CPU0
>    arm64: add CPU_HOTPLUG infrastructure
>    arm64: add PSCI CPU_OFF-based hotplug support
>
>   arch/arm64/Kconfig                 |    7 ++
>   arch/arm64/include/asm/irq.h       |    1 +
>   arch/arm64/include/asm/smp.h       |   37 +++++--
>   arch/arm64/kernel/cputable.c       |    2 +-
>   arch/arm64/kernel/head.S           |   12 +-
>   arch/arm64/kernel/irq.c            |   61 ++++++++++
>   arch/arm64/kernel/process.c        |    7 ++
>   arch/arm64/kernel/smp.c            |  215 ++++++++++++++++++++++--------------
>   arch/arm64/kernel/smp_psci.c       |   54 +++++++--
>   arch/arm64/kernel/smp_spin_table.c |   85 +++++++++++++-
>   arch/arm64/kernel/vmlinux.lds.S    |    1 -
>   11 files changed, 375 insertions(+), 107 deletions(-)
>
