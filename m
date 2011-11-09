From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 9 Nov 2011 17:04:47 +0530
Subject: [PATCHv4 07/13] ARM: s3c64xx: convert to MULTI_IRQ_HANDLER
In-Reply-To: <CAJuYYwRPoFDUhtcVLT_rj4c9whJWVXyQ7tcaK3O_G3X9SYf-cw@mail.gmail.com>
References: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
 <1320369010-23428-8-git-send-email-jamie@jamieiles.com>
 <CAJuYYwRPoFDUhtcVLT_rj4c9whJWVXyQ7tcaK3O_G3X9SYf-cw@mail.gmail.com>
Message-ID: <CAJuYYwR=Y1WfpT+1ESm82cry+41AwGZR5HJqHpnx70ey=1hGew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

On 9 November 2011 16:55, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> Hi Jamie,
>
> On 4 November 2011 06:40, Jamie Iles <jamie@jamieiles.com> wrote:
>> Now that there is a generic IRQ handler for multiple VIC devices use it
>> for s3c64xx to help building multi platform kernels.
>>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
>> ---
>> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-s3c64xx/include/mach/entry-macro.S | ? ?7 ++++---
>> ?arch/arm/mach-s3c64xx/mach-anw6410.c ? ? ? ? ? ? | ? ?2 ++
>> ?arch/arm/mach-s3c64xx/mach-crag6410.c ? ? ? ? ? ?| ? ?2 ++
>> ?arch/arm/mach-s3c64xx/mach-hmt.c ? ? ? ? ? ? ? ? | ? ?2 ++
>> ?arch/arm/mach-s3c64xx/mach-mini6410.c ? ? ? ? ? ?| ? ?2 ++
>> ?arch/arm/mach-s3c64xx/mach-ncp.c ? ? ? ? ? ? ? ? | ? ?2 ++
>> ?arch/arm/mach-s3c64xx/mach-real6410.c ? ? ? ? ? ?| ? ?2 ++
>> ?arch/arm/mach-s3c64xx/mach-smartq5.c ? ? ? ? ? ? | ? ?2 ++
>> ?arch/arm/mach-s3c64xx/mach-smartq7.c ? ? ? ? ? ? | ? ?2 ++
>> ?arch/arm/mach-s3c64xx/mach-smdk6400.c ? ? ? ? ? ?| ? ?2 ++
>> ?arch/arm/mach-s3c64xx/mach-smdk6410.c ? ? ? ? ? ?| ? ?2 ++
>> ?12 files changed, 25 insertions(+), 3 deletions(-)
>>
>
> I have tested this patch series on smdk6410 board (s3c64xx) using the
> following repositorty and branch
>
> https://github.com/jamieiles/linux-2.6-ji.git ?branch: vic-dt
>
> There is a crash while booting. Am I using the right tree and branch?
> The following is the boot log. Is there any other config option to be
> enabled?
>
> By hard resetting to commit id
> 'f7bf800e2c0c2947e9b5839f7d2702a36ddfb71a' (ARM: omap2plus: convert to
> CONFIG_MULTI_IRQ_HANDLER), the board boots up fine.

There is similar issue on smdkv210 (s5pv210) board as well.

Thanks,
Thomas.

