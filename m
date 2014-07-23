From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Jul 2014 12:16:09 +0100
Subject: [PATCHv4 3/5] common: dma-mapping: Introduce common remapping
 functions
In-Reply-To: <1406079308-5232-4-git-send-email-lauraa@codeaurora.org>
References: <1406079308-5232-1-git-send-email-lauraa@codeaurora.org>
 <1406079308-5232-4-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140723111608.GC1366@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 02:35:06AM +0100, Laura Abbott wrote:
> +void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
> +{
> +	struct vm_struct *area = find_vm_area(cpu_addr);
> +
> +	if (!area || (area->flags & vm_flags) != vm_flags) {
> +		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
> +		return;
> +	}
> +
> +	unmap_kernel_range((unsigned long)cpu_addr, size);
> +	vunmap(cpu_addr);
> +}

One more thing - is unmap_kernel_range() needed here? vunmap() ends up
calling vunmap_page_range(), same as unmap_kernel_range(). I think one
difference is that in the vunmap case, TLB flushing is done lazily.

-- 
Catalin
