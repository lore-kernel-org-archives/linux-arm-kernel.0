From: kamezawa.hiroyu@jp.fujitsu.com (KAMEZAWA Hiroyuki)
Date: Fri, 19 Feb 2010 17:21:22 +0900
Subject: Kernel panic due to page migration accessing memory holes
In-Reply-To: <20100219151012.d430b7ea.kamezawa.hiroyu@jp.fujitsu.com>
References: <4B7C8DC2.3060004@codeaurora.org>
	<20100218100324.5e9e8f8c.kamezawa.hiroyu@jp.fujitsu.com>
	<4B7CF8C0.4050105@codeaurora.org>
	<20100218183604.95ee8c77.kamezawa.hiroyu@jp.fujitsu.com>
	<20100218100432.GA32626@csn.ul.ie>
	<4B7DEDB0.8030802@codeaurora.org>
	<20100219110003.dfe58df8.kamezawa.hiroyu@jp.fujitsu.com>
	<4B7E2635.8010700@codeaurora.org>
	<20100219151012.d430b7ea.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <20100219172122.fe0891f5.kamezawa.hiroyu@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Feb 2010 15:10:12 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> 1. re-implement pfn_valid() which returns correct value.
>    maybe not difficult. but please take care of defining CONFIG_HOLES_IN_....
>    etc.
> 
> 2. use DISCONTIGMEM and treat each bank and NUMA node.
>    There will be no waste for memmap. But other complication of CONFIG_NUMA.
>    
> 3. use SPARSEMEM.
>    You have even 2 choisce here. 
>    a - Set your MAX_ORDER and SECTION_SIZE to be proper value.
>    b - waste some amount of memory for memmap on the edge of section.
>        (and don't free memmap for the edge.)
>       

I read ARM's code briefly. In 2.6.32, ...I think (1) is implemented. As
==

#ifndef CONFIG_SPARSEMEM
int pfn_valid(unsigned long pfn)
{
        struct meminfo *mi = &meminfo;
        unsigned int left = 0, right = mi->nr_banks;

        do {
                unsigned int mid = (right + left) / 2;
                struct membank *bank = &mi->bank[mid];

                if (pfn < bank_pfn_start(bank))
                        right = mid;
                else if (pfn >= bank_pfn_end(bank))
                        left = mid + 1;
                else
                        return 1;
        } while (left < right);
        return 0;
}
EXPORT_SYMBOL(pfn_valid);
==
So, what you should do is upgrade to 2.6.32 or backport this one.

See this.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=b7cfda9fc3d7aa60cffab5367f2a72a4a70060cd

Thanks,
-Kame
