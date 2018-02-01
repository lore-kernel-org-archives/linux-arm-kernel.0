From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 1 Feb 2018 13:10:38 +0000
Subject: [PATCH] irqchip/gic-v3: Ignore disabled ITS nodes
In-Reply-To: <20180129164933.25479-1-sboyd@codeaurora.org>
References: <20180129164933.25479-1-sboyd@codeaurora.org>
Message-ID: <8e564636-aae3-4fee-a57c-6f1c01529b49@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/01/18 16:49, Stephen Boyd wrote:
> On some platforms there's an ITS available but it's not enabled
> because reading or writing the registers is denied by the
> firmware. In fact, reading or writing them will cause the system
> to reset.

Wow. Funky.

>  We could remove the node from DT in such a case, but
> it's better to skip nodes that are marked as "disabled" in DT so
> that we can describe the hardware that exists and use the status
> property to indicate how the firmware has configured things.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c      | 2 ++
>  drivers/irqchip/irq-gic-v3-its-platform-msi.c | 2 ++
>  drivers/irqchip/irq-gic-v3-its.c              | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> index 77931214d954..6b5f50e1fc72 100644
> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
> @@ -132,6 +132,8 @@ static int __init its_pci_of_msi_init(void)
>  
>  	for (np = of_find_matching_node(NULL, its_device_id); np;
>  	     np = of_find_matching_node(np, its_device_id)) {
> +		if (!of_device_is_available(np))
> +			continue;
>  		if (!of_property_read_bool(np, "msi-controller"))
>  			continue;
>  
> diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> index 833a90fe33ae..8881a053c173 100644
> --- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> +++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
> @@ -154,6 +154,8 @@ static void __init its_pmsi_of_init(void)
>  
>  	for (np = of_find_matching_node(NULL, its_device_id); np;
>  	     np = of_find_matching_node(np, its_device_id)) {
> +		if (!of_device_is_available(np))
> +			continue;
>  		if (!of_property_read_bool(np, "msi-controller"))
>  			continue;
>  
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 284738add89b..a84ee6ce244d 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1815,6 +1815,8 @@ static int __init its_of_probe(struct device_node *node)
>  
>  	for (np = of_find_matching_node(node, its_device_id); np;
>  	     np = of_find_matching_node(np, its_device_id)) {
> +		if (!of_device_is_available(np))
> +			continue;
>  		if (!of_property_read_bool(np, "msi-controller")) {
>  			pr_warn("%s: no msi-controller property, ITS ignored\n",
>  				np->full_name);
> 

Can you also address the same thing in
drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c?

Do we need a cc to stable for this?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