>
> Thanks,
> Thomas.
>
>
> U-Boot 1.3.4-00009-g9da84bd (Jun ?8 2010 - 09:46:01) for SMDK6410
>
>
> CPU: ? ? S3C6410 at 532MHz
> ? ? ? ? Fclk = 532MHz, Hclk = 133MHz, Pclk = 66MHz, Serial = CLKUART
> (SYNC Mode)
> Board: ? SMDK6410
> DRAM: ? ?128 MB
> Flash: ? 0 kB
> SD/MMC: ?SD/MMC channel0 is selected for booting device.
> 1886MB
> NAND: ? ?0 MB
> do not support this address : 57e7c008
> In: ? ? ?serial
> Out: ? ? serial
> Err: ? ? serial
> Net: ? ? smc911x
> Hit any key to stop autoboot: ?0
> SMDK6410 #
> SMDK6410 #
> SMDK6410 #
> SMDK6410 # setenv bootargs; setenv serverip 192.168.0.1; tftp 51000000
> small_root_v3.6.cramfs; tftp 50008000 zImage; bootm
> smc911x: initializing
> smc911x: detected LAN9115 controller
> smc911x: phy initialized
> smc911x: MAC 00:40:5c:26:0a:5b
> Using smc911x device
> TFTP from server 192.168.0.1; our IP address is 192.168.0.20
> Filename 'small_root_v3.6.cramfs'.
> Load address: 0x51000000
> Loading: T #################################################################
> ? ? ? ? #################################################################
> ? ? ? ? ################################################################
> done
> Bytes transferred = 2842624 (0x2b6000)
> smc911x: initializing
> smc911x: detected LAN9115 controller
> smc911x: phy initialized
> smc911x: MAC 00:40:5c:26:0a:5b
> Using smc911x device
> TFTP from server 192.168.0.1; our IP address is 192.168.0.20
> Filename 'zImage'.
> Load address: 0x50008000
> Loading: T #################################################################
> ? ? ? ? ########################################
> done
> Bytes transferred = 1534176 (0x1768e0)
> Boot with zImage
> do not support this address : 50008000
>
> Starting kernel ...
>
> Uncompressing Linux... done, booting the kernel.
> <5>Linux version 3.2.0-rc1-00031-gcbd9857-dirty
> (thomas at localhost.localdomain) (gcc version 4.4.1 (Sourcery G++ Lite
> 2009q3-67) ) #7 Wed Nov 9 16:35:12 IST 2011
> CPU: ARMv6-compatible processor [410fb766] revision 6 (ARMv7), cr=00c5387f
> CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> Machine: SMDK6410
> <4>Ignoring unrecognised tag 0x41001099
> Memory policy: ECC disabled, Data cache writeback
> CPU S3C6410 (id 0x36410100)
> <7>s3c6410_init_clocks: initialising clocks
> <6>S3C24XX Clocks, Copyright 2004 Simtec Electronics
> <3>camera: no parent clock specified
> <7>s3c6400_setup_clocks: registering clocks
> <7>s3c6400_setup_clocks: clkdiv0 = 01043310
> <7>s3c6400_setup_clocks: xtal is 12000000
> <6>S3C64XX: PLL settings, A=532000000, M=532000000, E=24000000
> <6>S3C64XX: HCLK2=266000000, HCLK=133000000, PCLK=66500000
> <6>mout_apll: source is fout_apll (1), rate is 532000000
> <6>mout_epll: source is epll (1), rate is 24000000
> <6>mout_mpll: source is mpll (1), rate is 532000000
> <7>s3c64xx_clk_doutmpll_get_rate: parent is 532000000
> <6>mmc_bus: source is dout_mpll (1), rate is 24181818
> <6>mmc_bus: source is mout_epll (0), rate is 24000000
> <6>mmc_bus: source is mout_epll (0), rate is 24000000
> <6>usb-bus-host: source is clk_48m (0), rate is 48000000
> <7>s3c64xx_clk_doutmpll_get_rate: parent is 532000000
> <6>uclk1: source is dout_mpll (1), rate is 66500000
> <6>spi-bus: source is mout_epll (0), rate is 24000000
> <6>spi-bus: source is mout_epll (0), rate is 24000000
> <6>audio-bus: source is mout_epll (0), rate is 24000000
> <6>audio-bus: source is mout_epll (0), rate is 24000000
> <6>audio-bus: source is mout_epll (0), rate is 24000000
> <6>irda-bus: source is mout_epll (0), rate is 24000000
> <3>camera: no parent clock specified
> <7>On node 0 totalpages: 8192
> <7>free_area_init_node: node 0, pgdat c02ce184, node_mem_map c0300000
> <7> ?Normal zone: 64 pages used for memmap
> <7> ?Normal zone: 0 pages reserved
> <7> ?Normal zone: 8128 pages, LIFO batch:0
> <6>CPU: found DTCM0 8k @ 0c002000, enabled
> <6>CPU: moved DTCM0 8k to fffe8000, enabled
> <6>CPU: found DTCM1 8k @ 0c004000, enabled
> <6>CPU: moved DTCM1 8k to fffea000, enabled
> <6>CPU: found ITCM0 8k @ 00000000, not enabled
> <6>CPU: moved ITCM0 8k to fffe0000, enabled
> <6>CPU: found ITCM1 8k @ 00000000, not enabled
> <6>CPU: moved ITCM1 8k to fffe2000, enabled
> <7>pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
> <7>pcpu-alloc: [0] 0
> Built 1 zonelists in Zone order, mobility grouping on. ?Total pages: 8128
> <5>Kernel command line: root=/dev/ram0 rw ramdisk=8192
> initrd=0x51000000,8M console=ttySAC0,115200 init=/linuxrc mem=32M
> <6>PID hash table entries: 128 (order: -3, 512 bytes)
> <6>Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
> <6>Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
> <6>Memory: 32MB = 32MB total
> <5>Memory: 21164k/21164k available, 11604k reserved, 0K highmem
> <5>Virtual kernel memory layout:
> ? ?vector ?: 0xffff0000 - 0xffff1000 ? ( ? 4 kB)
> ? ?DTCM ? ?: 0xfffe8000 - 0xfffec000 ? ( ?16 kB)
> ? ?ITCM ? ?: 0xfffe0000 - 0xfffe4000 ? ( ?16 kB)
> ? ?fixmap ?: 0xfff00000 - 0xfffe0000 ? ( 896 kB)
> ? ?vmalloc : 0xc2800000 - 0xf6000000 ? ( 824 MB)
> ? ?lowmem ?: 0xc0000000 - 0xc2000000 ? ( ?32 MB)
> ? ?modules : 0xbf000000 - 0xc0000000 ? ( ?16 MB)
> ? ? ?.text : 0xc0008000 - 0xc028c9a8 ? (2579 kB)
> ? ? ?.init : 0xc028d000 - 0xc02a9000 ? ( 112 kB)
> ? ? ?.data : 0xc02aa000 - 0xc02ce7e0 ? ( 146 kB)
> ? ? ? .bss : 0xc02cf024 - 0xc02ff68c ? ( 194 kB)
> <6>SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> <6>NR_IRQS:246
> <7>s3c64xx_init_irq: initialising interrupts
> <6>VIC @f6000000: id 0x00041192, vendor 0x41
> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
> <1>pgd = c0004000
> <1>[00000000] *pgd=00000000
> <0>Internal error: Oops: 5 [#1]
> <d>Modules linked in:
> CPU: 0 ? ?Not tainted ?(3.2.0-rc1-00031-gcbd9857-dirty #7)
> PC is at irq_domain_add+0x10/0x158
> LR is at s3c64xx_init_irq+0x2c/0x60
> pc : [<c005aa10>] ? ?lr : [<c0293660>] ? ?psr: 800001d3
> sp : c02abfa8 ?ip : ffffffff ?fp : 00000000
> r10: 502a3620 ?r9 : 410fb766 ?r8 : 50004008
> r7 : 00000000 ?r6 : 8fffffff ?r5 : ffffff7f ?r4 : c02cf284
> r3 : 00000000 ?r2 : 00000000 ?r1 : c02cf260 ?r0 : c02cf284
> Flags: Nzcv ?IRQs off ?FIQs off ?Mode SVC_32 ?ISA ARM ?Segment kernel
> Control: 00c5387f ?Table: 50004008 ?DAC: 00000017
> <0>Process swapper (pid: 0, stack limit = 0xc02aa268)
> <0>Stack: (0xc02abfa8 to 0xc02ac000)
> <0>bfa0: ? ? ? ? ? ? ? ? ? ffffffff ffffff7f 8fffffff c02ae77c 50004008 c0293660
> <0>bfc0: c02cf040 c02a4afc 8fffffff c028ff74 00000c00 c028d660 c028d2c0 00000000
> <0>bfe0: 00000000 c02a4afc 00c5387d c02ac084 c02a4af8 50008040 00000000 00000000
> [<c005aa10>] (irq_domain_add+0x10/0x158) from [<c0293660>]
> (s3c64xx_init_irq+0x2c/0x60)
> [<c0293660>] (s3c64xx_init_irq+0x2c/0x60) from [<c028ff74>] (init_IRQ+0x14/0x1c)
> [<c028ff74>] (init_IRQ+0x14/0x1c) from [<c028d660>] (start_kernel+0x15c/0x2c0)
> [<c028d660>] (start_kernel+0x15c/0x2c0) from [<50008040>] (0x50008040)
> <0>Code: e92d41f0 e1a04000 e5903014 e5907010 (e5933000)
> <4>---[ end trace 1b75b31a2719ed1c ]---
> <0>Kernel panic - not syncing: Attempted to kill the idle task!
> [<c0014978>] (unwind_backtrace+0x0/0xf4) from [<c01e9780>] (panic+0x58/0x188)
> [<c01e9780>] (panic+0x58/0x188) from [<c00297a0>] (do_exit+0x664/0x694)
> [<c00297a0>] (do_exit+0x664/0x694) from [<c0012728>] (die+0x11c/0x1d4)
> [<c0012728>] (die+0x11c/0x1d4) from [<c00161dc>] (__do_kernel_fault+0x64/0x84)
> [<c00161dc>] (__do_kernel_fault+0x64/0x84) from [<c0016340>]
> (do_page_fault+0x144/0x1e8)
> [<c0016340>] (do_page_fault+0x144/0x1e8) from [<c00084a0>]
> (do_DataAbort+0x34/0x98)
> [<c00084a0>] (do_DataAbort+0x34/0x98) from [<c000e6f8>] (__dabt_svc+0x38/0x60)
> Exception stack(0xc02abf60 to 0xc02abfa8)
> bf60: c02cf284 c02cf260 00000000 00000000 c02cf284 ffffff7f 8fffffff 00000000
> bf80: 50004008 410fb766 502a3620 00000000 ffffffff c02abfa8 c0293660 c005aa10
> bfa0: 800001d3 ffffffff
> [<c000e6f8>] (__dabt_svc+0x38/0x60) from [<c005aa10>]
> (irq_domain_add+0x10/0x158)
> [<c005aa10>] (irq_domain_add+0x10/0x158) from [<c0293660>]
> (s3c64xx_init_irq+0x2c/0x60)
> [<c0293660>] (s3c64xx_init_irq+0x2c/0x60) from [<c028ff74>] (init_IRQ+0x14/0x1c)
> [<c028ff74>] (init_IRQ+0x14/0x1c) from [<c028d660>] (start_kernel+0x15c/0x2c0)
> [<c028d660>] (start_kernel+0x15c/0x2c0) from [<50008040>] (0x50008040)
>
>
> [...]
>
