From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 8 Sep 2014 15:06:09 +0100
Subject: [PATCH] efi/arm64: fix fdt-related memory reservation
In-Reply-To: <1410183102-6969-1-git-send-email-msalter@redhat.com>
References: <1410183102-6969-1-git-send-email-msalter@redhat.com>
Message-ID: <20140908140609.GI12081@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Sep 08, 2014 at 02:31:42PM +0100, Mark Salter wrote:
> Commit 86c8b27a01cf:
>  "arm64: ignore DT memreserve entries when booting in UEFI mode
> 
> prevents early_init_fdt_scan_reserved_mem() from being called for
> arm64 kernels booting via UEFI. This was done because the kernel
> will use the UEFI memory map to determine reserved memory regions.
> That approach has problems in that early_init_fdt_scan_reserved_mem()
> also reserves the FDT itself and any node-specific reserved memory.
> By chance of some kernel configs, the FDT may be overwritten before
> it can be unflattened and the kernel will fail to boot. More subtle
> problems will result if the FDT has node specific reserved memory
> which is not really reserved.

That doesn't sound like fun; apologies for allowing such brokenness
through in the first place.

[...]

> +	/*
> +	 * Delete all memory reserve map entries. When booting via UEFI,
> +	 * kernel will use the UEFI memory map to find reserved regions.
> +	 */
> +	num_rsv = fdt_num_mem_rsv(fdt);
> +	for (i = 0; i < num_rsv; i++)
> +		fdt_del_mem_rsv(fdt, i);

I don't think that's right. Won't the memreserve entries shift down by
one each time we call fdt_del_mem_rsv?

Shouldn't this be something like:

while (fdt_num_mem_rsv(fdt))
	fdt_del_mem_rsv(fdt, 0);

Or we could count downwards.

Otherwise, the general approach sounds sane to me, so with that bug
fixed or disproven:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Given this is mostly in the EFI stub I expect that this will go via the
EFI tree?

Mark.

> +
>  	node = fdt_subnode_offset(fdt, 0, "chosen");
>  	if (node < 0) {
>  		node = fdt_add_subnode(fdt, 0, "chosen");
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-efi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
