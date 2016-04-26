From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Apr 2016 12:27:03 +0100
Subject: [PATCH 8/8] arm64: kaslr: increase randomization granularity
In-Reply-To: <1460992188-23295-9-git-send-email-ard.biesheuvel@linaro.org>
References: <1460992188-23295-1-git-send-email-ard.biesheuvel@linaro.org>
 <1460992188-23295-9-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160426112703.GJ27312@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 05:09:48PM +0200, Ard Biesheuvel wrote:
> Currently, our KASLR implementation randomizes the placement of the core
> kernel at 2 MB granularity. This is based on the arm64 kernel boot
> protocol, which mandates that the kernel is loaded TEXT_OFFSET bytes above
> a 2 MB aligned base address. This requirement is a result of the fact that
> the block size used by the early mapping code may be 2 MB at the most (for
> a 4 KB granule kernel)
> 
> But we can do better than that: since a KASLR kernel needs to be relocated
> in any case, we can tolerate a physical misalignment as long as the virtual
> misalignment relative to this 2 MB block size is equal in size, and code to
> deal with this is already in place.
> 
> Since we align the kernel segments to 64 KB, let's randomize the physical
> offset at 64 KB granularity as well (unless CONFIG_DEBUG_ALIGN_RODATA is
> enabled). This way, the page table and TLB footprint is not affected.
> 
> The higher granularity allows for 5 bits of additional entropy to be used.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/libstub/arm64-stub.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Adding Matt to Cc, since this touches the stub and I'll need his ack
before I can merge it.

Will

> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index a90f6459f5c6..eae693eb3e91 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -81,15 +81,24 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
>  
>  	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed != 0) {
>  		/*
> +		 * If CONFIG_DEBUG_ALIGN_RODATA is not set, produce a
> +		 * displacement in the interval [0, MIN_KIMG_ALIGN) that
> +		 * is a multiple of the minimal segment alignment (SZ_64K)
> +		 */
> +		u32 mask = (MIN_KIMG_ALIGN - 1) & ~(SZ_64K - 1);
> +		u32 offset = !IS_ENABLED(CONFIG_DEBUG_ALIGN_RODATA) ?
> +			     (phys_seed >> 32) & mask : TEXT_OFFSET;
> +
> +		/*
>  		 * If KASLR is enabled, and we have some randomness available,
>  		 * locate the kernel at a randomized offset in physical memory.
>  		 */
> -		*reserve_size = kernel_memsize + TEXT_OFFSET;
> +		*reserve_size = kernel_memsize + offset;
>  		status = efi_random_alloc(sys_table_arg, *reserve_size,
>  					  MIN_KIMG_ALIGN, reserve_addr,
> -					  phys_seed);
> +					  (u32)phys_seed);
>  
> -		*image_addr = *reserve_addr + TEXT_OFFSET;
> +		*image_addr = *reserve_addr + offset;
>  	} else {
>  		/*
>  		 * Else, try a straight allocation at the preferred offset.
> -- 
> 2.5.0
> 
