From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 Oct 2015 11:57:17 +0100
Subject: [PATCH] arm64: change to use memmove in efi-stub
In-Reply-To: <1444992367-11121-1-git-send-email-yalin.wang2010@gmail.com>
References: <1444992367-11121-1-git-send-email-yalin.wang2010@gmail.com>
Message-ID: <20151016105716.GB975@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 16, 2015 at 06:46:07PM +0800, yalin wang wrote:
> Change to use memmove(), in case the dest address overlap with the
> source address.

This cannot happen, and memove would not be sufficient if it did.

The destination is a region returned by EFI_BOOT_SERVICES.AllocatePages,
which can only allocate pages which were free to begin with. Therefore
the new region cannot overlap with the stub (whose pages are not free).

Were the new region to overlap with the stub, the memmove could corrupt
the code/data in use by the stub, and things would explode shortly
thereafter.

Thanks,
Mark.

> 
> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
> ---
>  arch/arm64/kernel/efi-stub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
> index 816120e..b6dc44b 100644
> --- a/arch/arm64/kernel/efi-stub.c
> +++ b/arch/arm64/kernel/efi-stub.c
> @@ -59,7 +59,7 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
>  			}
>  			*image_addr = *reserve_addr + TEXT_OFFSET;
>  		}
> -		memcpy((void *)*image_addr, old_image_addr, kernel_size);
> +		memmove((void *)*image_addr, old_image_addr, kernel_size);
>  		*reserve_size = kernel_memsize;
>  	}
>  
> -- 
> 1.9.1
> 
