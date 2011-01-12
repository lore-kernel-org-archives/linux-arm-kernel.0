From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 12 Jan 2011 15:48:24 +0300
Subject: [PATCH 5/5 v2] ARM: pxa: Fix recursive call of
	pxa_(un)mask_low_gpio()
In-Reply-To: <1294699993-4712-5-git-send-email-marek.vasut@gmail.com>
References: <1294699993-4712-1-git-send-email-marek.vasut@gmail.com>
	<1294699993-4712-5-git-send-email-marek.vasut@gmail.com>
Message-ID: <4D2DA318.6020406@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11-01-2011 1:53, Marek Vasut wrote:

> Signed-off-by: Marek Vasut<marek.vasut@gmail.com>
> ---
> v2: Remove dead code as proposed by Sergei

>   arch/arm/mach-pxa/irq.c |    8 ++------
>   1 files changed, 2 insertions(+), 6 deletions(-)

> diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
> index a7deff5..76e69cf 100644
> --- a/arch/arm/mach-pxa/irq.c
> +++ b/arch/arm/mach-pxa/irq.c
> @@ -110,16 +110,12 @@ static void pxa_ack_low_gpio(unsigned int irq)
>
>   static void pxa_mask_low_gpio(unsigned int irq)
>   {
> -	struct irq_desc *desc = irq_to_desc(irq);
> -
> -	desc->chip->mask(irq);
> +	pxa_mask_irq(irq);
>   }
>
>   static void pxa_unmask_low_gpio(unsigned int irq)
>   {
> -	struct irq_desc *desc = irq_to_desc(irq);
> -
> -	desc->chip->unmask(irq);
> +	pxa_unmask_irq(irq);
>   }
>
>   static struct irq_chip pxa_low_gpio_chip = {

    If the above two functions are the methods of this IRQ chip, shouldn't you 
just replace the initializers and remove the functions altogether?

WBR, Sergei
