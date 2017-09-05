From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Tue, 5 Sep 2017 13:54:19 +0100
Subject: [RFC PATCH 6/6] iommu/arm-smmu-v3: Avoid ILLEGAL setting of
 STE.S1STALLD and CD.S
In-Reply-To: <1504167642-14922-7-git-send-email-xieyisheng1@huawei.com>
References: <1504167642-14922-1-git-send-email-xieyisheng1@huawei.com>
 <1504167642-14922-7-git-send-email-xieyisheng1@huawei.com>
Message-ID: <738977bb-4cd7-7d86-0ea0-0c88b6af721c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/08/17 09:20, Yisheng Xie wrote:
> It is ILLEGAL to set STE.S1STALLD if STALL_MODEL is not 0b00, which
> means we should not disable stall mode if stall/terminate mode is not
> configuable.
> 
> Meanwhile, it is also ILLEGAL when STALL_MODEL==0b10 && CD.S==0 which
> means if stall mode is force we should always set CD.S.
> 
> This patch add ARM_SMMU_FEAT_TERMINATE feature bit for smmu, and use
> TERMINATE feature checking to ensue above ILLEGAL cases from happening.
> 
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index dbda2eb..0745522 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -55,6 +55,7 @@
>  #define IDR0_STALL_MODEL_SHIFT		24
>  #define IDR0_STALL_MODEL_MASK		0x3
>  #define IDR0_STALL_MODEL_STALL		(0 << IDR0_STALL_MODEL_SHIFT)
> +#define IDR0_STALL_MODEL_NS		(1 << IDR0_STALL_MODEL_SHIFT)
>  #define IDR0_STALL_MODEL_FORCE		(2 << IDR0_STALL_MODEL_SHIFT)
>  #define IDR0_TTENDIAN_SHIFT		21
>  #define IDR0_TTENDIAN_MASK		0x3
> @@ -766,6 +767,7 @@ struct arm_smmu_device {
>  #define ARM_SMMU_FEAT_SVM		(1 << 15)
>  #define ARM_SMMU_FEAT_HA		(1 << 16)
>  #define ARM_SMMU_FEAT_HD		(1 << 17)
> +#define ARM_SMMU_FEAT_TERMINATE		(1 << 18)

I'd rather introduce something like "ARM_SMMU_FEAT_STALL_FORCE" instead.
Terminate model has another meaning, and is defined by a different bit in
IDR0.

Thanks,
Jean
