From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 21 Jul 2013 10:09:31 +0200
Subject: [PATCH 1/5] ARM: bcm4760: Add platform infrastructure
In-Reply-To: <20130721002713.512199844@gmail.com>
References: <20130721002320.730568671@gmail.com>
 <20130721002713.512199844@gmail.com>
Message-ID: <201307211009.31789.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 21 July 2013, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> Platform infrastructure for the Broadcom BCM4760 based ARM11 SoCs.
> 
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>

Looks very nice overall, thanks for following up on this!

> +#define BCM4760_PERIPH_PHYS   0x00080000
> +#define BCM4760_PERIPH_VIRT   IOMEM(0xd0080000)
> +#define BCM4760_PERIPH_SIZE   SZ_512K
> +
> +static struct map_desc io_map __initdata = {
> +	.virtual = (unsigned long) BCM4760_PERIPH_VIRT,
> +	.pfn = __phys_to_pfn(BCM4760_PERIPH_PHYS),
> +	.length = BCM4760_PERIPH_SIZE,
> +	.type = MT_DEVICE,
> +};
> +
> +static void __init bcm4760_map_io(void)
> +{
> +	iotable_init(&io_map, 1);
> +}

I would hope expect a comment here explaining what those registers are and why
they are mapped early.

> +
> +#define BCM4760_CPUID0 IOMEM(0xd00b0ff0)
> +#define BCM4760_CPUID1 IOMEM(0xd00b0ff4)

Better make these

#define BCM4760_CPUID0 (BCM4760_PERIPH_VIRT + 0x30ff0)
#define BCM4760_CPUID1 (BCM4760_PERIPH_VIRT + 0x30ff4)

for clarity.

> +static void __init bcm4760_system_rev(void)
> +{
> +	u32 id0, id1;
> +
> +	id0 = readl_relaxed(BCM4760_CPUID0);
> +	id1 = readl_relaxed(BCM4760_CPUID1);
> +
> +	if (id0 >> 16 != 0xbcbc)
> +		system_rev = 0xbc4760a0;
> +	else
> +		system_rev = id0 << 8 | (id1 & 0xff);
> +}

Or even better, change this function to do:

	struct device_node *node = of_find_compatible_node(NULL, NULL, "brcm,whatever");
	void __iomem *regs = of_iomap(node, 0);
	u32 id0, id1;

	id0 = readl_relaxed(regs + BCM4760_CPUID0);
	id1 = readl_relaxed(regs + BCM4760_CPUID1);

	...

	iounmap(regs);
	of_node_put(node);


bonus points if you use soc_device_register();

What is the system_rev variable actually used for?

> +		uart0 at c0000 {
> +			compatible = "brcm,bcm4760-pl011", "arm,pl011", "arm,primecell";
> +			reg = <0xc0000 0x1000>;
> +			interrupt-parent = <&vic0>;
> +			interrupts = <14>;
> +		};
> +
> +		uart1 at c1000 {
> +			compatible = "brcm,bcm4760-pl011", "arm,pl011", "arm,primecell";
> +			reg = <0xc1000 0x1000>;
> +			interrupt-parent = <&vic0>;
> +			interrupts = <15>;
> +		};
> +
> +		uart2 at b2000 {
> +			compatible = "brcm,bcm4760-pl011", "arm,pl011", "arm,primecell";
> +			reg = <0xb2000 0x1000>;
> +			interrupt-parent = <&vic0>;
> +			interrupts = <16>;
> +		};
> +	};

Please change the names here to say "serial" rather than "uartX". The name should not
have an index in it (that's what the @address part is for) and there are conventions
for common devices.

If some of the serial ports are not connected on all boars, best mark them as
status="disabled"; here and only enable them in the board specific file.

> +config ARCH_BCM4760
> +	bool "Broadcom BCM4760 based SoCs (ARM11)" if ARCH_MULTI_V6
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> +	select ARM_AMBA
> +	select ARM_VIC
> +	select CLKDEV_LOOKUP
> +	select CLKSRC_OF
> +	select COMMON_CLK
> +	select CPU_V6
> +	select GENERIC_CLOCKEVENTS
> +	select GENERIC_IRQ_CHIP
> +	select MULTI_IRQ_HANDLER
> +	select NO_IOPORT
> +	select PINCTRL
> +	select PINMUX
> +	select SPARSE_IRQ
> +	select USE_OF

A lot of these are implied by ARCH_MULTIPLATFORM or ARCH_MULTI_V6 and can be removed
here. I don't think you should select 'PINCTRL and PINMUX' here, as long as the code
builds without them.

	Arnd
