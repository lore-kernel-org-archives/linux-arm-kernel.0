From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 23 Aug 2012 09:52:07 +0200
Subject: [RFC 2/4] ARM: dma-mapping: IOMMU allocates pages from pool with
 GFP_ATOMIC
In-Reply-To: <20120823091519.804aeae4ba93bcfe011e787c@nvidia.com>
References: <1345630830-9586-1-git-send-email-hdoyu@nvidia.com>
 <1345630830-9586-3-git-send-email-hdoyu@nvidia.com>
 <CAHQjnOOF7Ca-Dz8K_zcS=gxQsJvKYaWA3tqUeK1RSd-wLYZ44w@mail.gmail.com>
 <20120822.163648.3800987367886904.hdoyu@nvidia.com>
 <012401cd80f4$59727020$0c575060$%szyprowski@samsung.com>
 <20120823091519.804aeae4ba93bcfe011e787c@nvidia.com>
Message-ID: <014501cd8104$35a8ce40$a0fa6ac0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hiroshi,

On Thursday, August 23, 2012 8:15 AM Hiroshi Doyu wrote:

> On Thu, 23 Aug 2012 07:58:34 +0200
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> 
> > Hello,
> >
> > On Wednesday, August 22, 2012 3:37 PM Hiroshi Doyu wrote:
> >
> > > KyongHo Cho <pullip.cho@samsung.com> wrote @ Wed, 22 Aug 2012 14:47:00 +0200:
> > >
> > > > vzalloc() call in __iommu_alloc_buffer() also causes BUG() in atomic context.
> > >
> > > Right.
> > >
> > > I've been thinking that kzalloc() may be enough here, since
> > > vzalloc() was introduced to avoid allocation failure for big chunk of
> > > memory, but I think that it's unlikely that the number of page array
> > > can be so big. So I propose to drop vzalloc() here, and just simply to
> > > use kzalloc only as below(*1).
> >
> > We already had a discussion about this, so I don't think it makes much sense to
> > change it back to kzalloc. This vmalloc() call won't hurt anyone. It should not
> > be considered a problem for atomic allocations, because no sane driver will try
> > to allocate buffers larger than a dozen KiB with GFP_ATOMIC flag. I would call
> > such try a serious bug, which we should not care here.
> 
> Ok, I've already sent v2 just now, where, instead of changing it back,
> just with GFP_ATOMIC, kzalloc() would be selected, just in case. I guess
> that this would be ok(a bit safer?)

I've posted some comments to v2. If you agree with my suggestion, no changes around
those vmalloc() calls will be needed.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
