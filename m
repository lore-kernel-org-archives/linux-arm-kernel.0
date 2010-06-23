From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 23 Jun 2010 11:20:55 +0200
Subject: Samsung SoCs: preparation for single kernel
In-Reply-To: <AANLkTikspf9zHuSKe86wDQxI12HpJo_occBlLUXBkjef@mail.gmail.com>
References: <AANLkTinGwWzIAOe2tj6V2kCrMiPT7PHlYs1kFS-IsiN4@mail.gmail.com>
	<AANLkTil-AOEqhMOXydaiA1X_v0rjoNQxALrO0UY638AS@mail.gmail.com>
	<AANLkTil1i_ZGI8bY14HhjrAk9RooVreAJsTteqqrMgqJ@mail.gmail.com>
	<AANLkTikDml6gQAsiRrCjIt4bUD3hnpAATr1erqCGOJMd@mail.gmail.com>
	<002301cb129c$ec59fe30$c50dfa90$%szyprowski@samsung.com>
	<AANLkTikspf9zHuSKe86wDQxI12HpJo_occBlLUXBkjef@mail.gmail.com>
Message-ID: <003e01cb12b5$656c0670$30441350$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, June 23, 2010 10:02 AM Eric Miao wrote:

> >> Now you have
> >>
> >> s5pv210_device_hsmmc0
> >> s5pc100_device_hsmmc0
> >> s3c64xx_device_hsmmc0
> >> ....
> >>
> >> each with a different base.
> >
> > There is no need for such code duplication.
> 
> However, I believe this is the right way to go. A certain level of
> duplication is the price to pay for a generic and clean solution.
> 
> When a peripheral controller or IP is moved from one SoC to the
> next generation, there are several things could have been changed:
> 
> 1. new base address and IRQ number
> 2. fixes and enhancements to the original IP
> 
> 1. will result in a different 'struct resource', and 2. will result in a
> different 'struct platform_device' with a different name, so the driver
> can match the platform_device_id table as you agreed I'm right on
> that recommendation.
> 
> They are actually _two_ different devices.

Right, they are separate entities, but would be really good if a similar
git brcode could be merged together.

> > Ben is working on a solution for
> > a single kernel which supports multiple SoCs. Some of his work in
> progress can
> > be found here: git://git.fluff.org/bjdooks/linux branch wip-samsung-dev
> and
> > wip-samsung-dev2.
> 
> Could you describe it a bit here and bring it on table for discussion?

The idea behind his patches is to provide a table for each SoC with short
description of all available devices and generate platform_device entries
dynamically from that table.

Here is a short code example:

struct s3c_pdev_table s3c6xxx_dev_table[] __initdata = {
	{
		.type	= SAMSUNG_DEVICE_UART,
		.name	= "s3c6400-uart",
		.index	= 0,
		.base	= S3C_PA_UART0,
		.irq	= IRQ_S3CUART_RX0,
		.template = &template_uart_s3c64xx,
	}, {
		.type	= SAMSUNG_DEVICE_UART,
		.name	= "s3c6400-uart",
		.index	= 1,
		.base	= S3C_PA_UART1,
		.irq	= IRQ_S3CUART_RX1,
		.template = &template_uart_s3c64xx,
	}, {
		.type	= SAMSUNG_DEVICE_UART,
		.name	= "s3c6400-uart",
		.index	= 2,
		.base	= S3C_PA_UART2,
		.irq	= IRQ_S3CUART_RX2,
		.template = &template_uart_s3c64xx,
	}, {
		.type	= SAMSUNG_DEVICE_UART,
		.name	= "s3c6400-uart",
		.index	= 3,
		.base	= S3C_PA_UART3,
		.irq	= IRQ_S3CUART_RX3,
		.template = &template_uart_s3c64xx,
	}, {
		.type	= SAMSUNG_DEVICE_WATCHDOG,
		.name	= "s3c2410-wdt",
		.index	= -1,
		.base	= S3C64XX_PA_WATCHDOG,
		.irq	= IRQ_WDT,
	}, {
		.type	= SAMSUNG_DEVICE_SDHCI,
		.name	= "s3c-sdhci",
		.index	= 0,
		.base	= S3C64XX_PA_HSMMC0 ,
		.irq	= IRQ_HSMMC0,
		.dma	= &samsung_std_dma_mask,
	}, {
		.type	= SAMSUNG_DEVICE_SDHCI,
		.name	= "s3c-sdhci",
		.index	= 1,
		.base	= S3C64XX_PA_HSMMC1,
		.irq	= IRQ_HSMMC1,
		.dma	= &samsung_std_dma_mask,
	}, {
		.type	= SAMSUNG_DEVICE_SDHCI,
		.name	= "s3c-sdhci",
		.index	= 2,
		.base	= S3C64XX_PA_HSMMC2,
		.irq	= IRQ_HSMMC1,
		.dma	= &samsung_std_dma_mask,
	}, {
		.type	= SAMSUNG_DEVICE_OHCI,
		.name	= "s3c2410-ohci",
		.index	= -1,
		.base	= S3C64XX_PA_USBHOST,
		.irq	= IRQ_USBH,
		.dma	= &samsung_std_dma_mask,
	}, {
		.type	= SAMSUNG_DEVICE_NAND,
		.name	= "s3c6400-nand",
		.index	= -1,
		.base	= 0x4E000000,
		.irq	= IRQ_NFC,
	}, {
		.type	= SAMSUNG_DEVICE_I2C,
		.name	= "s3c2440-i2c",
		.index	= 0,
		.base	= S3C64XX_PA_IIC0,
		.irq	= IRQ_IIC,
	}, {
...

This solution is imho really clean an easy to understand. It is also
easy to check which SoC has which peripherals defined and how.

I hope Ben will be able to finish it soon and all Samsung platforms can
be converted for it. Then creating a single kernel for more than one SoC
should be possible with only a few additional changes.

> PS: My feeling of commenting several of the samsung patches so far turns
> out to be quite frustrated, or I'm just too sensitive. NOTE neither am I
> NAKing Samsung patches, nor am I interested to be involved, I'm just givin
> my suggestions.

I'm sorry if I offended You. I just wanted to show that the solution has
been already found.

Best regards
--	
Marek Szyprowski
Samsung Poland R&D Center
