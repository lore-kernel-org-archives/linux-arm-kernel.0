From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Mon, 3 Apr 2017 14:04:35 +0530
Subject: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
In-Reply-To: <20170227195441.5170-5-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-5-jean-philippe.brucker@arm.com>
Message-ID: <CA+sq2CeWpGarhT9p+iVo8nJXR=xpkj6XNMwv4LvbP0M6JxA_SA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static size_t arm_smmu_atc_invalidate_domain(struct arm_smmu_domain *smmu_domain,
> +                                            unsigned long iova, size_t size)
> +{
> +       unsigned long flags;
> +       struct arm_smmu_cmdq_ent cmd = {0};
> +       struct arm_smmu_group *smmu_group;
> +       struct arm_smmu_master_data *master;
> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
> +       struct arm_smmu_cmdq_ent sync_cmd = {
> +               .opcode = CMDQ_OP_CMD_SYNC,
> +       };
> +
> +       spin_lock_irqsave(&smmu_domain->groups_lock, flags);
> +
> +       list_for_each_entry(smmu_group, &smmu_domain->groups, domain_head) {
> +               if (!smmu_group->ats_enabled)
> +                       continue;

If ATS is not supported, this seems to increase no of cycles spent in
pgtbl_lock.
Can we return from this API by checking 'ARM_SMMU_FEAT_ATS' in smmu->features ?

Thanks,
Sunil.
