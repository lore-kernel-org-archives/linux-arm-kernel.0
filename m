From: eric.auger@redhat.com (Auger Eric)
Date: Tue, 13 Sep 2016 16:04:52 +0200
Subject: [PATCH] iommu/io-pgtable-arm: Check for v7s-incapable systems
In-Reply-To: <2e473e263ac469bd6d3b09e7756c138325e10969.1473773198.git.robin.murphy@arm.com>
References: <2e473e263ac469bd6d3b09e7756c138325e10969.1473773198.git.robin.murphy@arm.com>
Message-ID: <79a0ef0e-f035-2c2a-2991-05a7ff3223e5@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 13/09/2016 15:26, Robin Murphy wrote:
> On machines with no 32-bit addressable RAM whatsoever, we shouldn't
> even touch the v7s format as it's never going to work.
> 
> Fixes: e5fc9753b1a8 ("iommu/io-pgtable: Add ARMv7 short descriptor support")
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index def8ca1c982d..b7759a48f4ed 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -633,6 +633,9 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>  {
>  	struct arm_v7s_io_pgtable *data;
>  
> +	if (upper_32_bits(PHYS_OFFSET))
> +		return NULL;
> +
>  	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
>  		return NULL;
>  
> 
Fixes the oops on AMD Overdrive
(CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST=y and no DMA_API)

Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
