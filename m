From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Wed, 23 Feb 2011 16:22:18 -0800
Subject: [PATCH 5/5] ARM: msm: update GPIO chained IRQ handler to use
	EOI in parent chip
In-Reply-To: <1298302096-21275-6-git-send-email-will.deacon@arm.com>
References: <1298302096-21275-1-git-send-email-will.deacon@arm.com>
	<1298302096-21275-6-git-send-email-will.deacon@arm.com>
Message-ID: <4D65A4BA.8030206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
> The chained GPIO IRQ handler on MSM8x60 calls ->ack on the parent chip
> after handling the interrupt.
> 
> This patch updates the code to use ->irq_eoi now that the GIC has moved
> to using the fasteoi flow model.
> 
> Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/mach-msm/gpio-v2.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-msm/gpio-v2.c b/arch/arm/mach-msm/gpio-v2.c
> index 0de19ec..04fb411 100644
> --- a/arch/arm/mach-msm/gpio-v2.c
> +++ b/arch/arm/mach-msm/gpio-v2.c
> @@ -318,7 +318,7 @@ static void msm_summary_irq_handler(unsigned int irq, struct irq_desc *desc)
>  			generic_handle_irq(msm_gpio_to_irq(&msm_gpio.gpio_chip,
>  							   i));
>  	}
> -	desc->chip->ack(irq);
> +	desc->chip->irq_eoi(irq);

should be dec->chip->irq_eoi(&desc->irq_data);


--
Sent by an employee of the Qualcomm Innovation Center, Inc. The Qualcomm 
Innovation Center, Inc. is a member of the Code Aurora Forum.
