From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 10 May 2017 14:35:20 +0100
Subject: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
In-Reply-To: <bc1237e2-3690-bc1e-b7bc-86b982c9058f@semihalf.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-5-jean-philippe.brucker@arm.com>
 <bc1237e2-3690-bc1e-b7bc-86b982c9058f@semihalf.com>
Message-ID: <d4ad80e6-4654-710c-4b30-35fd81ab3f06@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/17 13:54, Tomasz Nowicki wrote:
> Hi Jean,
> 
> On 27.02.2017 20:54, Jean-Philippe Brucker wrote:
>> +/*
>> + * Returns -ENOSYS if ATS is not supported either by the device or by
>> the SMMU
>> + */
>> +static int arm_smmu_enable_ats(struct arm_smmu_master_data *master)
>> +{
>> +    int ret;
>> +    size_t stu;
>> +    struct pci_dev *pdev;
>> +    struct arm_smmu_device *smmu = master->smmu;
>> +
>> +    if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev))
>> +        return -ENOSYS;
>> +
>> +    pdev = to_pci_dev(master->dev);
>> +
>> +#ifdef CONFIG_PCI_ATS
>> +    if (!pdev->ats_cap)
>> +        return -ENOSYS;
>> +#else
>> +    return -ENOSYS;
>> +#endif
> 
> Nit: This deserves to be another helper in ats.c like:
> 
> int pci_ats_supported(struct pci_dev *dev) {
>         if (!pdev->ats_cap)
>                 return 0;
> 
>         return 1;
> }

Indeed, although in my next version I'll remove this check altogether.
Instead I now rely on pci_enable_ats to check for ats_cap (as discussed in
patch 3). The downside is that we can't distinguish between absence of ATS
and error in enabling ATS. So we don't print a message in the latter case
anymore, we expect device drivers to check whether ATS is enabled.

Thanks,
Jean
