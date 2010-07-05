From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 05 Jul 2010 11:52:54 +0100
Subject: [patch 1/2] arm: Disable outer (L2) cache in kexec
In-Reply-To: <20100705092105.157256920@linutronix.de>
References: <20100705092105.157256920@linutronix.de>
Message-ID: <1278327174.11315.21.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-07-05 at 10:25 +0100, Thomas Gleixner wrote:
> kexec does not disable the outer cache before disabling the inner
> caches in cpu_proc_fin(). So L2 is enabled across the kexec jump. When
> the new kernel enables chaches again, it randomly crashes.
> 
> Disabling L2 before calling cpu_proc_fin() cures the problem.
> 
> Disabling L2 requires the following new functions: flush_all(),
> inv_all() and disable(). Add them to outer_cache_fns and call them
> from the kexec code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Index: linux-2.6/arch/arm/include/asm/outercache.h
> ===================================================================
> --- linux-2.6.orig/arch/arm/include/asm/outercache.h
> +++ linux-2.6/arch/arm/include/asm/outercache.h
> @@ -25,6 +25,9 @@ struct outer_cache_fns {
>         void (*inv_range)(unsigned long, unsigned long);
>         void (*clean_range)(unsigned long, unsigned long);
>         void (*flush_range)(unsigned long, unsigned long);
> +       void (*flush_all)(void);
> +       void (*inv_all)(void);
> +       void (*disable)(void);

Why don't we handle the flush_all/inv_all in the disable function and
avoid exporting them? Once exported, people may start using them in
drivers and they should use the DMA API for this. The inv_all is also
dangerous if called when the L2 is enabled.

> +static inline void outer_cache_disable(void)
> +{
> +       if (outer_cache.disable)
> +               outer_cache.disable();
> +}

Personal preference - "outer_disable()" as we don't call any of the
other functions outer_cache_*().

> --- linux-2.6.orig/arch/arm/kernel/machine_kexec.c
> +++ linux-2.6/arch/arm/kernel/machine_kexec.c
> @@ -74,7 +74,10 @@ void machine_kexec(struct kimage *image)
>                            (unsigned long) reboot_code_buffer + KEXEC_CONTROL_PAGE_SIZE);
>         printk(KERN_INFO "Bye!\n");
> 
> +       outer_flush_all();
> +       outer_cache_disable();
>         cpu_proc_fin();
> +       outer_inv_all();

As I said above, we could have just outer_disable() here which does
outer_flush_all, disabling and outer_inv_all. I don't think the
invalidation needs to be done after cup_proc_fin().

Thanks.

-- 
Catalin
