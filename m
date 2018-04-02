From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 2 Apr 2018 08:57:44 +0200
Subject: [PATCH v5 3/5] mm/memblock: introduce
 memblock_search_pfn_regions()
In-Reply-To: <1522636236-12625-4-git-send-email-hejianet@gmail.com>
References: <1522636236-12625-1-git-send-email-hejianet@gmail.com>
 <1522636236-12625-4-git-send-email-hejianet@gmail.com>
Message-ID: <CAKv+Gu8dO=fn+MLvZEGzJMvw6u1vMaACz5utBzE4YLLFduGRFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 April 2018 at 04:30, Jia He <hejianet@gmail.com> wrote:
> This api is the preparation for further optimizing early_pfn_valid
>

Please add more explanatation here of what it is you are doing and why.


> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
> ---
>  include/linux/memblock.h | 2 ++
>  mm/memblock.c            | 9 +++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 0257aee..a0127b3 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -203,6 +203,8 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
>              i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>
> +int memblock_search_pfn_regions(unsigned long pfn);
> +
>  /**
>   * for_each_free_mem_range - iterate through free memblock areas
>   * @i: u64 used as loop variable
> diff --git a/mm/memblock.c b/mm/memblock.c
> index ba7c878..0f4004c 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1617,6 +1617,15 @@ static int __init_memblock memblock_search(struct memblock_type *type, phys_addr
>         return -1;
>  }
>
> +/* search memblock with the input pfn, return the region idx */
> +int __init_memblock memblock_search_pfn_regions(unsigned long pfn)
> +{
> +       struct memblock_type *type = &memblock.memory;
> +       int mid = memblock_search(type, PFN_PHYS(pfn));
> +
> +       return mid;
> +}
> +
>  bool __init memblock_is_reserved(phys_addr_t addr)
>  {
>         return memblock_search(&memblock.reserved, addr) != -1;
> --
> 2.7.4
>
