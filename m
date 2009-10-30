From: 914059751@qq.com (=?gbk?B?uvrR7sr3?=)
Date: Fri, 30 Oct 2009 11:18:13 +0800
Subject: what's zero_pages for in paging_int
Message-ID: <tencent_6A57DBDE2957BDF72E459404@qq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, guys

     In paging_int, after setting up bootmem allocator, why zero page is needed? i cannot see any things usefull resides on that page, something i missing obviously?

    thanks
----rocky

 ---------------------Linux-2.6.30/arch/arm/mm/mmu.c-----------------------

void __init paging_init(struct machine_desc *mdesc)
{
         void *zero_page;

         build_mem_type_table();
         sanity_check_meminfo();
         prepare_page_table();
         bootmem_init();
         devicemaps_init(mdesc);
         kmap_init();/*DF: most embedded system do NOT have any HIGH MEM */
         top_pmd = pmd_off_k(0xffff0000);
 

         /*
          * allocate the zero page.  Note that this always succeeds and
          * returns a zeroed result.
          */
         zero_page = alloc_bootmem_low_pages(PAGE_SIZE);   /* DF: what?s this for? */
         empty_zero_page = virt_to_page(zero_page);
         flush_dcache_page(empty_zero_page);

}
