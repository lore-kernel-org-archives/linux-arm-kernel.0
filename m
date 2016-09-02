From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Sep 2016 11:26:18 +0100
Subject: [PATCH] arm64/efi: efi_init error handling fix
In-Reply-To: <1472811519-4897-1-git-send-email-xieyisheng1@huawei.com>
References: <1472811519-4897-1-git-send-email-xieyisheng1@huawei.com>
Message-ID: <20160902102618.GC17482@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 02, 2016 at 06:18:39PM +0800, Xie Yisheng wrote:
> From: Yisheng Xie <xieyisheng1@huawei.com>
> 
> There's an early memmap leak in efi_init error path, fix it.
> 
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/firmware/efi/arm-init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Adding linux-efi, Ard and Matt. Please try to CC the relevant people in
future.

Will

> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index c49d50e..5080e40 100644
> --- a/drivers/firmware/efi/arm-init.c
> +++ b/drivers/firmware/efi/arm-init.c
> @@ -243,8 +243,10 @@ void __init efi_init(void)
>  	     "Unexpected EFI_MEMORY_DESCRIPTOR version %ld",
>  	      efi.memmap.desc_version);
>  
> -	if (uefi_init() < 0)
> +	if (uefi_init() < 0) {
> +		early_memunmap(efi.memmap.map, params.mmap_size);
>  		return;
> +	}
>  
>  	reserve_regions();
>  	efi_memattr_init();
> -- 
> 1.7.12.4
> 
