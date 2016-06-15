From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Wed, 15 Jun 2016 16:25:17 +0300
Subject: [PATCH v8 0/4] ACPI: parse the SPCR table
In-Reply-To: <5760ADD3.30509@riken.jp>
References: <5760ADD3.30509@riken.jp>
Message-ID: <36cf7c7b-59e5-a6a7-8c90-d9873c96e5ac@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/15/2016 04:22 AM, Itaru Kitayama wrote:
> Hi Aleksey,
> 
> I've wondering whether your V8 patch set should support !4K-page kernels.
> So far I've seen that on Mustang, 4K-page kernel boots fine, but 64K-page
> kernel always ends up with a panic.

[...]

> [    0.000000] ACPI: SSDT 0x00000043FA846000 000032 (v02 REDHAT UARTCLKS
> 00000001      01000013)
> [    0.000000] ACPI: SPCR: console: uart,mmio,0x1c020000,115200
> [    0.000000] memblock_reserve: [0x000043ffff0000-0x000043ffffffff]
> flags 0x0 memblock_alloc_range_nid+0x64/0x78
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] kernel BUG at arch/arm64/mm/mmu.c:480!
> [    0.000000] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.7.0-rc1-dev+ #28
> [    0.000000] Hardware name: APM X-Gene Mustang board (DT)
> [    0.000000] task: ffff000008e18980 ti: ffff000008df0000 task.ti:
> ffff000008df0000
> [    0.000000] PC is at map_kernel_segment+0x44/0xb0
> [    0.000000] LR is at paging_init+0x84/0x5b0
> [    0.000000] pc : [<ffff000008b350e0>] lr : [<ffff000008b351d0>]
> pstate: 600002c5
> [    0.000000] sp : ffff000008df3e60
> [    0.000000] x29: ffff000008df3e60 x28: 0000004000d3001c

[...]

> [    0.000000] 3da0: 6666666633343030 6c66205d66666666 2030783020736761
> ffff00000992e03d
> [    0.000000] [<ffff000008b350e0>] map_kernel_segment+0x44/0xb0
> [    0.000000] [<ffff000008b351d0>] paging_init+0x84/0x5b0
> [    0.000000] [<ffff000008b32708>] setup_arch+0x198/0x534
> [    0.000000] [<ffff000008b30848>] start_kernel+0x70/0x388
> [    0.000000] [<ffff000008b301bc>] __primary_switched+0x30/0x74

The trace shows that it's not SPCR.  It's in paging_init() call that is
next to acpi_boot_table_init() in
/home/amakarov/work/linux/arch/arm64/kernel/setup.c where SPCR is
initialized.

Thank you
Aleksey Makarov

> [    0.000000] Code: cb150035 92403ea5 cb010056 b4000045 (d4210000)
> [    0.000000] ---[ end trace cb88537fdc8fa200 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
> the idle task!
