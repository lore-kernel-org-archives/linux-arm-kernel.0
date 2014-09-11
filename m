From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Sep 2014 12:44:34 +0200
Subject: [PATCHv3 5/6] ARM: imx: Add initial support for Freescale LS1021A
In-Reply-To: <517628172fb3416ea7b12b4ae24e098a@BL2PR03MB467.namprd03.prod.outlook.com>
References: <1410253952-15631-1-git-send-email-jingchang.lu@freescale.com>
 <20140402.o60F9Z4YVe@wuerfel>
 <517628172fb3416ea7b12b4ae24e098a@BL2PR03MB467.namprd03.prod.outlook.com>
Message-ID: <3005087.EqTxEFbPyU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 September 2014 09:53:56 Jingchang Lu wrote:
> >From: Arnd Bergmann [mailto:arnd at arndb.de]
> >
> >Ok, I see. The actual point of dma_zone_size however is slightly different,
> >and I think you should not use it like this. We normally only use ZONE_DMA
> >if there are devices that have a limitation smaller than 4GB, and that
> >appear to be the case for your system.
> >
> >The message you quote is only present in arch/powerpc, so I'm not sure
> >what symptoms you are actually seeing. Please try removing the
> >dma_zone_size setting for your platform and report if it works or what the
> >symptom is if it does not work with the latest kernel.
> >
> >We definitely need to get this to work out of the box without a
> >dma_zone_size hack.
> >
> >Can you describe what the memory layout is of your platform? Can you have
> >RAM installed above the 4GB physical address boundary? If you can, are
> >there any devices that are unable to perform DMA into that memory without
> >the use of an IOMMU?
> >
> Our first LS1021A support is based on kernel-3.12, where when LPAE enabled
> it will compare the device's coherent_dma_mask with arm_dma_limit, which is
> 64-bit 0xffffffffffffffff without CONFIG_ZONE_DMA, with CONFIG_ZONE_DMA can
> limit the comparison and avoid the warning.
> All device can address 32-bit address space on LS1021A, With you comment above,
> I remove the dma_zone_size and only reserve the CONFIG_ZONE_DMA On kernel-3.12,
> finding all works well, so I will remove the dma_zone_size setting on 3.12. Thanks.

Ok, good.
 
> I have a look on latest kernel, finding get_coherent_dma_mask() has limited the mask
> to (u64)DMA_BIT_MASK(32), does this mean the CONFIG_ZONE_DMA is not needed for me
> here? Thanks.

You only need to enable CONFIG_ZONE_DMA in the case of RAM above the 4GB
boundary. I would suggest you do the same as some of the other platforms
by adding

	select ZONE_DMA if ARM_LPAE

into your Kconfig file. If LPAE is disabled, you know that you won't
need ZONE_DMA.

	Arnd
