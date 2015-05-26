From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 May 2015 17:12:45 +0100
Subject: [PATCH 2/3] iommu/arm-smmu: Add initial driver support for ARM
 SMMUv3 devices
In-Reply-To: <556283D5.4030901@huawei.com>
References: <1431108046-9675-1-git-send-email-will.deacon@arm.com>
 <1431108046-9675-3-git-send-email-will.deacon@arm.com>
 <5551AE56.6050906@huawei.com> <20150512165500.GE2062@arm.com>
 <55530C4F.5000605@huawei.com> <20150521112555.GH21920@arm.com>
 <556283D5.4030901@huawei.com>
Message-ID: <20150526161245.GR1565@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 25, 2015 at 03:07:17AM +0100, leizhen wrote:
> On 2015/5/21 19:25, Will Deacon wrote:
> > On Wed, May 13, 2015 at 09:33:19AM +0100, leizhen wrote:
> >> If SMMU_IDR1.SIDSIZE = 32 really exist(or too big), we need dynamic choose
> >> Lv2 table size(4K,16K,64K).  Because Lv1 table maybe too big, and can not
> >> be allocated by current API, a dts configuration should be added, like
> >> lv1-table-base = <0x0 0x0>, and we use ioremap_cache get VA(maybe ioremap,
> >> for non-coherent SMMU).
> >>
> >> Oh, I can do it after your patches upstreamed, because this problem maybe
> >> only I met.
> > 
> > I'll have a think about this and see what I can come up with for version
> > 2 of the patch. I'd like to avoid adding additional properties to the DT
> > until they're actually needed, though.
> 
> OK. Will you support non-pci devices in patch version 2?

I don't (yet) plan to support non-PCI devices, for two reasons:

  (1) The support should be based on top of Laurent's RFC series here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/343686.html

      which needs some review etc.

  (2) My simulator only has PCI endpoints

Of course, if you have something that you can test with, then I'm more
than happy to review patches adding this support providing that they're
based on the series above.

On the table front, my current v2 patch uses 16k level-2 tables allocated
lazily (so each one has 256 entries and covers a single PCI bus). I've
also capped the SIDSIZE to 21 for the moment, which means we get a 64k
table there.

Sound reasonable for the time being?

Will
