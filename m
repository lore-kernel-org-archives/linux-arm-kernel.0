From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Jan 2014 15:53:02 +0000
Subject: [PATCH 05/11] iommu/arm-smmu: Check for duplicate stream IDs
 when registering master devices
In-Reply-To: <1389876263-25759-6-git-send-email-andreas.herrmann@calxeda.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-6-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <20140122155302.GF14108@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 12:44:17PM +0000, Andreas Herrmann wrote:
> Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> ---
>  drivers/iommu/arm-smmu.c |   25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 02a871e..a4e0c93 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -56,6 +56,9 @@
>  /* Maximum number of stream IDs assigned to a single device */
>  #define MAX_MASTER_STREAMIDS		8
>  
> +/* Maximum stream ID */
> +#define ARM_SMMU_MAX_STREAMID		(SZ_64K - 1)
> +
>  /* Maximum number of context banks per SMMU */
>  #define ARM_SMMU_MAX_CBS		128
>  
> @@ -386,6 +389,8 @@ struct arm_smmu_device {
>  	u32				smr_mask_mask;
>  	u32				smr_id_mask;
>  
> +	unsigned long			*sids;

DECLARE_BITMAP instead? However, that's an 8k bitmap just for sanity
checking, which I'm not too fond of. Given that the motivation for the
checking was your smr allocator, perhaps it's sufficient just to do the
checking on a per-master basis, which we can do with the exhaustive search
each time.

Will
