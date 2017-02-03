From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 03 Feb 2017 10:27:59 +0800
Subject: [PATCH v8 15/15] irqchip: mbigen: Add ACPI support
In-Reply-To: <1484744105-53140-16-git-send-email-guohanjun@huawei.com>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
 <1484744105-53140-16-git-send-email-guohanjun@huawei.com>
Message-ID: <5893EAAF.6000204@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2017 08:55 PM, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> With the preparation of platform msi support and interrupt producer
> in DSDT, we can add mbigen ACPI support now.
>
> We are using Interrupt resource type in _CRS methd to indicate number
> of irq pins instead of num_pins in DT to avoid _DSD usage in this case.
>
> For mbigen,
>      Device(MBI0) {
>            Name(_HID, "HISI0152")
>            Name(_UID, Zero)
>            Name(_CRS, ResourceTemplate() {
>                    Memory32Fixed(ReadWrite, 0xa0080000, 0x10000)
> 		  Interrupt(ResourceProducer,...) {12,14,....}
>            })
>      }
>
> For devices,
>     Device(COM0) {
>            Name(_HID, "ACPIIDxx")
>            Name(_UID, Zero)
>            Name(_CRS, ResourceTemplate() {
>                   Memory32Fixed(ReadWrite, 0xb0030000, 0x10000)
> 		 Interrupt(ResourceConsumer,..., "\_SB.MBI0") {12}
>            })
>      }
>
> With the help of platform msi and interrupt producer, then devices
> will get the virq from mbigen's irqdomain.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Ma Jun <majun258@huawei.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/irqchip/irq-mbigen.c | 70 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 67 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index 4e11da5..64f8561 100644
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
> +	status = acpi_walk_resources(ACPI_HANDLE(&pdev->dev), METHOD_NAME__CRS,
> +				     mbigen_acpi_process_resource, &num_msis);
> +        if (ACPI_FAILURE(status) || num_msis == 0)

There are some trailing white spaces in this patch, I will send a
updated one if no more comments.

Thanks
Hanjun
