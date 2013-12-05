From: tj@kernel.org (Tejun Heo)
Date: Thu, 5 Dec 2013 11:59:36 -0500
Subject: [PATCH v2 08/23] mm/memblock: Add memblock memory allocation apis
In-Reply-To: <52A07BBE.7060507@ti.com>
References: <1386037658-3161-1-git-send-email-santosh.shilimkar@ti.com>
 <1386037658-3161-9-git-send-email-santosh.shilimkar@ti.com>
 <20131203232445.GX8277@htj.dyndns.org> <529F5047.50309@ti.com>
 <20131204160730.GQ3158@htj.dyndns.org> <529F5C55.1020707@ti.com>
 <52A07BBE.7060507@ti.com>
Message-ID: <20131205165936.GB24062@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Dec 05, 2013 at 03:12:30PM +0200, Grygorii Strashko wrote:
> I'll try to provide more technical details here.
> As Santosh mentioned in previous e-mails, it's not easy to simply
> get rid of using MAX_NUMNODES:
> 1) we introduce new interface memblock_allocX 
> 2) our interface uses memblock APIs __next_free_mem_range_rev()
>    and __next_free_mem_range()
> 3) __next_free_mem_range_rev() and __next_free_mem_range() use MAX_NUMNODES
> 4) _next_free_mem_range_rev() and __next_free_mem_range() are used standalone,
>    outside of our interface as part of *for_each_free_mem_range* or for_each_mem_pfn_range ..
> 
> The point [4] leads to necessity to find and correct all places where memmblock APIs
> are used and where it's expected to get MAX_NUMNODES as input parameter.
> The major problem is that simple "grep" will not work, because memmblock APIs calls
> are hidden inside other MM modules and it's not always clear
> what will be passed as input parameters to APIs of these MM modules
> (for example sparse_memory_present_with_active_regions() or sparse.c).

Isn't that kinda trivial to work around?  Make those functions accept
both MAX_NUMNODES and NUMA_NO_NODE but emit warning on MAX_NUMNODES
(preferably throttled reasonably).  Given the history of API, we'd
probably want to keep such warning for extended period of time but
that's what we'd need to do no matter what.

> As result, WIP patch, I did, and which was posted by Santosh illustrates
> the probable size and complexity of the change.

Again, I don't really mind the order things happen but I don't think
it's a good idea to spread misusage with a new API.  You gotta deal
with it one way or the other.

> Sorry, but question here is not "Do or not to do?", but rather 'how to do?",
> taking into account complexity and state of the current MM code.
> For example. would it be ok if I'll workaround the issue as in the attached patch?

Well, it's more of when.  It's not really a technically difficult
task and all I'm saying is it better be sooner than later.

Thanks.

-- 
tejun
