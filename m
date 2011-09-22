From: gdavis@mvista.com (George G. Davis)
Date: Thu, 22 Sep 2011 03:29:59 -0400
Subject: parallel load of modules on an ARM multicore
In-Reply-To: <274124B9C6907D4B8CE985903EAA19E9185A92923E@SI-MBX06.de.bosch.com>
References: <274124B9C6907D4B8CE985903EAA19E9185A92923E@SI-MBX06.de.bosch.com>
Message-ID: <20110922072959.GA6897@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Jun 20, 2011 at 03:43:27PM +0200, EXTERNAL Waechtler Peter (Fa. TCP, CM-AI/PJ-CF31) wrote:
> Hi,
> 
> I'm getting unexpected results from loading several modules - some
> of them in parallel - on an ARM11 MPcore system.
> 
> The system does not use "single sequential" modprobe commands - instead it
> starts several shells doing insmod sequences like this:
> 
> shell A:
> insmod a
> insmod ab
> insmod abc
> 
> shell B:
> insmod b
> insmod bc
> insmod bcd
> 
> shell C:
> insmod c
> insmod cd
> insmod cde
> 
> This is done to crash^H^H^H^H^Hboot faster ;)
> 
> While one insmod operation is protected via the module_mutex - I'm wondering
> what happens with the instruction cache invalidation.
> AFAICT the flush_icache_range only invalidates the ICache on the running cpu.
> The module_mutex is unlocked after _loading_ the module, do_mod_ctors() and
> do_one_initcall() are called without that lock - can they run on a different cpu?
> It's an preemptible system (SMP PREEMPT armv6l).

In case anyone missed the subtlety, this report was for an ARM11 MPCore system
with CONFIG_PREEMPT enabled.  I've also been looking into this and various other
memory corruption issues on ARM11 MPCore with CONFIG_PREEMPT enabled and have
come to the conclusion that CONFIG_PREEMPT is broken on ARM11 MPCore.

I added the following instrumentation in 3.1.0-rc4ish to watch for
process migration in a few places of interest:

diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 22de005..e36d682 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -62,11 +62,18 @@ static inline pte_t *
 pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr)
 {
 	pte_t *pte;
+	int cpu = raw_smp_processor_id();
 
 	pte = (pte_t *)__get_free_page(PGALLOC_GFP);
 	if (pte)
 		clean_pte_table(pte);
 
+//	WARN_ON(cpu != raw_smp_processor_id());
+	if (cpu != raw_smp_processor_id())
+		printk(KERN_EMERG "%s:%d: cpu was %d but is now %d, memory corruption is possible\n",
+		       __func__, __LINE__, cpu, raw_smp_processor_id());
+
+
 	return pte;
 }
 
@@ -74,6 +81,7 @@ static inline pgtable_t
 pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	struct page *pte;
+	int cpu = raw_smp_processor_id();
 
 #ifdef CONFIG_HIGHPTE
 	pte = alloc_pages(PGALLOC_GFP | __GFP_HIGHMEM, 0);
@@ -86,6 +94,11 @@ pte_alloc_one(struct mm_struct *mm, unsigned long addr)
 		pgtable_page_ctor(pte);
 	}
 
+//	WARN_ON(cpu != raw_smp_processor_id());
+	if (cpu != raw_smp_processor_id())
+		printk(KERN_EMERG "%s:%d: cpu was %d but is now %d, memory corruption is possible\n",
+		       __func__, __LINE__, cpu, raw_smp_processor_id());
+
 	return pte;
 }
 
@@ -108,9 +121,14 @@ static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t pte,
 	unsigned long prot)
 {
 	unsigned long pmdval = (pte + PTE_HWTABLE_OFF) | prot;
+	int cpu = raw_smp_processor_id();
 	pmdp[0] = __pmd(pmdval);
 	pmdp[1] = __pmd(pmdval + 256 * sizeof(pte_t));
 	flush_pmd_entry(pmdp);
+//	WARN_ON(cpu != raw_smp_processor_id());
+	if (cpu != raw_smp_processor_id())
+		printk(KERN_EMERG "%s:%d: cpu was %d but is now %d, memory corruption is possible\n",
+		       __func__, __LINE__, cpu, raw_smp_processor_id());
 }
 
 /*
diff --git a/kernel/module.c b/kernel/module.c
index e0ddcec..6a43af8 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2807,6 +2807,7 @@ static struct module *load_module(void __user *umod,
 	struct load_info info = { NULL, };
 	struct module *mod;
 	long err;
+	int cpu = raw_smp_processor_id();
 
 	DEBUGP("load_module: umod=%p, len=%lu, uargs=%p\n",
 	       umod, len, uargs);
@@ -2852,6 +2853,9 @@ static struct module *load_module(void __user *umod,
 	if (err < 0)
 		goto free_modinfo;
 
+	if (cpu != raw_smp_processor_id())
+		printk(KERN_EMERG "%s:%d: cpu was %d but is now %d, memory corruption is possible\n",
+		       __func__, __LINE__, cpu, raw_smp_processor_id());
 	flush_module_icache(mod);
 
 	/* Now copy in args */

