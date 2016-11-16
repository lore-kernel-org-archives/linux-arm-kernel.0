From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 16 Nov 2016 14:10:02 -0800
Subject: Boot failures in -next due to 'ARM: dts: imx: Remove
 skeleton.dtsi'
In-Reply-To: <20161116184649.GF11228@leverpostej>
References: <cda2df55-f2f3-00d6-c6b1-816ed47bbf56@roeck-us.net>
 <20161116184649.GF11228@leverpostej>
Message-ID: <20161116221002.GA19925@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 06:46:50PM +0000, Mark Rutland wrote:
> On Wed, Nov 16, 2016 at 09:45:35AM -0800, Guenter Roeck wrote:
> > Hi,
> 
> Hi,
> 
> > my 'sabrelite' and 'imx25-pdk' qemu boot tests are failing in linux-next.
> > 
> > Bisect for the sabrelite failure points to commit 'ARM: dts: imx: Remove skeleton.dtsi'.
> > 
> > Bisect log is attached. Complete test logs are at
> > http://kerneltests.org/builders/qemu-arm-next/builds/571/steps/qemubuildcommand/logs/stdio
> > 
> > Boot log for imx25-pdk:
> > 
> > qemu-system-arm: findnode_nofail Couldn't find node /chosen: FDT_ERR_NOTFOUND
> 
> So this implies we no longer have a /chosen node. We should add one to
> the relevant dts{i,} files, with stdout-path and so on.
> 
> > Boot log for sabrelite:
> > 
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Linux version 4.9.0-rc5-next-20161116 (groeck at jupiter.roeck-us.net) (gcc version 4.9.2 (GCC) ) #1 SMP Tue Nov 15 22:34:35 PST 2016
> > [    0.000000] CPU: ARMv7 Processor [410fc090] revision 0 (ARMv7), cr=10c5387d
> > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> > [    0.000000] OF: fdt:Machine model: Freescale i.MX6 DualLite SABRE Lite Board
> > [    0.000000] earlycon: ec_imx21 at MMIO 0x021e8000 (options '')
> > [    0.000000] bootconsole [ec_imx21] enabled
> > [    0.000000] INITRD: 0x14000000+0x00501600 is not a memory region - disabling initrd
> > [    0.000000] cma: Failed to reserve 64 MiB
> > [    0.000000] Memory policy: Data cache writeback
> > 
> > [ stuck here until aborted ]
> 
> The last message was from build_mem_types_table(), called from
> paging_init(). We'll head on to unflatten_device_tree() shortly
> afterwards.
> 
> I wonder if the DTB is corrupted somehow in this case. Maybe the initrd
> and cma failures is due to unparseable memory nodes.
> 
This appears to be quite messed up. There should be an initrd.
Here is the log with memblock=debug.

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.0-rc5-next-20161116 (groeck at server.roeck-us.net) (gcc version 4.9.2 (GCC) ) #1 SMP Wed Nov 16 13:05:32 PST 2016
[    0.000000] CPU: ARMv7 Processor [410fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] OF: fdt:Machine model: Freescale i.MX6 DualLite SABRE Lite Board
[    0.000000] earlycon: ec_imx21 at MMIO 0x021e8000 (options '')
[    0.000000] bootconsole [ec_imx21] enabled
[    0.000000] memblock_reserve: [0x00000010100000-0x00000011680737] flags 0x0 arm_memblock_init+0x28/0x190
[    0.000000] INITRD: 0x14000000+0x00501600 is not a memory region - disabling initrd
[    0.000000] memblock_reserve: [0x00000010004000-0x00000010007fff] flags 0x0 arm_mm_memblock_reserve+0x1c/0x24
[    0.000000] memblock_reserve: [0x00000014502000-0x0000001451885b] flags 0x0 early_init_dt_reserve_memory_arch+0x20/0x24
[    0.000000] cma: Failed to reserve 64 MiB
[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x0 reserved size = 0x159af94
[    0.000000]  memory.cnt  = 0x1
[    0.000000]  memory[0x0]	[0x00000000000000-0xffffffffffffffff], 0x0 bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0x3
[    0.000000]  reserved[0x0]	[0x00000010004000-0x00000010007fff], 0x4000 bytes flags: 0x0
[    0.000000]  reserved[0x1]	[0x00000010100000-0x00000011680737], 0x1580738 bytes flags: 0x0
[    0.000000]  reserved[0x2]	[0x00000014502000-0x0000001451885b], 0x1685c bytes flags: 0x0
[    0.000000] Memory policy: Data cache writeback

Memory size is obviously a bit on the high side.

Here is the log after reverting the 'offenting' patch:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.0-rc5-next-20161116-00001-g3e6c6cb5519b (groeck at server.roeck-us.net) (gcc version 4.9.2 (GCC) ) #1 SMP Wed Nov 16 13:14:07 PST 2016
[    0.000000] CPU: ARMv7 Processor [410fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
[    0.000000] OF: fdt:Machine model: Freescale i.MX6 DualLite SABRE Lite Board
[    0.000000] earlycon: ec_imx21 at MMIO 0x021e8000 (options '')
[    0.000000] bootconsole [ec_imx21] enabled
[    0.000000] memblock_reserve: [0x00000010100000-0x00000011680737] flags 0x0 arm_memblock_init+0x28/0x190
[    0.000000] memblock_reserve: [0x00000014000000-0x000000145015ff] flags 0x0 arm_memblock_init+0x108/0x190
[    0.000000] memblock_reserve: [0x00000010004000-0x00000010007fff] flags 0x0 arm_mm_memblock_reserve+0x1c/0x24
[    0.000000] memblock_reserve: [0x00000014502000-0x00000014518883] flags 0x0 early_init_dt_reserve_memory_arch+0x20/0x24
[    0.000000] cma: Failed to reserve 64 MiB
[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x8000000 reserved size = 0x1a9c5bc
[    0.000000]  memory.cnt  = 0x1
[    0.000000]  memory[0x0]	[0x00000010000000-0x00000017ffffff], 0x8000000 bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0x4
[    0.000000]  reserved[0x0]	[0x00000010004000-0x00000010007fff], 0x4000 bytes flags: 0x0
[    0.000000]  reserved[0x1]	[0x00000010100000-0x00000011680737], 0x1580738 bytes flags: 0x0
[    0.000000]  reserved[0x2]	[0x00000014000000-0x000000145015ff], 0x501600 bytes flags: 0x0
[    0.000000]  reserved[0x3]	[0x00000014502000-0x00000014518883], 0x16884 bytes flags: 0x0

Turns out cma allocation fails because the qemu default memory size for
sabrelite is 128MB, which isn't enough, or not enough anymore. That doesn't
seem to matter, though, as the boot succeeds without it (but only if I _don't_
set memblock=debug on the command line) 

Anyway, I guess the problem is that the "official" dtb files no longer provide
the skeleton /chosen and /memory nodes (and maybe others), and qemu seems to
expect that they are provided. Is that correct ?

Thanks,
Guenter
