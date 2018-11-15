From: rdunlap@infradead.org (Randy Dunlap)
Date: Thu, 15 Nov 2018 10:13:36 -0800
Subject: [PATCH 1/9] mm: Introduce new vm_insert_range API
In-Reply-To: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
Message-ID: <9655a12e-bd3d-aca2-6155-38924028eb5d@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/18 7:45 AM, Souptick Joarder wrote:
> Previouly drivers have their own way of mapping range of
> kernel pages/memory into user vma and this was done by
> invoking vm_insert_page() within a loop.
> 
> As this pattern is common across different drivers, it can
> be generalized by creating a new function and use it across
> the drivers.
> 
> vm_insert_range is the new API which will be used to map a
> range of kernel memory/pages to user vma.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> ---
>  include/linux/mm_types.h |  3 +++
>  mm/memory.c              | 28 ++++++++++++++++++++++++++++
>  mm/nommu.c               |  7 +++++++
>  3 files changed, 38 insertions(+)

Hi,

What is the opposite of vm_insert_range() or even of vm_insert_page()?
or is there no need for that?


> diff --git a/mm/memory.c b/mm/memory.c
> index 15c417e..da904ed 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1478,6 +1478,34 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
>  }
>  
>  /**
> + * vm_insert_range - insert range of kernel pages into user vma
> + * @vma: user vma to map to
> + * @addr: target user address of this page
> + * @pages: pointer to array of source kernel pages
> + * @page_count: no. of pages need to insert into user vma

s/no./number/

> + *
> + * This allows drivers to insert range of kernel pages they've allocated
> + * into a user vma. This is a generic function which drivers can use
> + * rather than using their own way of mapping range of kernel pages into
> + * user vma.
> + */
> +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> +			struct page **pages, unsigned long page_count)
> +{
> +	unsigned long uaddr = addr;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < page_count; i++) {
> +		ret = vm_insert_page(vma, uaddr, pages[i]);
> +		if (ret < 0)
> +			return ret;

For a non-trivial value of page_count:
Is it a problem if vm_insert_page() succeeds for several pages
and then fails?

> +		uaddr += PAGE_SIZE;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
>   * vm_insert_page - insert single page into user vma
>   * @vma: user vma to map to
>   * @addr: target user address of this page


thanks.
-- 
~Randy
