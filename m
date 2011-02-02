From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 2 Feb 2011 19:03:16 +0530
Subject: [PATCH v1 1/4] davinci: da8xx/omap-l1: add support for SPI
In-Reply-To: <4D49543A.1070302@criticallink.com>
References: <1296596979-18524-1-git-send-email-michael.williamson@criticallink.com>
	<1296596979-18524-2-git-send-email-michael.williamson@criticallink.com>
	<4D494C6A.30507@mvista.com> <4D49543A.1070302@criticallink.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302487782C9@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 18:25:22, Michael Williamson wrote:

> >> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> >> index beda8a4..f421f97 100644
> >> --- a/arch/arm/mach-davinci/devices-da8xx.c
> >> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> >> @@ -725,3 +725,99 @@ int __init da8xx_register_cpuidle(void)
> >>
> >>       return platform_device_register(&da8xx_cpuidle_device);
> >>   }
> >> +
> >> +static struct resource da8xx_spi0_resources[] = {
> >> +    [0] = {
> >> +        .start    = 0x01c41000,
> >> +        .end    = 0x01c41fff,
> >> +        .flags    = IORESOURCE_MEM,
> >> +    },
> >> +    [1] = {
> >> +        .start    = IRQ_DA8XX_SPINT0,
> >> +        .end    = IRQ_DA8XX_SPINT0,
> >> +        .flags    = IORESOURCE_IRQ,
> >> +    },
> >> +    [2] = {
> >> +        .start    = EDMA_CTLR_CHAN(0, 14),
> >> +        .end    = EDMA_CTLR_CHAN(0, 14),
> >> +        .flags    = IORESOURCE_DMA,
> >> +    },
> >> +    [3] = {
> >> +        .start    = EDMA_CTLR_CHAN(0, 15),
> >> +        .end    = EDMA_CTLR_CHAN(0, 15),
> >> +        .flags    = IORESOURCE_DMA,
> >> +    },
> > 
> >    We have DA830_DMACH_SPI0_[RT]X defined for SPI0 DMA channels...
> > 
> 
> 
> Right.  The current routines/structures were designed to support either da830 or
> da850.  They work because the interrupts and the DMA channels are fortunately
> the same for the SPI devices between the platforms.  I can use the DA830 enums, 
> but I had preferred the clarity of the EDMA_CTRL_CHAN macro, and it would 
> remove confusion that this might only apply for DA830 and not DA850.  It would
> be nice to rename that DA8XX_DMAC_SPI_[RT]X if the enums were used...
> 
> Can I leave this, or do you really want me to use the enums?
> 

Looks like a bunch of cleaning-up needs to happen in this area.
The DA830_DMACH_* are not used anywhere at all. Instead most of
devices-da8xx.c uses DMA channel numbers directly (except for ASP,
which has them defined in asp.h).

Since all the platform device definitions for DA8XX devices happens
in devices-da8xx.c, it makes sense to get rid of the DA830_DMACH_*
enum altogether and instead just define the channel numbers used in
devices-da8xx.c above the actual usage.

Mike, is that something you are willing take-up?

Thanks,
Sekhar
