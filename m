From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 24 Jun 2010 07:52:16 +0200
Subject: Samsung SoCs: preparation for single kernel
In-Reply-To: <AANLkTimqQyHLm4KcxYwYC8slSoy9udi2gganKdsD_8Nw@mail.gmail.com>
References: <AANLkTinGwWzIAOe2tj6V2kCrMiPT7PHlYs1kFS-IsiN4@mail.gmail.com>
	<AANLkTil-AOEqhMOXydaiA1X_v0rjoNQxALrO0UY638AS@mail.gmail.com>
	<AANLkTil1i_ZGI8bY14HhjrAk9RooVreAJsTteqqrMgqJ@mail.gmail.com>
	<AANLkTikDml6gQAsiRrCjIt4bUD3hnpAATr1erqCGOJMd@mail.gmail.com>
	<002301cb129c$ec59fe30$c50dfa90$%szyprowski@samsung.com>
	<AANLkTikspf9zHuSKe86wDQxI12HpJo_occBlLUXBkjef@mail.gmail.com>
	<003e01cb12b5$656c0670$30441350$%szyprowski@samsung.com>
	<AANLkTimqQyHLm4KcxYwYC8slSoy9udi2gganKdsD_8Nw@mail.gmail.com>
Message-ID: <002d01cb1361$69372c10$3ba58430$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, June 24, 2010 4:08 AM Kyungmin Park wrote:

