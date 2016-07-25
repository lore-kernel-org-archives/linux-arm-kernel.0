From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 25 Jul 2016 14:27:55 +0900
Subject: [PATCH v22 2/8] arm64: limit memory regions based on DT
 property, usable-memory-range
In-Reply-To: <579225B6.3090209@arm.com>
References: <20160712050514.22307-1-takahiro.akashi@linaro.org>
 <20160712050514.22307-3-takahiro.akashi@linaro.org>
 <578D1A31.5080509@arm.com> <20160721005756.GN20774@linaro.org>
 <579225B6.3090209@arm.com>
Message-ID: <20160725052754.GA8855@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

James,

On Fri, Jul 22, 2016 at 02:55:02PM +0100, James Morse wrote:
> Hi,
> 
> On 21/07/16 01:57, AKASHI Takahiro wrote:
> > Could you please apply the diff attached below and confirm that
> > kdump works in your environment?
> > I can't test it by myself since my hikey board seems to be broken now.
> 
> With this I get a failure even earlier, even with 'acpi=off'.
> With this patch, on boot of the kdump kernel I get:

I think you ran into the problem that I mentioned in:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/444500.html

You may want to
- apply the change stated above, or
  (Given that we don't know about the configuration of crash dump kernel,
  checking for CONFIG_ZONE_DMA doesn't make sense. Instead, we'd better
  always enforce ARCH_LOW_ADDRESS_LIMIT.)
- explicitly specify the start address (Y) below ARCH_LOW_ADDRESS_LIMIT
  at "crashkernel=X at Y"
Either would work.

Thanks,
-Takahiro AKASHI

