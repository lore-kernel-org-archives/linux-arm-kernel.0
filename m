From: bp@alien8.de (Borislav Petkov)
Date: Thu, 22 Oct 2015 11:57:16 +0200
Subject: [PATCH RFC v2] apei: Add ACPI APEI event notification support
In-Reply-To: <1445458480-6493-1-git-send-email-lho@apm.com>
References: <1445458480-6493-1-git-send-email-lho@apm.com>
Message-ID: <20151022095716.GC3671@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm top-posting here because I'm adding some more ARM people to CC and
would like for them to see the whole thing.

Ok, so what's the strategy here?

I know Tomasz did some untangling of GHES stuff to make it load on ARM
too and be arch-agnostic. The registration code in it is more than the
tiny edac_apei_irq_handler().

So why is this thing a separate driver? It is called EDAC_APEI although
it is ARM-specific.

Why can't it be part of ghes_edac.c with ARM-specific section, if
absolutely needed?

If this is going to implement the ACPI spec, then I don't see anything
vendor-, or arch-specific getting in the way except maybe that APMC0D51
id.

Hmmm?

On Wed, Oct 21, 2015 at 02:14:40PM -0600, Loc Ho wrote:
> Add ACPI APEI event notification support for ARMv8 SoC under the
> following conditions:
> 
> 1. Without EL3 support and no GPIO PIN available
> 2. With EL3 support but no mean to notify the OS
> 
> v2
> * Make all code more generic naming
> * Still waiting for comment from Linaro folks on APEI
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  drivers/edac/Kconfig     |    7 +++
>  drivers/edac/Makefile    |    2 +
>  drivers/edac/edac_apei.c |  114 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 123 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/edac/edac_apei.c
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index ef25000..62c2bb2 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -95,6 +95,13 @@ config EDAC_GHES
> 
>  	  In doubt, say 'Y'.
> 
> +config EDAC_APEI
> +	tristate "ACPI APEI errors notification"
> +	depends on ACPI_APEI && (ARM64 || COMPILE_TEST)
> +	help
> +	  APEI interface support for error notification via interrupt based
> +	  for ARMv8 64-bit SOCs.
> +
>  config EDAC_AMD64
>  	tristate "AMD64 (Opteron, Athlon64)"
>  	depends on EDAC_MM_EDAC && AMD_NB && EDAC_DECODE_MCE
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index dbf53e0..9f91ff3 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -19,6 +19,7 @@ edac_core-y	+= edac_pci.o edac_pci_sysfs.o
>  endif
> 
>  obj-$(CONFIG_EDAC_GHES)			+= ghes_edac.o
> +obj-$(CONFIG_EDAC_APEI)			+= edac_apei.o
> 
>  edac_mce_amd-y				:= mce_amd.o
>  obj-$(CONFIG_EDAC_DECODE_MCE)		+= edac_mce_amd.o
> @@ -70,3 +71,4 @@ obj-$(CONFIG_EDAC_OCTEON_PCI)		+= octeon_edac-pci.o
>  obj-$(CONFIG_EDAC_ALTERA_MC)		+= altera_edac.o
>  obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
>  obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
> +
> diff --git a/drivers/edac/edac_apei.c b/drivers/edac/edac_apei.c
> new file mode 100644
> index 0000000..fd066f0
> --- /dev/null
> +++ b/drivers/edac/edac_apei.c
> @@ -0,0 +1,114 @@
> +/*
> + * APEI notification support for ARM 64-bit Soc's
> + *
> + * Copyright (c) 2015, Applied Micro Circuits Corporation
> + * Author: Tuan Phan <tphan@apm.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + * This driver provides APEI error notification via interrupt with the UEFI
> + * FW for SoC processors under the following conditions:
> + *
> + * 1. No interrupt GPIO available or don't want to use one and no EL3 support
> + * 2. With EL3 support but no mean to interrupt the Linux OS that an event
> + *    has occurred.
> + *
> + */
> +#include <linux/acpi.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +struct edac_apei_dev {
> +	void  __iomem	*csr_base;
> +	struct device	*dev;
> +	u32		irq;
> +	acpi_handle	evt_handle;
> +};
> +
> +static const struct acpi_device_id edac_apei_match[] = {
> +	{ "APMC0D51", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, edac_apei_match);
> +
> +static irqreturn_t edac_apei_irq_handler(int irq, void *data)
> +{
> +	struct edac_apei_dev *ctx = (struct edac_apei_dev *) data;
> +
> +	/* Clear the interrupt */
> +	writel(readl(ctx->csr_base), ctx->csr_base);
> +
> +	/* Send error event */
> +	acpi_execute_simple_method(ctx->evt_handle, NULL, 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int edac_apei_probe(struct platform_device *pdev)
> +{
> +	struct edac_apei_dev *ctx;
> +	struct resource *res;
> +	acpi_handle evt_handle;
> +	int rc;
> +
> +	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, ctx);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ctx->csr_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(ctx->csr_base)) {
> +		dev_err(&pdev->dev, "No CSR resource\n");
> +		return PTR_ERR(ctx->csr_base);
> +	}
> +
> +	ctx->irq = platform_get_irq(pdev, 0);
> +	if (ctx->irq < 0) {
> +		dev_err(&pdev->dev, "No IRQ resource\n");
> +		return ctx->irq;
> +	}
> +
> +	rc = devm_request_irq(&pdev->dev, ctx->irq, edac_apei_irq_handler, 0,
> +			      dev_name(&pdev->dev), ctx);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Could not request IRQ %d\n", ctx->irq);
> +		return rc;
> +	}
> +
> +	if (!ACPI_SUCCESS(acpi_get_handle(ACPI_HANDLE(ctx->dev), "_EVT",
> +					  &evt_handle)))
> +		return AE_BAD_PARAMETER;
> +
> +	ctx->evt_handle = evt_handle;
> +
> +	return rc;
> +}
> +
> +static struct platform_driver edac_apei_driver = {
> +	.probe = edac_apei_probe,
> +	.driver = {
> +		.name = "edac-apei",
> +		.acpi_match_table = ACPI_PTR(edac_apei_match),
> +	},
> +};
> +module_platform_driver(edac_apei_driver);
> +
> +MODULE_DESCRIPTION("EDAC APEI driver");
> +MODULE_AUTHOR("Tuan Phan <tphan@apm.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("0.1");
> --
> 1.7.1
> 
> 

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
