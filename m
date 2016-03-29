From: julien.grall@arm.com (Julien Grall)
Date: Tue, 29 Mar 2016 17:35:57 +0100
Subject: [PATCH v7 10/17] arm/xen: Get event-channel irq through HVM_PARAM
 when booting with ACPI
In-Reply-To: <1458830676-27075-11-git-send-email-shannon.zhao@linaro.org>
References: <1458830676-27075-1-git-send-email-shannon.zhao@linaro.org>
 <1458830676-27075-11-git-send-email-shannon.zhao@linaro.org>
Message-ID: <56FAAEED.7060108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On 24/03/16 14:44, Shannon Zhao wrote:
> When booting with ACPI, it could get the event-channel irq through

The kernel will always get the event-channel IRQ through 
HVM_PARAM_CALLBACK_IRQ.

So I would say: ", the kernel will get the event-channel..."

> HVM_PARAM_CALLBACK_IRQ.
>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> ---
>   arch/arm/xen/enlighten.c | 36 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index d94f726..680aae0 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -30,6 +30,7 @@
>   #include <linux/time64.h>
>   #include <linux/timekeeping.h>
>   #include <linux/timekeeper_internal.h>
> +#include <linux/acpi.h>
>
>   #include <linux/mm.h>
>
> @@ -278,6 +279,35 @@ void __init xen_early_init(void)
>   		add_preferred_console("hvc", 0, NULL);
>   }
>
> +static void __init xen_acpi_guest_init(void)
> +{
> +#ifdef CONFIG_ACPI
> +	struct xen_hvm_param a;
> +	int interrupt, trigger, polarity;
> +
> +	a.domid = DOMID_SELF;
> +	a.index = HVM_PARAM_CALLBACK_IRQ;
> +	xen_events_irq = 0;
> +
> +	if (!HYPERVISOR_hvm_op(HVMOP_get_param, &a)) {
> +		if ((a.value >> 56) == HVM_PARAM_CALLBACK_TYPE_PPI) {
> +			interrupt = a.value & 0xff;
> +			trigger = ((a.value >> 8) & 0x1) ? ACPI_EDGE_SENSITIVE
> +							 : ACPI_LEVEL_SENSITIVE;
> +			polarity = ((a.value >> 8) & 0x2) ? ACPI_ACTIVE_LOW
> +							  : ACPI_ACTIVE_HIGH;
> +			xen_events_irq = acpi_register_gsi(NULL, interrupt,
> +							   trigger, polarity);
> +		}
> +	}

Can you invert the condition to remove one layer of indentation?

Regards,

-- 
Julien Grall
