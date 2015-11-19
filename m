From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 19 Nov 2015 21:22:56 +0900
Subject: [PATCH] ARM: cache-uniphier: use common API to find the next
 level cache
In-Reply-To: <1447242463-2881-1-git-send-email-yamada.masahiro@socionext.com>
References: <1447242463-2881-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNATkNEr4b5ir57BcYYbJAm6rnS_5Hcui6aG1CCfNp5pvzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It looks like no comment (no interest?) on this patch.
If nobody is opposed to this patch, I will put it into Russell's patch tracker.


2015-11-11 20:47 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The function uniphier_cache_get_next_level_node() does the same thing
> as of_find_next_cache_node().  Drop the former and stick to the common
> API.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/mm/cache-uniphier.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/arch/arm/mm/cache-uniphier.c b/arch/arm/mm/cache-uniphier.c
> index 0502ba1..a6fa7b7 100644
> --- a/arch/arm/mm/cache-uniphier.c
> +++ b/arch/arm/mm/cache-uniphier.c
> @@ -377,17 +377,6 @@ static const struct of_device_id uniphier_cache_match[] __initconst = {
>         { /* sentinel */ }
>  };
>
> -static struct device_node * __init uniphier_cache_get_next_level_node(
> -                                                       struct device_node *np)
> -{
> -       u32 phandle;
> -
> -       if (of_property_read_u32(np, "next-level-cache", &phandle))
> -               return NULL;
> -
> -       return of_find_node_by_phandle(phandle);
> -}
> -
>  static int __init __uniphier_cache_init(struct device_node *np,
>                                         unsigned int *cache_level)
>  {
> @@ -491,7 +480,7 @@ static int __init __uniphier_cache_init(struct device_node *np,
>          * next level cache fails because we want to continue with available
>          * cache levels.
>          */
> -       next_np = uniphier_cache_get_next_level_node(np);
> +       next_np = of_find_next_cache_node(np);
>         if (next_np) {
>                 (*cache_level)++;
>                 ret = __uniphier_cache_init(next_np, cache_level);
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best Regards
Masahiro Yamada
