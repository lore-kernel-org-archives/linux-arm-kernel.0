From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2018 18:07:12 +0100
Subject: [PATCH] iommu/arm-smmu-v3: Fix big-endian CMD_SYNC writes
In-Reply-To: <e14feb6f7dedc90d181e20fbeaaba49156b03b09.1539689371.git.robin.murphy@arm.com>
References: <e14feb6f7dedc90d181e20fbeaaba49156b03b09.1539689371.git.robin.murphy@arm.com>
Message-ID: <20181017170712.GA4570@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 12:31:07PM +0100, Robin Murphy wrote:
> When we insert the sync sequence number into the CMD_SYNC.MSIData field,
> we do so in CPU-native byte order, before writing out the whole command
> as explicitly little-endian dwords. Thus on big-endian systems, the SMMU
> will receive and write back a byteswapped version of sync_nr, which would
> be perfect if it were targeting a similarly-little-endian ITS, but since
> it's actually writing back to memory being polled by the CPUs, they're
> going to end up seeing the wrong thing.
> 
> Since the SMMU doesn't care what the MSIData actually contains, the
> minimal-overhead solution is to simply add an extra byteswap initially,
> such that it then writes back the big-endian format directly.
> 
> Fixes: 37de98f8f1cf ("iommu/arm-smmu-v3: Use CMD_SYNC completion MSI")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index db402e8b068b..867ba548c2cc 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -952,7 +952,7 @@ static int __arm_smmu_cmdq_issue_sync_msi(struct arm_smmu_device *smmu)
>  	struct arm_smmu_cmdq_ent ent = {
>  		.opcode = CMDQ_OP_CMD_SYNC,
>  		.sync	= {
> -			.msiaddr = virt_to_phys(&smmu->sync_count),
> +			.msiaddr = cpu_to_le32(virt_to_phys(&smmu->sync_count)),

Hmm, aren't you swabbing the address here? Don't we want to swab the data?
We also need a comment to explain this!

Will
