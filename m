From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 May 2017 14:55:57 +0100
Subject: [PATCH 3/6] irqchip: irq-mvebu-gicp: new driver for Marvell GICP
In-Reply-To: <1496135772-20694-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <2ea42715-700b-c363-eeba-db83b0f63a70@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/17 10:16, Thomas Petazzoni wrote:
> This commit adds a simple driver for the Marvell GICP, a hardware unit
> that converts memory writes into GIC SPI interrupts. The driver doesn't
> do anything but clear all interrupts at boot time, to avoid spurious
> interrupts left by the firmware.
> 
> The GICP registers are directly written to in hardware by the ICU unit,
> which is configured in a separate driver.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/irqchip/Kconfig          |  3 +++
>  drivers/irqchip/Makefile         |  1 +
>  drivers/irqchip/irq-mvebu-gicp.c | 53 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+)
>  create mode 100644 drivers/irqchip/irq-mvebu-gicp.c
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 478f8ac..e527ee5 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -268,6 +268,9 @@ config IRQ_MXS
>  	select IRQ_DOMAIN
>  	select STMP_DEVICE
>  
> +config MVEBU_GICP
> +	bool
> +
>  config MVEBU_ODMI
>  	bool
>  	select GENERIC_MSI_IRQ_DOMAIN
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index b64c59b..11eb858 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
>  obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingenic.o
>  obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
>  obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
> +obj-$(CONFIG_MVEBU_GICP)		+= irq-mvebu-gicp.o
>  obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
>  obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
>  obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
> diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
> new file mode 100644
> index 0000000..4effed4
> --- /dev/null
> +++ b/drivers/irqchip/irq-mvebu-gicp.c
> @@ -0,0 +1,53 @@
> +/*
> + * Copyright (C) 2017 Marvell
> + *
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +
> +#define GICP_SETSPI_NSR_OFFSET	0x0
> +#define GICP_CLRSPI_NSR_OFFSET	0x8
> +
> +#define GICP_INT_COUNT		128
> +
> +static int mvebu_gicp_probe(struct platform_device *pdev)
> +{
> +	void __iomem *regs;
> +	struct resource *res;
> +	int i;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	regs = ioremap(res->start, resource_size(res));
> +	if (!regs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < GICP_INT_COUNT; i++)
> +		writel(i, regs + GICP_CLRSPI_NSR_OFFSET);

What does this do on an edge interrupt? I bet this doesn't have any
effect, so you may want to use the irq_set_irqchip_state() API to clear
a potential pending state instead (and you may want to wire it in the
ICU driver itself as well).

> +
> +	iounmap(regs);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mvebu_gicp_of_match[] = {
> +	{ .compatible = "marvell,gicp", },
> +	{},
> +};
> +
> +static struct platform_driver mvebu_gicp_driver = {
> +	.probe  = mvebu_gicp_probe,
> +	.driver = {
> +		.name = "mvebu-gicp",
> +		.of_match_table = mvebu_gicp_of_match,
> +	},
> +};
> +builtin_platform_driver(mvebu_gicp_driver);
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
