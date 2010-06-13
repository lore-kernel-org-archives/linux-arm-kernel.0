From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 14 Jun 2010 00:00:11 +0800
Subject: [PATCH 1/2] [ARM] pxa3xx: add set_type to the ext_wakeup irq
	chip.
In-Reply-To: <1276417909-22980-2-git-send-email-grinberg@compulab.co.il>
References: <1276417909-22980-1-git-send-email-grinberg@compulab.co.il>
	<1276417909-22980-2-git-send-email-grinberg@compulab.co.il>
Message-ID: <AANLkTik9BRty_akndFUlsnllvNX9m375eVUzT9I8XjA8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 13, 2010 at 4:31 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> pxa3xx cpu needs the irq type setup to be able to
> wakeup from low power mode on IRQ_WAKEUPx events.
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>

OK, applied.

> ---
> ?arch/arm/mach-pxa/pxa3xx.c | ? 12 ++++++++++++
> ?1 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
> index f2f4127..2d54812 100644
> --- a/arch/arm/mach-pxa/pxa3xx.c
> +++ b/arch/arm/mach-pxa/pxa3xx.c
> @@ -566,11 +566,23 @@ static void pxa_unmask_ext_wakeup(unsigned int irq)
> ? ? ? ?PECR |= PECR_IE(irq - IRQ_WAKEUP0);
> ?}
>
> +static int pxa_set_ext_wakeup_type(unsigned int irq, unsigned int flow_type)
> +{
> + ? ? ? if (flow_type & IRQ_TYPE_EDGE_RISING)
> + ? ? ? ? ? ? ? PWER |= 1 << (irq - IRQ_WAKEUP0);
> +
> + ? ? ? if (flow_type & IRQ_TYPE_EDGE_FALLING)
> + ? ? ? ? ? ? ? PWER |= 1 << (irq - IRQ_WAKEUP0 + 2);
> +
> + ? ? ? return 0;
> +}
> +
> ?static struct irq_chip pxa_ext_wakeup_chip = {
> ? ? ? ?.name ? ? ? ? ? = "WAKEUP",
> ? ? ? ?.ack ? ? ? ? ? ?= pxa_ack_ext_wakeup,
> ? ? ? ?.mask ? ? ? ? ? = pxa_mask_ext_wakeup,
> ? ? ? ?.unmask ? ? ? ? = pxa_unmask_ext_wakeup,
> + ? ? ? .set_type ? ? ? = pxa_set_ext_wakeup_type,
> ?};
>
> ?static void __init pxa_init_ext_wakeup_irq(set_wake_t fn)
> --
> 1.6.4.4
>
>
