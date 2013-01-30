From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 30 Jan 2013 16:40:50 +0000
Subject: Commit 384a290283fde63ba8dc671fca5420111cdac19a seems to break
 11MPCore boot
In-Reply-To: <20130130160405.GC20593@e102568-lin.cambridge.arm.com>
References: <51093B0B.7010708@arm.com>
 <20130130160405.GC20593@e102568-lin.cambridge.arm.com>
Message-ID: <51094D12.60304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,


On 30/01/13 16:04, Lorenzo Pieralisi wrote:
> On Wed, Jan 30, 2013 at 03:23:55PM +0000, Punit Agrawal wrote:
>> Hi Nicolas,
>>
>> I was trying to boot 3.8-rc5 on Realview EB 11MPCore using realview-smp_defconfig as a starting point but the kernel failed to progress past the log below (config attached).
>>
>> Pawel suggested I try reverting 384a290283fde63ba8dc671fca5420111cdac19a - "ARM: gic: use a private mapping for CPU target interfaces" that you've authored. With this commit reverted the kernel boots.
>>
>> I am not quite sure why the commit breaks 11MPCore but Pawel (cc'd) might be able to shed light on that.
>
> I *think* it is because in the ARM11MPcore GIC
>
> dist_base + GIC_DIST_TARGET
>
> is RAZ for IT0-IT28. To give it a go you should change code in
>
> gic_cpu_init()
>
> and read (GIC_DIST_TARGET + 0x1c) (where IT29 starts)
>
> if I am not mistaken, since that will return the GIC CPU IF ID of the
> reading CPU.

With the following changes the kernel boots up further -

$ git diff
diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 36ae03a..68f6368 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -400,8 +400,11 @@ static void __cpuinit gic_cpu_init(struct
gic_chip_data *gic)
          * Get what the GIC says our CPU mask is.
          */
         BUG_ON(cpu >= NR_GIC_CPU_IF);
-   cpu_mask = readl_relaxed(dist_base + GIC_DIST_TARGET + 0);
+ cpu_mask = readl_relaxed(dist_base + GIC_DIST_TARGET + 0x1c);
+ cpu_mask = (cpu_mask & 0xff00) >> 8;
+
         gic_cpu_map[cpu] = cpu_mask;
+ printk(KERN_INFO "cpu: %d, cpu_mask: 0x%08x\n", cpu, cpu_mask);

         /*
          * Clear our mask from the other map entries in case they're

But doesn't go all the way to init.

Bytes transferred = 2350832 (23def0 hex)
## Booting kernel from Legacy Image at 00007fc0 ...
    Image Name:   Linux-3.8.0-rc5-dirty
    Image Type:   ARM Linux Kernel Image (uncompressed)
    Data Size:    2350768 Bytes =  2.2 MB
    Load Address: 00008000
    Entry Point:  00008000
    Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 3.8.0-rc5-dirty (punagr01 at e102309-lin) (gcc version 4.6.3
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #34 SMP Wed Jan 30 16:28:02 GMT 2013
CPU: ARMv6-compatible processor [410fb020] revision 0 (ARMv7), cr=00c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: ARM-RealView EB
Ignoring unrecognised tag 0x00000000
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writealloc
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
PERCPU: Embedded 8 pages/cpu @c070b000 s9920 r8192 d14656 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=/dev/nfs ip=dhcp console=ttyAMA0
nfsroot=10.1.193.144:/work/filesystems/11MPCore earlyprintk
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
__ex_table already sorted, skipping sort
Memory: 256MB = 256MB total
Memory: 254596k/254596k available, 7548k reserved, 0K highmem
Virtual kernel memory layout:
     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
     vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
     modules : 0xbf000000 - 0xc0000000   (  16 MB)
       .text : 0xc0008000 - 0xc0457d78   (4416 kB)
       .init : 0xc0458000 - 0xc048d6c0   ( 214 kB)
       .data : 0xc048e000 - 0xc04c8db0   ( 236 kB)
        .bss : 0xc04c8db0 - 0xc05076e8   ( 251 kB)
Hierarchical RCU implementation.
NR_IRQS:128
cpu: 0, cpu_mask: 0x00000001
------------[ cut here ]------------
WARNING: at arch/arm/common/gic.c:741 gic_init_bases+0x118/0x2ac()
Cannot allocate irq_descs @ IRQ96, assuming pre-allocated
Modules linked in:
[<c0015fd8>] (unwind_backtrace+0x0/0xfc) from [<c0327b44>]
(dump_stack+0x20/0x24)
[<c0327b44>] (dump_stack+0x20/0x24) from [<c001fe44>]
(warn_slowpath_common+0x5c/0x74)
[<c001fe44>] (warn_slowpath_common+0x5c/0x74) from [<c001ff18>]
(warn_slowpath_fmt+0x40/0x48)
[<c001ff18>] (warn_slowpath_fmt+0x40/0x48) from [<c045cfe0>]
(gic_init_bases+0x118/0x2ac)
[<c045cfe0>] (gic_init_bases+0x118/0x2ac) from [<c045d710>]
(gic_init_irq+0x78/0xc4)
[<c045d710>] (gic_init_irq+0x78/0xc4) from [<c04595dc>] (init_IRQ+0x1c/0x24)
[<c04595dc>] (init_IRQ+0x1c/0x24) from [<c045871c>]
(start_kernel+0x198/0x29c)
[<c045871c>] (start_kernel+0x198/0x29c) from [<00008078>] (0x8078)
---[ end trace 1b75b31a2719ed1c ]---
------------[ cut here ]------------
WARNING: at kernel/irq/irqdomain.c:234 irq_domain_add_legacy+0x84/0x144()
Modules linked in:
[<c0015fd8>] (unwind_backtrace+0x0/0xfc) from [<c0327b44>]
(dump_stack+0x20/0x24)
[<c0327b44>] (dump_stack+0x20/0x24) from [<c001fe44>]
(warn_slowpath_common+0x5c/0x74)
[<c001fe44>] (warn_slowpath_common+0x5c/0x74) from [<c001fe88>]
(warn_slowpath_null+0x2c/0x34)
[<c001fe88>] (warn_slowpath_null+0x2c/0x34) from [<c00757a4>]
(irq_domain_add_legacy+0x84/0x144)
[<c00757a4>] (irq_domain_add_legacy+0x84/0x144) from [<c045d000>]
(gic_init_bases+0x138/0x2ac)
[<c045d000>] (gic_init_bases+0x138/0x2ac) from [<c045d710>]
(gic_init_irq+0x78/0xc4)
[<c045d710>] (gic_init_irq+0x78/0xc4) from [<c04595dc>] (init_IRQ+0x1c/0x24)
[<c04595dc>] (init_IRQ+0x1c/0x24) from [<c045871c>]
(start_kernel+0x198/0x29c)
[<c045871c>] (start_kernel+0x198/0x29c) from [<00008078>] (0x8078)
---[ end trace 1b75b31a2719ed1d ]---
------------[ cut here ]------------
WARNING: at arch/arm/common/gic.c:746 gic_init_bases+0x150/0x2ac()
Modules linked in:
[<c0015fd8>] (unwind_backtrace+0x0/0xfc) from [<c0327b44>]
(dump_stack+0x20/0x24)
[<c0327b44>] (dump_stack+0x20/0x24) from [<c001fe44>]
(warn_slowpath_common+0x5c/0x74)
[<c001fe44>] (warn_slowpath_common+0x5c/0x74) from [<c001fe88>]
(warn_slowpath_null+0x2c/0x34)
[<c001fe88>] (warn_slowpath_null+0x2c/0x34) from [<c045d018>]
(gic_init_bases+0x150/0x2ac)
[<c045d018>] (gic_init_bases+0x150/0x2ac) from [<c045d710>]
(gic_init_irq+0x78/0xc4)
[<c045d710>] (gic_init_irq+0x78/0xc4) from [<c04595dc>] (init_IRQ+0x1c/0x24)
[<c04595dc>] (init_IRQ+0x1c/0x24) from [<c045871c>]
(start_kernel+0x198/0x29c)
[<c045871c>] (start_kernel+0x198/0x29c) from [<00008078>] (0x8078)
---[ end trace 1b75b31a2719ed1e ]---
Console: colour dummy device 80x30
Calibrating delay loop... 80.69 BogoMIPS (lpj=403456)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
ftrace: allocating 12715 entries in 38 pages
smp_twd: clock not found: -2
Calibrating local timer... 104.75MHz.
Setting up static identity map for 0x32d900 - 0x32d95c
CPU1: Booted secondary processor
cpu: 1, cpu_mask: 0x00000002
CPU2: Booted secondary processor
cpu: 2, cpu_mask: 0x00000004
CPU3: Booted secondary processor
cpu: 3, cpu_mask: 0x00000008
Brought up 4 CPUs
SMP: Total of 4 processors activated (330.75 BogoMIPS).
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
L2x0 series cache controller enabled
l2x0: 8 ways, CACHE_ID 0x00000080, AUX_CTRL 0x00790fff, Cache size:
1048576 B
Serial: AMBA PL011 UART driver
dev:uart0: ttyAMA0 at MMIO 0x10009000 (irq = 36) is a PL011 rev2
console [ttyAMA0] enabled, bootconsole disabled
console [ttyAMA0] enabled, bootconsole disabled
dev:uart1: ttyAMA1 at MMIO 0x1000a000 (irq = 37) is a PL011 rev2
dev:uart2: ttyAMA2 at MMIO 0x1000b000 (irq = 0) is a PL011 rev2
fpga:uart3: ttyAMA3 at MMIO 0x1000c000 (irq = 0) is a PL011 rev2
bio: create slab <bio-0> at 0
ssp-pl022 dev:ssp0: ARM PL022 driver, device ID: 0x00041022
pl022: mapped registers from 0x1000d000 to d0876000
ssp-pl022 dev:ssp0: probe - cannot get IRQ (-22)
ssp-pl022: probe of dev:ssp0 failed with error -22
Advanced Linux Sound Architecture Driver Initialized.
Switching to clocksource timer3
NET: Registered protocol family 2
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP: reno registered
UDP hash table entries: 256 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
msgmni has been set to 497
io scheduler noop registered
io scheduler deadline registered (default)
clcd-pl11x dev:clcd: PL111 rev0 at 0x10020000


>
> Just guessing, hope it helps,
>
> Lorenzo
>
>>
>> I'd be happy to test a fix as I have the board on my desk for a bit.
>>
>> Thanks,
>>
>> Punit

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
