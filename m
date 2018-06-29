From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 29 Jun 2018 15:52:12 +0100
Subject: [PATCH v2 3/4] arm64: IPI each CPU after invalidating the
 I-cache for kernel mappings
In-Reply-To: <20180628164646.GC10751@arm.com>
References: <1529656278-878-1-git-send-email-will.deacon@arm.com>
 <1529656278-878-4-git-send-email-will.deacon@arm.com>
 <20180628160005.cywb6vn7jl4v7kmb@armageddon.cambridge.arm.com>
 <20180628164646.GC10751@arm.com>
Message-ID: <20180629145211.kuiigg3kgtpubbhj@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 05:46:47PM +0100, Will Deacon wrote:
> On Thu, Jun 28, 2018 at 05:00:05PM +0100, Catalin Marinas wrote:
> > On Fri, Jun 22, 2018 at 09:31:17AM +0100, Will Deacon wrote:
> > > When invalidating the instruction cache for a kernel mapping via
> > > flush_icache_range(), it is also necessary to flush the pipeline for
> > > other CPUs so that instructions fetched into the pipeline before the
> > > I-cache invalidation are discarded. For example, if module 'foo' is
> > > unloaded and then module 'bar' is loaded into the same area of memory,
> > > a CPU could end up executing instructions from 'foo' when branching into
> > > 'bar' if these instructions were fetched into the pipeline before 'foo'
> > > was unloaded.
> > > 
> > > Whilst this is highly unlikely to occur in practice, particularly as
> > > any exception acts as a context-synchronizing operation, following the
> > > letter of the architecture requires us to execute an ISB on each CPU
> > > in order for the new instruction stream to be visible.
> > > 
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > 
> > I hit a warning via kgdb_flush_swbreak_addr() because if IRQs disabled
> > (and it actually deadlocks for me; running as a guest under KVM on TX1):
[...]
> Yuck, this is horrible. We don't actually need the IPI in this case because
> kgdb is using smp_call_function to roundup the secondary cores, but the core
> code doesn't have the flexibility for us to hook the operation like that.
> All it provides is a CACHE_FLUSH_IS_SAFE #define, which you can set to 0 if
> the maintenance isn't safe in IRQ-disabled context. However, there isn't a
> fall-back and the maintenance is just not performed at all in that case.
> 
> If we had a "flush the entire D-cache to PoU" instruction, we could hack
> something into the backend (MIPS does this) but we don't. The best I can
> come up with is the nasty hack below.
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index a0ec27066e6f..5a15d3ce3f0e 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -89,6 +89,19 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
>  	 * IPI all online CPUs so that they undergo a context synchronization
>  	 * event and are forced to refetch the new instructions.
>  	 */
> +#ifdef CONFIG_KGDB
> +	/*
> +	 * KGDB performs cache maintenance with interrupts disabled, so we
> +	 * will deadlock trying to IPI the secondary CPUs. In theory, we can
> +	 * set CACHE_FLUSH_IS_SAFE to 0 to avoid this known issue, but that
> +	 * just means that KGDB will elide the maintenance altogether! As it
> +	 * turns out, KGDB uses IPIs to round-up the secondary CPUs during
> +	 * the patching operation, so we don't need extra IPIs here anyway.
> +	 * In which case, add a KGDB-specific bodge and return early.
> +	 */
> +	if (kgdb_connected && irqs_disabled())
> +		return;
> +#endif
>  	kick_all_cpus_sync();
>  }

It's indeed a hack but we can live with this. On the patch with this
hunk:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
