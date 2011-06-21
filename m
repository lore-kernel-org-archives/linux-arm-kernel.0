From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Jun 2011 17:53:59 +0200
Subject: [PATCH] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <1308556402-10955-1-git-send-email-bs14@csr.com>
References: <1308556402-10955-1-git-send-email-bs14@csr.com>
Message-ID: <201106211753.59376.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 June 2011, Barry Song wrote:
> From: Binghua Duan <binghua.duan@csr.com>
> 
> SiRFprimaII is the latest generation application processor from CSR?s
> Multifunction SoC product family. Designed around an ARM cortex A9 core,
> high-speed memory bus, advanced 3D accelerator and full-HD multi-format
> video decoder, SiRFprimaII is able to meet the needs of complicated
> applications for modern multifunction devices that require heavy concurrent
> applications and fluid user experience. Integrated with GPS baseband,
> analog and PMU, this new platform is designed to provide a cost effective
> solution for Automotive and Consumer markets.
> 
> This patch adds the basic support for this SoC and EVB board based on device
> tree. It is following the ZYNQ of Grant Likely in some degree.

Hi Binghua and Barry,

Your platform looks pretty good already, it's good to see that you are
progressing so well with the conversion to device tree. 

> diff --git a/arch/arm/boot/dts/prima2-cb.dts b/arch/arm/boot/dts/prima2-cb.dts
> new file mode 100644
> index 0000000..6e8b17c
> --- /dev/null
> +++ b/arch/arm/boot/dts/prima2-cb.dts
> @@ -0,0 +1,44 @@
> +/dts-v1/;
> +/ {
> +        model = "SIRF Prima2 EVB";
> +        compatible = "sirf,prima2-cb", "sirf,prima2";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	interrupt-parent = <&intc>;
> +
> +        memory {
> +                reg = <0x00000000 0x20000000>;
> +        };
> +
> +	chosen {
> +		bootargs = "mem=512M real_root=/dev/mmcblk0p2 console=ttyS1 earlyprintk";
> +		linux,stdout-path = &uart1;
> +	};
> +
> +	amba {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		intc: interrupt-controller at 0x80020000 {
> +                         interrupt-controller;
> +                         compatible = "arm,sirfsoc";
> +                         reg = <0x80020000 0x1000>;
> +                         #interrupt-cells = <1>;
> +		};
> +
> +		uart0: uart at 0xb0050000 {
> +			       compatible = "sirf,uart";
> +			       reg = <0xb0050000 0x1000>;
> +			       interrupts = <17>;
> +		};
> +
> +		uart1: uart at 0xb0060000 {
> +			       compatible = "sirf,uart";
> +			       reg = <0xb0060000 0x1000>;
> +			       interrupts = <18>;
> +		};
> +	};
> +};

The "compatible" properties should really be more specific than this. You can
list multiple alternatives in there, but please always have one that identifies
the exact version of each of the macros uniquely.

Please also model the device hierarchy as close as possible to the high-level
block diagrams in the data sheet. I would e.g. expect this to have
multiple AMBA buses, one at 0x80000000 and one at 0xb0000000, so just define
them separately with a ranges property describing the location of the bus
in the address space, and put the child devices at relative addresses to that.

I would also recommend listing all devices in the device tree here, even if
the drivers are not yet ported.

Regarding the interrupt and timer drivers, there has been some discussion
about moving them to drivers/irq and drivers/clocksource, respectively.

> diff --git a/arch/arm/mach-prima2/clock.c b/arch/arm/mach-prima2/clock.c
> new file mode 100644
> index 0000000..a879fbf
> --- /dev/null
> +++ b/arch/arm/mach-prima2/clock.c

I can't really comment on the clock support. A lot has changed here recently,
so I hope someone else can comment.

> +#define IOTABLE_ENTRY(region) {\
> +	.virtual 	= SIRFSOC_##region##_VA_BASE, \
> +	.pfn	 	= __phys_to_pfn(SIRFSOC_##region##_PA_BASE),\
> +	.length		= SIRFSOC_##region##_SIZE, \
> +	.type 		= MT_DEVICE, \
> +}
> +
> +static struct map_desc sirfsoc_iodesc[] __initdata = {
> +        IOTABLE_ENTRY(INTR),
> +        IOTABLE_ENTRY(UART1),
> +        IOTABLE_ENTRY(TIMER),
> +        IOTABLE_ENTRY(CLOCK),
> +#ifdef CONFIG_CACHE_L2X0
> +	IOTABLE_ENTRY(L2CC),
> +#endif
> +};
> +
> +void __init sirfsoc_map_io(void)
> +{
> +	iotable_init(sirfsoc_iodesc, ARRAY_SIZE(sirfsoc_iodesc));
> +}
> +
> +#define L2X0_ADDR_FILTERING_START       0xC00
> +#define L2X0_ADDR_FILTERING_END         0xC04
> +
> +static int __init sirfsoc_init(void)
> +{
> +#ifdef CONFIG_CACHE_L2X0
> +	if (!(readl_relaxed(SIRFSOC_L2CC_VA_BASE + L2X0_CTRL) & 1)) {
> +		/*
> +		 * set the physical memory windows L2 cache will cover
> +		 */
> +		writel_relaxed(PHYS_OFFSET + 1024 * 1024 * 1024,
> +			SIRFSOC_L2CC_VA_BASE + L2X0_ADDR_FILTERING_END);
> +		writel_relaxed(PHYS_OFFSET | 0x1,
> +			SIRFSOC_L2CC_VA_BASE + L2X0_ADDR_FILTERING_START);
> +
> +		writel_relaxed(0,
> +			SIRFSOC_L2CC_VA_BASE + L2X0_TAG_LATENCY_CTRL);
> +		writel_relaxed(0,
> +			SIRFSOC_L2CC_VA_BASE + L2X0_DATA_LATENCY_CTRL);
> +	}
> +	l2x0_init((void __iomem *)SIRFSOC_L2CC_VA_BASE, 0x00040000,
> +		0x00000000);
> +#endif
> +
> +	return 0;
> +}
> +arch_initcall(sirfsoc_init);


