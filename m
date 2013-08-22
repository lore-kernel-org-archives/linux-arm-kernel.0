From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Aug 2013 17:16:14 +0100
Subject: [BUG] ARM64: Create 4K page size mmu memory map at init time
 will trigger exception.
In-Reply-To: <BFAC7FA8F7636E45AB9ECBAC17346F3434557683@SZXEML508-MBS.china.huawei.com>
References: <BFAC7FA8F7636E45AB9ECBAC17346F3434557683@SZXEML508-MBS.china.huawei.com>
Message-ID: <20130822161614.GE1352@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 04:35:29AM +0100, Leizhen (ThunderTown, Euler) wrote:
> This problem is on ARM64. When CONFIG_ARM64_64K_PAGES is not opened, the memory
> map size can be 2M(section) and 4K(PAGE). First, OS will create map for pgd
> (level 1 table) and level 2 table which in swapper_pg_dir. Then, OS register
> mem block into memblock.memory according to memory node in fdt, like memory at 0,
> and create map in setup_arch-->paging_init. If all mem block start address and
> size is integral multiple of 2M, there is no problem, because we will create 2M
> section size map whose entries locate in level 2 table. But if it is not
> integral multiple of 2M, we should create level 3 table, which granule is 4K.
> Now, current implementtion is call early_alloc-->memblock_alloc to alloc memory
> for level 3 table. This function will find a 4K free memory which locate in
> memblock.memory tail(high address), but paging_init is create map from low
> address to high address, so new alloced memory is not mapped, write page talbe
> entry to it will trigger exception.

I see how this can happen. There is a memblock_set_current_limit to
PGDIR_SIZE (1GB, we have a pre-allocated pmd) and in my tests I had at
least 1GB of RAM which got mapped first and didn't have this problem.
I'll come up with a patch tomorrow.

-- 
Catalin

P.S. Please try to send plain-text (rather than HTML) emails only, with
nicely wrapped lines. Thanks.
