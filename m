From: rientjes@google.com (David Rientjes)
Date: Thu, 26 Dec 2013 15:45:04 -0800 (PST)
Subject: [PATCH] mm/memblock: use WARN_ONCE when MAX_NUMNODES passed as
 input parameter
In-Reply-To: <1387578536-18280-1-git-send-email-santosh.shilimkar@ti.com>
References: <1387578536-18280-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.DEB.2.02.1312261542260.9342@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Dec 2013, Santosh Shilimkar wrote:

> diff --git a/mm/memblock.c b/mm/memblock.c
> index 71b11d9..6af873a 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -707,11 +707,9 @@ void __init_memblock __next_free_mem_range(u64 *idx, int nid,
>  	struct memblock_type *rsv = &memblock.reserved;
>  	int mi = *idx & 0xffffffff;
>  	int ri = *idx >> 32;
> -	bool check_node = (nid != NUMA_NO_NODE) && (nid != MAX_NUMNODES);
>  
> -	if (nid == MAX_NUMNODES)
> -		pr_warn_once("%s: Usage of MAX_NUMNODES is depricated. Use NUMA_NO_NODE instead\n",
> -			     __func__);
> +	if (WARN_ONCE(nid == MAX_NUMNODES, "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
> +		nid = NUMA_NO_NODE;
>  
>  	for ( ; mi < mem->cnt; mi++) {
>  		struct memblock_region *m = &mem->regions[mi];

Um, why do this at runtime?  This is only used for 
for_each_free_mem_range(), which is used rarely in x86 and memblock-only 
code.  I'm struggling to understand why we can't deterministically fix the 
callers if this condition is possible.
