From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 07 Jan 2016 14:52:32 +0100
Subject: [PATCH v3 0/3] dma-mapping: Patches for speeding up allocation
In-Reply-To: <1452109005-19517-1-git-send-email-dianders@chromium.org>
References: <1452109005-19517-1-git-send-email-dianders@chromium.org>
Message-ID: <568E6DA0.4000201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2016-01-06 20:36, Douglas Anderson wrote:
> This series of 3 patches will speed up memory allocation in dma-mapping
> quite a bit.
>
> The first patch ("ARM: dma-mapping: Optimize allocation") is hopefully
> not terribly controversial: it merely doesn't try as hard to allocate
> big chunks once it gets the first failure.  Since it's unlikely that
> further big chunks will help (they're not likely to be virtually aligned
> anyway), this should give a big speedup with no real regression to speak
> of.  Yes, things could be made better, but this seems like a sane start.
>
> The second patch ("common: DMA-mapping: add DMA_ATTR_SEQUENTIAL
> attribute") models MADV_SEQUENTIAL as I understand it.  Hopefully folks
> are happy with following that lead.  It does nothing by itself.
>
> The third patch ("ARM: dma-mapping: Use DMA_ATTR_SEQUENTIAL hint to
> optimize allocation") simply applies the 2nd patch.  Again it's pretty
> simple.  ...and again it does nothing by itself.
>
> Notably missing from this series is the fourth patch that adds teeth to
> the second and third.  You can find that out of tree at
> <https://chromium-review.googlesource.com/#/c/320498/>.  Unfortunately
> the rk3288_vpu, which is what I'm working on, is out of tree.
>
> All testing was done on the chromeos kernel-3.14.  Sanity (compile /
> boot) testing was done on a v4.4-rc6-based kernel.
>
> Also note that v2 of this series had an extra patch
> <https://patchwork.kernel.org/patch/7888861/> that would attempt to sort
> the allocation results to opportunistically get some extra alignment.  I
> dropped that, but it could be re-introduced if there was interest.  I
> found that it did give a little extra alignment sometimes, but maybe not
> enough to justify the extra complexity.  It also was a bit half-baked
> since it really should have tried harder to ensure alignment.
>
> Changes in v3:
> - add DMA_ATTR_SEQUENTIAL attribute new for v3
> - Use DMA_ATTR_SEQUENTIAL hint patch new for v3.
>
> Changes in v2:
> - No longer just 1 page at a time, but gives up higher order quickly.
> - Only tries important higher order allocations that might help us.
>
> Douglas Anderson (3):
>    ARM: dma-mapping: Optimize allocation
>    common: DMA-mapping: add DMA_ATTR_SEQUENTIAL attribute
>    ARM: dma-mapping: Use DMA_ATTR_SEQUENTIAL hint to optimize allocation
>
>   Documentation/DMA-attributes.txt | 11 +++++++++++
>   arch/arm/mm/dma-mapping.c        | 41 ++++++++++++++++++++++++++--------------
>   include/linux/dma-attrs.h        |  1 +
>   3 files changed, 39 insertions(+), 14 deletions(-)

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
