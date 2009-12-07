From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 07 Dec 2009 14:13:20 +0000
Subject: [PATCH 2/6] Broadcast the DMA cache operations on ARMv6 SMP hardware
In-Reply-To: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
References: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091207141038.30429.75648.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Snoop Control Unit on the ARM11MPCore hardware does not detect the
cache operations and the dma_cache_maint() function may leave stale
cache entries on other CPUs. The solution is to broadcast the cache
operations to the other CPUs in software. However, there is no
restriction to the contexts in which dma_cache_maint() function can be
called (interrupt context or IRQs disabled).

This patch implements the smp_dma_cache_op() function which performs the
broadcast and it can be called with interrupts disabled or from
interrupt context.

To avoid deadlocking when more than one CPU try to invoke this
function, the implementation uses spin_trylock() loop if the IRQs are
disabled and, if the lock cannot be acquired, it polls for an incoming
IPI and executes it. In the unlikely situation of two or more CPUs
calling the smp_dma_cache_op() function with interrupts disabled, there
may be spurious (or delayed) IPIs after a CPU completes and enables the
IRQs. These are handled by checking the corresponding "unfinished" bits
in the IPI handler.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

Just a note - the DMA cache ops broadcasting in software cannot easily
use the generic IPI functionality in the kernel because of the
restriction to have the interrupts enabled when invoking
smp_call_function(). Another reason to do it separately is that the
introduced smp_dma_cache_op() function runs the DMA cache operation
locally in parallel with the other CPUs while smp_call_function() would
only run it on the other CPUs in parallel but not with the current CPU.


 arch/arm/include/asm/cacheflush.h |   29 ++++++++
 arch/arm/kernel/smp.c             |  133 +++++++++++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig               |    5 +
 arch/arm/mm/dma-mapping.c         |   14 ++--
 4 files changed, 174 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 3d0cdd2..b3c53f5 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -280,6 +280,35 @@ extern void dmac_flush_range(const void *, const void *);
 
 #endif
 
+#ifdef CONFIG_CPU_NO_CACHE_BCAST
+enum smp_dma_cache_type {
+	SMP_DMA_CACHE_INV,
+	SMP_DMA_CACHE_CLEAN,
+	SMP_DMA_CACHE_FLUSH,
+};
+
+extern void smp_dma_cache_op(int type, const void *start, const void *end);
+
+static inline void smp_dma_inv_range(const void *start, const void *end)
+{
+	smp_dma_cache_op(SMP_DMA_CACHE_INV, start, end);
+}
+
+static inline void smp_dma_clean_range(const void *start, const void *end)
+{
+	smp_dma_cache_op(SMP_DMA_CACHE_CLEAN, start, end);
+}
+
+static inline void smp_dma_flush_range(const void *start, const void *end)
+{
+	smp_dma_cache_op(SMP_DMA_CACHE_FLUSH, start, end);
+}
+#else
+#define smp_dma_inv_range		dmac_inv_range
+#define smp_dma_clean_range		dmac_clean_range
+#define smp_dma_flush_range		dmac_flush_range
+#endif
+
 #ifdef CONFIG_OUTER_CACHE
 
 extern struct outer_cache_fns outer_cache;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 57162af..27827bd 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -65,6 +65,9 @@ enum ipi_msg_type {
 	IPI_CALL_FUNC,
 	IPI_CALL_FUNC_SINGLE,
 	IPI_CPU_STOP,
+#ifdef CONFIG_CPU_NO_CACHE_BCAST
+	IPI_DMA_CACHE,
+#endif
 };
 
 int __cpuinit __cpu_up(unsigned int cpu)
@@ -473,6 +476,10 @@ static void ipi_cpu_stop(unsigned int cpu)
 		cpu_relax();
 }
 
