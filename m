From: linfeng@cn.fujitsu.com (Lin Feng)
Date: Mon, 08 Apr 2013 18:23:16 +0800
Subject: [PATCH 1/2] mm: vmemmap: x86: add vmemmap_verify check for hot-add
 node case
In-Reply-To: <1365415000-10389-2-git-send-email-linfeng@cn.fujitsu.com>
References: <1365415000-10389-1-git-send-email-linfeng@cn.fujitsu.com>
 <1365415000-10389-2-git-send-email-linfeng@cn.fujitsu.com>
Message-ID: <51629A94.5000200@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On 04/08/2013 05:56 PM, Lin Feng wrote:
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 474e28f..e2a7277 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1318,6 +1318,8 @@ vmemmap_populate(struct page *start_page, unsigned long size, int node)
>  			if (!p)
>  				return -ENOMEM;
>  
> +			vmemmap_verify((pte_t *)p, node, addr, addr + PAGE_SIZE);
> +
>  			addr_end = addr + PAGE_SIZE;
>  			p_end = p + PAGE_SIZE;
>  		} else {
IIUC it seems that the original 'p_end = p + PAGE_SIZE' assignment is buggy, because:

1309                 if (!cpu_has_pse) {
1310                         next = (addr + PAGE_SIZE) & PAGE_MASK;
1311                         pmd = vmemmap_pmd_populate(pud, addr, node);
1312 
1313                         if (!pmd)
1314                                 return -ENOMEM;
1315 
1316                         p = vmemmap_pte_populate(pmd, addr, node);
1317 
1318                         if (!p)
1319                                 return -ENOMEM;
1320 
1321                         addr_end = addr + PAGE_SIZE;
1322                         p_end = p + PAGE_SIZE;

The return value of vmemmap_pte_populate() is the virtual address of pte, not the allocated
virtual address, which is different from vmemmap_alloc_block_buf() in cpu_has_pse case, so
the addition PAGE_SIZE in !cpu_has_pse case is nonsense.

Or am I missing something?

thanks,
linfeng
