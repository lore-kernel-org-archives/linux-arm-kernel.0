From: pmladek@suse.com (Petr Mladek)
Date: Tue, 9 Aug 2016 14:35:19 +0200
Subject: [PATCH v7 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
In-Reply-To: <1470672218-16059-2-git-send-email-cmetcalf@mellanox.com>
References: <1470672218-16059-1-git-send-email-cmetcalf@mellanox.com>
 <1470672218-16059-2-git-send-email-cmetcalf@mellanox.com>
Message-ID: <20160809123519.GE13300@pathway.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2016-08-08 12:03:35, Chris Metcalf wrote:
> Currently you can only request a backtrace of either all cpus, or
> all cpus but yourself.  It can also be helpful to request a remote
> backtrace of a single cpu, and since we want that, the logical
> extension is to support a cpumask as the underlying primitive.
> 
> This change modifies the existing lib/nmi_backtrace.c code to take
> a cpumask as its basic primitive, and modifies the linux/nmi.h code
> to use either the old "all/all_but_self" arch methods, or the new
> "cpumask" method, depending on which is available.

I seems to work fine. But I have some comments from the nitpicking
department, please see below.


> diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
> index f29501e1a5c1..6da698d54256 100644
> --- a/arch/x86/kernel/apic/hw_nmi.c
> +++ b/arch/x86/kernel/apic/hw_nmi.c
>  {
>  	apic->send_IPI_mask(mask, NMI_VECTOR);
>  }
>  
> -void arch_trigger_all_cpu_backtrace(bool include_self)
> +void arch_trigger_cpumask_backtrace(bool include_self, const cpumask_t *mask)
>  {
> -	nmi_trigger_all_cpu_backtrace(include_self, nmi_raise_cpu_backtrace);
> +	nmi_trigger_cpumask_backtrace(include_self, mask,
> +				      nmi_raise_cpu_backtrace);

It would make sense to rename too the functions in
in arch/x86/kernel/apic/hw_nmi.c that contains the "all_cpu"
in the name. In fact, the current names are rather confusing.
I suggest to do:

register_trigger_all_cpu_backtrace()
	-> register_nmi_cpu_backtrace_handler()

arch_trigger_all_cpu_backtrace_handler()
	-> nmi_cpu_backtrace_handler()


>  }
>  
>  static int

> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 4630eeae18e0..8e9ad95df219 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -31,38 +31,61 @@ static inline void hardlockup_detector_disable(void) {}
>  #endif
>  
>  /*
> - * Create trigger_all_cpu_backtrace() out of the arch-provided
> - * base function. Return whether such support was available,
> + * Create trigger_all_cpu_backtrace() etc out of the arch-provided
> + * base function(s). Return whether such support was available,
>   * to allow calling code to fall back to some other mechanism:
>   */
> -#ifdef arch_trigger_all_cpu_backtrace
>  static inline bool trigger_all_cpu_backtrace(void)
>  {
> +#if defined(arch_trigger_all_cpu_backtrace)
>  	arch_trigger_all_cpu_backtrace(true);
> -
>  	return true;
> +#elif defined(arch_trigger_cpumask_backtrace)
> +	arch_trigger_cpumask_backtrace(true, cpu_online_mask);
> +	return true;
> +#else
> +	return false;
> +#endif

Please, are there any plans to implement the cpumask variant also
on mips and sparc? So that all architectures are alligned again
and ifdefs reduced.


> diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
> index 26caf51cc238..5448d6621102 100644
> --- a/lib/nmi_backtrace.c
> +++ b/lib/nmi_backtrace.c
> @@ -17,7 +17,7 @@
>  #include <linux/kprobes.h>
>  #include <linux/nmi.h>
>  
> -#ifdef arch_trigger_all_cpu_backtrace
> +#ifdef arch_trigger_cpumask_backtrace
>  /* For reliability, we're prepared to waste bits here. */
>  static DECLARE_BITMAP(backtrace_mask, NR_CPUS) __read_mostly;
>  
> @@ -25,12 +25,13 @@ static DECLARE_BITMAP(backtrace_mask, NR_CPUS) __read_mostly;
>  static unsigned long backtrace_flag;
>  
>  /*
> - * When raise() is called it will be is passed a pointer to the
> + * When raise() is called it will be passed a pointer to the
>   * backtrace_mask. Architectures that call nmi_cpu_backtrace()
>   * directly from their raise() functions may rely on the mask
>   * they are passed being updated as a side effect of this call.
>   */
> -void nmi_trigger_all_cpu_backtrace(bool include_self,
> +void nmi_trigger_cpumask_backtrace(bool include_self,
> +				   const cpumask_t *mask,
>  				   void (*raise)(cpumask_t *mask))

The name "include_self" is confusing. The code does the opposite.
It excludes self when the value is false. I would rename it to
"exclude_self".

Also I would put the "mask" as the first parameter. The cpumask
is the main information. It is modified by the boolean. Finally
the NMI is raised by the "raise" function.


Best Regards,
Petr
