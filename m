From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Nov 2015 15:49:26 +0000
Subject: [PATCH] arm64: calculate the various pages number to show
In-Reply-To: <56571FBC.2020300@huawei.com>
References: <1448458872-39897-1-git-send-email-zhongjiang@huawei.com>
 <20151125150448.GD12434@leverpostej> <56571FBC.2020300@huawei.com>
Message-ID: <20151126154926.GG32343@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 11:05:32PM +0800, zhong jiang wrote:
> On 2015/11/25 23:04, Mark Rutland wrote:
> > On Wed, Nov 25, 2015 at 09:41:12PM +0800, zhongjiang wrote:
> >> This patch add the interface to show the number of 4KB or 64KB page,
> >> aims to statistics the number of different types of pages.
> > 
> > What is this useful for? Why do we want it?
> > 
> > What does it account for, just the swapper?
> > 
> 
> The patch is wirtten when I was in backport set_memory_ro. It can be used to
> detect whether there is a large page spliting and merging. large page will
> significantly reduce the TLB miss, and improve the system performance.

Ok, but typically the user isn't going to be able to do much with this
information. It feels more like something that should be in the page
table dump code (where we can calculate the values as we walk the
tables).

What is it intended to account for?

The entire swapper?

Just the linear mapping?

> >> Signed-off-by: zhongjiang <zhongjiang@huawei.com>
> >> ---
> >>  arch/arm64/include/asm/pgtable-types.h |   24 ++++++++++++++++++++++++
> >>  arch/arm64/mm/mmu.c                    |   28 ++++++++++++++++++++++++++++
> >>  arch/arm64/mm/pageattr.c               |   31 +++++++++++++++++++++++++++++++
> >>  3 files changed, 83 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/pgtable-types.h b/arch/arm64/include/asm/pgtable-types.h
> >> index 2b1bd7e..aa52546 100644
> >> --- a/arch/arm64/include/asm/pgtable-types.h
> >> +++ b/arch/arm64/include/asm/pgtable-types.h
> >> @@ -86,6 +86,30 @@ typedef pteval_t pgprot_t;
> >>  
> >>  #endif /* STRICT_MM_TYPECHECKS */
> >>  
> >> +struct seq_file;
> >> +extern void arch_report_meminfo(struct seq_file *m);
> >> +
> >> +enum pg_level {
> >> +	PG_LEVEL_NONE,
> >> +#ifdef CONFIG_ARM64_4K_PAGES
> >> +	PG_LEVEL_4K,
> >> +	PG_LEVEL_2M,
> >> +	PG_LEVEL_1G,
> >> +#else
> >> +	PG_LEVEL_64K,
> >> +	PG_LEVEL_512M,
> >> +#endif
> >> +	PG_LEVEL_NUM
> >> +};
> > 
> > This doesn't account for 16K pages, and it means each call site has to
> > handle the various page sizes directly.
> > 
> > It would be better to simply count PTE/PMD/PUD/PGD, then handle the size
> > conversion at the end when logging.
> > 
> 
> yes, now I only consider the 4kb and 64kb. if the patch is approved ,I will
> improve it.
> each call site need two different varialbes to statistics, aiming to distinguish
> diffent pages. I think it will no more simple.

I don't follow.

Rather than having:

	#if defined(CONFIG_ARM64_4K_PAGES)
		update_page_count(PG_LEVEL_4K, i);
	#else if defined(CONFIG_ARM64_16K_PAGES)
		update_page_count(PG_LEVEL_16K, i);
	#else if defined(CONFIG_ARM64_64K_PAGES)
		update_page_count(PG_LEVEL_64K, i);
	#else
	#error PAGE SIZE UNKNOWN
	#endif

You'd have:

	update_page_count(PG_LEVEL_PTE, i)

The latter is clearly simpler.

See the end of this email for what the other end would look like.

> >> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> >> index 7a5ff11..c1888b9 100644
> >> --- a/arch/arm64/mm/pageattr.c
> >> +++ b/arch/arm64/mm/pageattr.c
> >> @@ -15,12 +15,43 @@
> >>  #include <linux/module.h>
> >>  #include <linux/sched.h>
> >>  
> >> +#include <linux/seq_file.h>
> >>  #include <asm/pgalloc.h>
> >>  #include <asm/pgtable.h>
> >>  #include <asm/tlbflush.h>
> >>  
> >>  #include "mm.h"
> >>  
> >> +static unsigned long direct_pages_count[PG_LEVEL_NUM];
> > 
> > This doesn't match reality by the time we start executing the kernel,
> > given we created page tables in head.S.

As I mentioned here, I don't think that the account is correct, but it
depends on what you're trying to account for.

> >> +void update_page_count(int level, unsigned long pages)
> >> +{
> >> +	direct_pages_count[level] += pages;
> >> +}
> >> +
> >> +void split_page_count(int level)
> >> +{
> >> +	direct_pages_count[level]--;
> >> +	direct_pages_count[level-1] += PTRS_PER_PTE;
> >> +}
> >> +
> >> +void arch_report_meminfo(struct seq_file *m)
> >> +{
> >> +#ifdef CONFIG_ARM64_4K_PAGES
> >> +	seq_printf(m, "DirectMap4k:     %8lu kB\n",
> >> +			direct_pages_count[PG_LEVEL_4K] << 2);
> >> +	seq_printf(m, "DirectMap2M:     %8lu kB\n",
> >> +			direct_pages_count[PG_LEVEL_2M] << 11);
> >> +	seq_printf(m, "DirectMap1G:     %8lu kB\n",
> >> +			direct_pages_count[PG_LEVEL_1G] << 20);
> >> +#else
> >> +	seq_printf(m, "DirectMap64k:     %8lu kB\n",
> >> +			direct_pages_count[PG_LEVEL_64K] << 6);
> >> +	seq_printf(m, "DirectMap512M:     %8lu kB\n",
> >> +			direct_pages_count[PG_LEVEL_512M] << 19);
> >> +#endif
> >> +}
> > 
> > You could dynamuically determine the sizes here for each field, and not
> > have to have #ifdefs.> 
> 
> I don't understand what you mean. I think it can be more readable and operability.

Assuming you use PGLEVEL_{PTE,PMD,PUD,PGD}, you can have this work for
any size of page and number of levels using something like:

void arch_report_meminfo(struct seq_file *m)
{
	seq_printf(m, "DirectMap%dk:     %8lu kB\n",
		   PAGE_SIZE / SZ_1K,
		   direct_pages_count[PG_LEVEL_PTE] * PAGE_SIZE / SZ_1K);

#if CONFIG_PGTABLE_LEVELS > 2
	seq_printf(m, "DirectMap%dM:     %8lu kB\n",
		   PMD_SIZE / SZ_1M,
		   direct_pages_count[PG_LEVEL_PMD] * PUD_SIZE / SZ_1K);

#endif

#if CONFIG_PGTABLE_LEVELS > 3
	seq_printf(m, "DirectMap%dG:     %8lu kB\n",
		   PUD_SIZE / SZ_1G,
		   direct_pages_count[PG_LEVEL_PUD] * PUD_SIZE / SZ_1K);

#endif
}

I think that's far more readable and maintainable.

The above may not cover all cases; I'm not sure if you can have a huge
PGD entry in some configuration. If we can, it should be easy to fix up
for.

Thanks,
Mark.
