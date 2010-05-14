From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 May 2010 19:36:47 +0900
Subject: PIPT cache handling on s5pv210 chip
In-Reply-To: <AANLkTilN-B_hvIPWFC8Q02wIcO7nJLmodSj0RyBYZKuk@mail.gmail.com>
References: <AANLkTilN-B_hvIPWFC8Q02wIcO7nJLmodSj0RyBYZKuk@mail.gmail.com>
Message-ID: <00bc01caf351$5daf71c0$190e5540$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> Hi,
> 
> In s5pv210 code, there's some strange comments. Does anyone who know
> why does it required or more fancy way?
> 
> Thank you,
> Kyungmin Park
> 
> 
> /*
>  * flush_cache_vmap() is used when creating mappings (eg, via vmap,
>  * vmalloc, ioremap etc) in kernel space for pages.  On non-VIPT
>  * caches, since the direct-mappings of these pages may contain cached
>  * data, we need to do a full cache flush to ensure that writebacks
>  * don't corrupt data placed into these pages via the new mappings.
>  */
> static inline void flush_cache_vmap(unsigned long start, unsigned long end)
> {
> #if defined(CONFIG_ARCH_S5PV210)
> /*
>  * SAMSUNG SoC(S5PV210) has a L2 cache. L2 cache type is
>  * VIPT type but L2 is PIPT type cache. If disabling L2 cache, this
>  * code works well. But enabling L2 cache, there is data corruption
>  * problem. In case of S5PV210, just call flush_cache_all() function
>  * like as 2.6.28 kernel.
>  */
>         flush_cache_all();
> #else
>         if (!cache_is_vipt_nonaliasing())
>                 flush_cache_all();
>         else
>                 /*
>                  * set_pte_at() called from vmap_pte_range() does not
>                  * have a DSB after cleaning the cache line.
>                  */
>                 dsb();
> #endif
> }
> 
> static inline void flush_cache_vunmap(unsigned long start, unsigned long
end)
> {
> #if defined(CONFIG_ARCH_S5PV210)
>         flush_cache_all();
> #else
>         if (!cache_is_vipt_nonaliasing())
>                 flush_cache_all();
> #endif
> }
> 

Hi, 

In case of __vmalloc() with non-cacheable option, there may come some
malfunctions related to cache.
So to avoid this, it seems that the "if (!cache_is_vipt_nonaliasing())" has
been commented out like 28 version.

And the comments of the code looks wrong.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