> On Wed, Jun 23, 2010 at 6:20 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > Hello,
> >
> > On Wednesday, June 23, 2010 10:02 AM Eric Miao wrote:
> >
> >> >> Now you have
> >> >>
> >> >> s5pv210_device_hsmmc0
> >> >> s5pc100_device_hsmmc0
> >> >> s3c64xx_device_hsmmc0
> >> >> ....
> >> >>
> >> >> each with a different base.
> >> >
> >> > There is no need for such code duplication.
> >>
> >> However, I believe this is the right way to go. A certain level of
> >> duplication is the price to pay for a generic and clean solution.
> >>
> >> When a peripheral controller or IP is moved from one SoC to the
> >> next generation, there are several things could have been changed:
> >>
> >> 1. new base address and IRQ number
> >> 2. fixes and enhancements to the original IP
> >>
> >> 1. will result in a different 'struct resource', and 2. will result in a
> >> different 'struct platform_device' with a different name, so the driver
> >> can match the platform_device_id table as you agreed I'm right on
> >> that recommendation.
> >>
> >> They are actually _two_ different devices.
> >
> > Right, they are separate entities, but would be really good if a similar
> > git brcode could be merged together.
> >
> >> > Ben is working on a solution for
> >> > a single kernel which supports multiple SoCs. Some of his work in
> >> progress can
> >> > be found here: git://git.fluff.org/bjdooks/linux branch wip-samsung-
> dev
> >> and
> >> > wip-samsung-dev2.
> >>
> >> Could you describe it a bit here and bring it on table for discussion?
> >
> > The idea behind his patches is to provide a table for each SoC with short
> > description of all available devices and generate platform_device entries
> > dynamically from that table.
> >
> > Here is a short code example:
> >
> > struct s3c_pdev_table s3c6xxx_dev_table[] __initdata = {
> > ? ? ? ?{
> > ? ? ? ? ? ? ? ?.type ? = SAMSUNG_DEVICE_UART,
> > ? ? ? ? ? ? ? ?.name ? = "s3c6400-uart",
> > ? ? ? ? ? ? ? ?.index ?= 0,
> > ? ? ? ? ? ? ? ?.base ? = S3C_PA_UART0,
> > ? ? ? ? ? ? ? ?.irq ? ?= IRQ_S3CUART_RX0,
> > ? ? ? ? ? ? ? ?.template = &template_uart_s3c64xx,
> > ? ? ? ?}, {
> > ? ? ? ? ? ? ? ?.type ? = SAMSUNG_DEVICE_UART,
> > ? ? ? ? ? ? ? ?.name ? = "s3c6400-uart",
> > ? ? ? ? ? ? ? ?.index ?= 1,
> > ? ? ? ? ? ? ? ?.base ? = S3C_PA_UART1,
> > ? ? ? ? ? ? ? ?.irq ? ?= IRQ_S3CUART_RX1,
> > ? ? ? ? ? ? ? ?.template = &template_uart_s3c64xx,
> > ? ? ? ?}, {
> > ? ? ? ? ? ? ? ?.type ? = SAMSUNG_DEVICE_UART,
> > ? ? ? ? ? ? ? ?.name ? = "s3c6400-uart",
> > ? ? ? ? ? ? ? ?.index ?= 2,
> > ? ? ? ? ? ? ? ?.base ? = S3C_PA_UART2,
> > ? ? ? ? ? ? ? ?.irq ? ?= IRQ_S3CUART_RX2,
> > ? ? ? ? ? ? ? ?.template = &template_uart_s3c64xx,
> > ? ? ? ?}, {
> > ? ? ? ? ? ? ? ?.type ? = SAMSUNG_DEVICE_UART,
> > ? ? ? ? ? ? ? ?.name ? = "s3c6400-uart",
> > ? ? ? ? ? ? ? ?.index ?= 3,
> > ? ? ? ? ? ? ? ?.base ? = S3C_PA_UART3,
> > ? ? ? ? ? ? ? ?.irq ? ?= IRQ_S3CUART_RX3,
> > ? ? ? ? ? ? ? ?.template = &template_uart_s3c64xx,
> > ? ? ? ?}, {
> > ? ? ? ? ? ? ? ?.type ? = SAMSUNG_DEVICE_WATCHDOG,
> > ? ? ? ? ? ? ? ?.name ? = "s3c2410-wdt",
> > ? ? ? ? ? ? ? ?.index ?= -1,
> > ? ? ? ? ? ? ? ?.base ? = S3C64XX_PA_WATCHDOG,
> > ? ? ? ? ? ? ? ?.irq ? ?= IRQ_WDT,
> > ? ? ? ?}, {
> > ? ? ? ? ? ? ? ?.type ? = SAMSUNG_DEVICE_SDHCI,
> > ? ? ? ? ? ? ? ?.name ? = "s3c-sdhci",
> > ? ? ? ? ? ? ? ?.index ?= 0,
> > ? ? ? ? ? ? ? ?.base ? = S3C64XX_PA_HSMMC0 ,
> > ? ? ? ? ? ? ? ?.irq ? ?= IRQ_HSMMC0,
> > ? ? ? ? ? ? ? ?.dma ? ?= &samsung_std_dma_mask,
> > ? ? ? ?}, {
> > ? ? ? ? ? ? ? ?.type ? = SAMSUNG_DEVICE_SDHCI,
> > ? ? ? ? ? ? ? ?.name ? = "s3c-sdhci",
> > ? ? ? ? ? ? ? ?.index ?= 1,
> > ? ? ? ? ? ? ? ?.base ? = S3C64XX_PA_HSMMC1,
> > ? ? ? ? ? ? ? ?.irq ? ?= IRQ_HSMMC1,
> > ? ? ? ? ? ? ? ?.dma ? ?= &samsung_std_dma_mask,
> > ? ? ? ?}, {
> > ? ? ? ? ? ? ? ?.type ? = SAMSUNG_DEVICE_SDHCI,
> > ? ? ? ? ? ? ? ?.name ? = "s3c-sdhci",
> > ? ? ? ? ? ? ? ?.index ?= 2,
> > ? ? ? ? ? ? ? ?.base ? = S3C64XX_PA_HSMMC2,
> > ? ? ? ? ? ? ? ?.irq ? ?= IRQ_HSMMC1,
> > ? ? ? ? ? ? ? ?.dma ? ?= &samsung_std_dma_mask,
> > ? ? ? ?}, {
> > ? ? ? ? ? ? ? ?.type ? = SAMSUNG_DEVICE_OHCI,
> > ? ? ? ? ? ? ? ?.name ? = "s3c2410-ohci",
> > ? ? ? ? ? ? ? ?.index ?= -1,
> > ? ? ? ? ? ? ? ?.base ? = S3C64XX_PA_USBHOST,
> > ? ? ? ? ? ? ? ?.irq ? ?= IRQ_USBH,
> > ? ? ? ? ? ? ? ?.dma ? ?= &samsung_std_dma_mask,
> > ? ? ? ?}, {
> > ? ? ? ? ? ? ? ?.type ? = SAMSUNG_DEVICE_NAND,
> > ? ? ? ? ? ? ? ?.name ? = "s3c6400-nand",
> > ? ? ? ? ? ? ? ?.index ?= -1,
> > ? ? ? ? ? ? ? ?.base ? = 0x4E000000,
> > ? ? ? ? ? ? ? ?.irq ? ?= IRQ_NFC,
> > ? ? ? ?}, {
> > ? ? ? ? ? ? ? ?.type ? = SAMSUNG_DEVICE_I2C,
> > ? ? ? ? ? ? ? ?.name ? = "s3c2440-i2c",
> > ? ? ? ? ? ? ? ?.index ?= 0,
> > ? ? ? ? ? ? ? ?.base ? = S3C64XX_PA_IIC0,
> > ? ? ? ? ? ? ? ?.irq ? ?= IRQ_IIC,
> > ? ? ? ?}, {
> > ...
> >
> > This solution is imho really clean an easy to understand. It is also
> > easy to check which SoC has which peripherals defined and how.
> 
> Question. recently it's changed to use MMC0, MMC2, MMC3, then how to define
> it?

There is index parameter that defines the instance of the device.

> More basically, where these info are defined for chip or board?

The above table is defined per SoC. Each board then registers the particular
devices like it is done in the current kernels. The following diff should
explain it better:

-static struct platform_device *smdk6400_devices[] __initdata = {
-	&s3c_device_hsmmc1,
-	&s3c_device_i2c0,
+static struct s3c_devtable  smdk6400_devtable[] __initdata = {
+	{ .type = SAMSUNG_DEVICE_SDHCI,	.index = 1, },
+	{ .type = SAMSUNG_DEVICE_I2C,	.index = 0, },

static void __init smdk6400_machine_init(void)
 {
 	i2c_register_board_info(0, i2c_devs, ARRAY_SIZE(i2c_devs));
-	platform_add_devices(smdk6400_devices, ARRAY_SIZE(smdk6400_devices));
+	samsung_add_devices(smdk6400_devtable, ARRAY_SIZE(smdk6400_devtable));
 }

> If chip, the how to handle several variants?

The same way it is handled in the current kernels. Machine init code can
even do some additional fixups if required.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
