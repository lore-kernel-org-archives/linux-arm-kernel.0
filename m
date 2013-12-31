From: b.brezillon@overkiz.com (boris brezillon)
Date: Tue, 31 Dec 2013 18:25:40 +0100
Subject: [PATCH] at91: ohci: fixed broken sanity check
In-Reply-To: <1388507624-10636-1-git-send-email-jjhiblot@traphandler.com>
References: <1388507624-10636-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <52C2FE14.1020806@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jean-Jacques,

On 31/12/2013 17:33, jjhiblot at traphandler.com wrote:
> From: jean-jacques hiblot <jean-jacques.hiblot@jdsu.com>
>
> The test (pdev->resource[1].flags != IORESOURCE_IRQ) is broken because the flags
> value may contain not only the information IORESSOURCE_IRQ but also the IRQ type
> (IORESOURCE_IRQ_HIGHLEVEL for example).
>

This is already fixed: we moved to platform_get_irq and
platform_get_ressource instead of directly accessing platform
resource table.

See http://lists.openwall.net/linux-kernel/2013/12/08/128.

This solves both the problem you're reporting and another problem when
resources are in a different order (nothing guarantees the resources
order when using DT).

Best Regards,

Boris

> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>   drivers/usb/host/ohci-at91.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index 418444e..df9c8a4 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -142,8 +142,8 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>   		return -ENODEV;
>   	}
>
> -	if ((pdev->resource[0].flags != IORESOURCE_MEM)
> -			|| (pdev->resource[1].flags != IORESOURCE_IRQ)) {
> +	if (!(pdev->resource[0].flags & IORESOURCE_MEM)
> +			|| !(pdev->resource[1].flags & IORESOURCE_IRQ)) {
>   		pr_debug("hcd probe: invalid resource type\n");
>   		return -ENODEV;
>   	}
>