+#ifdef CONFIG_CPU_NO_CACHE_BCAST
+static void ipi_dma_cache_op(unsigned int cpu);
+#endif
+
 /*
  * Main handler for inter-processor interrupts
  *
@@ -532,6 +539,12 @@ asmlinkage void __exception do_IPI(struct pt_regs *regs)
 				ipi_cpu_stop(cpu);
 				break;
 
+#ifdef CONFIG_CPU_NO_CACHE_BCAST
+			case IPI_DMA_CACHE:
+				ipi_dma_cache_op(cpu);
+				break;
+#endif
+
 			default:
 				printk(KERN_CRIT "CPU%u: Unknown IPI message 0x%x\n",
 				       cpu, nextmsg);
@@ -687,3 +700,123 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	} else
 		local_flush_tlb_kernel_range(start, end);
 }
+
+#ifdef CONFIG_CPU_NO_CACHE_BCAST
+/*
+ * DMA cache maintenance operations on SMP if the automatic hardware
+ * broadcasting is not available
+ */
+struct smp_dma_cache_struct {
+	int type;
+	const void *start;
+	const void *end;
+	cpumask_t unfinished;
+};
+
+static struct smp_dma_cache_struct *smp_dma_cache_data;
+static DEFINE_RWLOCK(smp_dma_cache_data_lock);
+static DEFINE_SPINLOCK(smp_dma_cache_lock);
+
+static void local_dma_cache_op(int type, const void *start, const void *end)
+{
+	switch (type) {
+	case SMP_DMA_CACHE_INV:
+		dmac_inv_range(start, end);
+		break;
+	case SMP_DMA_CACHE_CLEAN:
+		dmac_clean_range(start, end);
+		break;
+	case SMP_DMA_CACHE_FLUSH:
+		dmac_flush_range(start, end);
+		break;
+	default:
+		printk(KERN_CRIT "CPU%u: Unknown SMP DMA cache type %d\n",
+		       smp_processor_id(), type);
+	}
+}
+
+/*
+ * This function must be executed with interrupts disabled.
+ */
+static void ipi_dma_cache_op(unsigned int cpu)
+{
+	read_lock(&smp_dma_cache_data_lock);
+
+	/* check for spurious IPI */
+	if ((smp_dma_cache_data == NULL) ||
+	    (!cpu_isset(cpu, smp_dma_cache_data->unfinished)))
+		goto out;
+	local_dma_cache_op(smp_dma_cache_data->type,
+			   smp_dma_cache_data->start, smp_dma_cache_data->end);
+	cpu_clear(cpu, smp_dma_cache_data->unfinished);
+ out:
+	read_unlock(&smp_dma_cache_data_lock);
+}
+
+/*
+ * Execute the DMA cache operations on all online CPUs. This function
+ * can be called with interrupts disabled or from interrupt context.
+ */
+static void __smp_dma_cache_op(int type, const void *start, const void *end)
+{
+	struct smp_dma_cache_struct data;
+	cpumask_t callmap = cpu_online_map;
+	unsigned int cpu = get_cpu();
+	unsigned long flags;
+
+	cpu_clear(cpu, callmap);
+	data.type = type;
+	data.start = start;
+	data.end = end;
+	data.unfinished = callmap;
+
+	/*
+	 * If the spinlock cannot be acquired, other CPU is trying to
+	 * send an IPI. If the interrupts are disabled, we have to
+	 * poll for an incoming IPI.
+	 */
+	while (!spin_trylock_irqsave(&smp_dma_cache_lock, flags)) {
+		if (irqs_disabled())
+			ipi_dma_cache_op(cpu);
+	}
+
+	write_lock(&smp_dma_cache_data_lock);
+	smp_dma_cache_data = &data;
+	write_unlock(&smp_dma_cache_data_lock);
+
+	if (!cpus_empty(callmap))
+		send_ipi_message(&callmap, IPI_DMA_CACHE);
+	/* run the local operation in parallel with the other CPUs */
+	local_dma_cache_op(type, start, end);
+
+	while (!cpus_empty(data.unfinished))
+		barrier();
+
+	write_lock(&smp_dma_cache_data_lock);
+	smp_dma_cache_data = NULL;
+	write_unlock(&smp_dma_cache_data_lock);
+
+	spin_unlock_irqrestore(&smp_dma_cache_lock, flags);
+	put_cpu();
+}
+
+#define DMA_MAX_RANGE		SZ_4K
+
+/*
+ * Split the cache range in smaller pieces if interrupts are enabled
+ * to reduce the latency caused by disabling the interrupts during the
+ * broadcast.
+ */
+void smp_dma_cache_op(int type, const void *start, const void *end)
+{
+	if (irqs_disabled() || (end - start <= DMA_MAX_RANGE))
+		__smp_dma_cache_op(type, start, end);
+	else {
+		const void *ptr;
+		for (ptr = start; ptr < end - DMA_MAX_RANGE;
+		     ptr += DMA_MAX_RANGE)
+			__smp_dma_cache_op(type, ptr, ptr + DMA_MAX_RANGE);
+		__smp_dma_cache_op(type, ptr, end);
+	}
+}
+#endif
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9264d81..ce382f5 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -516,6 +516,11 @@ config CPU_CACHE_VIPT
 config CPU_CACHE_FA
 	bool
 
+config CPU_NO_CACHE_BCAST
+	bool
+	depends on SMP
+	default y if CPU_V6
+
 if MMU
 # The copy-page model
 config CPU_COPY_V3
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b9590a7..176c696 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -219,7 +219,7 @@ __dma_alloc(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp,
 	{
 		void *ptr = page_address(page);
 		memset(ptr, 0, size);
-		dmac_flush_range(ptr, ptr + size);
+		smp_dma_flush_range(ptr, ptr + size);
 		outer_flush_range(__pa(ptr), __pa(ptr) + size);
 	}
 
@@ -548,15 +548,15 @@ void dma_cache_maint(const void *start, size_t size, int direction)
 
 	switch (direction) {
 	case DMA_FROM_DEVICE:		/* invalidate only */
-		inner_op = dmac_inv_range;
+		inner_op = smp_dma_inv_range;
 		outer_op = outer_inv_range;
 		break;
 	case DMA_TO_DEVICE:		/* writeback only */
-		inner_op = dmac_clean_range;
+		inner_op = smp_dma_clean_range;
 		outer_op = outer_clean_range;
 		break;
 	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
-		inner_op = dmac_flush_range;
+		inner_op = smp_dma_flush_range;
 		outer_op = outer_flush_range;
 		break;
 	default:
@@ -578,15 +578,15 @@ static void dma_cache_maint_contiguous(struct page *page, unsigned long offset,
 
 	switch (direction) {
 	case DMA_FROM_DEVICE:		/* invalidate only */
-		inner_op = dmac_inv_range;
+		inner_op = smp_dma_inv_range;
 		outer_op = outer_inv_range;
 		break;
 	case DMA_TO_DEVICE:		/* writeback only */
-		inner_op = dmac_clean_range;
+		inner_op = smp_dma_clean_range;
 		outer_op = outer_clean_range;
 		break;
 	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
-		inner_op = dmac_flush_range;
+		inner_op = smp_dma_flush_range;
 		outer_op = outer_flush_range;
 		break;
 	default:
