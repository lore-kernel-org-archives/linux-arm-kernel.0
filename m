From: gerald.schaefer@de.ibm.com (Gerald Schaefer)
Date: Tue, 8 Nov 2016 20:27:42 +0100
Subject: [PATCH 2/2] mm: hugetlb: support gigantic surplus pages
In-Reply-To: <20161108091725.GA18678@sha-win-210.asiapac.arm.com>
References: <1478141499-13825-1-git-send-email-shijie.huang@arm.com>
 <1478141499-13825-3-git-send-email-shijie.huang@arm.com>
 <20161107162504.17591806@thinkpad>
 <20161108021929.GA982@sha-win-210.asiapac.arm.com>
 <20161108070851.GA15044@sha-win-210.asiapac.arm.com>
 <20161108091725.GA18678@sha-win-210.asiapac.arm.com>
Message-ID: <20161108202742.57ed120d@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Nov 2016 17:17:28 +0800
Huang Shijie <shijie.huang@arm.com> wrote:

> > I will look at the lockdep issue.
> I tested the new patch (will be sent out later) on the arm64 platform,
> and I did not meet the lockdep issue when I enabled the lockdep.
> The following is my config:
> 
> 	CONFIG_LOCKD=y
> 	CONFIG_LOCKD_V4=y
> 	CONFIG_LOCKUP_DETECTOR=y
>         # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> 	CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
> 	CONFIG_DEBUG_SPINLOCK=y
> 	CONFIG_DEBUG_LOCK_ALLOC=y
> 	CONFIG_PROVE_LOCKING=y
> 	CONFIG_LOCKDEP=y
> 	CONFIG_LOCK_STAT=y
> 	CONFIG_DEBUG_LOCKDEP=y
> 	CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> 	
> So do I miss something? 

Those options should be OK. Meanwhile I looked into this a little more,
and the problematic line/lock is spin_lock_irqsave(&z->lock, flags) at
the top of alloc_gigantic_page(). From the lockdep trace we see that
it is triggered by an mmap(), and then hugetlb_acct_memory() ->
__alloc_huge_page() -> alloc_gigantic_page().

However, in between those functions (inside gather_surplus_pages())
a NUMA_NO_NODE node id comes into play. And this finally results in
alloc_gigantic_page() being called with NUMA_NO_NODE as nid (which is
-1), and NODE_DATA(nid)->node_zones will then reach into Nirvana.

So, I guess the problem is a missing NUMA_NO_NODE check in
alloc_gigantic_page(), similar to the one in
__hugetlb_alloc_buddy_huge_page(). And somehow this was not a problem
before the gigantic surplus change.
