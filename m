From: shijie.huang@arm.com (Huang Shijie)
Date: Tue, 8 Nov 2016 15:08:53 +0800
Subject: [PATCH 2/2] mm: hugetlb: support gigantic surplus pages
In-Reply-To: <20161108021929.GA982@sha-win-210.asiapac.arm.com>
References: <1478141499-13825-1-git-send-email-shijie.huang@arm.com>
 <1478141499-13825-3-git-send-email-shijie.huang@arm.com>
 <20161107162504.17591806@thinkpad>
 <20161108021929.GA982@sha-win-210.asiapac.arm.com>
Message-ID: <20161108070851.GA15044@sha-win-210.asiapac.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 10:19:30AM +0800, Huang Shijie wrote:
> On Mon, Nov 07, 2016 at 04:25:04PM +0100, Gerald Schaefer wrote:
> > On Thu, 3 Nov 2016 10:51:38 +0800
> > Huang Shijie <shijie.huang@arm.com> wrote:
> > 
> > > When testing the gigantic page whose order is too large for the buddy
> > > allocator, the libhugetlbfs test case "counter.sh" will fail.
> > > 
> > > The failure is caused by:
> > >  1) kernel fails to allocate a gigantic page for the surplus case.
> > >     And the gather_surplus_pages() will return NULL in the end.
> > > 
> > >  2) The condition checks for "over-commit" is wrong.
> > > 
> > > This patch adds code to allocate the gigantic page in the
> > > __alloc_huge_page(). After this patch, gather_surplus_pages()
> > > can return a gigantic page for the surplus case.
> > > 
> > > This patch also changes the condition checks for:
> > >      return_unused_surplus_pages()
> > >      nr_overcommit_hugepages_store()
> > > 
> > > After this patch, the counter.sh can pass for the gigantic page.
> > > 
> > > Acked-by: Steve Capper <steve.capper@arm.com>
> > > Signed-off-by: Huang Shijie <shijie.huang@arm.com>
> > > ---
> > >  mm/hugetlb.c | 15 ++++++++++-----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 0bf4444..2b67aff 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -1574,7 +1574,7 @@ static struct page *__alloc_huge_page(struct hstate *h,
> > >  	struct page *page;
> > >  	unsigned int r_nid;
> > > 
> > > -	if (hstate_is_gigantic(h))
> > > +	if (hstate_is_gigantic(h) && !gigantic_page_supported())
> > >  		return NULL;
> > 
> > Is it really possible to stumble over gigantic pages w/o having
> > gigantic_page_supported()?
> > 
> > Also, I've just tried this on s390 and counter.sh still fails after these
> > patches, and it should fail on all archs as long as you use the gigantic
> I guess the failure you met is caused by the libhugetlbfs itself, there are
> several bugs in the libhugetlbfs. I have a patch set for the
> libhugetlbfs too. I will send it as soon as possible.
> 
> > hugepage size as default hugepage size. This is because you only changed
> > nr_overcommit_hugepages_store(), which handles nr_overcommit_hugepages
> > in sysfs, and missed hugetlb_overcommit_handler() which handles
> > /proc/sys/vm/nr_overcommit_hugepages for the default sized hugepages.
> This is wrong. :)
Sorry, I was wrong :). The counters test does call the /proc/sys/vm/nr_overcommit_hugepages.
But in the arm64, it does not trigger a fail for the counters test.
In an other word, I did not change the hugetlb_overcommit_handler(),
the counters.sh also can pass in arm64. 

I will look at the lockdep issue.

Thanks
Huang Shijie
