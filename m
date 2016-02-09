From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Feb 2016 14:08:17 +0000
Subject: [PATCH 1/4] iommu/arm-smmu: Treat all device transactions as
 unprivileged
In-Reply-To: <6c5730256333b8d941f2c0371c1ab709a454938c.1453830752.git.robin.murphy@arm.com>
References: <cover.1453830752.git.robin.murphy@arm.com>
 <6c5730256333b8d941f2c0371c1ab709a454938c.1453830752.git.robin.murphy@arm.com>
Message-ID: <20160209140817.GN22874@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 06:06:34PM +0000, Robin Murphy wrote:
> The IOMMU API has no concept of privilege so assumes all devices and
> mappings are equal, and indeed most non-CPU master devices on an AMBA
> interconnect make little use of the attribute bits on the bus thus by
> default perform unprivileged data accesses.
> 
> Some devices, however, believe themselves more equal than others, such
> as programmable DMA controllers whose 'master' thread issues bus
> transactions marked as privileged instruction fetches, while the data
> accesses of its channel threads (under the control of Linux, at least)
> are marked as unprivileged. This poses a problem for implementing the
> DMA API on an IOMMU conforming to ARM VMSAv8, under which a page that is
> unprivileged-writeable is also implicitly privileged-execute-never.
> Given that, there is no one set of attributes with which iommu_map() can
> implement, say, dma_alloc_coherent() that will allow every possible type
> of access without something running into unexecepted permission faults.
> 
> Fortunately the SMMU architecture provides a means to mitigate such
> issues by overriding the incoming attributes of a transaction; make use
> of that to strip the privileged/unprivileged status off incoming
> transactions, leaving just the instruction/data dichotomy which the
> IOMMU API does at least understand; Four states good, two states better.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 59ee4b8..1f9093d 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -167,6 +167,9 @@
>  #define S2CR_TYPE_BYPASS		(1 << S2CR_TYPE_SHIFT)
>  #define S2CR_TYPE_FAULT			(2 << S2CR_TYPE_SHIFT)
>  
> +#define S2CR_PRIVCFG_SHIFT		24
> +#define S2CR_PRIVCFG_UNPRIV		(2 << S2CR_PRIVCFG_SHIFT)
> +
>  /* Context bank attribute registers */
>  #define ARM_SMMU_GR1_CBAR(n)		(0x0 + ((n) << 2))
>  #define CBAR_VMID_SHIFT			0
> @@ -1083,7 +1086,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
>  		u32 idx, s2cr;
>  
>  		idx = cfg->smrs ? cfg->smrs[i].idx : cfg->streamids[i];
> -		s2cr = S2CR_TYPE_TRANS |
> +		s2cr = S2CR_TYPE_TRANS | S2CR_PRIVCFG_UNPRIV |
>  		       (smmu_domain->cfg.cbndx << S2CR_CBNDX_SHIFT);
>  		writel_relaxed(s2cr, gr0_base + ARM_SMMU_GR0_S2CR(idx));

Hmm, do we also need to worry about the bypass case? I guess not for the
moment, but I anticipate horrible things.

Will
