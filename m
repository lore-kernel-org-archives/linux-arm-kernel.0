From: robdclark@gmail.com (Rob Clark)
Date: Thu, 11 Aug 2016 18:06:54 -0400
Subject: [PATCH V6 0/6] iommu/msm: Add DT adaptation and generic bindings
 support
In-Reply-To: <CAF6AEGsF5M1sfwaXKW0x=Mu=nQJR-9+xqrtXd=7Vz_+6G_u25A@mail.gmail.com>
References: <1465817767-9856-1-git-send-email-sricharan@codeaurora.org>
 <CAF6AEGsF5M1sfwaXKW0x=Mu=nQJR-9+xqrtXd=7Vz_+6G_u25A@mail.gmail.com>
Message-ID: <CAF6AEGsLGDqRuB97+qN1g7X60A49Wv1HGbAiaeZoxogMmHY9HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2016 at 4:11 PM, Rob Clark <robdclark@gmail.com> wrote:
> On Mon, Jun 13, 2016 at 7:36 AM, Sricharan R <sricharan@codeaurora.org> wrote:
>> The msm_iommu.c driver currently works based on platform data.
>> A single master device can be connected to more than one iommu and multiple
>> contexts in each of the iommu. This association between master and iommus was
>> represented from platform data using parent/child devices. The master drivers
>> were responsible for attaching all of the iommus/context to a domain. Now the
>> platform data support is removed and DT support is added. The master/iommus are
>> added through generic iommu bindings.
>>
>> This is essentially rework of the patch posted earlier by
>> Rob Clark <robdclark@gmail.com>. This series folds the changes in to the
>> existing driver with the addition of generic bindings.
>>
>>         http://www.spinics.net/lists/linux-arm-msm/msg10077.html
>>
>> Tested this series on ifc6410 board.
>
> btw, the current state, at least on linaro integration branch, fault
> handling doesn't work so well (ie. device never gets resumed).. which
> is a bit unfortunate for a gpu (and results in a *lot* of rebooting on
> my part when debugging userspace).  I haven't had time yet to compare
> to the ancient downstream driver, but not sure if you have any ideas?
>
> I guess probably disabling stall on fault would help.  But I'm not
> even getting the "Fault occurred in context.." prints.  Seeing the
> fault iova is pretty useful since that plus gpu cmdstream trace helps
> me figure out which texture/etc is being accessed out of bounds.

fyi, it looks like it is not getting any fault irq..  it's *possible*
that I screwed up the irq #'s when translating from downstream, so you
might want to double check that.  I thought I had it right, I assume I
would have noticed during piglit runs if fault recovery wasn't working
(since the result is that *everything* after the faulting test would
have failed since gpu is wedged with no access to memory), but it was
long enough ago that I can't claim that definitively.

If you need an easy way to trigger a gpu fault, msmtest is a good way,
change this line:

  https://github.com/freedreno/msmtest/blob/master/msmtest.c#L247

from OUT_RELOC() to OUT_RING(ring, 0x00000000) will trigger a fault.

BR,
-R

>
>> [V6] After some discussions on patch 6 [1] from previous post,
>>      it was concluded that the changes for using relaxed writes
>>      in all places should not be a part of this series, so should
>>      be moved it. So removed that patch and added Acked/Tested tags.
>>      [1] https://patchwork.kernel.org/patch/9129231/
>>
>> [V5] Changed the compatible binding name as per comments, added comments
>>      for usage of barriers in patch 6.
>>
>> [V4] Addressed comments for making the iommu compatible binding more soc
>>      specific and updated the documentation for the iommu clocks.
>>
>> [V3] Addressed comments to correct the usage
>>      of the #iommu-cells binding, improve the flush_iotlb_range function,
>>      added a new patch to use writel_relaxed for register access and split
>>      up the documentation patch.
>>
>> [V2] Adapted the driver to use generic ARMV7S short descriptor pagetable ops
>>      and addressed comments.
>>
>> [V1]
>>    https://lists.linuxfoundation.org/pipermail/iommu/2015-August/014074.html
>>
>> Sricharan R (6):
>>   iommu/msm: Add DT adaptation
>>   documentation: iommu: Add bindings for msm,iommu-v0 ip
>>   iommu/msm: Move the contents from msm_iommu_dev.c to msm_iommu.c
>>   iommu/msm: Add support for generic master bindings
>>   iommu/msm: use generic ARMV7S short descriptor pagetable ops
>>   iommu/msm: Remove driver BROKEN
>>
>>  .../devicetree/bindings/iommu/msm,iommu-v0.txt     |  64 ++
>>  drivers/iommu/Kconfig                              |   2 +-
>>  drivers/iommu/Makefile                             |   2 +-
>>  drivers/iommu/msm_iommu.c                          | 870 +++++++++++----------
>>  drivers/iommu/msm_iommu.h                          |  73 +-
>>  drivers/iommu/msm_iommu_dev.c                      | 381 ---------
>>  6 files changed, 564 insertions(+), 828 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>>  delete mode 100644 drivers/iommu/msm_iommu_dev.c
>>
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>>
