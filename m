From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 18 Feb 2016 10:44:07 +0000
Subject: [PATCH v2 1/2] efi: esrt: use memremap not ioremap to access
 ESRT table in memory
In-Reply-To: <1455535953-5056-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1455535953-5056-1-git-send-email-ard.biesheuvel@linaro.org>
 <1455535953-5056-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160218104407.GC2651@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Feb, at 12:32:32PM, Ard Biesheuvel wrote:
> On ARM and arm64, ioremap() and memremap() are not interchangeable like
> on x86, and the use of ioremap() on ordinary RAM is typically flagged
> as an error if the memory region being mapped is also covered by the
> linear mapping, since that would lead to aliases with conflicting
> cacheability attributes.
> 
> Since what we are dealing with is not an I/O region with side effects,
> using ioremap() here is arguably incorrect anyway, so let's replace
> it with memremap instead. Also add a missing unmap on the success path,
> and drop a memblock_remove() call which does not belong here, this far
> into the boot sequence.
> 
> Cc: Peter Jones <pjones@redhat.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/esrt.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

[...]

> @@ -432,8 +434,6 @@ static int __init esrt_sysfs_init(void)
>  	if (error)
>  		goto err_cleanup_list;
>  
> -	memblock_remove(esrt_data, esrt_data_size);
> -
>  	pr_debug("esrt-sysfs: loaded.\n");
>  
>  	return 0;

Shouldn't we be replacing memblock_remove() with free_bootmem_late()?
The original ESRT region is still reserved at this point, so we should
do our best to release it to the page allocator.
