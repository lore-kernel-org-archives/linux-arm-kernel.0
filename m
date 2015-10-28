From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 28 Oct 2015 18:08:36 +0000
Subject: [PATCH] [v2] arm64: efi: make sure vmlinux load address aligned
 on 2MB
In-Reply-To: <1446053844-27281-1-git-send-email-timur@codeaurora.org>
References: <1446053844-27281-1-git-send-email-timur@codeaurora.org>
Message-ID: <20151028180836.GB26777@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 12:37:24PM -0500, Timur Tabi wrote:
> The vmlinux image load address must be aligned to 2MB, as documented
> in Documentation/arm64/booting.txt. Otherwise, __create_page_tables
> in head.S will create incorrect page table entries.
> 

As I mentioned previously, this isn't quite correct.

How about rewording this to:

---
arm64: efi: ensure kernel is loaded at correct address

The kernel image needs to be loaded text_offset_bytes from a 2M-aligned
base, per Documentation/arm64/booting.txt. If loaded at the wrong offset
modulo 2M, __create_page_tables will create incorrect page tables.

The EFI stub implicitly assumes that dram_base (i.e. the lowest address
with a EFI_MEMORY_WB attribute) is 2M-aligned, and tries to load the
kernel at dram_base + TEXT_OFFSET. If dram_base is not 2M-aligned, the
kernel will be loaded at the wrong offset from 2M.
---

> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
>  arch/arm64/kernel/efi-stub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
> index 816120e..37118f4 100644
> --- a/arch/arm64/kernel/efi-stub.c
> +++ b/arch/arm64/kernel/efi-stub.c
> @@ -42,7 +42,8 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
>  		 * Mustang), we can still place the kernel at the address
>  		 * 'dram_base + TEXT_OFFSET'.
>  		 */
> -		*image_addr = *reserve_addr = dram_base + TEXT_OFFSET;
> +		*image_addr = *reserve_addr =
> +			round_up(dram_base, SZ_2M) + TEXT_OFFSET;

We also need to fix the test for whether we need to relocate the kernel:
(*image_addr != (dram_base + TEXT_OFFSET)).

When dram_base is not 2M aligned, that is broken, and it's been broken
since it was introduced in commit 3c7f255039a2ad6e ("arm64: efi: add EFI
stub") in v3.16.

It's a bit hideous to fix the general case, though, it seems.

Thanks,
Mark.
