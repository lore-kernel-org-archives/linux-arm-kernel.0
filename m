From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 12 Jun 2015 19:42:27 +0900
Subject: [PATCH v2 1/1] irqchip: exynos-combiner: Save IRQ enable set on
 suspend
In-Reply-To: <557AB00C.5040606@arm.com>
References: <1434087795-13990-1-git-send-email-javier.martinez@collabora.co.uk>
 <557AB00C.5040606@arm.com>
Message-ID: <557AB793.1060809@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.06.2015 19:10, Sudeep Holla wrote:
> 
> 
> On 12/06/15 06:43, Javier Martinez Canillas wrote:
>> The Exynos interrupt combiner IP loses its state when the SoC enters
>> into a low power state during a Suspend-to-RAM. This means that if a
>> IRQ is used as a source, the interrupts for the devices are disabled
>> when the system is resumed from a sleep state so are not triggered.
>>
>> Save the interrupt enable set register for each combiner group and
>> restore it after resume to make sure that the interrupts are enabled.
>>
> 
> Not sure if you need this. IMO it's not clean and redundant though I
> admit many drivers do exactly same thing. I am trying to remove or point
> out those redundant code as irqchip core has options/flags to do what
> you need. I assume there are no wakeup sources connected to this
> combiner.

It may have wake up sources connected. Correct me if I am wrong but (at
least) on Exynos5250 combiner takes care of gpx1 GPIO pins which may be
external interrupts (e.g. power key on Exynos5250 Snow). I didn't check
other boards.

Best regards,
Krzysztof

> Setting irqchip flags should solve this problem. A simple
> patch below should do the job ?
> 
> -->8
> 
> diff --git a/drivers/irqchip/exynos-combiner.c
> b/drivers/irqchip/exynos-combiner.c
> index 5945223b73fa..c0bcec59f829 100644
> --- a/drivers/irqchip/exynos-combiner.c
> +++ b/drivers/irqchip/exynos-combiner.c
> @@ -111,6 +111,7 @@ static struct irq_chip combiner_chip = {
>  #ifdef CONFIG_SMP
>         .irq_set_affinity       = combiner_set_affinity,
>  #endif
> +       .flags                  = IRQCHIP_MASK_ON_SUSPEND,
>  };
> 
> 
> 
