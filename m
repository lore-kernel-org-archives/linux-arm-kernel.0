From: rob.herring@calxeda.com (Rob Herring)
Date: Tue, 19 Feb 2013 07:57:36 -0600
Subject: [PATCH] irqchip: fix typo when moving gic_raise_softirq()
In-Reply-To: <1361281942-16885-1-git-send-email-javi.merino@arm.com>
References: <1361281942-16885-1-git-send-email-javi.merino@arm.com>
Message-ID: <512384D0.1010306@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2013 07:52 AM, Javi Merino wrote:
> In b1cffebf (ARM: GIC: remove direct use of gic_raise_softirq)
> gic_raise_softirq() was moved inside arch/arm/common/gic.c but in the
> process it reverted by mistake a change to that function made by
> 384a290 (ARM: gic: use a private mapping for CPU target interfaces).
> This breaks multicluster systems on ARM.
> 
> This patch fixes the typo.
> 
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>

I wouldn't really call this a typo, but a rebasing error. Not really
important though, so:

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  drivers/irqchip/irq-gic.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 644d724..a32e0d5 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -648,7 +648,7 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  
>  	/* Convert our logical CPU mask into a physical one. */
>  	for_each_cpu(cpu, mask)
> -		map |= 1 << cpu_logical_map(cpu);
> +		map |= gic_cpu_map[cpu];
>  
>  	/*
>  	 * Ensure that stores to Normal memory are visible to the
> 
