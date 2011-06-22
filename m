From: horms@verge.net.au (Simon Horman)
Date: Wed, 22 Jun 2011 18:55:32 +0900
Subject: [PATCH] ARM: conditional ioremap() fix for copy_oldmem_page()
In-Reply-To: <20110622034445.1936.16176.sendpatchset@t400s>
References: <20110622034445.1936.16176.sendpatchset@t400s>
Message-ID: <20110622095525.GC9215@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 12:44:45PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the copy_oldmem_page() function to ioremap() only
> when accessing memory that is outside the regular range
> of system memory that is managed by the kernel.
> 
> Without this patch a warning is triggered in the ARM-specific
> ioremap implementation, see WARN_ON(pfn_valid()) in ioremap.c
> 
> The copy_oldmem_page() function is used by the secondary crash
> kernel to access memory using the /proc/vmcore code implemented
> in fs/proc/vmcore.c. To pass information from the first kernel
> to the secondary crash kernel a kernel command line option is
> used to point out where the elf core hdr is located.
> 
> The crash kernel is loaded through kexec-tools which also contains
> code that reserves memory for the elfcorehdr= option. This memory
> block is reserved _inside_ the main system memory of the secondary
> kernel. The /proc/vmcore code in the secondary kernel is however
> using copy_oldmem_page() to access both this elfcorehdr area and
> the rest of the memory used by the the first kernel.
> 
> So the copy_oldmem_page() function is used to access data that
> may be located in system memory, or it may be outside. Always
> using ioremap will not work, so this patch makes it conditional
> based on pfn_valid().
> 
> For more details please look at the sh7372-based example here:
> http://permalink.gmane.org/gmane.linux.ports.sh.devel/11502
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Reviewed-by:  Simon Horman <horms@verge.net.au>

> ---
> 
>  arch/arm/kernel/crash_dump.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> --- 0001/arch/arm/kernel/crash_dump.c
> +++ work/arch/arm/kernel/crash_dump.c	2011-06-18 20:59:49.000000000 +0900
> @@ -39,9 +39,13 @@ ssize_t copy_oldmem_page(unsigned long p
>  	if (!csize)
>  		return 0;
>  
> -	vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
> -	if (!vaddr)
> -		return -ENOMEM;
> +	if (pfn_valid(pfn)) {
> +		vaddr = phys_to_virt(pfn << PAGE_SHIFT);
> +	} else {
> +		vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
> +		if (!vaddr)
> +			return -ENOMEM;
> +	}
>  
>  	if (userbuf) {
>  		if (copy_to_user(buf, vaddr + offset, csize)) {
> @@ -52,6 +56,8 @@ ssize_t copy_oldmem_page(unsigned long p
>  		memcpy(buf, vaddr + offset, csize);
>  	}
>  
> -	iounmap(vaddr);
> +	if (!pfn_valid(pfn))
> +		iounmap(vaddr);
> +
>  	return csize;
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
