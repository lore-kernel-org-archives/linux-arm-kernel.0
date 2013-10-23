From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Wed, 23 Oct 2013 10:04:57 -0400
Subject: [PATCH v8 17/19] grant-table: call set_phys_to_machine after
 mapping grant refs
In-Reply-To: <1382031814-8782-17-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1310171833520.26077@kaball.uk.xensource.com>
 <1382031814-8782-17-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20131023140457.GC27771@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 06:43:32PM +0100, Stefano Stabellini wrote:
> When mapping/unmapping grant refs, call
> set_phys_to_machine to update the P2M with the new mappings for
> autotranslate guests.

Heh. That sounds so odd (p2m + xlat).
Can you add a sentence saying that this is a mostly a nop on x86 please?

(Well, the call to set_phys_to_machine does end up with this check:

    if (unlikely(xen_feature(XENFEAT_auto_translated_physmap))) {
                BUG_ON(pfn != mfn && mfn != INVALID_P2M_ENTRY);
                return true;
        }    
But that should be a fairly small amount of code.


> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> ---
>  drivers/xen/grant-table.c |   17 +++++++++++++++--
>  1 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> index 04cdeb8..a36cb03 100644
> --- a/drivers/xen/grant-table.c
> +++ b/drivers/xen/grant-table.c
> @@ -49,6 +49,7 @@
>  #include <xen/grant_table.h>
>  #include <xen/interface/memory.h>
>  #include <xen/hvc-console.h>
> +#include <xen/swiotlb-xen.h>
>  #include <asm/xen/hypercall.h>
>  #include <asm/xen/interface.h>
>  
> @@ -889,8 +890,15 @@ int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
>  			gnttab_retry_eagain_gop(GNTTABOP_map_grant_ref, map_ops + i,
>  						&map_ops[i].status, __func__);
>  
> -	if (xen_feature(XENFEAT_auto_translated_physmap))
> +	if (xen_feature(XENFEAT_auto_translated_physmap)) {
> +		for (i = 0; i < count; i++) {
> +			if (map_ops[i].status)
> +				continue;
> +			set_phys_to_machine(map_ops[i].host_addr >> PAGE_SHIFT,
> +					map_ops[i].dev_bus_addr >> PAGE_SHIFT);
> +		}
>  		return ret;
> +	}
>  
>  	if (!in_interrupt() && paravirt_get_lazy_mode() == PARAVIRT_LAZY_NONE) {
>  		arch_enter_lazy_mmu_mode();
> @@ -933,8 +941,13 @@ int gnttab_unmap_refs(struct gnttab_unmap_grant_ref *unmap_ops,
>  	if (ret)
>  		return ret;
>  
> -	if (xen_feature(XENFEAT_auto_translated_physmap))
> +	if (xen_feature(XENFEAT_auto_translated_physmap)) {
> +		for (i = 0; i < count; i++) {
> +			set_phys_to_machine(unmap_ops[i].host_addr >> PAGE_SHIFT,
> +					INVALID_P2M_ENTRY);
> +		}
>  		return ret;
> +	}
>  
>  	if (!in_interrupt() && paravirt_get_lazy_mode() == PARAVIRT_LAZY_NONE) {
>  		arch_enter_lazy_mmu_mode();
> -- 
> 1.7.2.5
> 
