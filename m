From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Tue, 7 Dec 2010 10:45:46 +0900
Subject: [PATCH] ARM: Add Kconfig entry for SG chain support
In-Reply-To: <1291686036-32562-1-git-send-email-fernando.lugo@ti.com>
References: <1291686036-32562-1-git-send-email-fernando.lugo@ti.com>
Message-ID: <20101207104451X.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  6 Dec 2010 19:40:36 -0600
Fernando Guzman Lugo <fernando.lugo@ti.com> wrote:

> Add a entry to make possible SG chaining under ARM
> architecture.
> 
> Tidspbridge driver needs SG chaining, however SG chain has not
> been tested under all platforms. Adding this option OMAP
> platform can enable it and if other platforms have issues they
> would not enable it.
> 
> This patch is base on this discussion:
> 
> http://marc.info/?l=linux-arm-kernel&m=129166415415541&w=2
> 
> Signed-off-by: Fernando Guzman Lugo <fernando.lugo@ti.com>
> ---
>  arch/arm/Kconfig                   |    6 ++++++
>  arch/arm/include/asm/scatterlist.h |    4 ++++
>  2 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index dd944bd..f5cfd42 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1017,6 +1017,12 @@ config CPU_HAS_PMU
>  	default y
>  	bool
>  
> +config ARM_SG_CHAIN
> +	bool "Enable SG chain support"
> +	default n
> +	help
> +	  Enable support for SG chaining for ARM
> +

I thought that you simply add something like the following to
arch/arm/include/asm/scatterlist.h?

#ifdef CONFIG_ARCH_OMAP
#define ARCH_HAS_SG_CHAIN
#endif

Because you can't enable sg chaining on some arm architectures. Some
arm SCSI drivers can't handle sg chaining but they are not available
on omap, right? Why do you make this configurable on all arm archs
like the above?


>  if !MMU
>  source "arch/arm/Kconfig-nommu"
>  endif
> diff --git a/arch/arm/include/asm/scatterlist.h b/arch/arm/include/asm/scatterlist.h
> index 2f87870..eab7c4f 100644
> --- a/arch/arm/include/asm/scatterlist.h
> +++ b/arch/arm/include/asm/scatterlist.h
> @@ -5,4 +5,8 @@
>  #include <asm/types.h>
>  #include <asm-generic/scatterlist.h>
>  
> +#ifdef CONFIG_ARM_SG_CHAIN
> +#define ARCH_HAS_SG_CHAIN
> +#endif
> +
>  #endif /* _ASMARM_SCATTERLIST_H */
