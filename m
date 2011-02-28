From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Feb 2011 14:03:27 +0000
Subject: [PATCH 6/6] ARM: nmk: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <1298900022-21516-7-git-send-email-will.deacon@arm.com>
References: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
	<1298900022-21516-7-git-send-email-will.deacon@arm.com>
Message-ID: <20110228140327.GA1937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 01:33:42PM +0000, Will Deacon wrote:
> The chained GPIO IRQ handler for the nomadik platform can be called
> with the GIC as its host chip on the mach-ux500 machines.
> 
> This patch updates the code to use ->irq_eoi when it is available.
> 
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/plat-nomadik/gpio.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
> index 1e88ecb..51cc71b 100644
> --- a/arch/arm/plat-nomadik/gpio.c
> +++ b/arch/arm/plat-nomadik/gpio.c
> @@ -538,6 +538,8 @@ static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  	}
>  
>  	host_chip->irq_unmask(&desc->irq_data);
> +	if (host_chip->irq_eoi)
> +		host_chip->irq_eoi(&desc->irq_data);

I notice in some you delete the irq_unmask, others you leave it.  Shouldn't
they all be similar?

Maybe we do something like:

static inline void chained_irq_exit(struct irq_chip *chip, struct irq_desc *desc)
{
	if (chip->irq_eoi)
		chip->irq_eoi(&desc->irq_data);
	else
		chip->irq_unmask(&desc->irq_data);
}

to cover these exit paths in a common way?
