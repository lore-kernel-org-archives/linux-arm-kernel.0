From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Dec 2013 01:40:10 +0100
Subject: [PATCH 02/11] arm: pxa27x: support ICP DAS LP-8x4x
In-Reply-To: <1385879185-22455-3-git-send-email-ynvich@gmail.com>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <1385879185-22455-3-git-send-email-ynvich@gmail.com>
Message-ID: <201312060140.10376.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 01 December 2013, Sergei Ianovich wrote:
> 
> diff --git a/arch/arm/configs/lp8x4x_defconfig b/arch/arm/configs/lp8x4x_defconfig
> new file mode 100644
> index 0000000..5cd6d38
> --- /dev/null
> +++ b/arch/arm/configs/lp8x4x_defconfig
> @@ -0,0 +1,2320 @@
> +#
> +# Automatically generated file; DO NOT EDIT.
> +# Linux/arm 3.13.0-rc1 Kernel Configuration
> +#

Please use 'make savedefconfig' to generate a smaller version of this file.

Ideally we want shared defconfigs where you enable multiple (or all) pxa boards
at once and end up with a kernel that works on all of them.

For most other platforms the goal is even to have a shared defconfig across
SoC families, but PXA is one of the exceptions that I would make because
it is both old and rather different from even the ARM9 or Marvell Feroceon
based SoCs.

> +#define LP8X4X_FPGA_PHYS	0x17000000
> +#define LP8X4X_FPGA_VIRT	0xf1000000
> +#define LP8X4X_P2V(x)		IOMEM((x) - LP8X4X_FPGA_PHYS + LP8X4X_FPGA_VIRT)
> +#define LP8X4X_V2P(x)		((x) - LP8X4X_FPGA_VIRT + LP8X4X_FPGA_PHYS)

I would recommend defining LP8X4X_FPGA_VIRT as "(void *)0xf1000000". Ideally
we try to avoid hardwired virtual addresses entirely and instead use platform
device resources, but I realize that there are limits to how far you get with
that. Please make an effort to convert as many parts of the FPGA into platform
devices with regular resources, but know that we would not enforce this as
strictly as we do for new platforms.

> +
> +static struct irq_chip lp8x4x_irq_chip = {
> +	.name			= "FPGA",
> +	.irq_ack		= lp8x4x_ack_irq,
> +	.irq_mask		= lp8x4x_mask_irq,
> +	.irq_unmask		= lp8x4x_unmask_irq,
> +};

Please try to move the irqchip code to drivers/irqchip/.

> +static struct platform_device lp8x4x_flash_device[] = {

static platform_device definitions are no longer the way to do this. For
modern platforms, you'd use a device tree, but here I think it is acceptable
(because of the PXA exception) to use a hardcoded board file.

The correct way to create the devices is using platform_device_register_data()
or a related function that returns a dynamically allocated platform device.

	Arnd
