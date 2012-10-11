From: will.deacon@arm.com (Will Deacon)
Date: Thu, 11 Oct 2012 20:50:33 +0100
Subject: bug with 3.4.6, 3.5.3, 3.6.1
In-Reply-To: <5076D12A.1070700@xenomai.org>
References: <50765D3B.6000909@xenomai.org>
 <20121011103637.GC30598@mudshark.cambridge.arm.com>
 <5076CA56.3020006@xenomai.org>
 <20121011135905.GL30598@mudshark.cambridge.arm.com>
 <5076D12A.1070700@xenomai.org>
Message-ID: <20121011195033.GA31946@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2012 03:59 PM, Will Deacon wrote:
> I'll have to do some digging and get back to you.

Ok, so here's what I think is going on (although note that I'm at home now,
so I've not been able to test anything):

	- Your PHYS_OFFSET is at 2GB, so your static idmap is as follows:
	  idmap: 0x8029c638 - 0x8029c66c and I think your init_mm lives
	  at 0x8037f2b4.

	- The idmap takes up two sections, so actually spans from:
	  0x80200000 - 0x80400000 and is mapped as *strongly ordered*.

This means that the atomic_inc(&mm->mm_count); in secondary_start_kernel
is UNPREDICTABLE, because it results in an exclusive access to
strongly-ordered memory.

There are several ways to solve this:

	1. Avoid exclusives with the idmap (see patch below)
	2. Set idmap_pgd to swapper when VA == PA
	3. Map idmap with pages and round up text section
	4. Switch to swapper before entering secondary_start_kernel
	5. Make idmap normal (cacheable?) shared memory

However, these have some problems:

	(2) means the idmap is cacheable. This is probably not an issue
	when VA == PA, but it's still an oddity compared to other setups

	(3) is really messy

	(4,5) probably have serious issues with SMP

so I've had a crack at (1) below. Please see if it fixes your problem.

Cheers,

Will

--->8

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index d100eac..aa55580 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -290,18 +290,24 @@ static void percpu_timer_setup(void);
 asmlinkage void __cpuinit secondary_start_kernel(void)
 {
 	struct mm_struct *mm = &init_mm;
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
+
+	/*
+	 * The identity mapping is uncached (strongly ordered), so
+	 * switch away from it before attempting any exclusive accesses.
+	 */
+	cpu_switch_mm(mm->pgd, mm);
+	enter_lazy_tlb(mm, current);
+	local_flush_tlb_all();
 
 	/*
 	 * All kernel threads share the same mm context; grab a
 	 * reference and switch to it.
 	 */
+	cpu = smp_processor_id();
 	atomic_inc(&mm->mm_count);
 	current->active_mm = mm;
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
-	cpu_switch_mm(mm->pgd, mm);
-	enter_lazy_tlb(mm, current);
-	local_flush_tlb_all();
 
 	printk("CPU%u: Booted secondary processor\n", cpu);
 
