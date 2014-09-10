From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Sep 2014 09:42:02 +0200
Subject: [PATCHv3 5/6] ARM: imx: Add initial support for Freescale LS1021A
In-Reply-To: <daf5ec5b70164b3e9a810def41909c48@BL2PR03MB467.namprd03.prod.outlook.com>
References: <1410253952-15631-1-git-send-email-jingchang.lu@freescale.com>
 <3532608.xLS91GQkq4@wuerfel>
 <daf5ec5b70164b3e9a810def41909c48@BL2PR03MB467.namprd03.prod.outlook.com>
Message-ID: <20140402.o60F9Z4YVe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 September 2014 03:31:19 Jingchang Lu wrote:

> >> +DT_MACHINE_START(LS1021A, "Freescale LS1021A")
> >> + #ifdef CONFIG_ZONE_DMA
> >> +       .dma_zone_size  = SZ_128M,
> >> +#endif
> >> +       .init_machine   = ls1021a_init_machine,
> >> +       .dt_compat      = ls1021a_dt_compat,
> >> +       .restart        = mxc_restart,
> >> +MACHINE_END
> >
> >I believe someone recently posted a patch to derive the dma_zone_size from
> >device tree. Can yo try to find that and see if that will work for you?
> >
> >Can you explain what the reason is for needing a DMA zone?
>
> With LPAE enabled on our SoC, we meet the system complaint of
> "coherent DMA mask 0xffffffff is smaller than system GFP_DMA mask 0xffffffffffffffff",
> and I notice that CONFIG_ZONE_DMA and dma_zone_size is a common resolve for this.

Ok, I see. The actual point of dma_zone_size however is slightly
different, and I think you should not use it like this. We normally
only use ZONE_DMA if there are devices that have a limitation smaller
than 4GB, and that appear to be the case for your system.

The message you quote is only present in arch/powerpc, so I'm not sure
what symptoms you are actually seeing. Please try removing the
dma_zone_size setting for your platform and report if it works or
what the symptom is if it does not work with the latest kernel.

We definitely need to get this to work out of the box without
a dma_zone_size hack.

Can you describe what the memory layout is of your platform? Can you
have RAM installed above the 4GB physical address boundary? If you
can, are there any devices that are unable to perform DMA into that
memory without the use of an IOMMU?

	Arnd
