From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 25 May 2018 12:35:42 +0200
Subject: REGRESSION: iommu fails to take address limit into account
In-Reply-To: <CAKv+Gu9HoV-V4nj3j6VPzwGz3Z-G4G7zUQcUHufQ6Rdkk8-VNQ@mail.gmail.com>
References: <CAKv+Gu9HoV-V4nj3j6VPzwGz3Z-G4G7zUQcUHufQ6Rdkk8-VNQ@mail.gmail.com>
Message-ID: <CAKv+Gu_0ECwLhoA2ywp3nntFX=RxfpM+MWFwTain1WN1sMrW9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 May 2018 at 11:48, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
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
>

I have narrowed it down a bit further: even though the IOVA range
ignores the IORT address limit, the device's DMA mask is set
correctly. The only problem is that the driver (like all drivers
afaict) does not take into account the fact that its DMA mask has
already been set by the bus layer before its probe function is called.

I could add something like this

-       if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)))
+       if (dma_get_mask(&pdev->dev) == DMA_BIT_MASK(32) &&
+           dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)))
                dev_warn(&pdev->dev, "Failed to enable 64-bit DMA\n");

to only override the mask if it is not at its default value, but it
feels like papering over the problem given that most drivers appear to
ignore the preset mask as well.
