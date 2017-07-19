From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Jul 2017 12:25:24 +0100
Subject: [PATCH 3/5] iommu/arm-smmu-v3: add IOMMU_CAP_BYPASS to the ARM
 SMMUv3 driver
In-Reply-To: <CAALAos8y0kLGrbwgz3u=ZVyteSicuPyQZ3Yp=LPZohXzVaE5NQ@mail.gmail.com>
References: <1500456838-18405-1-git-send-email-anup.patel@broadcom.com>
 <1500456838-18405-4-git-send-email-anup.patel@broadcom.com>
 <ace28bd1-2dd3-482c-d11b-539c055ee9b7@arm.com>
 <CAALAos8y0kLGrbwgz3u=ZVyteSicuPyQZ3Yp=LPZohXzVaE5NQ@mail.gmail.com>
Message-ID: <20170719112524.GF13642@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 19, 2017 at 04:53:04PM +0530, Anup Patel wrote:
> On Wed, Jul 19, 2017 at 4:30 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> > On 19/07/17 10:33, Anup Patel wrote:
> >> The ARM SMMUv3 support bypassing transactions for which domain
> >> is not configured. The patch adds corresponding IOMMU capability
> >> to advertise this fact.
> >>
> >> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> >> ---
> >>  drivers/iommu/arm-smmu-v3.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> >> index 568c400..a6c7f66 100644
> >> --- a/drivers/iommu/arm-smmu-v3.c
> >> +++ b/drivers/iommu/arm-smmu-v3.c
> >> @@ -1423,6 +1423,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
> >>               return true;
> >>       case IOMMU_CAP_NOEXEC:
> >>               return true;
> >> +     case IOMMU_CAP_BYPASS:
> >> +             return true;
> >
> > And this is never true. If Linux knows a device masters through the
> > SMMU, it will always have a default domain of some sort (either identity
> > or DMA ops). If Linux doesn't know, then it won't have been able to
> > initialise the stream table for the relevant stream IDs, thus any
> > 'bypass' DMA is going to raise C_BAD_STE. SMMUv3 can effectively only
> > bypass unknown stream IDs if disabled entirely.
> 
> What if we don't want to use IOMMU for certain device and
> due to this we never provide "iommus" DT attribute in the
> device DT node. Further, we want to access device without
> "iommus" DT attribute from user-space using VFIO no-IOMMU.

Wait, you want to pass a device through to userspace but you don't want to
use the IOMMU? Why not?

If you describe the SMMU in firmware with only a partial topology
description, then you will run into problems with unknown masters trying to
perform DMA. That's the IOMMU doing its job!

Will
