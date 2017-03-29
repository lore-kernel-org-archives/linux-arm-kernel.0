From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 29 Mar 2017 10:48:36 +0200
Subject: [RFC PATCHv2 02/21] cma: Introduce cma_for_each_area
In-Reply-To: <1489798493-16600-3-git-send-email-labbott@redhat.com>
References: <1489798493-16600-1-git-send-email-labbott@redhat.com>
 <1489798493-16600-3-git-send-email-labbott@redhat.com>
Message-ID: <CA+M3ks6F_9dhfD4DLMJ=GNsr=H86_XLyiBHvzvz6+akjLSNBUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-03-18 1:54 GMT+01:00 Laura Abbott <labbott@redhat.com>:
>
> Frameworks (e.g. Ion) may want to iterate over each possible CMA area to
> allow for enumeration. Introduce a function to allow a callback.

even outside ION rework that could be useful

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  include/linux/cma.h |  2 ++
>  mm/cma.c            | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index d41d1f8..3e8fbf5 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -34,4 +34,6 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>                               gfp_t gfp_mask);
>  extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
> +
> +extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
>  #endif
> diff --git a/mm/cma.c b/mm/cma.c
> index 0d187b1..9a040e1 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -498,3 +498,17 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
>
>         return true;
>  }
> +
> +int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
> +{
> +       int i;
> +
> +       for (i = 0; i < cma_area_count; i++) {
> +               int ret = it(&cma_areas[i], data);
> +
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> --
> 2.7.4
>



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
