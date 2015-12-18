From: dianders@chromium.org (Doug Anderson)
Date: Fri, 18 Dec 2015 14:35:40 -0800
Subject: [PATCH 3/3] iommu/dma: Avoid unlikely high-order allocations
In-Reply-To: <8014a146e90282b8cbc5868cee0d01776670d9a6.1450457730.git.robin.murphy@arm.com>
References: <9a84191ed813c23db7901f8c73f514d081495bdf.1450457730.git.robin.murphy@arm.com>
 <8014a146e90282b8cbc5868cee0d01776670d9a6.1450457730.git.robin.murphy@arm.com>
Message-ID: <CAD=FV=WqJHjb3zoZn=8OPO2iKH1k1sMvXkVBkyM6pAyvo6PgDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robin,

On Fri, Dec 18, 2015 at 9:01 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> Doug reports that the equivalent page allocator on 32-bit ARM exhibits
> particularly pathalogical behaviour under memory pressure when
> fragmentation is high, where allocating a 4MB buffer takes tens of
> seconds and the number of calls to alloc_pages() is over 9000![1]
>
> We can drastically improve that situation without losing the other
> benefits of high-order allocations when they would succeed, by assuming
> memory pressure is relatively constant over the course of an allocation,
> and not retrying allocations at orders we know to have failed before.
> This way, the best-case behaviour remains unchanged, and in the worst
> case we should see at most a dozen or so (MAX_ORDER - 1) failed attempts
> before falling back to single pages for the remainder of the buffer.
>
> [1]:http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/394660.html
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Presumably it makes sense to update this based on v2 of my patch to
the original code?  AKA: <https://patchwork.kernel.org/patch/7888851/>
?
