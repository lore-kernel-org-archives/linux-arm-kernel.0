From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 25 Jul 2011 18:08:59 +0530
Subject: [PATCH 3/4] ARM: CPU hotplug: pass in proper affinity mask on
	IRQ migration
In-Reply-To: <E1Qjv7j-0003Ia-FD@rmk-PC.arm.linux.org.uk>
References: <20110721151413.GD28942@n2100.arm.linux.org.uk>
	<E1Qjv7j-0003Ia-FD@rmk-PC.arm.linux.org.uk>
Message-ID: <4E2D63E3.8000308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/21/2011 8:55 PM, Russell King - ARM Linux wrote:
> Now that the GIC takes care of selecting a target interrupt from the
> affinity mask, we don't need all this complexity in the core code
> anymore.  Just detect when we need to break affinity.
>
> Signed-off-by: Russell King<rmk+kernel@arm.linux.org.uk>
> ---
>   arch/arm/kernel/irq.c |   10 ++++------
>   1 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index d7aa5c9..ab63c05 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -133,17 +133,15 @@ int __init arch_probe_nr_irqs(void)
>
>   static bool migrate_one_irq(struct irq_data *d)
>   {
> -	unsigned int cpu = cpumask_any_and(d->affinity, cpu_online_mask);
> +	const struct cpumask *affinity = d->affinity;
>   	bool ret = false;
>
> -	if (cpu>= nr_cpu_ids) {
> -		cpu = cpumask_any(cpu_online_mask);
> +	if (cpumask_any_and(affinity, cpu_online_mask)>= nr_cpu_ids) {
> +		affinity cpu_online_mask;

I noticed, you missed '=' above and same is corrected in PATCH 4/4.
Should be fixed in this patch itself to avoid git-bisect breakage.

Regards
Santosh
