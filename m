From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 01 Mar 2011 16:11:40 +0300
Subject: [PATCH 3/6] ARM: tegra: update GPIO chained IRQ handler to use
	EOI in	parent chip
In-Reply-To: <1298900022-21516-4-git-send-email-will.deacon@arm.com>
References: <1298900022-21516-1-git-send-email-will.deacon@arm.com>
	<1298900022-21516-4-git-send-email-will.deacon@arm.com>
Message-ID: <4D6CF08C.6030109@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 28-02-2011 16:33, Will Deacon wrote:

> The chained GPIO IRQ handler on Tegra calls ->irq_ack on the parent
> chip prior to handling the interrupt.

> This patch updates the code to use ->irq_eoi now that the GIC has moved
> to using the fasteoi flow model.

> Acked-by: Colin Cross<ccross@android.com>
> Signed-off-by: Will Deacon<will.deacon@arm.com>
> ---
>   arch/arm/mach-tegra/gpio.c |   17 +----------------
>   1 files changed, 1 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/gpio.c b/arch/arm/mach-tegra/gpio.c
> index ad80488..5019b01 100644
> --- a/arch/arm/mach-tegra/gpio.c
> +++ b/arch/arm/mach-tegra/gpio.c
> @@ -219,9 +219,6 @@ static void tegra_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>   	struct tegra_gpio_bank *bank;
>   	int port;
>   	int pin;
> -	int unmasked = 0;
> -
> -	desc->irq_data.chip->irq_ack(&desc->irq_data);

    Won't this code break after the first patch as it removes irq_ack() 
method? I.e. shouldn't the patches be combined to keep them bisectable?

WBR, Sergei
