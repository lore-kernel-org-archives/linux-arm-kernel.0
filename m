From: kong.kongxinwei@hisilicon.com (Xinwei Kong)
Date: Fri, 30 Dec 2016 16:59:19 +0800
Subject: [PATCH v5 14/14] irqchip: mbigen: Add ACPI support
In-Reply-To: <1482384922-21507-15-git-send-email-guohanjun@huawei.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-15-git-send-email-guohanjun@huawei.com>
Message-ID: <586621E7.7020609@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/12/22 13:35, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> With the preparation of platform msi support and interrupt producer
> in DSDT, we can add mbigen ACPI support now.
>
> We are using _PRS methd to indicate number of irq pins instead
> of num_pins in DT to avoid _DSD usage in this case.
>
> For mbi-gen,
>      Device(MBI0) {
>            Name(_HID, "HISI0152")
>            Name(_UID, Zero)
>            Name(_CRS, ResourceTemplate() {
>                    Memory32Fixed(ReadWrite, 0xa0080000, 0x10000)
>            })
>
>            Name (_PRS, ResourceTemplate() {
> 		  Interrupt(ResourceProducer,...) {12,14,....}
>            })
>      }
>
> For devices,
>
>     Device(COM0) {
>            Name(_HID, "ACPIIDxx")
>            Name(_UID, Zero)
>            Name(_CRS, ResourceTemplate() {
>                   Memory32Fixed(ReadWrite, 0xb0030000, 0x10000)
> 		 Interrupt(ResourceConsumer,..., "\_SB.MBI0") {12}
>            })
>      }
>
> With the helpe of platform msi and interrupt producer, then devices
> will get the virq from mbi-gen's irqdomain.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ma Jun <majun258@huawei.com>
> ---
>   drivers/irqchip/irq-mbigen.c | 70 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 67 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index 4e11da5..17d35fa 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -16,6 +16,7 @@
>    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> +#include <linux/acpi.h>
>   #include <linux/interrupt.h>
>   #include <linux/irqchip.h>
>   #include <linux/module.h>
> @@ -180,7 +181,7 @@ static int mbigen_domain_translate(struct irq_domain *d,
>   				    unsigned long *hwirq,
>   				    unsigned int *type)
>   {
> -	if (is_of_node(fwspec->fwnode)) {
> +	if (is_of_node(fwspec->fwnode) || is_acpi_device_node(fwspec->fwnode)) {
>   		if (fwspec->param_count != 2)
>   			return -EINVAL;
>   
> @@ -271,6 +272,54 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
>   	return 0;
>   }
>   
> +#ifdef CONFIG_ACPI
> +static acpi_status mbigen_acpi_process_resource(struct acpi_resource *ares,
> +					     void *context)
> +{
> +	struct acpi_resource_extended_irq *ext_irq;
> +	u32 *num_irqs = context;
> +
> +	switch (ares->type) {
> +	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
> +		ext_irq = &ares->data.extended_irq;
> +		*num_irqs += ext_irq->interrupt_count;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return AE_OK;
> +}
> +
> +static int mbigen_acpi_create_domain(struct platform_device *pdev,
> +				     struct mbigen_device *mgn_chip)
> +{
> +	struct irq_domain *domain;
> +	u32 num_msis = 0;
> +	acpi_status status;
> +
> +	status = acpi_walk_resources(ACPI_HANDLE(&pdev->dev), METHOD_NAME__PRS,
> +				     mbigen_acpi_process_resource, &num_msis);
> +        if (ACPI_FAILURE(status) || num_msis == 0)
> +		return -EINVAL;
> +
> +	domain = platform_msi_create_device_domain(&pdev->dev, num_msis,
> +						   mbigen_write_msg,
> +						   &mbigen_domain_ops,
> +						   mgn_chip);
> +	if (!domain)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +#else
> +static int mbigen_acpi_create_domain(struct platform_device *pdev,
> +				     struct mbigen_device *mgn_chip)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>   static int mbigen_device_probe(struct platform_device *pdev)
>   {
>   	struct mbigen_device *mgn_chip;
> @@ -288,9 +337,17 @@ static int mbigen_device_probe(struct platform_device *pdev)
>   	if (IS_ERR(mgn_chip->base))
>   		return PTR_ERR(mgn_chip->base);
>   
> -	err = mbigen_of_create_domain(pdev, mgn_chip);
> -	if (err)
> +	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
> +		err = mbigen_of_create_domain(pdev, mgn_chip);
> +	else if (ACPI_COMPANION(&pdev->dev))
> +		err = mbigen_acpi_create_domain(pdev, mgn_chip);
> +	else
> +		err = -EINVAL;
> +
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to create mbi-gen@%p irqdomain", mgn_chip->base);
>   		return err;
> +	}
>   
>   	platform_set_drvdata(pdev, mgn_chip);
>   	return 0;
> @@ -302,10 +359,17 @@ static int mbigen_device_probe(struct platform_device *pdev)
>   };
>   MODULE_DEVICE_TABLE(of, mbigen_of_match);
>   
> +static const struct acpi_device_id mbigen_acpi_match[] = {
> +        { "HISI0152", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
> +
>   static struct platform_driver mbigen_platform_driver = {
>   	.driver = {
>   		.name		= "Hisilicon MBIGEN-V2",
>   		.of_match_table	= mbigen_of_match,
> +		.acpi_match_table = ACPI_PTR(mbigen_acpi_match),
>   	},
>   	.probe			= mbigen_device_probe,
>   };
Tested-by:  Xinwei Kong <kong.kongxinwei@hisilicon.com>
