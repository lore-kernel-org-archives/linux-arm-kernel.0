From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 18 Mar 2016 12:26:09 +0000
Subject: [PATCH v15 1/6] efi: ARM/arm64: ignore DT memory nodes instead
 of removing them
In-Reply-To: <1457481587-8976-2-git-send-email-ddaney.cavm@gmail.com>
References: <1457481587-8976-1-git-send-email-ddaney.cavm@gmail.com>
 <1457481587-8976-2-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160318122609.GS2619@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 08 Mar, at 03:59:42PM, David Daney wrote:
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> There are two problems with the UEFI stub DT memory node removal
> routine:
> - it deletes nodes as it traverses the tree, which happens to work
>   but is not supported, as deletion invalidates the node iterator;
> - deleting memory nodes entirely may discard annotations in the form
>   of additional properties on the nodes.
> 
> Since the discovery of DT memory nodes occurs strictly before the
> UEFI init sequence, we can simply clear the memblock memory table
> before parsing the UEFI memory map. This way, it is no longer
> necessary to remove the nodes, so we can remove that logic from the
> stub as well.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/firmware/efi/arm-init.c    |  8 ++++++++
>  drivers/firmware/efi/libstub/fdt.c | 24 +-----------------------
>  2 files changed, 9 insertions(+), 23 deletions(-)
 
I've not delved into the rest of the series too deeply, but this looks
like a straight forward change.

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>

> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index 9e15d57..40c9d85 100644
> --- a/drivers/firmware/efi/arm-init.c
> +++ b/drivers/firmware/efi/arm-init.c
> @@ -143,6 +143,14 @@ static __init void reserve_regions(void)
>  	if (efi_enabled(EFI_DBG))
>  		pr_info("Processing EFI memory map:\n");
>  
> +	/*
> +	 * Discard memblocks discovered so far: if there are any at this
> +	 * point, they originate from memory nodes in the DT, and UEFI
> +	 * uses its own memory map instead.
> +	 */
> +	memblock_dump_all();
> +	memblock_remove(0, ULLONG_MAX);
> +
>  	for_each_efi_memory_desc(&memmap, md) {
>  		paddr = md->phys_addr;
>  		npages = md->num_pages;

Out of curiosity, could some kind person explain (or point me at a
previous explanation for) why we may have both DT memory nodes and a
UEFI memory map and why they're not compatible enough to co-exist?
