From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Apr 2017 17:08:41 +0100
Subject: [PATCH] iommu/arm-smmu-v3: Increase SMMU CMD queue poll timeout
In-Reply-To: <1493035176-3633-1-git-send-email-gakula@caviumnetworks.com>
References: <1493035176-3633-1-git-send-email-gakula@caviumnetworks.com>
Message-ID: <20170424160841.GS12323@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 05:29:36PM +0530, Geetha sowjanya wrote:
> From: Geetha <gakula@cavium.com>
> 
> When large memory is being unmapped, huge no of tlb invalidation cmds are
> submitted followed by a SYNC command. This sometimes hits CMD queue full and
> poll on queue drain is being timedout throwing error message 'CMD_SYNC timeout'.
> 
> Although there is no functional issue, error message confuses user. Hence increased
> poll timeout to 500us

Hmm, what are you doing to unmap that much? Is this VFIO teardown? Do you
have 7c6d90e2bb1a ("iommu/io-pgtable-arm: Fix iova_to_phys for block
entries") applied?

Will

> 
> Signed-off-by: Geetha <gakula@cavium.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 591bb96..1dcd154 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -407,7 +407,7 @@
>  #define PRIQ_1_ADDR_MASK		0xfffffffffffffUL
>  
>  /* High-level queue structures */
> -#define ARM_SMMU_POLL_TIMEOUT_US	100
> +#define ARM_SMMU_POLL_TIMEOUT_US	500
>  
>  #define MSI_IOVA_BASE			0x8000000
>  #define MSI_IOVA_LENGTH			0x100000
> -- 
> 1.9.1
> 
