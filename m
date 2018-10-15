From: andrew.murray@arm.com (Andrew Murray)
Date: Mon, 15 Oct 2018 13:46:18 +0100
Subject: [PATCH 1/1] iommu/arm-smmu-v3: eliminate a potential memory
 corruption on Hi16xx soc
In-Reply-To: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
References: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20181015124617.GA12972@e119886-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhen,

On Mon, Oct 15, 2018 at 04:36:16PM +0800, Zhen Lei wrote:
> ITS translation register map:
> 0x0000-0x003C	Reserved
> 0x0040		GITS_TRANSLATER
> 0x0044-0xFFFC	Reserved
> 
> The standard GITS_TRANSLATER register in ITS is only 4 bytes, but Hisilicon
> expands the next 4 bytes to carry some IMPDEF information. That means, 8 bytes
> data will be written to MSIAddress each time.
> 
> MSIAddr: |----4bytes----|----4bytes----|
> 	 |    MSIData   |    IMPDEF    |
> 
> There is no problem for ITS, because the next 4 bytes space is reserved in ITS.
> But it will overwrite the 4 bytes memory following "sync_count". It's very
> luckly that the previous and the next neighbour of "sync_count" are both aligned
> by 8 bytes, so no problem is met now.

My understanding is that MSI's are 32bit memory writes and as such the SMMU
performs a 32bit write in response to the MSI. If so then what is different
with the Hi16xx that causes a problem? Have you been able to able to adjust
the layout of the arm_smmu_device struct to demonstrate this?

Thanks,

Andrew Murray

> 
> It's good to explicitly add a workaround:
> 1. Add gcc __attribute__((aligned(8))) to make sure that "sync_count" is always
>    aligned by 8 bytes.
> 2. Add a "u64" union member to make sure the 4 bytes padding is always exist.
> 
> There is no functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 5059d09..a07bc0d 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -586,7 +586,10 @@ struct arm_smmu_device {
>  
>  	struct arm_smmu_strtab_cfg	strtab_cfg;
>  
> +	union {
> +	u64				padding; /* workaround for Hisilicon */
>  	u32				sync_count;
> +	} __attribute__((aligned(8)));
>  
>  	/* IOMMU core code handle */
>  	struct iommu_device		iommu;
> -- 
> 1.8.3
> 
> 
> _______________________________________________
> iommu mailing list
> iommu at lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
