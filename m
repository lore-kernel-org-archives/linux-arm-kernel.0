From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 17 Nov 2014 20:29:45 +0000
Subject: [PATCH 1/8] ARM: convert printk(KERN_* to pr_*
In-Reply-To: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
References: <20141117202911.GZ4042@n2100.arm.linux.org.uk>
Message-ID: <E1XqSvh-0002EF-3Y@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert many (but not all) printk(KERN_* to pr_* to simplify the code.
We take the opportunity to join some printk lines together so we don't
split the message across several lines, and we also add a few levels
to some messages which were previously missing them.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c        | 13 ++++++-------
 arch/arm/kernel/atags_compat.c  |  6 ++----
 arch/arm/kernel/atags_parse.c   |  5 ++---
 arch/arm/kernel/atags_proc.c    |  4 ++--
 arch/arm/kernel/bios32.c        |  2 +-
 arch/arm/kernel/dma-isa.c       |  4 ++--
 arch/arm/kernel/dma.c           | 26 +++++++++++--------------
 arch/arm/kernel/etm.c           | 12 ++++++------
 arch/arm/kernel/fiq.c           |  2 +-
 arch/arm/kernel/irq.c           |  2 +-
 arch/arm/kernel/machine_kexec.c |  6 +++---
 arch/arm/kernel/module.c        |  2 +-
 arch/arm/kernel/smp.c           | 16 ++++++++--------
 arch/arm/kernel/smp_twd.c       |  4 ++--
 arch/arm/kernel/swp_emulate.c   |  2 +-
 arch/arm/kernel/thumbee.c       |  2 +-
 arch/arm/kernel/topology.c      |  4 ++--
 arch/arm/kernel/traps.c         | 42 ++++++++++++++++++++---------------------
 arch/arm/kernel/xscale-cp0.c    |  7 +++----
 arch/arm/mm/alignment.c         | 10 +++++-----
 arch/arm/mm/cache-feroceon-l2.c |  6 +++---
 arch/arm/mm/cache-tauros2.c     | 12 ++++++------
 arch/arm/mm/fault-armv.c        |  6 +++---
 arch/arm/mm/fault.c             | 31 +++++++++++++++---------------
 arch/arm/mm/init.c              |  4 ++--
 arch/arm/mm/mmu.c               | 38 +++++++++++++++----------------------
 arch/arm/nwfpe/fpmodule.c       |  4 ++--
 arch/arm/vfp/vfpsingle.c        |  2 +-
 28 files changed, 128 insertions(+), 146 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index e57d7e5bf96a..7b69c5f9cd74 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -282,8 +282,8 @@ static int sa1111_retrigger_lowirq(struct irq_data *d)
 	}
 
 	if (i == 8)
-		printk(KERN_ERR "Danger Will Robinson: failed to "
-			"re-trigger IRQ%d\n", d->irq);
+		pr_err("Danger Will Robinson: failed to re-trigger IRQ%d\n",
+		       d->irq);
 	return i == 8 ? -1 : 0;
 }
 
@@ -384,8 +384,8 @@ static int sa1111_retrigger_highirq(struct irq_data *d)
 	}
 
 	if (i == 8)
-		printk(KERN_ERR "Danger Will Robinson: failed to "
-			"re-trigger IRQ%d\n", d->irq);
+		pr_err("Danger Will Robinson: failed to re-trigger IRQ%d\n",
+		       d->irq);
 	return i == 8 ? -1 : 0;
 }
 
@@ -740,9 +740,8 @@ static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
 		goto err_unmap;
 	}
 
-	printk(KERN_INFO "SA1111 Microprocessor Companion Chip: "
-		"silicon revision %lx, metal revision %lx\n",
-		(id & SKID_SIREV_MASK)>>4, (id & SKID_MTREV_MASK));
+	pr_info("SA1111 Microprocessor Companion Chip: silicon revision %lx, metal revision %lx\n",
+		(id & SKID_SIREV_MASK) >> 4, id & SKID_MTREV_MASK);
 
 	/*
 	 * We found it.  Wake the chip up, and initialise.
diff --git a/arch/arm/kernel/atags_compat.c b/arch/arm/kernel/atags_compat.c
index 5236ad38f417..05c28b12353c 100644
--- a/arch/arm/kernel/atags_compat.c
+++ b/arch/arm/kernel/atags_compat.c
@@ -97,8 +97,7 @@ static void __init build_tag_list(struct param_struct *params, void *taglist)
 	struct tag *tag = taglist;
 
 	if (params->u1.s.page_size != PAGE_SIZE) {
-		printk(KERN_WARNING "Warning: bad configuration page, "
-		       "trying to continue\n");
+		pr_warn("Warning: bad configuration page, trying to continue\n");
 		return;
 	}
 
@@ -109,8 +108,7 @@ static void __init build_tag_list(struct param_struct *params, void *taglist)
 	    params->u1.s.nr_pages != 0x04000 &&
 	    params->u1.s.nr_pages != 0x08000 &&
 	    params->u1.s.nr_pages != 0x10000) {
-		printk(KERN_WARNING "Warning: bad NeTTrom parameters "
-		       "detected, using defaults\n");
+		pr_warn("Warning: bad NeTTrom parameters detected, using defaults\n");
 
 		params->u1.s.nr_pages = 0x1000;	/* 16MB */
 		params->u1.s.ramdisk_size = 0;
diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 528f8af2addb..68c6ae0b9e4c 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -167,8 +167,7 @@ static void __init parse_tags(const struct tag *t)
 {
 	for (; t->hdr.size; t = tag_next(t))
 		if (!parse_tag(t))
-			printk(KERN_WARNING
-				"Ignoring unrecognised tag 0x%08x\n",
+			pr_warn("Ignoring unrecognised tag 0x%08x\n",
 				t->hdr.tag);
 }
 
@@ -193,7 +192,7 @@ setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
 	 */
 	for_each_machine_desc(p)
 		if (machine_nr == p->nr) {
-			printk("Machine: %s\n", p->name);
+			pr_info("Machine: %s\n", p->name);
 			mdesc = p;
 			break;
 		}
diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
index c7ff8073416f..5a3379055f55 100644
--- a/arch/arm/kernel/atags_proc.c
+++ b/arch/arm/kernel/atags_proc.c
@@ -41,7 +41,7 @@ static int __init init_atags_procfs(void)
 	size_t size;
 
 	if (tag->hdr.tag != ATAG_CORE) {
-		printk(KERN_INFO "No ATAGs?");
+		pr_info("No ATAGs?");
 		return -EINVAL;
 	}
 
@@ -68,7 +68,7 @@ static int __init init_atags_procfs(void)
 
 nomem:
 	kfree(b);
-	printk(KERN_ERR "Exporting ATAGs: not enough memory\n");
+	pr_err("Exporting ATAGs: not enough memory\n");
 
 	return -ENOMEM;
 }
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 17a26c17f7f5..391ffdfce571 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -355,7 +355,7 @@ void pcibios_fixup_bus(struct pci_bus *bus)
 	/*
 	 * Report what we did for this bus
 	 */
-	printk(KERN_INFO "PCI: bus%d: Fast back to back transfers %sabled\n",
+	pr_info("PCI: bus%d: Fast back to back transfers %sabled\n",
 		bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");
 }
 EXPORT_SYMBOL(pcibios_fixup_bus);
diff --git a/arch/arm/kernel/dma-isa.c b/arch/arm/kernel/dma-isa.c
index 360bb6d701f5..84363fe7bad2 100644
--- a/arch/arm/kernel/dma-isa.c
+++ b/arch/arm/kernel/dma-isa.c
@@ -213,8 +213,8 @@ void __init isa_init_dma(void)
 		for (chan = 0; chan < 8; chan++) {
 			int ret = isa_dma_add(chan, &isa_dma[chan]);
 			if (ret)
-				printk(KERN_ERR "ISADMA%u: unable to register: %d\n",
-					chan, ret);
+				pr_err("ISADMA%u: unable to register: %d\n",
+				       chan, ret);
 		}
 
 		request_dma(DMA_ISA_CASCADE, "cascade");
diff --git a/arch/arm/kernel/dma.c b/arch/arm/kernel/dma.c
index 7b829d9663b1..e651c4d0a0d9 100644
--- a/arch/arm/kernel/dma.c
+++ b/arch/arm/kernel/dma.c
@@ -79,7 +79,7 @@ int request_dma(unsigned int chan, const char *device_id)
 	return ret;
 
 bad_dma:
-	printk(KERN_ERR "dma: trying to allocate DMA%d\n", chan);
+	pr_err("dma: trying to allocate DMA%d\n", chan);
 	return -EINVAL;
 
 busy:
@@ -100,7 +100,7 @@ void free_dma(unsigned int chan)
 		goto bad_dma;
 
 	if (dma->active) {
-		printk(KERN_ERR "dma%d: freeing active DMA\n", chan);
+		pr_err("dma%d: freeing active DMA\n", chan);
 		dma->d_ops->disable(chan, dma);
 		dma->active = 0;
 	}
@@ -111,11 +111,11 @@ void free_dma(unsigned int chan)
 		return;
 	}
 
-	printk(KERN_ERR "dma%d: trying to free free DMA\n", chan);
+	pr_err("dma%d: trying to free free DMA\n", chan);
 	return;
 
 bad_dma:
-	printk(KERN_ERR "dma: trying to free DMA%d\n", chan);
+	pr_err("dma: trying to free DMA%d\n", chan);
 }
 EXPORT_SYMBOL(free_dma);
 
@@ -126,8 +126,7 @@ void set_dma_sg (unsigned int chan, struct scatterlist *sg, int nr_sg)
 	dma_t *dma = dma_channel(chan);
 
 	if (dma->active)
-		printk(KERN_ERR "dma%d: altering DMA SG while "
-		       "DMA active\n", chan);
+		pr_err("dma%d: altering DMA SG while DMA active\n", chan);
 
 	dma->sg = sg;
 	dma->sgcount = nr_sg;
@@ -144,8 +143,7 @@ void __set_dma_addr (unsigned int chan, void *addr)
 	dma_t *dma = dma_channel(chan);
 
 	if (dma->active)
-		printk(KERN_ERR "dma%d: altering DMA address while "
-		       "DMA active\n", chan);
+		pr_err("dma%d: altering DMA address while DMA active\n", chan);
 
 	dma->sg = NULL;
 	dma->addr = addr;
@@ -162,8 +160,7 @@ void set_dma_count (unsigned int chan, unsigned long count)
 	dma_t *dma = dma_channel(chan);
 
 	if (dma->active)
-		printk(KERN_ERR "dma%d: altering DMA count while "
-		       "DMA active\n", chan);
+		pr_err("dma%d: altering DMA count while DMA active\n", chan);
 
 	dma->sg = NULL;
 	dma->count = count;
@@ -178,8 +175,7 @@ void set_dma_mode (unsigned int chan, unsigned int mode)
 	dma_t *dma = dma_channel(chan);
 
 	if (dma->active)
-		printk(KERN_ERR "dma%d: altering DMA mode while "
-		       "DMA active\n", chan);
+		pr_err("dma%d: altering DMA mode while DMA active\n", chan);
 
 	dma->dma_mode = mode;
 	dma->invalid = 1;
@@ -202,7 +198,7 @@ void enable_dma (unsigned int chan)
 	return;
 
 free_dma:
-	printk(KERN_ERR "dma%d: trying to enable free DMA\n", chan);
+	pr_err("dma%d: trying to enable free DMA\n", chan);
 	BUG();
 }
 EXPORT_SYMBOL(enable_dma);
@@ -223,7 +219,7 @@ void disable_dma (unsigned int chan)
 	return;
 
 free_dma:
