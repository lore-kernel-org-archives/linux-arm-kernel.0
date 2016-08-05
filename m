From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Fri, 5 Aug 2016 19:00:13 -0400
Subject: [PATCH 2/4] irqchip: irq-mvebu-pic: new driver for Marvell Armada
 7K/8K PIC
In-Reply-To: <1470408921-447-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1470408921-447-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1470408921-447-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CAP=VYLqoubxSMcJJLSqfGUPVfyggMYwpS1aVRmWri+AQvgHt5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 5, 2016 at 10:55 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> The Marvell Armada 7K/8K integrates a secondary interrupt controller
> very originally named "PIC". It is connected to the main GIC via a
> PPI. Amongst other things, this PIC is used for the ARM PMU.
>
> This commit adds a simple irqchip driver for this interrupt
> controller. Since this interrupt controller is not needed early at boot
> time, we make the driver a proper platform driver rather than use the
> IRQCHIP_DECLARE() mechanism.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/irqchip/Kconfig         |   3 +
>  drivers/irqchip/Makefile        |   1 +
>  drivers/irqchip/irq-mvebu-pic.c | 195 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 199 insertions(+)
>  create mode 100644 drivers/irqchip/irq-mvebu-pic.c
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index fa33c50..a6f90c5 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -246,6 +246,9 @@ config MVEBU_ODMI
>         bool
>         select GENERIC_MSI_IRQ_DOMAIN
>
> +config MVEBU_PIC
> +       bool

Please switch to a builtin registration call, and remove module.h and
all the MODULE_<xyz> references since this is a bool and not a
tristate Kconfig.

Thanks,
Paul.
--

> +
>  config LS_SCFG_MSI
>         def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
>         depends on PCI && PCI_MSI
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 38853a1..024a78d 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -67,5 +67,6 @@ obj-$(CONFIG_INGENIC_IRQ)             += irq-ingenic.o
>  obj-$(CONFIG_IMX_GPCV2)                        += irq-imx-gpcv2.o
>  obj-$(CONFIG_PIC32_EVIC)               += irq-pic32-evic.o
>  obj-$(CONFIG_MVEBU_ODMI)               += irq-mvebu-odmi.o
> +obj-$(CONFIG_MVEBU_PIC)                        += irq-mvebu-pic.o
>  obj-$(CONFIG_LS_SCFG_MSI)              += irq-ls-scfg-msi.o
>  obj-$(CONFIG_EZNPS_GIC)                        += irq-eznps.o
> diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
> new file mode 100644
> index 0000000..4a3aa7f
> --- /dev/null
> +++ b/drivers/irqchip/irq-mvebu-pic.c
> @@ -0,0 +1,195 @@
> +/*
> + * Copyright (C) 2016 Marvell
> + *
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>

[...]

> +static const struct of_device_id mvebu_pic_of_match[] = {
> +       { .compatible = "marvell,armada-8k-pic", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, mvebu_pic_of_match);
> +
> +static struct platform_driver mvebu_pic_driver = {
> +       .probe  = mvebu_pic_probe,
> +       .remove = mvebu_pic_remove,
> +       .driver = {
> +               .name = "mvebu-pic",
> +               .of_match_table = mvebu_pic_of_match,
> +       },
> +};
> +module_platform_driver(mvebu_pic_driver);
> +
> +MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:mvebu_pic");
> +
> --
> 2.7.4
>
