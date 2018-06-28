From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Jun 2018 17:46:47 +0100
Subject: [PATCH v2 3/4] arm64: IPI each CPU after invalidating the
 I-cache for kernel mappings
In-Reply-To: <20180628160005.cywb6vn7jl4v7kmb@armageddon.cambridge.arm.com>
References: <1529656278-878-1-git-send-email-will.deacon@arm.com>
 <1529656278-878-4-git-send-email-will.deacon@arm.com>
 <20180628160005.cywb6vn7jl4v7kmb@armageddon.cambridge.arm.com>
Message-ID: <20180628164646.GC10751@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Thu, Jun 28, 2018 at 05:00:05PM +0100, Catalin Marinas wrote:
> On Fri, Jun 22, 2018 at 09:31:17AM +0100, Will Deacon wrote:
> > When invalidating the instruction cache for a kernel mapping via
> > flush_icache_range(), it is also necessary to flush the pipeline for
> > other CPUs so that instructions fetched into the pipeline before the
> > I-cache invalidation are discarded. For example, if module 'foo' is
> > unloaded and then module 'bar' is loaded into the same area of memory,
> > a CPU could end up executing instructions from 'foo' when branching into
> > 'bar' if these instructions were fetched into the pipeline before 'foo'
> > was unloaded.
> > 
> > Whilst this is highly unlikely to occur in practice, particularly as
> > any exception acts as a context-synchronizing operation, following the
> > letter of the architecture requires us to execute an ISB on each CPU
> > in order for the new instruction stream to be visible.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> I hit a warning via kgdb_flush_swbreak_addr() because if IRQs disabled
> (and it actually deadlocks for me; running as a guest under KVM on TX1):
> 
> WARNING: CPU: 3 PID: 1 at /home/cmarinas/work/Linux/linux-2.6-aarch64/kernel/smp.c:416 smp_call_function_many+0xd4/0x350
> Modules linked in:
> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.18.0-rc2-00006-ga5cfc8429d36 #97
> Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> pstate: 200003c5 (nzCv DAIF -PAN -UAO)
> pc : smp_call_function_many+0xd4/0x350
> lr : smp_call_function+0x38/0x68
> sp : ffff0000080737f0
> x29: ffff0000080737f0 x28: ffff000009169000 
> x27: 0000000000000003 x26: 0000000000000000 
> x25: ffff00000815a3d0 x24: 0000000000000001 
> x23: 0000000000000000 x22: ffff000008eba730 
> x21: ffff000009169940 x20: 0000000000000000 
> x19: 0000000000000003 x18: ffffffffffffffff 
> x17: 0000000000000001 x16: 0000000000000019 
> x15: ffff0000091696c8 x14: ffff00008930ef07 
> x13: ffff00000930ef1d x12: 0000000000000010 
> x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f 
> x9 : 656565652aff6223 x8 : ffffffffffffffff 
> x7 : fefefefefefefefe x6 : ffff7dfffe7fe014 
> x5 : ffff000009169940 x4 : ffff000009147018 
> x3 : 0000000000000001 x2 : 0000000000000000 
> x1 : ffff00000815a3d0 x0 : 0000000000000000 
> Call trace:
>  smp_call_function_many+0xd4/0x350
>  smp_call_function+0x38/0x68
>  kick_all_cpus_sync+0x20/0x28
>  kgdb_flush_swbreak_addr+0x14/0x20
>  dbg_activate_sw_breakpoints+0x74/0xb0
>  gdb_serial_stub+0x6ec/0xc80
>  kgdb_cpu_enter+0x36c/0x578

Yuck, this is horrible. We don't actually need the IPI in this case because
kgdb is using smp_call_function to roundup the secondary cores, but the core
code doesn't have the flexibility for us to hook the operation like that.
All it provides is a CACHE_FLUSH_IS_SAFE #define, which you can set to 0 if
the maintenance isn't safe in IRQ-disabled context. However, there isn't a
fall-back and the maintenance is just not performed at all in that case.

If we had a "flush the entire D-cache to PoU" instruction, we could hack
something into the backend (MIPS does this) but we don't. The best I can
come up with is the nasty hack below.

Will

--->8

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index a0ec27066e6f..5a15d3ce3f0e 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -89,6 +89,19 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
 	 * IPI all online CPUs so that they undergo a context synchronization
 	 * event and are forced to refetch the new instructions.
 	 */
+#ifdef CONFIG_KGDB
+	/*
+	 * KGDB performs cache maintenance with interrupts disabled, so we
+	 * will deadlock trying to IPI the secondary CPUs. In theory, we can
+	 * set CACHE_FLUSH_IS_SAFE to 0 to avoid this known issue, but that
+	 * just means that KGDB will elide the maintenance altogether! As it
+	 * turns out, KGDB uses IPIs to round-up the secondary CPUs during
+	 * the patching operation, so we don't need extra IPIs here anyway.
+	 * In which case, add a KGDB-specific bodge and return early.
+	 */
+	if (kgdb_connected && irqs_disabled())
+		return;
+#endif
 	kick_all_cpus_sync();
 }
 
