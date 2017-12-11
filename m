From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 11 Dec 2017 10:27:08 +0000
Subject: [PATCH] ARM: Disable CONFIG_DEBUG_VIRTUAL for NOMMU
In-Reply-To: <1512467614-38194-1-git-send-email-vladimir.murzin@arm.com>
References: <1512467614-38194-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <abbfc5a0-2852-48a9-1d11-160a1a429088@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/17 09:53, Vladimir Murzin wrote:
> While running MPS2 platform (NOMMU) with DTB placed below PHYS_OFFSET
> following warning poped up:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at arch/arm/mm/physaddr.c:42 __virt_to_phys+0x2f/0x40
> virt_to_phys used for non-linear address: 00004000 (0x4000)
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.15.0-rc1-5a31bf2-clean+ #2767
> Hardware name: MPS2 (Device Tree Support)
> [<2100bf39>] (unwind_backtrace) from [<2100b3ff>] (show_stack+0xb/0xc)
> [<2100b3ff>] (show_stack) from [<2100e697>] (__warn+0x87/0xac)
> [<2100e697>] (__warn) from [<2100e6db>] (warn_slowpath_fmt+0x1f/0x28)
> [<2100e6db>] (warn_slowpath_fmt) from [<2100c603>] (__virt_to_phys+0x2f/0x40)
> [<2100c603>] (__virt_to_phys) from [<2116a499>] (early_init_fdt_reserve_self+0xd/0x24)
> [<2116a499>] (early_init_fdt_reserve_self) from [<2116222d>] (arm_memblock_init+0xb5/0xf8)
> [<2116222d>] (arm_memblock_init) from [<21161cad>] (setup_arch+0x38b/0x50e)
> [<21161cad>] (setup_arch) from [<21160455>] (start_kernel+0x31/0x280)
> [<21160455>] (start_kernel) from [<00000000>] (  (null))
> random: get_random_bytes called from init_oops_id+0x17/0x2c with crng_init=0
> ---[ end trace 0000000000000000 ]---
> 
> Platforms without MMU support run with 1:1 (i.e. linear) memory
> mapping, so disable CONFIG_DEBUG_VIRTUAL.
> 
> Fixes: e377cd8221eb ("ARM: 8640/1: Add support for CONFIG_DEBUG_VIRTUAL")
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
> KernelVersion: 4.15-rc1
> 
> arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 18c1e7d..6cd616b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -4,7 +4,7 @@ config ARM
>  	default y
>  	select ARCH_CLOCKSOURCE_DATA
>  	select ARCH_DISCARD_MEMBLOCK if !HAVE_ARCH_PFN_VALID
> -	select ARCH_HAS_DEBUG_VIRTUAL
> +	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_SET_MEMORY
> 

Ok for patch tracker?

Vladimir
