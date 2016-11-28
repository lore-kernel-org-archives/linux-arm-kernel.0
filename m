From: vbabka@suse.cz (Vlastimil Babka)
Date: Mon, 28 Nov 2016 15:20:05 +0100
Subject: [PATCH v2 0/6] mm: fix the "counter.sh" failure for libhugetlbfs
In-Reply-To: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
References: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
Message-ID: <6b83ea5d-a465-7582-a215-51a21fb4ce2e@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2016 08:07 AM, Huang Shijie wrote:
> (1) Background
>    For the arm64, the hugetlb page size can be 32M (PMD + Contiguous bit).
>    In the 4K page environment, the max page order is 10 (max_order - 1),
>    so 32M page is the gigantic page.
>
>    The arm64 MMU supports a Contiguous bit which is a hint that the TTE
>    is one of a set of contiguous entries which can be cached in a single
>    TLB entry.  Please refer to the arm64v8 mannul :
>        DDI0487A_f_armv8_arm.pdf (in page D4-1811)
>
> (2) The bug
>    After I tested the libhugetlbfs, I found the test case "counter.sh"
>    will fail with the gigantic page (32M page in arm64 board).
>
>    This patch set adds support for gigantic surplus hugetlb pages,
>    allowing the counter.sh unit test to pass.
>
> v1 -- > v2:
>    1.) fix the compiler error in X86.
>    2.) add new patches for NUMA.
>        The patch #2 ~ #5 are new patches.
>
> Huang Shijie (6):
>   mm: hugetlb: rename some allocation functions
>   mm: hugetlb: add a new parameter for some functions
>   mm: hugetlb: change the return type for alloc_fresh_gigantic_page
>   mm: mempolicy: intruduce a helper huge_nodemask()
>   mm: hugetlb: add a new function to allocate a new gigantic page
>   mm: hugetlb: support gigantic surplus pages
>
>  include/linux/mempolicy.h |   8 +++
>  mm/hugetlb.c              | 128 ++++++++++++++++++++++++++++++++++++----------
>  mm/mempolicy.c            |  20 ++++++++
>  3 files changed, 130 insertions(+), 26 deletions(-)

Can't say I'm entirely happy with the continued direction of maze of 
functions for huge page allocation :( Feels like path of least 
resistance to basically copy/paste the missing parts here. Is there no 
way to consolidate the code more?
