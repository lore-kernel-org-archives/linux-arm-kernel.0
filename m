From: shijie.huang@arm.com (Huang Shijie)
Date: Wed, 7 Dec 2016 16:46:56 +0800
Subject: [PATCH v3 0/4] mm: fix the "counter.sh" failure for libhugetlbfs
In-Reply-To: <20161205093100.GF30758@dhcp22.suse.cz>
References: <1480929431-22348-1-git-send-email-shijie.huang@arm.com>
 <20161205093100.GF30758@dhcp22.suse.cz>
Message-ID: <20161207084653.GA4846@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 05:31:01PM +0800, Michal Hocko wrote:
> On Mon 05-12-16 17:17:07, Huang Shijie wrote:
> [...]
> >    The failure is caused by:
> >     1) kernel fails to allocate a gigantic page for the surplus case.
> >        And the gather_surplus_pages() will return NULL in the end.
> > 
> >     2) The condition checks for some functions are wrong:
> >         return_unused_surplus_pages()
> >         nr_overcommit_hugepages_store()
> >         hugetlb_overcommit_handler()
> 
> OK, so how is this any different from gigantic (1G) hugetlb pages on
> x86_64? Do we need the same functionality or is it just 32MB not being
> handled in the same way as 1G?
I tested this patch set on the Softiron board(ARM64) which has 16G memory.
I appended "hugepagesz=1G hugepages=6" in the kernel cmdline, the arm64
will use the PUD_SIZE for the hugetlb page.

The 1G page size can run well, I post the log here:

--------------------------------------------------------
	counters.sh (1024M: 64):        PASS
	********** TEST SUMMARY
	*                      1024M         
	*                      32-bit 64-bit 
	*     Total testcases:     0      1   
	*             Skipped:     0      0   
	*                PASS:     0      1   
	*                FAIL:     0      0   
	*    Killed by signal:     0      0   
	*   Bad configuration:     0      0   
	*       Expected FAIL:     0      0   
	*     Unexpected PASS:     0      0   
	* Strange test result:     0      0   
	**********
--------------------------------------------------------

My desktop is x86_64, but its memory is just 8G.
I will expand its memory capacity, and continue to
the test for x86_64. 

Thanks
Huang Shijie
