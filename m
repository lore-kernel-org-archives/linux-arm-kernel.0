From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 25 May 2018 11:34:35 +0100
Subject: REGRESSION: iommu fails to take address limit into account
In-Reply-To: <CAKv+Gu9HoV-V4nj3j6VPzwGz3Z-G4G7zUQcUHufQ6Rdkk8-VNQ@mail.gmail.com>
References: <CAKv+Gu9HoV-V4nj3j6VPzwGz3Z-G4G7zUQcUHufQ6Rdkk8-VNQ@mail.gmail.com>
Message-ID: <31cd3850-fb61-2d5d-7394-66d84d46b63e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 25/05/18 10:48, Ard Biesheuvel wrote:
> Hello all,
> 
> I am looking into an issue where a platform device is wired to a
> MMU-500, and for some reason (which is under investigation) the
> platform device can not drive all address bits. I can work around this
> by limiting the DMA mask to 40 bits in the driver. However, the IORT
> table allows me to set the address limit as well, and so I was
> expecting this to be taken into account by the SMMU driver.
> 
> When the iort/iommu layer sets up the DMA operations,
> iommu_dma_init_domain() is entered with the expected values:
> 
> base == 0
> size == 0x100_0000_0000
> 
> However, the iommu layer ends up generating IOVA addresses that have
> bits [47:40] set (which is what the MMU-500 supports). Looking closer,
> this is not surprising, given that the end_pfn variable that is
> calculated in iommu_dma_init_domain() is no longer used after Zhen's
> patch aa3ac9469c185 ("iommu/iova: Make dma_32bit_pfn implicit") was
> applied.
> 
> So effectively, this is a regression, and I would like your help
> figuring out how to go about fixing this.

Note that the size passed to iommu_dma_init_domain() has *never* been 
any kind of enforced limit, so nothing is actually regressing here. If 
the device master interface is natively >40 bits wide (such that the 
driver would expect to set a larger DMA mask) and the restriction is 
purely in the interconnect between device and SMMU, then that's the case 
which has always been broken.

I do have a long-standing plan of attack for fixing the underlying issue 
(of actually enforcing any dma mask restriction described by IORT or DT 
"dma-ranges"), but it's one of those things that's tied to a whole bunch 
of other rework and fixes in order to be viable. I'm about to go off on 
holiday for a while but I should hopefully have the bandwidth to start 
looking at this seriously once I get back (frankly it's been getting 
bumped down my to-do list for far too long now...)

Robin.