-	printk(KERN_ERR "dma%d: trying to disable free DMA\n", chan);
+	pr_err("dma%d: trying to disable free DMA\n", chan);
 	BUG();
 }
 EXPORT_SYMBOL(disable_dma);
@@ -240,7 +236,7 @@ EXPORT_SYMBOL(dma_channel_active);
 
 void set_dma_page(unsigned int chan, char pagenr)
 {
-	printk(KERN_ERR "dma%d: trying to set_dma_page\n", chan);
+	pr_err("dma%d: trying to set_dma_page\n", chan);
 }
 EXPORT_SYMBOL(set_dma_page);
 
diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 131a6ab5f355..8b96972dcb1d 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -213,7 +213,7 @@ static void etm_dump(void)
 	int length;
 
 	if (!t->etb_regs) {
-		printk(KERN_INFO "No tracing hardware found\n");
+		pr_info("No tracing hardware found\n");
 		return;
 	}
 
@@ -229,11 +229,11 @@ static void etm_dump(void)
 
 	etb_writel(t, first, ETBR_READADDR);
 
-	printk(KERN_INFO "Trace buffer contents length: %d\n", length);
-	printk(KERN_INFO "--- ETB buffer begin ---\n");
+	pr_info("Trace buffer contents length: %d\n", length);
+	pr_info("--- ETB buffer begin ---\n");
 	for (; length; length--)
 		printk("%08x", cpu_to_be32(etb_readl(t, ETBR_READMEM)));
-	printk(KERN_INFO "\n--- ETB buffer end ---\n");
+	pr_info("\n--- ETB buffer end ---\n");
 
 	/* deassert the overflow bit */
 	etb_writel(t, 1, ETBR_CTRL);
@@ -633,14 +633,14 @@ static int __init etm_init(void)
 
 	retval = amba_driver_register(&etb_driver);
 	if (retval) {
-		printk(KERN_ERR "Failed to register etb\n");
+		pr_err("Failed to register etb\n");
 		return retval;
 	}
 
 	retval = amba_driver_register(&etm_driver);
 	if (retval) {
 		amba_driver_unregister(&etb_driver);
-		printk(KERN_ERR "Failed to probe etm\n");
+		pr_err("Failed to probe etm\n");
 		return retval;
 	}
 
diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index b37752a96652..059c3da0fee3 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -124,7 +124,7 @@ int claim_fiq(struct fiq_handler *f)
 void release_fiq(struct fiq_handler *f)
 {
 	if (current_fiq != f) {
-		printk(KERN_ERR "%s FIQ trying to release %s FIQ\n",
+		pr_err("%s FIQ trying to release %s FIQ\n",
 		       f->name, current_fiq->name);
 		dump_stack();
 		return;
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 7c81ec428b9b..f2fea6831cd5 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -82,7 +82,7 @@ void set_irq_flags(unsigned int irq, unsigned int iflags)
 	unsigned long clr = 0, set = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 
 	if (irq >= nr_irqs) {
-		printk(KERN_ERR "Trying to set irq flags for IRQ%d\n", irq);
+		pr_err("Trying to set irq flags for IRQ%d\n", irq);
 		return;
 	}
 
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 8cf0996aa1a8..4f75192f2ef9 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -126,12 +126,12 @@ void machine_crash_shutdown(struct pt_regs *regs)
 		msecs--;
 	}
 	if (atomic_read(&waiting_for_crash_ipi) > 0)
-		printk(KERN_WARNING "Non-crashing CPUs did not react to IPI\n");
+		pr_warn("Non-crashing CPUs did not react to IPI\n");
 
 	crash_save_cpu(regs, smp_processor_id());
 	machine_kexec_mask_interrupts();
 
-	printk(KERN_INFO "Loading crashdump kernel...\n");
+	pr_info("Loading crashdump kernel...\n");
 }
 
 /*
@@ -177,7 +177,7 @@ void machine_kexec(struct kimage *image)
 	reboot_entry_phys = (unsigned long)reboot_entry +
 		(reboot_code_buffer_phys - (unsigned long)reboot_code_buffer);
 
-	printk(KERN_INFO "Bye!\n");
+	pr_info("Bye!\n");
 
 	if (kexec_reinit)
 		kexec_reinit();
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 6a4dffefd357..bea7db9e5b80 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -251,7 +251,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 #endif
 
 		default:
-			printk(KERN_ERR "%s: unknown relocation: %u\n",
+			pr_err("%s: unknown relocation: %u\n",
 			       module->name, ELF32_R_TYPE(rel->r_info));
 			return -ENOEXEC;
 		}
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 13396d3d600e..3138d8ea9e55 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -225,7 +225,7 @@ void __cpu_die(unsigned int cpu)
 		pr_err("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
-	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);
+	pr_notice("CPU%u: shutdown\n", cpu);
 
 	/*
 	 * platform_cpu_kill() is generally expected to do the powering off
@@ -235,7 +235,7 @@ void __cpu_die(unsigned int cpu)
 	 * the requesting CPU and the dying CPU actually losing power.
 	 */
 	if (!platform_cpu_kill(cpu))
-		printk("CPU%u: unable to kill\n", cpu);
+		pr_err("CPU%u: unable to kill\n", cpu);
 }
 
 /*
@@ -351,7 +351,7 @@ asmlinkage void secondary_start_kernel(void)
 
 	cpu_init();
 
-	printk("CPU%u: Booted secondary processor\n", cpu);
+	pr_info("CPU%u: Booted secondary processor\n", cpu);
 
 	preempt_disable();
 	trace_hardirqs_off();
@@ -387,8 +387,8 @@ asmlinkage void secondary_start_kernel(void)
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
-	printk(KERN_INFO "SMP: Total of %d processors activated.\n",
-	       num_online_cpus());
+	pr_info("SMP: Total of %d processors activated.\n",
+		num_online_cpus());
 
 	hyp_mode_check();
 }
@@ -521,7 +521,7 @@ static void ipi_cpu_stop(unsigned int cpu)
 	if (system_state == SYSTEM_BOOTING ||
 	    system_state == SYSTEM_RUNNING) {
 		raw_spin_lock(&stop_lock);
-		printk(KERN_CRIT "CPU%u: stopping\n", cpu);
+		pr_crit("CPU%u: stopping\n", cpu);
 		dump_stack();
 		raw_spin_unlock(&stop_lock);
 	}
@@ -615,8 +615,8 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 
 	default:
-		printk(KERN_CRIT "CPU%u: Unknown IPI message 0x%x\n",
-		       cpu, ipinr);
+		pr_crit("CPU%u: Unknown IPI message 0x%x\n",
+		        cpu, ipinr);
 		break;
 	}
 
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 93090213c71c..172c6a05d27f 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -199,7 +199,7 @@ static void twd_calibrate_rate(void)
 	 * the timer ticks
 	 */
 	if (twd_timer_rate == 0) {
-		printk(KERN_INFO "Calibrating local timer... ");
+		pr_info("Calibrating local timer... ");
 
 		/* Wait for a tick to start */
 		waitjiffies = get_jiffies_64() + 1;
@@ -223,7 +223,7 @@ static void twd_calibrate_rate(void)
 
 		twd_timer_rate = (0xFFFFFFFFU - count) * (HZ / 5);
 
-		printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
+		pr_cont("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
 			(twd_timer_rate / 10000) % 100);
 	}
 }
diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
index 587fdfe1a72c..afdd51e30bec 100644
--- a/arch/arm/kernel/swp_emulate.c
+++ b/arch/arm/kernel/swp_emulate.c
@@ -260,7 +260,7 @@ static int __init swp_emulation_init(void)
 		return -ENOMEM;
 #endif /* CONFIG_PROC_FS */
 
-	printk(KERN_NOTICE "Registering SWP/SWPB emulation handler\n");
+	pr_notice("Registering SWP/SWPB emulation handler\n");
 	register_undef_hook(&swp_hook);
 
 	return 0;
diff --git a/arch/arm/kernel/thumbee.c b/arch/arm/kernel/thumbee.c
index 80f0d69205e7..8ff8dbfbe9fb 100644
--- a/arch/arm/kernel/thumbee.c
+++ b/arch/arm/kernel/thumbee.c
@@ -72,7 +72,7 @@ static int __init thumbee_init(void)
 	if ((pfr0 & 0x0000f000) != 0x00001000)
 		return 0;
 
-	printk(KERN_INFO "ThumbEE CPU extension supported.\n");
+	pr_info("ThumbEE CPU extension supported.\n");
 	elf_hwcap |= HWCAP_THUMBEE;
 	thread_register_notifier(&thumbee_notifier_block);
 
diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 89cfdd6e50cb..08b7847bf912 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -165,7 +165,7 @@ static void update_cpu_capacity(unsigned int cpu)
 
 	set_capacity_scale(cpu, cpu_capacity(cpu) / middle_capacity);
 
-	printk(KERN_INFO "CPU%u: update cpu_capacity %lu\n",
+	pr_info("CPU%u: update cpu_capacity %lu\n",
 		cpu, arch_scale_cpu_capacity(NULL, cpu));
 }
 
@@ -269,7 +269,7 @@ void store_cpu_topology(unsigned int cpuid)
 
 	update_cpu_capacity(cpuid);
 
-	printk(KERN_INFO "CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
+	pr_info("CPU%u: thread %d, cpu %d, socket %d, mpidr %x\n",
 		cpuid, cpu_topology[cpuid].thread_id,
 		cpu_topology[cpuid].core_id,
 		cpu_topology[cpuid].socket_id, mpidr);
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 0c8b10801d36..bb121b52ef36 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -198,14 +198,14 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	}
 
 	if (!fp) {
-		printk("no frame pointer");
+		pr_cont("no frame pointer");
 		ok = 0;
 	} else if (verify_stack(fp)) {
-		printk("invalid frame pointer 0x%08x", fp);
+		pr_cont("invalid frame pointer 0x%08x", fp);
 		ok = 0;
 	} else if (fp < (unsigned long)end_of_stack(tsk))
-		printk("frame pointer underflow");
-	printk("\n");
+		pr_cont("frame pointer underflow");
+	pr_cont("\n");
 
 	if (ok)
 		c_backtrace(fp, mode);
@@ -240,8 +240,8 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 	static int die_counter;
 	int ret;
 
-	printk(KERN_EMERG "Internal error: %s: %x [#%d]" S_PREEMPT S_SMP
-	       S_ISA "\n", str, err, ++die_counter);
+	pr_emerg("Internal error: %s: %x [#%d]" S_PREEMPT S_SMP S_ISA "\n",
+	         str, err, ++die_counter);
 
 	/* trap and error numbers are mostly meaningless on ARM */
 	ret = notify_die(DIE_OOPS, str, regs, err, tsk->thread.trap_no, SIGSEGV);
@@ -250,8 +250,8 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 
 	print_modules();
 	__show_regs(regs);
