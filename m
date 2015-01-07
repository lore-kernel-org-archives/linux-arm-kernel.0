From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Wed, 7 Jan 2015 09:50:50 -0500
Subject: [Bugfix] x86/apic: Fix xen IRQ allocation failure caused by
 commit b81975eade8c
In-Reply-To: <1420611244-25624-1-git-send-email-jiang.liu@linux.intel.com>
References: <1420611244-25624-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <20150107145050.GC30457@l.oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 02:13:49PM +0800, Jiang Liu wrote:
> Commit b81975eade8c ("x86, irq: Clean up irqdomain transition code")
> breaks xen IRQ allocation because xen_smp_prepare_cpus() doesn't invoke
> setup_IO_APIC(), so no irqdomains created for IOAPICs and
> mp_map_pin_to_irq() fails at the very beginning.
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -2369,31 +2369,29 @@ static void ioapic_destroy_irqdomain(int idx)
>  	ioapics[idx].pin_info = NULL;
>  }
>  
> -void __init setup_IO_APIC(void)
> +void __init setup_IO_APIC(bool xen_smp)
>  {
>  	int ioapic;
>  
> -	/*
> -	 * calling enable_IO_APIC() is moved to setup_local_APIC for BP
> -	 */
> -	io_apic_irqs = nr_legacy_irqs() ? ~PIC_IRQS : ~0UL;
> +	if (!xen_smp) {
> +		apic_printk(APIC_VERBOSE, "ENABLING IO-APIC IRQs\n");
> +		io_apic_irqs = nr_legacy_irqs() ? ~PIC_IRQS : ~0UL;
> +
> +		/* Set up IO-APIC IRQ routing. */
> +		x86_init.mpparse.setup_ioapic_ids();
> +		sync_Arb_IDs();
> +	}


Is there a specific reason that this cannot run in all cases?

What I am asking is why are we doing a special case here? The description
at the top implied that we were just missing an call to
setup_IO_APIC.. 

>  
> -	apic_printk(APIC_VERBOSE, "ENABLING IO-APIC IRQs\n");
>  	for_each_ioapic(ioapic)
>  		BUG_ON(mp_irqdomain_create(ioapic));
> -
> -	/*
> -         * Set up IO-APIC IRQ routing.
> -         */
> -	x86_init.mpparse.setup_ioapic_ids();
> -
> -	sync_Arb_IDs();
>  	setup_IO_APIC_irqs();
> -	init_IO_APIC_traps();
> -	if (nr_legacy_irqs())
> -		check_timer();
> -
>  	ioapic_initialized = 1;
> +
> +	if (!xen_smp) {
> +		init_IO_APIC_traps();
> +		if (nr_legacy_irqs())
> +			check_timer();
> +	}
>  }
>  
>  /*
> diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
> index 4c071aeb8417..7eb0283901fa 100644
> --- a/arch/x86/xen/smp.c
> +++ b/arch/x86/xen/smp.c
> @@ -326,7 +326,10 @@ static void __init xen_smp_prepare_cpus(unsigned int max_cpus)
>  
>  		xen_raw_printk(m);
>  		panic(m);
> +	} else {
> +		setup_IO_APIC(true);
>  	}
> +
>  	xen_init_lock_cpu(0);
>  
>  	smp_store_boot_cpu_info();
> -- 
> 1.7.10.4
> 
