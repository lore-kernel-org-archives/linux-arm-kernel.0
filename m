From: tn@semihalf.com (Tomasz Nowicki)
Date: Mon, 15 May 2017 14:47:25 +0200
Subject: [RFC PATCH 07/30] iommu/arm-smmu-v3: Add second level of context
 descriptor table
In-Reply-To: <20170227195441.5170-8-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-8-jean-philippe.brucker@arm.com>
Message-ID: <ef690c27-95cc-c15d-7e70-7e89de7bc08a@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On 27.02.2017 20:54, Jean-Philippe Brucker wrote:
> @@ -1213,17 +1356,59 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_master_data *master)
>  __maybe_unused
>  static int arm_smmu_alloc_cd(struct arm_smmu_master_data *master)
>  {
> +	int ssid;
> +	int i, ret;
>  	struct arm_smmu_cd_cfg *cfg = &master->ste.cd_cfg;
>
> -	return arm_smmu_bitmap_alloc(cfg->context_map, ilog2(cfg->num_entries));
> +	if (cfg->linear)
> +		return arm_smmu_bitmap_alloc(cfg->table.context_map,
> +					     ilog2(cfg->num_entries));
> +
> +	/* Find first leaf table with an empty slot, or allocate a new leaf */
> +	for (i = cfg->l1.cur_table; i < cfg->num_entries; i++) {
> +		struct arm_smmu_cd_table *table = &cfg->l1.tables[i];
> +
> +		if (!table->cdptr) {
> +			__le64 *l1ptr = cfg->l1.ptr + i * CTXDESC_L1_DESC_DWORD;
> +
> +			ret = arm_smmu_alloc_cd_leaf_table(master->smmu, table,
> +							   CTXDESC_NUM_L2_ENTRIES);
> +			if (ret)
> +				return ret;
> +
> +			arm_smmu_write_cd_l1_desc(l1ptr, table);
> +			arm_smmu_sync_cd(master, i << CTXDESC_SPLIT, false);
> +		}
> +
> +		ssid = arm_smmu_bitmap_alloc(table->context_map, CTXDESC_SPLIT);
> +		if (ssid < 0)
> +			continue;
> +
> +		cfg->l1.cur_table = i;
> +		return i << CTXDESC_SPLIT | ssid;
> +	}
> +
> +	return -ENOSPC;
>  }
>
>  __maybe_unused
>  static void arm_smmu_free_cd(struct arm_smmu_master_data *master, u32 ssid)
>  {
> +	unsigned long l1_idx, idx;
>  	struct arm_smmu_cd_cfg *cfg = &master->ste.cd_cfg;
>
> -	arm_smmu_bitmap_free(cfg->context_map, ssid);
> +	if (cfg->linear) {
> +		arm_smmu_bitmap_free(cfg->table.context_map, ssid);
> +		return;
> +	}
> +
> +	l1_idx = ssid >> CTXDESC_SPLIT;
> +	idx = ssid & ((1 << CTXDESC_SPLIT) - 1);
> +	arm_smmu_bitmap_free(cfg->l1.tables[l1_idx].context_map, idx);
> +
> +	/* Prepare next allocation */
> +	if (cfg->l1.cur_table > idx)
> +		cfg->l1.cur_table = idx;
>  }

I am not sure what is the logic here. idx becomes index of l1.tables in 
arm_smmu_alloc_cd() which in turn may be out of allocated memory. I may 
miss something. Can you please elaborate on this?

Thanks,
Tomasz
