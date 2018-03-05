From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 5 Mar 2018 13:09:19 +0000
Subject: [PATCH 35/37] iommu/arm-smmu-v3: Add support for PRI
In-Reply-To: <6f55afcf-04b0-0dc4-6c75-064b70e6851c@huawei.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-36-jean-philippe.brucker@arm.com>
 <6f55afcf-04b0-0dc4-6c75-064b70e6851c@huawei.com>
Message-ID: <d4e8ad96-fe68-d869-a5ba-c901d4b436aa@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/18 12:29, Dongdong Liu wrote:
>>
>> +static int arm_smmu_enable_pri(struct arm_smmu_master_data *master)
>> +{
>> +	int ret, pos;
>> +	struct pci_dev *pdev;
>> +	/*
>> +	 * TODO: find a good inflight PPR number. We should divide the PRI queue
>> +	 * by the number of PRI-capable devices, but it's impossible to know
>> +	 * about current and future (hotplugged) devices. So we're at risk of
>> +	 * dropping PPRs (and leaking pending requests in the FQ).
>> +	 */
>> +	size_t max_inflight_pprs = 16;
>> +	struct arm_smmu_device *smmu = master->smmu;
>> +
>> +	if (!(smmu->features & ARM_SMMU_FEAT_PRI) || !dev_is_pci(master->dev))
>> +		return -ENOSYS;
>> +
>> +	pdev = to_pci_dev(master->dev);
>> +
>  From here
>> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
>> +	if (!pos)
>> +		return -ENOSYS;
> to here, seems this code is not needed as it is already done in
> pci_reset_pri().

Indeed, thanks. It would allow to differentiate a device that doesn't
support PRI from a reset error, but since we ignore the return value at
the moment I'll remove it.

Thanks,
Jean
