From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Fri, 19 Aug 2016 17:49:38 +0800
Subject: [RFC PATCH] arm64/hugetlb enable gigantic hugepage
In-Reply-To: <1471521929-9207-1-git-send-email-xieyisheng1@huawei.com>
References: <1471521929-9207-1-git-send-email-xieyisheng1@huawei.com>
Message-ID: <68b492dc-06ea-dd33-2197-1f4b71d36072@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add more,

hi all,
Could anyone do me a favor and give some comments?

Thanks
Xie Yisheng

On 2016/8/18 20:05, Xie Yisheng wrote:
> As we know, arm64 also support gigantic hugepage eg. 1G.
> So I try to use this function by adding hugepagesz=1G
> in kernel parameters, with CONFIG_CMA=y.
> However, when:
> echo xx > /sys/kernel/mm/hugepages/hugepages-1048576kB/
>           nr_hugepages
> it failed with the info:
> -bash: echo: write error: Invalid argument
> 
> This patch make gigantic hugepage can be used on arm64,
> when CONFIG_CMA=y or other related configs is enable.
> 
> Signed-off-by: Xie Yisheng <xieyisheng1@huawei.com>
> ---
>  mm/hugetlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 87e11d8..b4d8048 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1022,7 +1022,8 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>  		((node = hstate_next_node_to_free(hs, mask)) || 1);	\
>  		nr_nodes--)
>  
> -#if (defined(CONFIG_X86_64) || defined(CONFIG_S390)) && \
> +#if (defined(CONFIG_X86_64) || defined(CONFIG_S390) || \
> +	defined(CONFIG_ARM64)) && \
>  	((defined(CONFIG_MEMORY_ISOLATION) && defined(CONFIG_COMPACTION)) || \
>  	defined(CONFIG_CMA))
>  static void destroy_compound_gigantic_page(struct page *page,
> 
