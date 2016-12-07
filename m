From: mhocko@suse.com (Michal Hocko)
Date: Wed, 7 Dec 2016 16:02:38 +0100
Subject: [PATCH v3 0/4] mm: fix the "counter.sh" failure for libhugetlbfs
In-Reply-To: <20161206100358.GA4619@sha-win-210.asiapac.arm.com>
References: <1480929431-22348-1-git-send-email-shijie.huang@arm.com>
 <20161205093100.GF30758@dhcp22.suse.cz>
 <20161206100358.GA4619@sha-win-210.asiapac.arm.com>
Message-ID: <20161207150237.GC31797@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 06-12-16 18:03:59, Huang Shijie wrote:
> On Mon, Dec 05, 2016 at 05:31:01PM +0800, Michal Hocko wrote:
> > On Mon 05-12-16 17:17:07, Huang Shijie wrote:
> > [...]
> > >    The failure is caused by:
> > >     1) kernel fails to allocate a gigantic page for the surplus case.
> > >        And the gather_surplus_pages() will return NULL in the end.
> > > 
> > >     2) The condition checks for some functions are wrong:
> > >         return_unused_surplus_pages()
> > >         nr_overcommit_hugepages_store()
> > >         hugetlb_overcommit_handler()
> > 
> > OK, so how is this any different from gigantic (1G) hugetlb pages on
> I think there is no different from gigantic (1G) hugetlb pages on
> x86_64. Do anyone ever tested the 1G hugetlb pages in x86_64 with the "counter.sh"
> before? 

I suspect nobody has because the gigantic page support is still somehow
coarse and from a quick look into the code we only support pre-allocated
giga pages. In other words surplus pages and their accounting is not
supported at all.

I haven't yet checked your patchset but I can tell you one thing.
Surplus and subpool pages code is tricky as hell. And it is not just a
matter of teaching the huge page allocation code to do the right thing.
There are subtle details all over the place. E.g. we currently
do not free giga pages AFAICS. In fact I believe that the giga pages are
kind of implanted to the existing code without any higher level
consistency. This should change long term. But I am worried it is much
more work.

Now I might be wrong because I might misremember things which might have
been changed recently but please make sure you describe the current
state and changes of giga pages when touching this area much better if
you want to pursue this route...

Thanks!
-- 
Michal Hocko
SUSE Labs
