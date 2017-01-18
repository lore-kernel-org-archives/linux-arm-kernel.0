From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 18 Jan 2017 12:46:02 +0100
Subject: [PATCH v8 18/18] iommu/arm-smmu: Do not advertise
 IOMMU_CAP_INTR_REMAP anymore
In-Reply-To: <1484127714-3263-19-git-send-email-eric.auger@redhat.com>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
 <1484127714-3263-19-git-send-email-eric.auger@redhat.com>
Message-ID: <6ea18f9d-a09c-6af6-9852-decffa680e55@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.01.2017 10:41, Eric Auger wrote:
> IOMMU_CAP_INTR_REMAP has been advertised in arm-smmu(-v3) although
> on ARM this property is not attached to the IOMMU but rather is
> implemented in the MSI controller (GICv3 ITS).
>
> Now vfio_iommu_type1 checks MSI remapping capability at MSI controller
> level, let's correct this.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

For patches [15-18]:
Reviewed-by: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>

Thanks,
Tomasz

>
> ---
>
> v7 -> v8:
> - added Will's A-b
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 --
>  drivers/iommu/arm-smmu.c    | 2 --
>  2 files changed, 4 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 6c4111c..d9cf6cb 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1375,8 +1375,6 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
>  		return true;
> -	case IOMMU_CAP_INTR_REMAP:
> -		return true; /* MSIs are just memory writes */
>  	case IOMMU_CAP_NOEXEC:
>  		return true;
>  	default:
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index a354572..13d2600 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1374,8 +1374,6 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>  		 * requests.
>  		 */
>  		return true;
> -	case IOMMU_CAP_INTR_REMAP:
> -		return true; /* MSIs are just memory writes */
>  	case IOMMU_CAP_NOEXEC:
>  		return true;
>  	default:
>
