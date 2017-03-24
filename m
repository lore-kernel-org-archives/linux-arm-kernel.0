From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Fri, 24 Mar 2017 15:09:49 +0000
Subject: [PATCH V9 00/11] IOMMU probe deferral support
In-Reply-To: <20170324144340.GA17560@red-moon>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <58D49845.9060407@hisilicon.com>
 <0ea8022b-a19b-335d-6cc6-81510196f891@codeaurora.org>
 <5FC3163CFD30C246ABAA99954A238FA81750B7CB@lhreml504-mbs>
 <20170324144340.GA17560@red-moon>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA81750BC12@lhreml504-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi at arm.com]
> Sent: Friday, March 24, 2017 2:44 PM
> To: Shameerali Kolothum Thodi
> Cc: Sricharan R; Wangzhou (B); robin.murphy at arm.com;
> will.deacon at arm.com; joro at 8bytes.org; iommu at lists.linux-foundation.org;
> linux-arm-kernel at lists.infradead.org; linux-arm-msm at vger.kernel.org;
> m.szyprowski at samsung.com; bhelgaas at google.com; linux-
> pci at vger.kernel.org; linux-acpi at vger.kernel.org; tn at semihalf.com;
> hanjun.guo at linaro.org; okaya at codeaurora.org
> Subject: Re: [PATCH V9 00/11] IOMMU probe deferral support
> 
> On Fri, Mar 24, 2017 at 09:27:51AM +0000, Shameerali Kolothum Thodi wrote:
> 
> [...]
> 
> > @@ -107,7 +107,7 @@ int of_dma_configure(struct device *dev, struct
> device_node *np)
> >   	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
> >   	if (ret < 0) {
> >   		dma_addr = offset = 0;
> >  -		size = dev->coherent_dma_mask + 1;
> >  +		size = max(dev->coherent_dma_mask, dev-
> >coherent_dma_mask + 1);
> >
> > @@ -1386,7 +1387,8 @@ int acpi_dma_configure(struct device *dev, enum
> dev_dma_attr attr)
> >   	 * Assume dma valid range starts at 0 and covers the whole
> >   	 * coherent_dma_mask.
> >   	 */
> >  -	arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1,
> iommu,
> >  +	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask +
> 1);
> 
> size is not defined in acpi_dma_configure(), so there is something missing in
> the diff above, just to make sure we are testing the same thing.
> 
> Mind posting kernel logs with and without patch above (fixed) for DT boot
> and ACPI boot please.

Sure. We will rerun the tests to create the logs again and share.

Also need to double check, v9 patches are applied correctly on top of our branch.
If I remember correctly v7 was fine with DT(didn't test with ACPI). But then as 
Shicharan said it had that size fix.

Thanks,
Shameer
[...]
