From: grant.likely@linaro.org (Grant Likely)
Date: Thu, 11 Sep 2014 12:08:46 +0100
Subject: [PATCH v3 11/17] ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and
 register device's gsi
In-Reply-To: <1409583475-6978-12-git-send-email-hanjun.guo@linaro.org>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-12-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140911110846.D152DC408F0@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  1 Sep 2014 22:57:49 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> Introduce ACPI_IRQ_MODEL_GIC which is needed for ARM64 as GIC is
> used, and then register device's gsi with the core IRQ subsystem.
> 
> acpi_register_gsi() is similar to DT based irq_of_parse_and_map(),
> since gsi is unique in the system, so use hwirq number directly
> for the mapping.
> 
> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/kernel/acpi.c |   73 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/bus.c       |    3 ++
>  include/linux/acpi.h     |    1 +
>  3 files changed, 77 insertions(+)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 35dff11..354b912 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -37,6 +37,12 @@ EXPORT_SYMBOL(acpi_pci_disabled);
>  static int enabled_cpus;	/* Processors (GICC) with enabled flag in MADT */
>  
>  /*
> + * Since we're on ARM, the default interrupt routing model
> + * clearly has to be GIC.
> + */
> +enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_GIC;
> +
> +/*
>   * __acpi_map_table() will be called before page_init(), so early_ioremap()
>   * or early_memremap() should be called here to for ACPI table mapping.
>   */
> @@ -194,6 +200,73 @@ void __init acpi_smp_init_cpus(void)
>  	pr_info("%d CPUs enabled, %d CPUs total\n", enabled_cpus, total_cpus);
>  }
>  
> +int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
> +{
> +	*irq = irq_find_mapping(NULL, gsi);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);

Why is this exported? x86 exports it, but ia64 does not. There aren't
very many callers, and none of them can be built as a module AFAICS.

> +
> +/*
> + * success: return IRQ number (>0)
> + * failure: return =< 0
> + */
> +int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
> +{
> +	unsigned int irq;
> +	unsigned int irq_type;
> +
> +	/*
> +	 * ACPI have no bindings to indicate SPI or PPI, so we
> +	 * use different mappings from DT in ACPI.
> +	 *
> +	 * For FDT
> +	 * PPI interrupt: in the range [0, 15];
> +	 * SPI interrupt: in the range [0, 987];
> +	 *
> +	 * For ACPI, GSI should be unique so using
> +	 * the hwirq directly for the mapping:
> +	 * PPI interrupt: in the range [16, 31];
> +	 * SPI interrupt: in the range [32, 1019];
> +	 */

Hmmm, so doing it this way means that DT systems will have a different
irq_domain setup compared with ACPI systems. I'm not convinced we want
to do that, but I need to look at the code that sets up the new domains
before I comment further...

g.
