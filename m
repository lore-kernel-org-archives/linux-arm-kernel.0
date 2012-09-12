From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 12 Sep 2012 10:40:26 +0100
Subject: [PATCH v4 1/2] ARM: arch_timers: enable the use of the virtual
 timer
In-Reply-To: <5050060E.4080504@codeaurora.org>
References: <1346780329-14451-1-git-send-email-marc.zyngier@arm.com>
 <1346780329-14451-2-git-send-email-marc.zyngier@arm.com>
 <5050060E.4080504@codeaurora.org>
Message-ID: <5050588A.5030504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rohit,

On 12/09/12 04:48, Rohit Vaswani wrote:
> On 9/4/2012 10:38 AM, Marc Zyngier wrote:
> 
> At the moment, the arch_timer driver only uses the physical timer,
> which can cause problem if PL2 hasn't enabled PL1 access in CNTHCTL,
> which is likely in a virtualized environment. Instead, the virtual
> timer is always available.
> 
> This patch enables the use of the virtual timer, unless no
> interrupt is provided in the DT for it, in which case it falls
> back to the physical timer.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com><mailto:marc.zyngier@arm.com>
> ---
>  arch/arm/kernel/arch_timer.c | 343 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 241 insertions(+), 102 deletions(-)
> 
> <snip>
> 
> 
> 
> @@ -329,6 +449,7 @@ int __init arch_timer_of_register(void)
>  {
>         struct device_node *np;
>         u32 freq;
> +       int i;
> 
>         np = of_find_matching_node(NULL, arch_timer_of_match);
>         if (!np) {
> @@ -340,22 +461,40 @@ int __init arch_timer_of_register(void)
>         if (!of_property_read_u32(np, "clock-frequency", &freq))
>                 arch_timer_rate = freq;
> 
> -       arch_timer_ppi = irq_of_parse_and_map(np, 0);
> -       arch_timer_ppi2 = irq_of_parse_and_map(np, 1);
> -       pr_info("arch_timer: found %s irqs %d %d\n",
> -               np->name, arch_timer_ppi, arch_timer_ppi2);
> +       for (i = PHYS_SECURE_PPI; i < MAX_TIMER_PPI; i++)
> +               arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
> +
> +       /*
> +        * If no interrupt provided for virtual timer, we'll have to
> +        * stick to the physical timer. It'd better be accessible...
> +        */
> +       if (!arch_timer_ppi[VIRT_PPI]) {
> +               arch_timer_use_virtual = false;
> +
> +               if (!arch_timer_ppi[PHYS_SECURE_PPI] ||
> +                   !arch_timer_ppi[PHYS_NONSECURE_PPI]) {
> +                       pr_warn("arch_timer: No interrupt available, giving up\n");
> +                       return -EINVAL;
> 
> Should this be
> 
> if (!arch_timer_ppi[PHYS_SECURE_PPI] &&
>                     !arch_timer_ppi[PHYS_NONSECURE_PPI]) {
> ...
> ?

Hmmm. You're allowed to have a secure interrupt and no non-secure, but
not the opposite. So it should be

if (!arch_timer_ppi[PHYS_SECURE_PPI])

I'll fix this. But frankly, I'd love to to get rid of all these tests
and mandate the DT to fully describe all the interrupts.

> 
> <snip>
> 
> Also, I have based my next mm-arch_timer patch on this.

Sounds good. Let me know when I can have a look at it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
