From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 10 May 2017 14:54:26 +0200
Subject: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
In-Reply-To: <20170227195441.5170-5-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-5-jean-philippe.brucker@arm.com>
Message-ID: <bc1237e2-3690-bc1e-b7bc-86b982c9058f@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On 27.02.2017 20:54, Jean-Philippe Brucker wrote:
> +/*
> + * Returns -ENOSYS if ATS is not supported either by the device or by the SMMU
> + */
> +static int arm_smmu_enable_ats(struct arm_smmu_master_data *master)
> +{
> +	int ret;
> +	size_t stu;
> +	struct pci_dev *pdev;
> +	struct arm_smmu_device *smmu = master->smmu;
> +
> +	if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev))
> +		return -ENOSYS;
> +
> +	pdev = to_pci_dev(master->dev);
> +
> +#ifdef CONFIG_PCI_ATS
> +	if (!pdev->ats_cap)
> +		return -ENOSYS;
> +#else
> +	return -ENOSYS;
> +#endif

Nit: This deserves to be another helper in ats.c like:

int pci_ats_supported(struct pci_dev *dev) {
         if (!pdev->ats_cap)
                 return 0;

         return 1;
}

Thanks,
Tomasz
