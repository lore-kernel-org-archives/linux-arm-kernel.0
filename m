From: robherring2@gmail.com (Rob Herring)
Date: Fri, 21 Oct 2011 13:03:01 -0500
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <20111021151511.GK30168@mudshark.cambridge.arm.com>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<20111017082506.GC21648@n2100.arm.linux.org.uk>
	<20111017092342.GB2459@mudshark.cambridge.arm.com>
	<201110201657.51810.arnd@arndb.de>
	<20111021105941.GE30168@mudshark.cambridge.arm.com>
	<4EA18638.6020809@gmail.com>
	<20111021151511.GK30168@mudshark.cambridge.arm.com>
Message-ID: <4EA1B3D5.9070802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2011 10:15 AM, Will Deacon wrote:
> Hi Rob,
> 
> On Fri, Oct 21, 2011 at 03:48:24PM +0100, Rob Herring wrote:
>> On 10/21/2011 05:59 AM, Will Deacon wrote:
>>> 2. The GIC is hosed on versatile express. Reverting e3f14d3 ("ARM: gic: add
>>>    OF based initialization") and 2071a2a4 ("ARM: gic: add irq_domain support")
>>>    allows me to boot again.
>>>
>>
>> I'll take a look at it today. Do you have more details or a boot log?
> 
> I'm afraid I'm frantically trying to get things sorted for Prague, so I haven't
> had a chance to dig further on this. Here's the boot log:
> 
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 3.1.0-rc9+ (will at mudshark) (gcc version 4.5.2 (Ubuntu/Linaro 4.5.2-8ubuntu3) ) #2 SMP PREEMPT Fri Oct 21 10:55:23 BST 2011
> [    0.000000] CPU: ARMv7 Processor [410fc091] revision 1 (ARMv7), cr=10c5387f
> [    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] Machine: ARM-Versatile Express
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Memory policy: ECC disabled, Data cache writealloc
> [    0.000000] On node 0 totalpages: 262144
> [    0.000000] free_area_init_node: node 0, pgdat c04035e0, node_mem_map c0421000
> [    0.000000]   Normal zone: 1728 pages used for memmap
> [    0.000000]   Normal zone: 0 pages reserved
> [    0.000000]   Normal zone: 194880 pages, LIFO batch:31
> [    0.000000]   HighMem zone: 576 pages used for memmap
> [    0.000000]   HighMem zone: 64960 pages, LIFO batch:15
> [    0.000000] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
> [    0.000000] PERCPU: Embedded 7 pages/cpu @c0d29000 s5664 r8192 d14816 u32768
> [    0.000000] pcpu-alloc: s5664 r8192 d14816 u32768 alloc=8*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 259840
> [    0.000000] Kernel command line: root=/dev/nfs ip=dhcp console=ttyAMA0 nfsroot=10.1.79.58:/exports/linaro-11.09,tcp rw debug user_debug=31 earlyprintk mem=1G
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Memory: 1024MB = 1024MB total
> [    0.000000] Memory: 1034180k/1034180k available, 14396k reserved, 262144K highmem
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
> [    0.000000]     vmalloc : 0xf0800000 - 0xf8000000   ( 120 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc03c2250   (3817 kB)
> [    0.000000]       .init : 0xc03c3000 - 0xc03e7620   ( 146 kB)
> [    0.000000]       .data : 0xc03e8000 - 0xc04040e0   ( 113 kB)
> [    0.000000]        .bss : 0xc0404104 - 0xc04205f4   ( 114 kB)
> [    0.000000] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000] NR_IRQS:128 nr_irqs:128 128

It is working for me. You're booting with sparse irq. ARM's support of
sparse irq is essentially broken. It does not sparsely allocate
irq_descs, but allocates all nr_irqs irq_descs.

The following patch fixes things and is more in line with other arch's
implementations of arch_probe_nr_irqs. I need to fix mnp platforms
still. Any platform that enables sparse irq needs to either set
machine_desc->nr_irqs or properly call irq_alloc_descs.

Rob

From: Rob Herring <rob.herring@calxeda.com>
Date: Tue, 13 Sep 2011 15:08:37 -0500
Subject: [PATCH] ARM: fix sparse irq pre-allocations

Returning NR_IRQS in arch_probe_nr_irqs makes SPARSE_IRQ behave the same as
!SPARSE_IRQ in that NR_IRQ irqdescs are allocated. There is some advantage
that NR_IRQ is run-time vs. compile time, but sparse irq is crippled on
ARM. With irqdomains, each interrupt controller should allocate the
irqdescs that it needs.

If machine_desc->nr_irqs is set, then the irqdescs will be pre-allocated.
If the default NR_IRQS is used then no irqdescs will be pre-allocated.

Perhaps 0-16 should be reserved for IPIs on SMP?

There are 3 users of SPARSE_IRQ: pxa, mnp, and shmobile. shmobile is the
only platform that correctly allocates irqdescs. This commit will break
mnp platforms which don't set nr_irqs.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/kernel/irq.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index de3dcab..b32f438 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -133,8 +133,11 @@ void __init init_IRQ(void)
 #ifdef CONFIG_SPARSE_IRQ
 int __init arch_probe_nr_irqs(void)
 {
-	nr_irqs = machine_desc->nr_irqs ? machine_desc->nr_irqs : NR_IRQS;
-	return nr_irqs;
+	if (machine_desc->nr_irqs) {
+		nr_irqs = machine_desc->nr_irqs;
+		return nr_irqs;
+	}
+	return 0;
 }
 #endif

-- 
1.7.5.4
