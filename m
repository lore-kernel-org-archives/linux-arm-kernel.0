From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Jun 2015 16:01:15 +0100
Subject: ARMADA-XP cpu1 .. cpu3 does not come online
In-Reply-To: <20150618142835.GF312@lunn.ch>
References: <20150618123833.GA28005@t440.home> <20150618133607.GB312@lunn.ch>
 <20150618142233.GL7557@n2100.arm.linux.org.uk>
 <20150618142835.GF312@lunn.ch>
Message-ID: <20150618150115.GO7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 04:28:35PM +0200, Andrew Lunn wrote:
> On Thu, Jun 18, 2015 at 03:22:33PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Jun 18, 2015 at 03:36:07PM +0200, Andrew Lunn wrote:
> > > > Uncompressing Linux... done, booting the kernel.                               
> > > > [    0.000000] Booting Linux on physical CPU 0x0                               
> > > > [    0.000000] Linux version 4.0.5-00001-g8b87c3c (peter at t440) (gcc version 4.95
> > > > [    0.000000] CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7), cr=10c5387d 
> > > > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache 
> > > > [    0.000000] Machine model: AXP-TEST-BOARD 
> > > > [    0.000000] bootconsole [earlycon0] enabled
> > > > [    0.000000] Truncating RAM at 0x00000000-0xffffffff to -0x2f800000 
> > > > 
> > > > ^^ This is worrying to me, firstly because memory is being truncated down, secondly because my dts file only specifies memory from 0x00000000 to 0xf000000 (see attached dts file)
> > > 
> > > 0x2f800000 suggests you have an old boot loader, with IO at
> > > 0xd000,0000. Upgrading to a newer uboot will allow you to use more of
> > > the 4G of RAM. It might also fix your SMP issue.
> > 
> > No.  The 0x2f800000 comes from having more than 0x2f800000 bytes of memory
> > and having highmem disabled.  It's got nothing to do with boot loaders at
> > all.
> > 
> > The way this works is that sanity_check_meminfo() looks at the base of
> > the vmalloc() area.  If PAGE_OFFSET + memory_size results in memory above
> > the vmalloc() area, and highmem is disabled, sanity_check_meminfo()
> > truncates the memory to that limit and reports the above message.
> 
> Hi Russell
> 
> Thanks for the explanation.
> 
> I think at one point x86 used to print a hint about enabling HIGHMEM.
> Is it worth adding something similar?

Probably yes, but I'm also in favour of changing the Kconfig too - maybe
something like this:

 arch/arm/Kconfig  | 6 ++++--
 arch/arm/mm/mmu.c | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index add5370eb5e5..e307b36d0e1e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1654,8 +1654,9 @@ config HAVE_GENERIC_RCU_GUP
 	depends on ARM_LPAE
 
 config HIGHMEM
-	bool "High Memory Support"
+	bool "High Memory Support" if !(CPU_32v6 || CPU_32v7) || EXPERT
 	depends on MMU
+	default y if CPU_32v6 || CPU_32v7
 	help
 	  The address space of ARM processors is only 4 Gigabytes large
 	  and it has to accommodate user address space, kernel address
@@ -1671,8 +1672,9 @@ config HIGHMEM
 	  If unsure, say n.
 
 config HIGHPTE
-	bool "Allocate 2nd-level pagetables from highmem"
+	bool "Allocate 2nd-level pagetables from highmem" if EXPERT
 	depends on HIGHMEM
+	default y
 
 config HW_PERF_EVENTS
 	bool "Enable hardware performance counter support for perf events"
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 6ca7d9aa896f..d543e5c7eecc 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1072,6 +1072,7 @@ void __init sanity_check_meminfo(void)
 	int highmem = 0;
 	phys_addr_t vmalloc_limit = __pa(vmalloc_min - 1) + 1;
 	struct memblock_region *reg;
+	bool should_use_highmem = false;
 
 	for_each_memblock(memory, reg) {
 		phys_addr_t block_start = reg->base;
@@ -1090,6 +1091,7 @@ void __init sanity_check_meminfo(void)
 				pr_notice("Ignoring RAM at %pa-%pa (!CONFIG_HIGHMEM)\n",
 					  &block_start, &block_end);
 				memblock_remove(reg->base, reg->size);
+				should_use_highmem = true;
 				continue;
 			}
 
@@ -1100,6 +1102,7 @@ void __init sanity_check_meminfo(void)
 					  &block_start, &block_end, &vmalloc_limit);
 				memblock_remove(vmalloc_limit, overlap_size);
 				block_end = vmalloc_limit;
+				should_use_highmem = true;
 			}
 		}
 
@@ -1134,6 +1137,9 @@ void __init sanity_check_meminfo(void)
 		}
 	}
 
+	if (should_use_highmem)
+		pr_notice("Consider using a HIGHMEM enabled kernel.\n");
+
 	high_memory = __va(arm_lowmem_limit - 1) + 1;
 
 	/*

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
