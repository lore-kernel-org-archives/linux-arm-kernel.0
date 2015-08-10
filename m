From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Aug 2015 13:50:39 +0100
Subject: Disabling caches with MMU enabled
Message-ID: <20150810125039.GT7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an erratum for Cortex-A15 which contains this paragraph:

 2) Do not issue write-back cacheable stores at any time when the cache
 is disabled (SCTLR.C=0) and the MMU is enabled (SCTLR.M=1). Because it
 is implementation defined whether cacheable stores update the cache when
 the cache is disabled it is not expected that any portable code will
 execute cacheable stores when the cache is disabled.

The interesting part is the second sentence, which implies that having the
MMU enabled with writeback mappings, but with the C bit clear is not an
expected use case.  Moreover, it reinforces the ARM ARM statment that a
disabled cache may still be searched, and updated with written data.

However, the v7_exit_coherency_flush() function creates exactly this
scenario by clearing the C bit:

#define v7_exit_coherency_flush(level) \
        asm volatile( \
        ".arch  armv7-a \n\t" \
        "stmfd  sp!, {fp, ip} \n\t" \
        "mrc    p15, 0, r0, c1, c0, 0   @ get SCTLR \n\t" \
        "bic    r0, r0, #"__stringify(CR_C)" \n\t" \
        "mcr    p15, 0, r0, c1, c0, 0   @ set SCTLR \n\t" \
        "isb    \n\t" \

However, v7_exit_coherency_flush() is careful to disable caching, flush
the cache and then disable coherency.  Whether that's sufficient for all
cases is open to question - and where we need this CA15 errata implemented,
it implies that even this sequence is not permissible to use there.

tegra_disable_clean_inv_dcache() is an assembly version of something
similar to the above, and has the same concerns as the above.

Implementations which copy the ARM Ltd platforms CPU hotplug hack also
do this, but in a much more dirty way.  We really need people to stop
copying the ARM Ltd CPU hotplug hack - I'd go as far as saying that
arm-soc must stop merging code which introduces these, or (as I've
already said) which try to turn the ARM CPU hotplug hack into some
generic facility for platforms to make use of:

static inline void cpu_enter_lowpower(void)
{
        "       mrc     p15, 0, %0, c1, c0, 1\n"
        "       bic     %0, %0, %3\n"
        "       mcr     p15, 0, %0, c1, c0, 1\n"
...
          : "=&r" (v)
          : "r" (0), "Ir" (CR_C), "Ir" (0x40)
}

The exynos implementation of v7_exit_coherency() is another instance.

arch/arm/mach-shmobile/platsmp-apmu.c:cpu_enter_lowpower_a15() definitely
looks like it's a problem, because we are talking about Cortex-A15 there,
and the sequence is just turning off the C bit, but then reverting back
to C code to then call the cache flushing.  This is definitely unsafe.

I think all places which clear the C bit need to be re-reviewed and at
least some of them fixed, or converted to use a macro such as the
v7_exit_coherency_flush macro - and they should get a notice placed
on them to discourage copy-n-pasting it.

Incidentally, armada_370_xp_pmsu_idle_enter() should be fixed not to use
hard-coded constants in the assembly.  Use the "Ir" asm() constraint and
pass CR_C in.

Basically, grep for '\<CR_C\>' (quotes and backslashes required for
grep...)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
