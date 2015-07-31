From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 31 Jul 2015 11:44:24 +0100
Subject: [PATCH 1/8] arm/xen: Remove helpers which are PV specific
In-Reply-To: <1438095769-2560-2-git-send-email-julien.grall@citrix.com>
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
 <1438095769-2560-2-git-send-email-julien.grall@citrix.com>
Message-ID: <alpine.DEB.2.02.1507311142580.11337@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Jul 2015, Julien Grall wrote:
> ARM guests are assimilated to HVM guest on ARM. The current
> implementation is assuming a 1:1 mapping which is only true for DOM0 and
> may not be at all in the future.
> 
> Furthermore, all the helpers but arbitrary_virt_to_machine are used in
> x86 specific code (or only compiled for).
> 
> The helper arbitrary_virt_to_machine is only used in PV specific code.
> Therefore we should never call the function.
> 
> Add a BUG() in this helper and drop all the others.
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>
> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/include/asm/xen/page.h | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
> index 1bee8ca..c2e9dcd 100644
> --- a/arch/arm/include/asm/xen/page.h
> +++ b/arch/arm/include/asm/xen/page.h
> @@ -54,26 +54,14 @@ static inline unsigned long mfn_to_pfn(unsigned long mfn)
>  
>  #define mfn_to_local_pfn(mfn) mfn_to_pfn(mfn)
>  
> -static inline xmaddr_t phys_to_machine(xpaddr_t phys)
> -{
> -	unsigned offset = phys.paddr & ~PAGE_MASK;
> -	return XMADDR(PFN_PHYS(pfn_to_mfn(PFN_DOWN(phys.paddr))) | offset);
> -}
> -
> -static inline xpaddr_t machine_to_phys(xmaddr_t machine)
> -{
> -	unsigned offset = machine.maddr & ~PAGE_MASK;
> -	return XPADDR(PFN_PHYS(mfn_to_pfn(PFN_DOWN(machine.maddr))) | offset);
> -}
>  /* VIRT <-> MACHINE conversion */
> -#define virt_to_machine(v)	(phys_to_machine(XPADDR(__pa(v))))
>  #define virt_to_mfn(v)		(pfn_to_mfn(virt_to_pfn(v)))
>  #define mfn_to_virt(m)		(__va(mfn_to_pfn(m) << PAGE_SHIFT))
>  
> +/* Only used in PV code. However ARM guest is always assimilated as HVM. */
                               ^ "However" doesn't make sense here from an
                               english grammer point of view.

Aside from this:

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  static inline xmaddr_t arbitrary_virt_to_machine(void *vaddr)
>  {
> -	/* TODO: assuming it is mapped in the kernel 1:1 */
> -	return virt_to_machine(vaddr);
> +	BUG();
>  }
>  
>  /* TODO: this shouldn't be here but it is because the frontend drivers
> -- 
> 2.1.4
> 
