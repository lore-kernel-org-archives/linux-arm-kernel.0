From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Thu, 26 Jul 2012 12:36:55 -0400
Subject: [Xen-devel] [PATCH 03/24] xen/arm: page.h definitions
In-Reply-To: <1343316846-25860-3-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-3-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20120726163655.GD9222@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 04:33:45PM +0100, Stefano Stabellini wrote:
> ARM Xen guests always use paging in hardware, like PV on HVM guests in
> the X86 world.

Nice, so no dealing with the P2M at all in the guest?

> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> ---
>  arch/arm/include/asm/xen/page.h |   77 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 77 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/include/asm/xen/page.h
> 
> diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
> new file mode 100644
> index 0000000..6cfe9a1
> --- /dev/null
> +++ b/arch/arm/include/asm/xen/page.h
> @@ -0,0 +1,77 @@
> +#ifndef _ASM_ARM_XEN_PAGE_H
> +#define _ASM_ARM_XEN_PAGE_H
> +
> +#include <asm/page.h>
> +#include <linux/pfn.h>
> +#include <linux/types.h>
> +#include <asm/pgtable.h>
> +#include <xen/interface/grant_table.h>

I don't if it makes such a difference, but putting the headers in sorted
order is sometimes nicer than just randomly.. But that might be just
me liking an orderly world nowadays :-)

> +
> +#define pfn_to_mfn(pfn)			(pfn)
> +#define phys_to_machine_mapping_valid	(1)
> +#define mfn_to_pfn(mfn)			(mfn)
> +#define mfn_to_virt(m)			(__va(mfn_to_pfn(m) << PAGE_SHIFT))
> +
> +#define pte_mfn	    pte_pfn
> +#define mfn_pte	    pfn_pte
> +
> +/* Xen machine address */
> +typedef struct xmaddr {
> +	phys_addr_t maddr;
> +} xmaddr_t;
> +
> +/* Xen pseudo-physical address */
> +typedef struct xpaddr {
> +	phys_addr_t paddr;
> +} xpaddr_t;
> +
> +#define XMADDR(x)	((xmaddr_t) { .maddr = (x) })
> +#define XPADDR(x)	((xpaddr_t) { .paddr = (x) })
> +
> +static inline xmaddr_t phys_to_machine(xpaddr_t phys)
> +{
> +	unsigned offset = phys.paddr & ~PAGE_MASK;
> +	return XMADDR(PFN_PHYS(pfn_to_mfn(PFN_DOWN(phys.paddr))) | offset);
> +}
> +
> +static inline xpaddr_t machine_to_phys(xmaddr_t machine)
> +{
> +	unsigned offset = machine.maddr & ~PAGE_MASK;
> +	return XPADDR(PFN_PHYS(mfn_to_pfn(PFN_DOWN(machine.maddr))) | offset);
> +}
> +/* VIRT <-> MACHINE conversion */
> +#define virt_to_machine(v)	(phys_to_machine(XPADDR(__pa(v))))
> +#define virt_to_pfn(v)          (PFN_DOWN(__pa(v)))
> +#define virt_to_mfn(v)		(pfn_to_mfn(virt_to_pfn(v)))
> +#define mfn_to_virt(m)		(__va(mfn_to_pfn(m) << PAGE_SHIFT))
> +
> +static inline xmaddr_t arbitrary_virt_to_machine(void *vaddr)
> +{
> +	/* XXX: assuming it is mapped in the kernel 1:1 */
> +	return virt_to_machine(vaddr);
> +}
> +
> +/* XXX: this shouldn't be here */

So why is it here?

> +static inline pte_t *lookup_address(unsigned long address, unsigned int *level)
> +{
> +	BUG();
> +	return NULL;
> +}
> +
> +static inline int m2p_add_override(unsigned long mfn, struct page *page,
> +		struct gnttab_map_grant_ref *kmap_op)
> +{
> +	return 0;
> +}
> +
> +static inline int m2p_remove_override(struct page *page, bool clear_pte)
> +{
> +	return 0;
> +}
> +
> +static inline bool set_phys_to_machine(unsigned long pfn, unsigned long mfn)
> +{
> +	BUG();
> +	return false;
> +}
> +#endif /* _ASM_ARM_XEN_PAGE_H */
> -- 
> 1.7.2.5
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
