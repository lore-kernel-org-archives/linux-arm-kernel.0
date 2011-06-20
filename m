From: external.Peter.Waechtler@de.bosch.com (EXTERNAL Waechtler Peter (Fa. TCP, CM-AI/PJ-CF31))
Date: Mon, 20 Jun 2011 15:43:27 +0200
Subject: parallel load of modules on an ARM multicore
Message-ID: <274124B9C6907D4B8CE985903EAA19E9185A92923E@SI-MBX06.de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm getting unexpected results from loading several modules - some
of them in parallel - on an ARM11 MPcore system.

The system does not use "single sequential" modprobe commands - instead it
starts several shells doing insmod sequences like this:

shell A:
insmod a
insmod ab
insmod abc

shell B:
insmod b
insmod bc
insmod bcd

shell C:
insmod c
insmod cd
insmod cde

This is done to crash^H^H^H^H^Hboot faster ;)

While one insmod operation is protected via the module_mutex - I'm wondering
what happens with the instruction cache invalidation.
AFAICT the flush_icache_range only invalidates the ICache on the running cpu.
The module_mutex is unlocked after _loading_ the module, do_mod_ctors() and
do_one_initcall() are called without that lock - can they run on a different cpu?
It's an preemptible system (SMP PREEMPT armv6l).

Wouldn't it be required to flush the icache on _all_ cpus?
It might be highly dependable from the cache organization, but isn't it possible
that the cpu that didn't load the module, is scheduled to run a function from it
with a "stale" instruction cache line???

I sometimes see oopses where I wonder how such a state could be reached.
The code and register state seem not to fit - looks like an interrupt does not
restore all registers properly :)

Also an Oops happens when loading module abc, and still the module list is
reported empty in the Oops despite the fact that "abc" depends on "a". Hmh.


Best regards

        Peter

<snip kernel/module.c:SYSCALL_DEFINE3(init_module>
[..]
        /* Only one module load at a time, please */
        if (mutex_lock_interruptible(&module_mutex) != 0)
                return -EINTR;

        /* Do all the hard work */
        mod = load_module(umod, len, uargs);
        if (IS_ERR(mod)) {
                mutex_unlock(&module_mutex);
                return PTR_ERR(mod);
        }

        /* Drop lock so they can recurse */
        mutex_unlock(&module_mutex);

        blocking_notifier_call_chain(&module_notify_list,
                        MODULE_STATE_COMING, mod);

        do_mod_ctors(mod);
        /* Start the module */
        if (mod->init != NULL)
                ret = do_one_initcall(mod->init);
</snip>

<snip kernel/module.c:load_module>
[..]
        old_fs = get_fs();
        set_fs(KERNEL_DS);

        /*
         * Flush the instruction cache, since we've played with text.
         * Do it before processing of module parameters, so the module
         * can provide parameter accessor functions of its own.
         */
        if (mod->module_init)
                flush_icache_range((unsigned long)mod->module_init,
                                   (unsigned long)mod->module_init
                                   + mod->init_size);
        flush_icache_range((unsigned long)mod->module_core,
                           (unsigned long)mod->module_core + mod->core_size);

        set_fs(old_fs);

</snip>

arch/arm/mm/cache-v6.S:

ENTRY(v6_flush_kern_cache_all)
        mov     r0, #0
#ifdef HARVARD_CACHE
        mcr     p15, 0, r0, c7, c14, 0          @ D cache clean+invalidate
#ifndef CONFIG_ARM_ERRATA_411920
        mcr     p15, 0, r0, c7, c5, 0           @ I+BTB cache invalidate
#else
        b       v6_icache_inval_all
#endif
#else
        mcr     p15, 0, r0, c7, c15, 0          @ Cache clean+invalidate
#endif
        mov     pc, lr
