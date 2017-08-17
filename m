From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 17 Aug 2017 14:01:39 +0100
Subject: [RFC PATCH 4/4] ACPI: IORT: Add SMMUv3 MSI support
In-Reply-To: <de1b88e0-57d5-b73b-bc49-3c28070df6b1@linaro.org>
References: <1502276017-63108-1-git-send-email-guohanjun@huawei.com>
 <1502276017-63108-5-git-send-email-guohanjun@huawei.com>
 <20170811093348.GC26039@red-moon>
 <CAGHbJ3AgEvbpsPdeqJ+bFWa5hBMqxBX6g1eC4HiUvHarJf8H+g@mail.gmail.com>
 <20170815171525.GB13707@e107981-lin.cambridge.arm.com>
 <de1b88e0-57d5-b73b-bc49-3c28070df6b1@linaro.org>
Message-ID: <20170817130139.GA17795@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 03:49:37PM +0800, Hanjun Guo wrote:

[...]

> >  /**
> >   * iort_get_platform_device_domain() - Find MSI domain related to a
> >   * platform device
> >@@ -1159,6 +1207,8 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
> >  	/* Configure DMA for the page table walker */
> >  	acpi_dma_configure(&pdev->dev, attr);
> >+	iort_set_device_domain(&pdev->dev, node);
> 
> This is fine to me, but I think we still need to retrieve
> the output ID as the request id for ITS, which means we
> need to do that in iort_pmsi_get_dev_id(), right?

Yes, probably we can add code there like:

ret = iort_get_id_mapping_index(&index);
if (!ret)
	iort_node_get_id(node, &id, index);
	...

This requires updating iort_node_get_id() to allow single mappings
for SMMU/PMCG as you flagged up before.

I will think a bit more to see if there is a cleaner way to reshuffle
the mapping API.

Thanks,
Lorenzo
