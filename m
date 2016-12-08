From: mhocko@suse.com (Michal Hocko)
Date: Thu, 8 Dec 2016 10:52:54 +0100
Subject: [PATCH v3 0/4] mm: fix the "counter.sh" failure for libhugetlbfs
In-Reply-To: <20161208093623.GA4551@sha-win-210.asiapac.arm.com>
References: <1480929431-22348-1-git-send-email-shijie.huang@arm.com>
 <20161205093100.GF30758@dhcp22.suse.cz>
 <20161206100358.GA4619@sha-win-210.asiapac.arm.com>
 <20161207150237.GC31797@dhcp22.suse.cz>
 <20161208093623.GA4551@sha-win-210.asiapac.arm.com>
Message-ID: <20161208095253.GB8330@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 08-12-16 17:36:24, Huang Shijie wrote:
> On Wed, Dec 07, 2016 at 11:02:38PM +0800, Michal Hocko wrote:
[...]
> > I haven't yet checked your patchset but I can tell you one thing.
>
> Could you please review the patch set when you have time? Thanks a lot.

>From a quick glance you do not handle the reservation code at all. You
just make sure that the allocation doesn't fail unconditionally. I might
be wrong here and Naoya resp. Mike will know much better but this seems
far from enough to me.

> 
> > Surplus and subpool pages code is tricky as hell. And it is not just a
> Agree. 
> 
> Do we really need so many accountings? such as reserve/ovorcommit/surplus.

If we want to make giga page the first class citizen then the whole
reservation/surplus code has to independent on the page size.

> > matter of teaching the huge page allocation code to do the right thing.
> > There are subtle details all over the place. E.g. we currently
> > do not free giga pages AFAICS. In fact I believe that the giga pages are
> Please correct me if I am wrong. :)
> 
> I think the free-giga-pages can work well.
> Please see the code in update_and_free_page(). 

Hmm, I have missed that part. I guess you are right but I would have to
look much closer. Hugetlb code tends to be full of surprises.

> Could you please list all the subtle details you think the code is wrong?
> I can check them one by one.

Well, this would take me quite some time and basically restudy the whole
hugetlb code again. What you are trying to achieve is not a simple "fix
a test case" thing. You are trying to implement full featured giga pages
suport. And as I've said this requires a deeper understanding of the
current code and clean it up considerably wrt. giga pages. This is
definitely desirable plan longterm and I would like to encourage you for
that but it is not a simple project at the same time. 
-- 
Michal Hocko
SUSE Labs
