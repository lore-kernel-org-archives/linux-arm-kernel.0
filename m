From: james.morse@arm.com (James Morse)
Date: Fri, 05 Jan 2018 11:06:45 +0000
Subject: [PATCH][v2] arm64: Allocate elfcorehdr & crashkernel mem before
 any reservation
In-Reply-To: <1515080048-9154-1-git-send-email-poonam.aggrwal@nxp.com>
References: <1515080048-9154-1-git-send-email-poonam.aggrwal@nxp.com>
Message-ID: <5A4F5C45.3090006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Poonam,

On 04/01/18 15:34, Poonam Aggrwal wrote:
> Address for both crashkernel memory and elfcorehdr can be assigned
> statically. For crashkernel memory it is via crashkernel=SIZE at ADDRESS
> and elfcorehdr_addr via by kexec-utils in dump kernel device tree.

There are some crashkernel=SIZE at ADDRESS values that the user can supply that we
must reject. The obvious one is if it overlaps with the kernel text. (this patch
won't spot this). We need to read the hardware's reserved regions from the DT
before we allocate the crashkernel region, for example if the bootloader
reserved a chunk of memory for a frame-buffer, I shouldn't be able to use that
as crashkernel memory.

(you shouldn't need to specify an address, doing so prevents the kernel from
picking memory it can use)


> So memory should be reserved for both the above areas before any
> other memory reservations are done. Otherwise overlaps may happen and
> memory allocations will fail leading to failure in booting the 
> dump capture kernel.

> Signed-off-by: Guanhua <guanhua.gao@nxp.com>

The first signed-off-by should be the patch author.
If you want to credit your colleagues you can use 'CC', or they can give
reviewed-by/acked-by to the patch.


> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>
> Signed-off-by: Abhimanyu Saini <abhimanyu.saini@nxp.com>

And the last signed-of-by should be from the person posting to the mailing list.


> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 00e7b90..24ce15d 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -453,6 +453,14 @@ void __init arm64_memblock_init(void)
>  	 * Register the kernel text, kernel data, initrd, and initial
>  	 * pagetables with memblock.
>  	 */

Please don't insert this code between 'memblock_reserve(__pa_symbol(_text), _end
- _text);' and the comment that describes it.


> +
> +	/* make these the first reservations to avoid chances of
> +	 * overlap
> +	 */

Nit: comment style


> +	reserve_elfcorehdr();

(Moving reserve_elfcorehdr() makes sense, but..)


> +	reserve_crashkernel();

reserve_crashkernel() does the allocation for the crashkernels reserved memory.
I expect this to always fail in the kdump kernel because there isn't enough
memory. (fdt_enforce_memory_region() at the top of this function calls
memblock_cap_memory_range()).

Moving this allocation above the early_init_fdt_scan_reserved_mem() below means
we may allocate memory for the crashdump that is in use by firmware/hardware and
described as reserved in the DT.


>  	memblock_reserve(__pa_symbol(_text), _end - _text);
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	if (initrd_start) {
> @@ -472,10 +480,6 @@ void __init arm64_memblock_init(void)
>  	else
>  		arm64_dma_phys_limit = PHYS_MASK + 1;
>  
> -	reserve_crashkernel();
> -
> -	reserve_elfcorehdr();
> -
>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>  
>  	dma_contiguous_reserve(arm64_dma_phys_limit);
> 


Thanks,

James
