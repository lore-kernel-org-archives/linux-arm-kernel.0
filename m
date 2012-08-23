From: pullip.cho@samsung.com (KyongHo Cho)
Date: Thu, 23 Aug 2012 12:57:01 +0900
Subject: [RFC 2/4] ARM: dma-mapping: IOMMU allocates pages from pool with
 GFP_ATOMIC
In-Reply-To: <20120822.163648.3800987367886904.hdoyu@nvidia.com>
References: <1345630830-9586-1-git-send-email-hdoyu@nvidia.com>
 <1345630830-9586-3-git-send-email-hdoyu@nvidia.com>
 <CAHQjnOOF7Ca-Dz8K_zcS=gxQsJvKYaWA3tqUeK1RSd-wLYZ44w@mail.gmail.com>
 <20120822.163648.3800987367886904.hdoyu@nvidia.com>
Message-ID: <CAHQjnOMnGMTgrcK+aNsn1OuePdLbPyWkOJoArhUJes4zkwzHAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

We have faced with WQXGA(2560x1600) support and framebuffers become
dramatically larger.
Moreover, high resolution camera sensors also press memory use more than
the screen size.

However, I think that it is enough with your change because allocation
failure of several
contiguous pages also shows that the system don't have enough memory.

On Wed, Aug 22, 2012 at 10:36 PM, Hiroshi Doyu <hdoyu@nvidia.com> wrote:
> Hi,
>
> KyongHo Cho <pullip.cho@samsung.com> wrote @ Wed, 22 Aug 2012 14:47:00
+0200:
>
>> vzalloc() call in __iommu_alloc_buffer() also causes BUG() in atomic
context.
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
>
> *1:
> From a613c40d1b3d4fb1577cdb0807a74e8dbd08a3e6 Mon Sep 17 00:00:00 2001
> From: Hiroshi Doyu <hdoyu@nvidia.com>
> Date: Wed, 22 Aug 2012 16:25:54 +0300
> Subject: [PATCH 1/1] ARM: dma-mapping: Use only kzalloc without vzalloc
>
> Use only kzalloc for atomic allocation.
>
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>  arch/arm/mm/dma-mapping.c |   10 ++--------
>  1 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 4656c0f..d4f1cf2 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1083,10 +1083,7 @@ static struct page **__iommu_alloc_buffer(struct
device *dev, size_t size,
>         int count = size >> PAGE_SHIFT;
>         int array_size = count * sizeof(struct page *);
>
> -       if (array_size <= PAGE_SIZE)
> -               pages = kzalloc(array_size, gfp);
> -       else
> -               pages = vzalloc(array_size);
> +       pages = kzalloc(array_size, gfp);
>         if (!pages)
>                 return NULL;
>
> @@ -1107,10 +1104,7 @@ static struct page **__iommu_alloc_buffer(struct
device *dev, size_t size,
>
>         return pages;
>  error:
> -       if (array_size <= PAGE_SIZE)
> -               kfree(pages);
> -       else
> -               vfree(pages);
> +       kfree(pages);
>         return NULL;
>  }
>
> --
> 1.7.5.4
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a hrefmailto:"dont@kvack.org"> email at kvack.org </a>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120823/8c7327be/attachment-0001.html>
