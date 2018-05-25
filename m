From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 25 May 2018 11:48:49 +0200
Subject: REGRESSION: iommu fails to take address limit into account
Message-ID: <CAKv+Gu9HoV-V4nj3j6VPzwGz3Z-G4G7zUQcUHufQ6Rdkk8-VNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I am looking into an issue where a platform device is wired to a
MMU-500, and for some reason (which is under investigation) the
platform device can not drive all address bits. I can work around this
by limiting the DMA mask to 40 bits in the driver. However, the IORT
table allows me to set the address limit as well, and so I was
expecting this to be taken into account by the SMMU driver.

When the iort/iommu layer sets up the DMA operations,
iommu_dma_init_domain() is entered with the expected values:

base == 0
size == 0x100_0000_0000

However, the iommu layer ends up generating IOVA addresses that have
bits [47:40] set (which is what the MMU-500 supports). Looking closer,
this is not surprising, given that the end_pfn variable that is
calculated in iommu_dma_init_domain() is no longer used after Zhen's
patch aa3ac9469c185 ("iommu/iova: Make dma_32bit_pfn implicit") was
applied.

So effectively, this is a regression, and I would like your help
figuring out how to go about fixing this.

Thanks,
Ard.