> [    0.000000] Linux version 4.7.0-rc4+ (morse at melchizedek) (gcc version 5.2.1 6
> [    0.000000] Boot CPU: AArch64 Processor [411fd071]
> [    0.000000] earlycon: pl11 at MMIO 0x000000007ff80000 (options '')
> [    0.000000] bootconsole [pl11] enabled
> [    0.000000] debug: ignoring loglevel setting.
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: EFI v2.50 by ARM Juno EFI Nov 24 2015 12:36:35
> [    0.000000] efi:  ACPI=0xf95b0000  ACPI 2.0=0xf95b0014  PROP=0xfe8db4d8
> [    0.000000] Reserving 1KB of memory at 0x9fffff000 for elfcorehdr
> [    0.000000] cma: Failed to reserve 16 MiB
> [    0.000000] On node 0 totalpages: 132160
> [    0.000000]   DMA zone: 17 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 1088 pages, LIFO batch:0
> [    0.000000]   Normal zone: 2048 pages used for memmap
> [    0.000000]   Normal zone: 131072 pages, LIFO batch:31
> [    0.000000] bootmem alloc of 64 bytes failed!
> [    0.000000] Kernel panic - not syncing: Out of memory
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.7.0-rc4+ #4600
> [    0.000000] Hardware name: ARM Juno development board (r1) (DT)
> [    0.000000] Call trace:
> [    0.000000] [<ffff0000080889a8>] dump_backtrace+0x0/0x1e8
> [    0.000000] [<ffff000008088ba4>] show_stack+0x14/0x20
> [    0.000000] [<ffff000008363274>] dump_stack+0x94/0xb8
> [    0.000000] [<ffff00000816192c>] panic+0x10c/0x278
> [    0.000000] [<ffff000008b14980>] free_bootmem_late+0x0/0xa0
> [    0.000000] [<ffff000008b14e68>] __alloc_bootmem_low+0x2c/0x38
> [    0.000000] [<ffff000008b02954>] setup_arch+0x2e4/0x5ac
> [    0.000000] [<ffff000008b00854>] start_kernel+0x70/0x390
> [    0.000000] [<ffff000008b001bc>] __primary_switched+0x30/0x6c
> [    0.000000] ---[ end Kernel panic - not syncing: Out of memory
> 
> 
> Trying again, booted with:
> > console=ttyAMA0,115200 earlycon=pl011,0x7ff80000 root=/dev/nfs
> > nfsroot=10.X.X.X:/ubuntu-15.04-server-arm64,v3 resume=/dev/sda2 no_console_suspend
> > ip=dhcp rw crashkernel=512M stacktrace ignore_loglevel=1 acpi=off efi=debug
> memblock=debug
> 
> kexec-tools invoked as:
> > kexec -x --reuse-cmdline --dtb=/sys/firmware/fdt -p /aarch64-Image
> 
> cat /proc/iomem | grep Crash:
> > 9e0000000-9ffffffff : Crash kernel
> 
> crash kernel memblock before call to memblock_cap_memory_range():
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0x1fef10000 reserved size = 0x4f3b
> [    0.000000]  memory.cnt  = 0x9
> [    0.000000]  memory[0x0]     [0x00000080000000-0x000000dfffffff], 0x60000000
> bytes flags: 0x0
> [    0.000000]  memory[0x1]     [0x000000e00f0000-0x000000f949ffff], 0x193b0000
> bytes flags: 0x0
> (uefi runtime code|data|acpi:)
> [    0.000000]  memory[0x2]     [0x000000f94a0000-0x000000f984ffff], 0x3b0000
> bytes flags: 0x4
> [    0.000000]  memory[0x3]     [0x000000f9850000-0x000000fe81ffff], 0x4fd0000
> bytes flags: 0x0
> (uefi runtime data:)
> [    0.000000]  memory[0x4]     [0x000000fe820000-0x000000fe85ffff], 0x40000
> bytes flags: 0x4
> [    0.000000]  memory[0x5]     [0x000000fe860000-0x000000fe86ffff], 0x10000
> bytes flags: 0x0
> (uefi runtime data:)
> [    0.000000]  memory[0x6]     [0x000000fe870000-0x000000fe8bffff], 0x50000
> bytes flags: 0x4
> [    0.000000]  memory[0x7]     [0x000000fe8c0000-0x000000feffffff], 0x740000
> bytes flags: 0x0
> [    0.000000]  memory[0x8]     [0x00000880000000-0x000009ffffffff], 0x180000000
> bytes flags: 0x0
> [    0.000000]  reserved.cnt  = 0x2
> (uefi memory map:)
> [    0.000000]  reserved[0x0]   [0x000000f985a000-0x000000f985afff], 0x1000
> bytes flags: 0x0
> (device tree:)
> [    0.000000]  reserved[0x1]   [0x000009e0ce0000-0x000009e0ce3f3a], 0x3f3b
> bytes flags: 0x0
> 
> crash kernel memblock after call to memblock_cap_memory_range():
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0x20440000 reserved size = 0x3f3b
> [    0.000000]  memory.cnt  = 0x4
> [    0.000000]  memory[0x0]     [0x000000f94a0000-0x000000f984ffff], 0x3b0000
> bytes flags: 0x4
> [    0.000000]  memory[0x1]     [0x000000fe820000-0x000000fe85ffff], 0x40000
> bytes flags: 0x4
> [    0.000000]  memory[0x2]     [0x000000fe870000-0x000000fe8bffff], 0x50000
> bytes flags: 0x4
> [    0.000000]  memory[0x3]     [0x000009e0000000-0x000009ffffffff], 0x20000000
> bytes flags: 0x0
> [    0.000000]  reserved.cnt  = 0x1
> [    0.000000]  reserved[0x0]   [0x000009e0ce0000-0x000009e0ce3f3a], 0x3f3b
> bytes flags: 0x0
> (reserve kernel text:)
> [    0.000000] memblock_reserve: [0x000009e0080000-0x000009e0cd0fff] flags 0x0
> arm64_memblock_init+0x1e0/0x40c
> (reserve elfcorehdr:)
> [    0.000000] memblock_reserve: [0x000009fffff000-0x000009fffff3ff] flags 0x0
> arm64_memblock_init+0x37c/0x40c
> [    0.000000] Reserving 1KB of memory at 0x9fffff000 for elfcorehdr
> [    0.000000] cma: Failed to reserve 16 MiB
> ...
> 
> It looks like memblock_cap_memory_range() did exactly what you intended
> 
> This first fault seems to be because memblock_start_of_DRAM() is being dragged
> down by the preserved nomap areas, this means there isn't any usable memory
> within ~4G of memblock_start_of_DRAM()...
> 
> I will dig into the bootmem alloc failure next week...
> 
> (let me know if you want the full boot logs... they are more noise than signal)
> 
> 
> Thanks,
> 
> James
> 
> 
> 
> 
