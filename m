From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 15 Mar 2016 13:03:04 +0100
Subject: [RFC 3/3] iommu: dma-iommu: use common implementation also on ARM
 architecture
In-Reply-To: <CANqRtoRiZOPhCBo38zVLL6tQB2aBLy3uWWbqJJypxEFDXJwF1Q@mail.gmail.com>
References: <1455870164-25337-1-git-send-email-m.szyprowski@samsung.com>
 <1455870164-25337-4-git-send-email-m.szyprowski@samsung.com>
 <CANqRtoRiZOPhCBo38zVLL6tQB2aBLy3uWWbqJJypxEFDXJwF1Q@mail.gmail.com>
Message-ID: <56E7F9F8.6030203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2016-03-15 12:18, Magnus Damm wrote:
> Hi Marek,
>
> On Fri, Feb 19, 2016 at 5:22 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> This patch replaces ARM-specific IOMMU-based DMA-mapping implementation
>> with generic IOMMU DMA-mapping code shared with ARM64 architecture. The
>> side-effect of this change is a switch from bitmap-based IO address space
>> management to tree-based code. There should be no functional changes
>> for drivers, which rely on initialization from generic arch_setup_dna_ops()
>> interface. Code, which used old arm_iommu_* functions must be updated to
>> new interface.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
> Thanks for your efforts and my apologies for late comments. Just FYI
> I'll try your patch (and this series) with the ipmmu-vmsa.c driver on
> 32-bit ARM and see how it goes. Nice not to have to support multiple
> interfaces depending on architecture!

Thanks for testing!

> One question that comes to mind is how to handle features.
>
> For instance, the 32-bit ARM code supports DMA_ATTR_FORCE_CONTIGUOUS
> while the shared code in drivers/iommu/dma-iommu.c does not. I assume
> existing users may rely on such features so from my point of view it
> probably makes sense to carry over features from the 32-bit ARM code
> into the shared code before pulling the plug.

Right, this has to be added to common code before merging.

> I also wonder if it is possible to do a step-by-step migration and
> support both old and new interfaces in the same binary? That may make
> things easier for multiplatform enablement. So far I've managed to
> make one IOMMU driver support both 32-bit ARM and 64-bit ARM with some
> ugly magic, so adjusting 32-bit ARM dma-mapping code to coexist with
> the shared code in drivers/iommu/dma-iommu.c may also be possible. And
> probably involving even more ugly magic. =)

Having one IOMMU driver for both 32-bit and 64-bit ARM archs is quite easy
IF you rely on the iommu core to setup everything. See exynos-iommu driver
- after my last patches it now works fine on both archs (using arch
specific interfaces). Most of the magic is done automatically by
arch_setup_dma_ops().

The real problem is the fact that there are drivers (like DRM) which rely
on specific dma-mapping functions from ARM architecture, which need to be
rewritten.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
