From: toshi.kani@hpe.com (Kani, Toshi)
Date: Fri, 5 Jan 2018 22:15:57 +0000
Subject: [RFC patch] ioremap: don't set up huge I/O mappings when
 p4d/pud/pmd is zero
In-Reply-To: <1514460261-65222-1-git-send-email-guohanjun@huawei.com>
References: <1514460261-65222-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1515193319.2108.24.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-12-28 at 19:24 +0800, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> When we using iounmap() to free the 4K mapping, it just clear the PTEs
> but leave P4D/PUD/PMD unchanged, also will not free the memory of page
> tables.
> 
> This will cause issues on ARM64 platform (not sure if other archs have
> the same issue) for this case:
> 
> 1. ioremap a 4K size, valid page table will build,
> 2. iounmap it, pte0 will set to 0;
> 3. ioremap the same address with 2M size, pgd/pmd is unchanged,
>    then set the a new value for pmd;
> 4. pte0 is leaked;
> 5. CPU may meet exception because the old pmd is still in TLB,
>    which will lead to kernel panic.
> 
> Fix it by skip setting up the huge I/O mappings when p4d/pud/pmd is
> zero.

Hi Hanjun,

I tested the above steps on my x86 box, but was not able to reproduce
your kernel panic.  On x86, a 4K vaddr gets allocated from a small
fragmented free range, whereas a 2MB vaddr is from a larger free range. 
Their addrs have different alignments (4KB & 2MB) as well.  So, the
steps did not lead to use a same pmd entry.

However, I agree that zero'd pte entries will be leaked when a pmd map
is set if they are present under the pmd.

I also tested your patch on my x86 box.  Unfortunately, it effectively
disabled 2MB mappings.  While a 2MB vaddr gets allocated from a larger
free range, it sill comes from a free range covered by zero'd pte
entries.  So, it ends up with 4KB mappings with your changes.

I think we need to come up with other approach.
Thanks,
-Toshi