> +#ifndef __MACH_PRIMA2_IO_H
> +#define __MACH_PRIMA2_IO_H
> +
> +#define IO_SPACE_LIMIT 0xffffffff
> +
> +#define __mem_pci(x)   (x)
> +#define __io(a)        ((void __iomem *)(a))
> +
> +#endif

This is broken for PCI I/O space windows. The same issue keeps coming
up with every new platform, and I wish we could simply not have to
define these.

Do you have any PCI or PCMCIA devices?

> diff --git a/arch/arm/mach-prima2/include/mach/isa-dma.h b/arch/arm/mach-prima2/include/mach/isa-dma.h
> +
> +#ifndef __MACH_PRIMA2_ISADMA_H
> +#define __MACH_PRIMA2_ISADMA_H
> +
> +#define MAX_DMA_CHANNELS 32
> +
> +#endif

Would it make sense to convert the DMA support on your platform to the
more modern dmaengine API? The old ISA DMA API is showing its age, and
will cause trouble when you want to support different DMA controllers
in a single kernel.

> diff --git a/arch/arm/mach-prima2/include/mach/map.h b/arch/arm/mach-prima2/include/mach/map.h
> new file mode 100644
> index 0000000..9a3ad94
> --- /dev/null
> +++ b/arch/arm/mach-prima2/include/mach/map.h
> +
> +#define SIRFSOC_VA(x)			(VMALLOC_END + ((x) & 0x00FFF000))
> +
> +/* INTR */
> +#define SIRFSOC_INTR_PA_BASE		0x80020000
> +#define SIRFSOC_INTR_VA_BASE		SIRFSOC_VA(0x002000)
> +#define SIRFSOC_INTR_SIZE		SZ_4K
> +
> +/* L2 CACHE */
> +#define SIRFSOC_L2CC_PA_BASE		0x80040000
> +#define SIRFSOC_L2CC_VA_BASE		SIRFSOC_VA(0x004000)
> +#define SIRFSOC_L2CC_SIZE		SZ_4K
> +
> +/* CLOCK */
> +#define SIRFSOC_CLOCK_PA_BASE		0x88000000
> +#define SIRFSOC_CLOCK_VA_BASE		SIRFSOC_VA(0x005000)
> +#define SIRFSOC_CLOCK_SIZE		SZ_4K
> +
> +/* RESET CONTROLLER */
> +#define SIRFSOC_RSTC_PA_BASE		0x88010000
> +#define SIRFSOC_RSTC_VA_BASE		SIRFSOC_VA(0x006000)
> +#define SIRFSOC_RSTC_SIZE		SZ_4K
> +
> +/* OS TIMER */
> +#define SIRFSOC_TIMER_PA_BASE		0xb0020000
> +#define SIRFSOC_TIMER_VA_BASE		SIRFSOC_VA(0x00c000)
> +#define SIRFSOC_TIMER_SIZE		SZ_4K
> +
> +/* UART-1: used as serial debug port */
> +#define SIRFSOC_UART1_PA_BASE		0xb0060000
> +#define SIRFSOC_UART1_VA_BASE		SIRFSOC_VA(0x060000)
> +#define SIRFSOC_UART1_SIZE		SZ_4K
> +
> +/* RAM BASE*/
> +#define SIRFSOC_SDRAM_PA		0x00000000
> +
> +#endif

I think these should all be converted into device tree properties if
possible. Anything that can be initialized late enough should just
do an ioremap at the time when you first need to access the registers.

For the L2 cache, Rob already posted a binding, so best work with him
on that one.

> +/*
> + * Restrict DMA-able region to workaround silicon limitation.
> + * The limitation restricts buffers available for DMA to SD/MMC
> + * hardware to be below 256MB
> + */
> +#define ARM_DMA_ZONE_SIZE	(SZ_256M)
> +

This is very unfortunate, but I guess there is no real way to avoid
doing this, right?

> +static void sirfsoc_irq_mask(struct irq_data *d)
> +{
> +	unsigned long mask;
> +
> +	mask = __raw_readl(SIRFSOC_INTR_VA_BASE + SIRFSOC_INT_RISC_MASK0 + (d->irq / 32) * 4) &
> +		~(1 << ( d->irq % 32));
> +	__raw_writel(mask, SIRFSOC_INTR_VA_BASE + SIRFSOC_INT_RISC_MASK0 + (d->irq / 32) * 4);
> +}

Better use readl_relaxed here than __raw_readl.


> +/* timer0 interrupt handler */
> +static irqreturn_t sirfsoc_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *ce = dev_id;
> +
> +	WARN_ON(!(__raw_readl(SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_STATUS) & BIT(0)));
> +
> +	/* clear timer0 interrupt */
> +	__raw_writel(BIT(0), SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_STATUS);

Here, too.

	Arnd
