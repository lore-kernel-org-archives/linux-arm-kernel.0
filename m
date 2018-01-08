From: toshi.kani@hpe.com (Kani, Toshi)
Date: Mon, 8 Jan 2018 23:36:57 +0000
Subject: [RFC patch] ioremap: don't set up huge I/O mappings when
 p4d/pud/pmd is zero
In-Reply-To: <e0fa1b52-86f5-687e-46b3-78ddd03565d8@huawei.com>
References: <1514460261-65222-1-git-send-email-guohanjun@huawei.com>
 <1515193319.2108.24.camel@hpe.com>
 <e0fa1b52-86f5-687e-46b3-78ddd03565d8@huawei.com>
Message-ID: <1515457376.2108.34.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-01-06 at 17:46 +0800, Hanjun Guo wrote:
> On 2018/1/6 6:15, Kani, Toshi wrote:
> > On Thu, 2017-12-28 at 19:24 +0800, Hanjun Guo wrote:
> > > From: Hanjun Guo <hanjun.guo@linaro.org>
> > > 
> > > When we using iounmap() to free the 4K mapping, it just clear the PTEs
> > > but leave P4D/PUD/PMD unchanged, also will not free the memory of page
> > > tables.
> > > 
> > > This will cause issues on ARM64 platform (not sure if other archs have
> > > the same issue) for this case:
> > > 
> > > 1. ioremap a 4K size, valid page table will build,
> > > 2. iounmap it, pte0 will set to 0;
> > > 3. ioremap the same address with 2M size, pgd/pmd is unchanged,
> > >    then set the a new value for pmd;
> > > 4. pte0 is leaked;
> > > 5. CPU may meet exception because the old pmd is still in TLB,
> > >    which will lead to kernel panic.
> > > 
> > > Fix it by skip setting up the huge I/O mappings when p4d/pud/pmd is
> > > zero.
> > 
> > Hi Hanjun,
> > 
> > I tested the above steps on my x86 box, but was not able to reproduce
> > your kernel panic.  On x86, a 4K vaddr gets allocated from a small
> > fragmented free range, whereas a 2MB vaddr is from a larger free range. 
> > Their addrs have different alignments (4KB & 2MB) as well.  So, the
> > steps did not lead to use a same pmd entry.
> 
> Thanks for the testing, I can only reproduce this on my ARM64 platform
> which the CPU will cache the PMD in TLB, from my knowledge, only Cortex-A75
> will do this, so ARM64 platforms which are not A75 based can't be reproduced
> either.
> 
> Catalin, Will, I can reproduce this issue in about 3 minutes with following
> simplified test case [1], and can trigger panic as [2], could you take a look
> as well?

Yes, the test case looks good to me. (nit - it should check if vir_addr
is not NULL.)

> > However, I agree that zero'd pte entries will be leaked when a pmd map
> > is set if they are present under the pmd.
> 
> Thanks for the confirm.
> 
> > 
> > I also tested your patch on my x86 box.  Unfortunately, it effectively
> > disabled 2MB mappings.  While a 2MB vaddr gets allocated from a larger
> > free range, it sill comes from a free range covered by zero'd pte
> > entries.  So, it ends up with 4KB mappings with your changes.
> > 
> > I think we need to come up with other approach.
> 
> Yes, As I said in my patch, this is just RFC, comments are welcomed :)

I am wondering if we can follow the same approach in
arch/x86/mm/pageattr.c.  Like the ioremap case, populate_pmd() does not
check if there is a pte table under the pmd.  But its free function,
unmap_pte_range() calls try_to_free_pte_page() so that a pte table is
freed when all pte entries are zero'd.  It then calls pmd_clear().
iounmap()'s free function, vunmap_pte_range() does not free up a pte
table even if all pte entries are zero'd.

Thanks,
-Toshi
