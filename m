From: minchan@kernel.org (Minchan Kim)
Date: Thu, 23 Aug 2012 12:49:35 +0900
Subject: [RFC 2/4] ARM: dma-mapping: IOMMU allocates pages from pool with
 GFP_ATOMIC
In-Reply-To: <20120822.163648.3800987367886904.hdoyu@nvidia.com>
References: <1345630830-9586-1-git-send-email-hdoyu@nvidia.com>
 <1345630830-9586-3-git-send-email-hdoyu@nvidia.com>
 <CAHQjnOOF7Ca-Dz8K_zcS=gxQsJvKYaWA3tqUeK1RSd-wLYZ44w@mail.gmail.com>
 <20120822.163648.3800987367886904.hdoyu@nvidia.com>
Message-ID: <20120823034935.GC5369@bbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 03:36:48PM +0200, Hiroshi Doyu wrote:
> Hi,
> 
> KyongHo Cho <pullip.cho@samsung.com> wrote @ Wed, 22 Aug 2012 14:47:00 +0200:
> 
> > vzalloc() call in __iommu_alloc_buffer() also causes BUG() in atomic context.
> 
> Right.
> 
> I've been thinking that kzalloc() may be enough here, since
> vzalloc() was introduced to avoid allocation failure for big chunk of
> memory, but I think that it's unlikely that the number of page array
> can be so big. So I propose to drop vzalloc() here, and just simply to
> use kzalloc only as below(*1).
> 
> For example, 
> 
> 1920(H) x 1080(W) x 4(bytes) ~= 8MiB
> 
> For 8 MiB buffer,
>   8(MiB) * 1024 = 8192(KiB)
>   8192(KiB) / 4(KiB/page) = 2048 pages
>   sizeof(struct page *) = 4 bytes
>   2048(pages) * 4(bytes/page) = 8192(bytes) = 8(KiB)
>   8(KiB) / 4(KiB/page) = 2 pages
> 
> If the above estimation is right(I hope;)), the necessary pages are
> _at most_ 2 pages. If the system gets into the situation to fail to
> allocate 2 contiguous pages, that's real the problem. I guess that
> that kind of fragmentation problem would be solved with page migration
> or something, especially nowadays devices are getting larger memories.

In atomic context, VM have no choice except relying on kswapd so
high order allocation can fail easily when memory fragementation
is high.

-- 
Kind regards,
Minchan Kim
