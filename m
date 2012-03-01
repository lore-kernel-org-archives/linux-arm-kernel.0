From: hpa@zytor.com (H. Peter Anvin)
Date: Thu, 01 Mar 2012 12:46:57 -0800
Subject: [PATCH] mm: module_alloc: check if size is 0
In-Reply-To: <1330631119-10059-1-git-send-email-veli-pekka.peltola@bluegiga.com>
References: <1330631119-10059-1-git-send-email-veli-pekka.peltola@bluegiga.com>
Message-ID: <4F4FE041.1000507@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2012 11:45 AM, Veli-Pekka Peltola wrote:
> diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> index 1e9be5d..d44d212 100644
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -39,8 +39,8 @@
>  #ifdef CONFIG_MMU
>  void *module_alloc(unsigned long size)
>  {
> -	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> -				GFP_KERNEL, PAGE_KERNEL_EXEC, -1,
> +	return size == 0 ? NULL : __vmalloc_node_range(size, 1, MODULES_VADDR,
> +				MODULES_END, GFP_KERNEL, PAGE_KERNEL_EXEC, -1,
>  				__builtin_return_address(0));
>  }
>  #endif
> diff --git a/arch/mips/kernel/module.c b/arch/mips/kernel/module.c
> index a5066b1..cd768e9 100644
> --- a/arch/mips/kernel/module.c
> +++ b/arch/mips/kernel/module.c
> @@ -47,8 +47,8 @@ static DEFINE_SPINLOCK(dbe_lock);
>  #ifdef MODULE_START
>  void *module_alloc(unsigned long size)
>  {
> -	return __vmalloc_node_range(size, 1, MODULE_START, MODULE_END,
> -				GFP_KERNEL, PAGE_KERNEL, -1,
> +	return size == 0 ? NULL : __vmalloc_node_range(size, 1, MODULE_START,
> +				MODULE_END, GFP_KERNEL, PAGE_KERNEL, -1,
>  				__builtin_return_address(0));
>  }
>  #endif
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index 925179f..bff6118 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -38,7 +38,7 @@
>  
>  void *module_alloc(unsigned long size)
>  {
> -	if (PAGE_ALIGN(size) > MODULES_LEN)
> +	if (size == 0 || PAGE_ALIGN(size) > MODULES_LEN)
>  		return NULL;
>  	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
>  				GFP_KERNEL | __GFP_HIGHMEM, PAGE_KERNEL_EXEC,

Looks good stylistically but really awkward technically.

I would like to suggest using the idiom:

	if (!size)
		return NULL;

... consistently; combined with the PAGE_ALIGN() clause for x86 is fine too.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
