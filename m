From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 1 Sep 2011 11:36:20 +0800
Subject: [PATCH 1/7] ARM: l2x0: add empty l2x0_of_init
In-Reply-To: <1314841446-11006-2-git-send-email-robherring2@gmail.com>
References: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
	<1314841446-11006-2-git-send-email-robherring2@gmail.com>
Message-ID: <CAGsJ_4zS8qA-rD+NQzUo58J8pT+-4uhrCdHCKgkCJxX30KY3Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/1 Rob Herring <robherring2@gmail.com>:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Add empty version of l2x0_of_init for when CONFIG_CACHE_L2X0 is not selected.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Acked-by: Barry Song <21cnbao@gmail.com>

it seems most people use
"
#ifdef CONFIG_CACHE_L2X0
...
l2x0 related codes
...
#endif
"
or
"
obj-$(CONFIG_CACHE_L2X0) += xxx-l2x0.o
"

to avoid l2x0 related codes compiled and linked into kernel.

but this patch provides another option. it is not bad too.

> ---
> ?arch/arm/include/asm/hardware/cache-l2x0.h | ? ?7 +++++++
> ?1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
> index 4a6004a..967a808 100644
> --- a/arch/arm/include/asm/hardware/cache-l2x0.h
> +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
> @@ -90,7 +90,14 @@
>
> ?#ifndef __ASSEMBLY__
> ?extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
> +#if defined(CONFIG_CACHE_L2X0) && defined(CONFIG_OF)
> ?extern int l2x0_of_init(__u32 aux_val, __u32 aux_mask);
> +#else
> +static int l2x0_of_init(__u32 aux_val, __u32 aux_mask)
> +{
> + ? ? ? return -ENODEV;
> +}
> ?#endif
> +#endif /* __ASSEMBLY__ */
>
> ?#endif
> --
> 1.7.4.1

-barry