-	printk(KERN_EMERG "Process %.*s (pid: %d, stack limit = 0x%p)\n",
-		TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), end_of_stack(tsk));
+	pr_emerg("Process %.*s (pid: %d, stack limit = 0x%p)\n",
+		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), end_of_stack(tsk));
 
 	if (!user_mode(regs) || in_interrupt()) {
 		dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
@@ -446,7 +446,7 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 die_sig:
 #ifdef CONFIG_DEBUG_USER
 	if (user_debug & UDBG_UNDEFINED) {
-		printk(KERN_INFO "%s (%d): undefined instruction: pc=%p\n",
+		pr_info("%s (%d): undefined instruction: pc=%p\n",
 			current->comm, task_pid_nr(current), pc);
 		__show_regs(regs);
 		dump_instr(KERN_INFO, regs);
@@ -496,7 +496,7 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason)
 {
 	console_verbose();
 
-	printk(KERN_CRIT "Bad mode in %s handler detected\n", handler[reason]);
+	pr_crit("Bad mode in %s handler detected\n", handler[reason]);
 
 	die("Oops - bad mode", regs, 0);
 	local_irq_disable();
@@ -516,7 +516,7 @@ static int bad_syscall(int n, struct pt_regs *regs)
 
 #ifdef CONFIG_DEBUG_USER
 	if (user_debug & UDBG_SYSCALL) {
-		printk(KERN_ERR "[%d] %s: obsolete system call %08x.\n",
+		pr_err("[%d] %s: obsolete system call %08x.\n",
 			task_pid_nr(current), current->comm, n);
 		dump_instr(KERN_ERR, regs);
 	}
@@ -721,7 +721,7 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 	 * something catastrophic has happened
 	 */
 	if (user_debug & UDBG_SYSCALL) {
-		printk("[%d] %s: arm syscall %d\n",
+		pr_err("[%d] %s: arm syscall %d\n",
 		       task_pid_nr(current), current->comm, no);
 		dump_instr("", regs);
 		if (user_mode(regs)) {
@@ -780,8 +780,8 @@ late_initcall(arm_mrc_hook_init);
 
 void __bad_xchg(volatile void *ptr, int size)
 {
-	printk("xchg: bad data size: pc 0x%p, ptr 0x%p, size %d\n",
-		__builtin_return_address(0), ptr, size);
+	pr_err("xchg: bad data size: pc 0x%p, ptr 0x%p, size %d\n",
+	       __builtin_return_address(0), ptr, size);
 	BUG();
 }
 EXPORT_SYMBOL(__bad_xchg);
@@ -798,8 +798,8 @@ baddataabort(int code, unsigned long instr, struct pt_regs *regs)
 
 #ifdef CONFIG_DEBUG_USER
 	if (user_debug & UDBG_BADABORT) {
-		printk(KERN_ERR "[%d] %s: bad data abort: code %d instr 0x%08lx\n",
-			task_pid_nr(current), current->comm, code, instr);
+		pr_err("[%d] %s: bad data abort: code %d instr 0x%08lx\n",
+		       task_pid_nr(current), current->comm, code, instr);
 		dump_instr(KERN_ERR, regs);
 		show_pte(current->mm, addr);
 	}
@@ -815,29 +815,29 @@ baddataabort(int code, unsigned long instr, struct pt_regs *regs)
 
 void __readwrite_bug(const char *fn)
 {
-	printk("%s called, but not implemented\n", fn);
+	pr_err("%s called, but not implemented\n", fn);
 	BUG();
 }
 EXPORT_SYMBOL(__readwrite_bug);
 
 void __pte_error(const char *file, int line, pte_t pte)
 {
-	printk("%s:%d: bad pte %08llx.\n", file, line, (long long)pte_val(pte));
+	pr_err("%s:%d: bad pte %08llx.\n", file, line, (long long)pte_val(pte));
 }
 
 void __pmd_error(const char *file, int line, pmd_t pmd)
 {
-	printk("%s:%d: bad pmd %08llx.\n", file, line, (long long)pmd_val(pmd));
+	pr_err("%s:%d: bad pmd %08llx.\n", file, line, (long long)pmd_val(pmd));
 }
 
 void __pgd_error(const char *file, int line, pgd_t pgd)
 {
-	printk("%s:%d: bad pgd %08llx.\n", file, line, (long long)pgd_val(pgd));
+	pr_err("%s:%d: bad pgd %08llx.\n", file, line, (long long)pgd_val(pgd));
 }
 
 asmlinkage void __div0(void)
 {
-	printk("Division by zero in kernel.\n");
+	pr_err("Division by zero in kernel.\n");
 	dump_stack();
 }
 EXPORT_SYMBOL(__div0);
diff --git a/arch/arm/kernel/xscale-cp0.c b/arch/arm/kernel/xscale-cp0.c
index e42adc6bcdb1..bdbb8853a19b 100644
--- a/arch/arm/kernel/xscale-cp0.c
+++ b/arch/arm/kernel/xscale-cp0.c
@@ -157,15 +157,14 @@ static int __init xscale_cp0_init(void)
 
 	if (cpu_has_iwmmxt()) {
 #ifndef CONFIG_IWMMXT
-		printk(KERN_WARNING "CAUTION: XScale iWMMXt coprocessor "
-			"detected, but kernel support is missing.\n");
+		pr_warn("CAUTION: XScale iWMMXt coprocessor detected, but kernel support is missing.\n");
 #else
-		printk(KERN_INFO "XScale iWMMXt coprocessor detected.\n");
+		pr_info("XScale iWMMXt coprocessor detected.\n");
 		elf_hwcap |= HWCAP_IWMMXT;
 		thread_register_notifier(&iwmmxt_notifier_block);
 #endif
 	} else {
-		printk(KERN_INFO "XScale DSP coprocessor detected.\n");
+		pr_info("XScale DSP coprocessor detected.\n");
 		thread_register_notifier(&dsp_notifier_block);
 		cp_access |= 1;
 	}
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index 83792f4324ea..2c0c541c60ca 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -113,7 +113,7 @@ static int safe_usermode(int new_usermode, bool warn)
 		new_usermode |= UM_FIXUP;
 
 		if (warn)
-			printk(KERN_WARNING "alignment: ignoring faults is unsafe on this CPU.  Defaulting to fixup mode.\n");
+			pr_warn("alignment: ignoring faults is unsafe on this CPU.  Defaulting to fixup mode.\n");
 	}
 
 	return new_usermode;
@@ -523,7 +523,7 @@ do_alignment_ldmstm(unsigned long addr, unsigned long instr, struct pt_regs *reg
 	 * processor for us.
 	 */
 	if (addr != eaddr) {
-		printk(KERN_ERR "LDMSTM: PC = %08lx, instr = %08lx, "
+		pr_err("LDMSTM: PC = %08lx, instr = %08lx, "
 			"addr = %08lx, eaddr = %08lx\n",
 			 instruction_pointer(regs), instr, addr, eaddr);
 		show_regs(regs);
@@ -567,7 +567,7 @@ do_alignment_ldmstm(unsigned long addr, unsigned long instr, struct pt_regs *reg
 	return TYPE_FAULT;
 
 bad:
-	printk(KERN_ERR "Alignment trap: not handling ldm with s-bit set\n");
+	pr_err("Alignment trap: not handling ldm with s-bit set\n");
 	return TYPE_ERROR;
 }
 
@@ -899,13 +899,13 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	return 0;
 
  swp:
-	printk(KERN_ERR "Alignment trap: not handling swp instruction\n");
+	pr_err("Alignment trap: not handling swp instruction\n");
 
  bad:
 	/*
 	 * Oops, we didn't handle the instruction.
 	 */
-	printk(KERN_ERR "Alignment trap: not handling instruction "
+	pr_err("Alignment trap: not handling instruction "
 		"%0*lx at [<%08lx>]\n",
 		isize << 1,
 		isize == 2 ? tinstr : instr, instrptr);
diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
index e028a7f2ebcc..097181e08c25 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -313,7 +313,7 @@ static void __init disable_l2_prefetch(void)
 	 */
 	u = read_extra_features();
 	if (!(u & 0x01000000)) {
-		printk(KERN_INFO "Feroceon L2: Disabling L2 prefetch.\n");
+		pr_info("Feroceon L2: Disabling L2 prefetch.\n");
 		write_extra_features(u | 0x01000000);
 	}
 }
@@ -326,7 +326,7 @@ static void __init enable_l2(void)
 	if (!(u & 0x00400000)) {
 		int i, d;
 
-		printk(KERN_INFO "Feroceon L2: Enabling L2\n");
+		pr_info("Feroceon L2: Enabling L2\n");
 
 		d = flush_and_disable_dcache();
 		i = invalidate_and_disable_icache();
@@ -353,7 +353,7 @@ void __init feroceon_l2_init(int __l2_wt_override)
 
 	enable_l2();
 
-	printk(KERN_INFO "Feroceon L2: Cache support initialised%s.\n",
+	pr_info("Feroceon L2: Cache support initialised%s.\n",
 			 l2_wt_override ? ", in WT override mode" : "");
 }
 #ifdef CONFIG_OF
diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index b273739e6359..1e373d268c04 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -185,7 +185,7 @@ static void enable_extra_feature(unsigned int features)
 		u &= ~0x01000000;
 	else
 		u |= 0x01000000;
-	printk(KERN_INFO "Tauros2: %s L2 prefetch.\n",
+	pr_info("Tauros2: %s L2 prefetch.\n",
 			(features & CACHE_TAUROS2_PREFETCH_ON)
 			? "Enabling" : "Disabling");
 
@@ -193,7 +193,7 @@ static void enable_extra_feature(unsigned int features)
 		u |= 0x00100000;
 	else
 		u &= ~0x00100000;
-	printk(KERN_INFO "Tauros2: %s line fill burt8.\n",
+	pr_info("Tauros2: %s line fill burt8.\n",
 			(features & CACHE_TAUROS2_LINEFILL_BURST8)
 			? "Enabling" : "Disabling");
 
@@ -216,7 +216,7 @@ static void __init tauros2_internal_init(unsigned int features)
 		 */
 		feat = read_extra_features();
 		if (!(feat & 0x00400000)) {
-			printk(KERN_INFO "Tauros2: Enabling L2 cache.\n");
+			pr_info("Tauros2: Enabling L2 cache.\n");
 			write_extra_features(feat | 0x00400000);
 		}
 
@@ -253,7 +253,7 @@ static void __init tauros2_internal_init(unsigned int features)
 		 */
 		actlr = read_actlr();
 		if (!(actlr & 0x00000002)) {
-			printk(KERN_INFO "Tauros2: Enabling L2 cache.\n");
+			pr_info("Tauros2: Enabling L2 cache.\n");
 			write_actlr(actlr | 0x00000002);
 		}
 
@@ -262,11 +262,11 @@ static void __init tauros2_internal_init(unsigned int features)
 #endif
 
 	if (mode == NULL) {
-		printk(KERN_CRIT "Tauros2: Unable to detect CPU mode.\n");
+		pr_crit("Tauros2: Unable to detect CPU mode.\n");
 		return;
 	}
 
-	printk(KERN_INFO "Tauros2: L2 cache support initialised "
+	pr_info("Tauros2: L2 cache support initialised "
 			 "in %s mode.\n", mode);
 }
 
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index ff379ac115df..d9e0d00a6699 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -235,7 +235,7 @@ void __init check_writebuffer_bugs(void)
 	const char *reason;
 	unsigned long v = 1;
 
-	printk(KERN_INFO "CPU: Testing write buffer coherency: ");
+	pr_info("CPU: Testing write buffer coherency: ");
 
 	page = alloc_page(GFP_KERNEL);
 	if (page) {
@@ -261,9 +261,9 @@ void __init check_writebuffer_bugs(void)
 	}
 
 	if (v) {
-		printk("failed, %s\n", reason);
+		pr_cont("failed, %s\n", reason);
 		shared_pte_mask = L_PTE_MT_UNCACHED;
 	} else {
-		printk("ok\n");
+		pr_cont("ok\n");
 	}
 }
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index eb8830a4c5ed..a982dc3190df 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -63,9 +63,9 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 	if (!mm)
 		mm = &init_mm;
 
-	printk(KERN_ALERT "pgd = %p\n", mm->pgd);
+	pr_alert("pgd = %p\n", mm->pgd);
 	pgd = pgd_offset(mm, addr);
-	printk(KERN_ALERT "[%08lx] *pgd=%08llx",
+	pr_alert("[%08lx] *pgd=%08llx",
 			addr, (long long)pgd_val(*pgd));
 
 	do {
@@ -77,31 +77,31 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 			break;
 
 		if (pgd_bad(*pgd)) {
-			printk("(bad)");
+			pr_cont("(bad)");
 			break;
 		}
 
 		pud = pud_offset(pgd, addr);
 		if (PTRS_PER_PUD != 1)
-			printk(", *pud=%08llx", (long long)pud_val(*pud));
+			pr_cont(", *pud=%08llx", (long long)pud_val(*pud));
 
 		if (pud_none(*pud))
 			break;
 
 		if (pud_bad(*pud)) {
-			printk("(bad)");
+			pr_cont("(bad)");
 			break;
 		}
 
 		pmd = pmd_offset(pud, addr);
 		if (PTRS_PER_PMD != 1)
-			printk(", *pmd=%08llx", (long long)pmd_val(*pmd));
+			pr_cont(", *pmd=%08llx", (long long)pmd_val(*pmd));
 
 		if (pmd_none(*pmd))
 			break;
 
 		if (pmd_bad(*pmd)) {
-			printk("(bad)");
+			pr_cont("(bad)");
 			break;
 		}
 
@@ -110,15 +110,15 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 			break;
 
 		pte = pte_offset_map(pmd, addr);
-		printk(", *pte=%08llx", (long long)pte_val(*pte));
+		pr_cont(", *pte=%08llx", (long long)pte_val(*pte));
 #ifndef CONFIG_ARM_LPAE
-		printk(", *ppte=%08llx",
+		pr_cont(", *ppte=%08llx",
 		       (long long)pte_val(pte[PTE_HWTABLE_PTRS]));
 #endif
 		pte_unmap(pte);
 	} while(0);
 
-	printk("\n");
+	pr_cont("\n");
 }
 #else					/* CONFIG_MMU */
 void show_pte(struct mm_struct *mm, unsigned long addr)
@@ -142,10 +142,9 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 	 * No handler, we'll have to terminate things with extreme prejudice.
 	 */
 	bust_spinlocks(1);
-	printk(KERN_ALERT
-		"Unable to handle kernel %s at virtual address %08lx\n",
-		(addr < PAGE_SIZE) ? "NULL pointer dereference" :
-		"paging request", addr);
+	pr_alert("Unable to handle kernel %s@virtual address %08lx\n",
+		 (addr < PAGE_SIZE) ? "NULL pointer dereference" :
+		 "paging request", addr);
 
 	show_pte(mm, addr);
 	die("Oops", regs, fsr);
@@ -551,7 +550,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
 		return;
 
-	printk(KERN_ALERT "Unhandled fault: %s (0x%03x) at 0x%08lx\n",
+	pr_alert("Unhandled fault: %s (0x%03x) at 0x%08lx\n",
 		inf->name, fsr, addr);
 
 	info.si_signo = inf->sig;
@@ -583,7 +582,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
 		return;
 
-	printk(KERN_ALERT "Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
+	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
 		inf->name, ifsr, addr);
 
 	info.si_signo = inf->sig;
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 92bba32d9230..6ca53c338519 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -67,7 +67,7 @@ early_param("initrd", early_initrd);
 
 static int __init parse_tag_initrd(const struct tag *tag)
 {
-	printk(KERN_WARNING "ATAG_INITRD is deprecated; "
+	pr_warn("ATAG_INITRD is deprecated; "
 		"please update your bootloader.\n");
 	phys_initrd_start = __virt_to_phys(tag->u.initrd.start);
 	phys_initrd_size = tag->u.initrd.size;
@@ -544,7 +544,7 @@ void __init mem_init(void)
 #define MLM(b, t) b, t, ((t) - (b)) >> 20
 #define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
 
-	printk(KERN_NOTICE "Virtual kernel memory layout:\n"
+	pr_notice("Virtual kernel memory layout:\n"
 			"    vector  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
 #ifdef CONFIG_HAVE_TCM
 			"    DTCM    : 0x%08lx - 0x%08lx   (%4ld kB)\n"
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9f98cec7fe1e..d028dc74a9d5 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -192,7 +192,7 @@ early_param("cachepolicy", early_cachepolicy);
 static int __init early_nocache(char *__unused)
 {
 	char *p = "buffered";
-	printk(KERN_WARNING "nocache is deprecated; use cachepolicy=%s\n", p);
+	pr_warn("nocache is deprecated; use cachepolicy=%s\n", p);
 	early_cachepolicy(p);
 	return 0;
 }
@@ -201,7 +201,7 @@ early_param("nocache", early_nocache);
 static int __init early_nowrite(char *__unused)
 {
 	char *p = "uncached";
-	printk(KERN_WARNING "nowb is deprecated; use cachepolicy=%s\n", p);
+	pr_warn("nowb is deprecated; use cachepolicy=%s\n", p);
 	early_cachepolicy(p);
 	return 0;
 }
@@ -786,8 +786,7 @@ static void __init create_36bit_mapping(struct map_desc *md,
 	length = PAGE_ALIGN(md->length);
 
 	if (!(cpu_architecture() >= CPU_ARCH_ARMv6 || cpu_is_xsc3())) {
-		printk(KERN_ERR "MM: CPU does not support supersection "
-		       "mapping for 0x%08llx at 0x%08lx\n",
+		pr_err("MM: CPU does not support supersection mapping for 0x%08llx at 0x%08lx\n",
 		       (long long)__pfn_to_phys((u64)md->pfn), addr);
 		return;
 	}
@@ -799,15 +798,13 @@ static void __init create_36bit_mapping(struct map_desc *md,
 	 *	of the actual domain assignments in use.
 	 */
 	if (type->domain) {
-		printk(KERN_ERR "MM: invalid domain in supersection "
-		       "mapping for 0x%08llx at 0x%08lx\n",
+		pr_err("MM: invalid domain in supersection mapping for 0x%08llx at 0x%08lx\n",
 		       (long long)__pfn_to_phys((u64)md->pfn), addr);
 		return;
 	}
 
 	if ((addr | length | __pfn_to_phys(md->pfn)) & ~SUPERSECTION_MASK) {
-		printk(KERN_ERR "MM: cannot create mapping for 0x%08llx"
-		       " at 0x%08lx invalid alignment\n",
+		pr_err("MM: cannot create mapping for 0x%08llx at 0x%08lx invalid alignment\n",
 		       (long long)__pfn_to_phys((u64)md->pfn), addr);
 		return;
 	}
@@ -850,18 +847,16 @@ static void __init create_mapping(struct map_desc *md)
 	pgd_t *pgd;
 
 	if (md->virtual != vectors_base() && md->virtual < TASK_SIZE) {
-		printk(KERN_WARNING "BUG: not creating mapping for 0x%08llx"
-		       "@0x%08lx in user region\n",
-		       (long long)__pfn_to_phys((u64)md->pfn), md->virtual);
+		pr_warn("BUG: not creating mapping for 0x%08llx at 0x%08lx in user region\n",
+			(long long)__pfn_to_phys((u64)md->pfn), md->virtual);
 		return;
 	}
 
 	if ((md->type == MT_DEVICE || md->type == MT_ROM) &&
 	    md->virtual >= PAGE_OFFSET &&
 	    (md->virtual < VMALLOC_START || md->virtual >= VMALLOC_END)) {
-		printk(KERN_WARNING "BUG: mapping for 0x%08llx"
-		       " at 0x%08lx out of vmalloc space\n",
-		       (long long)__pfn_to_phys((u64)md->pfn), md->virtual);
+		pr_warn("BUG: mapping for 0x%08llx at 0x%08lx out of vmalloc space\n",
+			(long long)__pfn_to_phys((u64)md->pfn), md->virtual);
 	}
 
 	type = &mem_types[md->type];
@@ -881,9 +876,8 @@ static void __init create_mapping(struct map_desc *md)
 	length = PAGE_ALIGN(md->length + (md->virtual & ~PAGE_MASK));
 
 	if (type->prot_l1 == 0 && ((addr | phys | length) & ~SECTION_MASK)) {
-		printk(KERN_WARNING "BUG: map for 0x%08llx at 0x%08lx can not "
-		       "be mapped using pages, ignoring.\n",
-		       (long long)__pfn_to_phys(md->pfn), addr);
+		pr_warn("BUG: map for 0x%08llx at 0x%08lx can not be mapped using pages, ignoring.\n",
+			(long long)__pfn_to_phys(md->pfn), addr);
 		return;
 	}
 
@@ -1053,15 +1047,13 @@ static int __init early_vmalloc(char *arg)
 
 	if (vmalloc_reserve < SZ_16M) {
 		vmalloc_reserve = SZ_16M;
-		printk(KERN_WARNING
-			"vmalloc area too small, limiting to %luMB\n",
+		pr_warn("vmalloc area too small, limiting to %luMB\n",
 			vmalloc_reserve >> 20);
 	}
 
 	if (vmalloc_reserve > VMALLOC_END - (PAGE_OFFSET + SZ_32M)) {
 		vmalloc_reserve = VMALLOC_END - (PAGE_OFFSET + SZ_32M);
-		printk(KERN_WARNING
-			"vmalloc area is too big, limiting to %luMB\n",
+		pr_warn("vmalloc area is too big, limiting to %luMB\n",
 			vmalloc_reserve >> 20);
 	}
 
@@ -1094,7 +1086,7 @@ void __init sanity_check_meminfo(void)
 
 			if (highmem) {
 				pr_notice("Ignoring RAM at %pa-%pa (!CONFIG_HIGHMEM)\n",
-					&block_start, &block_end);
+					  &block_start, &block_end);
 				memblock_remove(reg->base, reg->size);
 				continue;
 			}
@@ -1103,7 +1095,7 @@ void __init sanity_check_meminfo(void)
 				phys_addr_t overlap_size = reg->size - size_limit;
 
 				pr_notice("Truncating RAM at %pa-%pa to -%pa",
-				      &block_start, &block_end, &vmalloc_limit);
+					  &block_start, &block_end, &vmalloc_limit);
 				memblock_remove(vmalloc_limit, overlap_size);
 				block_end = vmalloc_limit;
 			}
diff --git a/arch/arm/nwfpe/fpmodule.c b/arch/arm/nwfpe/fpmodule.c
index 4e729f055a81..b2a9182acf14 100644
--- a/arch/arm/nwfpe/fpmodule.c
+++ b/arch/arm/nwfpe/fpmodule.c
@@ -86,12 +86,12 @@ extern void nwfpe_enter(void);
 static int __init fpe_init(void)
 {
 	if (sizeof(FPA11) > sizeof(union fp_state)) {
-		printk(KERN_ERR "nwfpe: bad structure size\n");
+		pr_err("nwfpe: bad structure size\n");
 		return -EINVAL;
 	}
 
 	if (sizeof(FPREG) != 12) {
-		printk(KERN_ERR "nwfpe: bad register size\n");
+		pr_err("nwfpe: bad register size\n");
 		return -EINVAL;
 	}
 	if (fpe_type[0] && strcmp(fpe_type, "nwfpe"))
diff --git a/arch/arm/vfp/vfpsingle.c b/arch/arm/vfp/vfpsingle.c
index 4f96c1617aae..f0465ba0f221 100644
--- a/arch/arm/vfp/vfpsingle.c
+++ b/arch/arm/vfp/vfpsingle.c
@@ -290,7 +290,7 @@ u32 vfp_estimate_sqrt_significand(u32 exponent, u32 significand)
 	u32 z, a;
 
 	if ((significand & 0xc0000000) != 0x40000000) {
-		printk(KERN_WARNING "VFP: estimate_sqrt: invalid significand\n");
+		pr_warn("VFP: estimate_sqrt: invalid significand\n");
 	}
 
 	a = significand << 1;
-- 
1.8.3.1
