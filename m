From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Mon, 3 Oct 2016 20:51:31 +0100
Subject: [PATCH -next v2] arm*/efi: efi_init error handling fix
In-Reply-To: <1474371593-10250-1-git-send-email-xieyisheng1@huawei.com>
References: <1474371593-10250-1-git-send-email-xieyisheng1@huawei.com>
Message-ID: <20161003195131.GK16071@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Sep, at 07:39:53PM, Yisheng Xie wrote:
> There's an early memmap leak in efi_init error path, fix it.
> 
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/firmware/efi/arm-init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index 9f8d996..7c2fe57 100644
> --- a/drivers/firmware/efi/arm-init.c
> +++ b/drivers/firmware/efi/arm-init.c
> @@ -245,8 +245,10 @@ void __init efi_init(void)
>  	     "Unexpected EFI_MEMORY_DESCRIPTOR version %ld",
>  	      efi.memmap.desc_version);
>  
> -	if (uefi_init() < 0)
> +	if (uefi_init() < 0) {
> +		efi_memmap_unmap();
>  		return;
> +	}
>  
>  	reserve_regions();
>  	efi_memattr_init();

Thanks, applied to 'next'.