Now with sufficient system stress, I get the following recurring problems
(it's a 3-core system : ):

load_module:2858: cpu was 0 but is now 1, memory corruption is possible
load_module:2858: cpu was 0 but is now 2, memory corruption is possible
load_module:2858: cpu was 1 but is now 0, memory corruption is possible
load_module:2858: cpu was 1 but is now 2, memory corruption is possible
load_module:2858: cpu was 2 but is now 0, memory corruption is possible
load_module:2858: cpu was 2 but is now 1, memory corruption is possible
pte_alloc_one:100: cpu was 0 but is now 1, memory corruption is possible
pte_alloc_one:100: cpu was 0 but is now 2, memory corruption is possible
pte_alloc_one:100: cpu was 1 but is now 0, memory corruption is possible
pte_alloc_one:100: cpu was 1 but is now 2, memory corruption is possible
pte_alloc_one:100: cpu was 2 but is now 0, memory corruption is possible
pte_alloc_one:100: cpu was 2 but is now 1, memory corruption is possible
pte_alloc_one_kernel:74: cpu was 2 but is now 1, memory corruption is possible

With sufficient stress and extended run time, the system will eventually
hang or oops with non-sensical oops traces - machine state does not
make sense relative to the code excuting@the time of the oops.

The interesting point here is that each of the above contain critical
sections in which ARM11 MPCore memory is inconsistent, i.e. cache on
CPU A contains modified entries but then migration occurs and the
cache is flushed on CPU B yet those cache ops called in the above
cases do not implement ARM11 MPCore RWFO workarounds.  Furthermore,
the current ARM11 MPCore RWFO workarounds for DMA et al are unsafe
as well for the CONFIG_PREEMPT case because, again, process migration
can occur during DMA cache maintance operations in between RWFO and
cache op instructions resulting in memory inconsistencies for the
DMA case - a very narrow but real window.

So what's the recommendation, don't use CONFIG_PREEMPT on ARM11 MPCore?

Are there any known fixes for CONFIG_PREEMPT on ARM11 MPCore if it
is indeed broken as it appears?

Thanks in advance for comments.

--
Regards,
George

> 
> Wouldn't it be required to flush the icache on _all_ cpus?
> It might be highly dependable from the cache organization, but isn't it possible
> that the cpu that didn't load the module, is scheduled to run a function from it
> with a "stale" instruction cache line???
> 
> I sometimes see oopses where I wonder how such a state could be reached.
> The code and register state seem not to fit - looks like an interrupt does not
> restore all registers properly :)
> 
> Also an Oops happens when loading module abc, and still the module list is
> reported empty in the Oops despite the fact that "abc" depends on "a". Hmh.
> 
> 
> Best regards
> 
>         Peter
> 
> <snip kernel/module.c:SYSCALL_DEFINE3(init_module>
> [..]
>         /* Only one module load at a time, please */
>         if (mutex_lock_interruptible(&module_mutex) != 0)
>                 return -EINTR;
> 
>         /* Do all the hard work */
>         mod = load_module(umod, len, uargs);
>         if (IS_ERR(mod)) {
>                 mutex_unlock(&module_mutex);
>                 return PTR_ERR(mod);
>         }
> 
>         /* Drop lock so they can recurse */
>         mutex_unlock(&module_mutex);
> 
>         blocking_notifier_call_chain(&module_notify_list,
>                         MODULE_STATE_COMING, mod);
> 
>         do_mod_ctors(mod);
>         /* Start the module */
>         if (mod->init != NULL)
>                 ret = do_one_initcall(mod->init);
> </snip>
> 
> <snip kernel/module.c:load_module>
> [..]
>         old_fs = get_fs();
>         set_fs(KERNEL_DS);
> 
>         /*
>          * Flush the instruction cache, since we've played with text.
>          * Do it before processing of module parameters, so the module
>          * can provide parameter accessor functions of its own.
>          */
>         if (mod->module_init)
>                 flush_icache_range((unsigned long)mod->module_init,
>                                    (unsigned long)mod->module_init
>                                    + mod->init_size);
>         flush_icache_range((unsigned long)mod->module_core,
>                            (unsigned long)mod->module_core + mod->core_size);
> 
>         set_fs(old_fs);
> 
> </snip>
> 
> arch/arm/mm/cache-v6.S:
> 
> ENTRY(v6_flush_kern_cache_all)
>         mov     r0, #0
> #ifdef HARVARD_CACHE
>         mcr     p15, 0, r0, c7, c14, 0          @ D cache clean+invalidate
> #ifndef CONFIG_ARM_ERRATA_411920
>         mcr     p15, 0, r0, c7, c5, 0           @ I+BTB cache invalidate
> #else
>         b       v6_icache_inval_all
> #endif
> #else
>         mcr     p15, 0, r0, c7, c15, 0          @ Cache clean+invalidate
> #endif
>         mov     pc, lr
> 
> 
> 
> 
> 
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
