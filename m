From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 7 Apr 2015 18:26:56 +0100
Subject: [PATCH v2 2/3] arm,arm64/xen: move Xen initialization earlier
In-Reply-To: <1424267513-15836-3-git-send-email-julien.grall@linaro.org>
References: <1424267513-15836-1-git-send-email-julien.grall@linaro.org>
 <1424267513-15836-3-git-send-email-julien.grall@linaro.org>
Message-ID: <alpine.DEB.2.02.1504071823510.7690@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

I think that this patch should go via the Xen tree, however as it
touches arch/arm/kernel/setup.c, I would like your Acked-by before
adding it to the Xen queue.

Thanks,

Stefano


On Wed, 18 Feb 2015, Julien Grall wrote:
> From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> 
> Currently, Xen is initialized/discovered in an initcall. This doesn't
> allow us to support earlyprintk or choosing the preferred console when
> running on Xen.
> 
> The current function xen_guest_init is now split in 2 parts:
>     - xen_early_init: Check if there is a Xen node in the device tree
>     and setup domain type
>     - xen_guest_init: Retrieve the information from the device node and
>     initialize Xen (grant table, shared page...)
> 
> The former is called in setup_arch, while the latter is an initcall.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Signed-off-by: Julien Grall <julien.grall@linaro.org>
> Acked-by: Ian Campbell <ian.campbell@citrix.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> 
> ---
>     It's based on a patch sent by Stefano nearly 2 years ago [1].
> 
>     [1] http://lists.xen.org/archives/html/xen-devel/2013-08/msg02960.html
> 
>     Changes in v2:
>         - Add Ian's ack
> ---
>  arch/arm/include/asm/xen/hypervisor.h |  8 +++++
>  arch/arm/kernel/setup.c               |  2 ++
>  arch/arm/xen/enlighten.c              | 58 ++++++++++++++++++++---------------
>  arch/arm64/kernel/setup.c             |  2 ++
>  4 files changed, 46 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/include/asm/xen/hypervisor.h b/arch/arm/include/asm/xen/hypervisor.h
> index 1317ee4..04ff8e7 100644
> --- a/arch/arm/include/asm/xen/hypervisor.h
> +++ b/arch/arm/include/asm/xen/hypervisor.h
> @@ -1,6 +1,8 @@
>  #ifndef _ASM_ARM_XEN_HYPERVISOR_H
>  #define _ASM_ARM_XEN_HYPERVISOR_H
>  
> +#include <linux/init.h>
> +
>  extern struct shared_info *HYPERVISOR_shared_info;
>  extern struct start_info *xen_start_info;
>  
> @@ -18,4 +20,10 @@ static inline enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
>  
>  extern struct dma_map_ops *xen_dma_ops;
>  
> +#ifdef CONFIG_XEN
> +void __init xen_early_init(void);
> +#else
> +static inline void xen_early_init(void) { return; }
> +#endif
> +
>  #endif /* _ASM_ARM_XEN_HYPERVISOR_H */
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index e55408e..8b59d0d 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -46,6 +46,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cachetype.h>
>  #include <asm/tlbflush.h>
> +#include <asm/xen/hypervisor.h>
>  
>  #include <asm/prom.h>
>  #include <asm/mach/arch.h>
> @@ -936,6 +937,7 @@ void __init setup_arch(char **cmdline_p)
>  
>  	arm_dt_init_cpu_maps();
>  	psci_init();
> +	xen_early_init();
>  #ifdef CONFIG_SMP
>  	if (is_smp()) {
>  		if (!mdesc->smp_init || !mdesc->smp_init()) {
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index c8d3a17..1660432 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -53,6 +53,8 @@ EXPORT_SYMBOL_GPL(xen_platform_pci_unplug);
>  
>  static __read_mostly unsigned int xen_events_irq;
>  
> +static __initdata struct device_node *xen_node;
> +
>  /* map fgmfn of domid to lpfn in the current domain */
>  static int map_foreign_page(unsigned long lpfn, unsigned long fgmfn,
>  			    unsigned int domid)
> @@ -222,42 +224,28 @@ static irqreturn_t xen_arm_callback(int irq, void *arg)
>   * documentation of the Xen Device Tree format.
>   */
>  #define GRANT_TABLE_PHYSADDR 0
> -static int __init xen_guest_init(void)
> +void __init xen_early_init(void)
>  {
> -	struct xen_add_to_physmap xatp;
> -	static struct shared_info *shared_info_page = 0;
> -	struct device_node *node;
>  	int len;
>  	const char *s = NULL;
>  	const char *version = NULL;
>  	const char *xen_prefix = "xen,xen-";
> -	struct resource res;
> -	phys_addr_t grant_frames;
>  
> -	node = of_find_compatible_node(NULL, NULL, "xen,xen");
> -	if (!node) {
> +	xen_node = of_find_compatible_node(NULL, NULL, "xen,xen");
> +	if (!xen_node) {
>  		pr_debug("No Xen support\n");
> -		return 0;
> +		return;
>  	}
> -	s = of_get_property(node, "compatible", &len);
> +	s = of_get_property(xen_node, "compatible", &len);
>  	if (strlen(xen_prefix) + 3  < len &&
>  			!strncmp(xen_prefix, s, strlen(xen_prefix)))
>  		version = s + strlen(xen_prefix);
>  	if (version == NULL) {
>  		pr_debug("Xen version not found\n");
> -		return 0;
> -	}
> -	if (of_address_to_resource(node, GRANT_TABLE_PHYSADDR, &res))
> -		return 0;
> -	grant_frames = res.start;
> -	xen_events_irq = irq_of_parse_and_map(node, 0);
> -	if (!xen_events_irq) {
> -		pr_debug("Xen event channel interrupt not found\n");
> -		return -ENODEV;
> +		return;
>  	}
>  
> -	pr_info("Xen %s support found, events_irq=%d gnttab_frame=%pa\n",
> -			version, xen_events_irq, &grant_frames);
> +	pr_info("Xen %s support found\n", version);
>  
>  	xen_domain_type = XEN_HVM_DOMAIN;
>  
> @@ -267,10 +255,32 @@ static int __init xen_guest_init(void)
>  		xen_start_info->flags |= SIF_INITDOMAIN|SIF_PRIVILEGED;
>  	else
>  		xen_start_info->flags &= ~(SIF_INITDOMAIN|SIF_PRIVILEGED);
> +}
> +
> +static int __init xen_guest_init(void)
> +{
> +	struct xen_add_to_physmap xatp;
> +	struct shared_info *shared_info_page = NULL;
> +	struct resource res;
> +	phys_addr_t grant_frames;
> +
> +	if (!xen_domain())
> +		return 0;
> +
> +	if (of_address_to_resource(xen_node, GRANT_TABLE_PHYSADDR, &res)) {
> +		pr_err("Xen grant table base address not found\n");
> +		return -ENODEV;
> +	}
> +	grant_frames = res.start;
> +
> +	xen_events_irq = irq_of_parse_and_map(xen_node, 0);
> +	if (!xen_events_irq) {
> +		pr_err("Xen event channel interrupt not found\n");
> +		return -ENODEV;
> +	}
> +
> +	shared_info_page = (struct shared_info *)get_zeroed_page(GFP_KERNEL);
>  
> -	if (!shared_info_page)
> -		shared_info_page = (struct shared_info *)
> -			get_zeroed_page(GFP_KERNEL);
>  	if (!shared_info_page) {
>  		pr_err("not enough memory\n");
>  		return -ENOMEM;
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index e8420f6..c00ae01 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -62,6 +62,7 @@
>  #include <asm/memblock.h>
>  #include <asm/psci.h>
>  #include <asm/efi.h>
> +#include <asm/xen/hypervisor.h>
>  
>  unsigned int processor_id;
>  EXPORT_SYMBOL(processor_id);
> @@ -388,6 +389,7 @@ void __init setup_arch(char **cmdline_p)
>  	unflatten_device_tree();
>  
>  	psci_init();
> +	xen_early_init();
>  
>  	cpu_read_bootcpu_ops();
>  #ifdef CONFIG_SMP
> -- 
> 2.1.4
> 
