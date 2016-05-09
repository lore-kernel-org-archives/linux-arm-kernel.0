From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 9 May 2016 18:06:12 +0200
Subject: [PATCH v2] clocksource/arm_arch_timer: Force per-CPU interrupt to
 be level-triggered
In-Reply-To: <1462805488-21535-1-git-send-email-marc.zyngier@arm.com>
References: <1462805488-21535-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <5730B574.9060209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/05/16 16:51, Marc Zyngier wrote:
> The ARM architected timer produces level-triggered interrupts (this
> is mandated by the architecture). Unfortunately, most device-trees
> get this wrong, and expose an edge-triggered interrupt.
>
> Until now, this wasn't too much an issue, as the programming of the
> trigger would fail (the corresponding PPI cannot be reconfigured),
> and the kernel would be happy with this. But we're about to change
> this, and trust DT a lot if the driver doesn't provide its own
> trigger information. In that context, the timer breaks badly.
>
> While we do need to fix the DTs, there is also some userspace out
> there (kvmtool) that generates the same kind of broken DT on the
> fly, and that will completely break with newer kernels.
>
> As a safety measure, and to keep buggy software alive as well as
> buying us some time to fix DTs all over the place, let's check
> what trigger configuration has been given us by the firmware.
> If this is not a level configuration, then we know that the
> DT/ACPI configuration is bust, and we pick some defaults which
> won't be worse than the existing setup.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
> - from v1: realised that there is no sane default, as we already have
>    diverging configurations. Instead, test for a level interrupt, and
>    force it to level low if current setting was edge. Also scream at the
>    unfortunate user.
>
>   drivers/clocksource/arm_arch_timer.c | 27 ++++++++++++++++++++++++---
>   1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 5152b38..be8cc6d 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -8,6 +8,9 @@
>    * it under the terms of the GNU General Public License version 2 as
>    * published by the Free Software Foundation.
>    */
> +
> +#define pr_fmt(fmt)	"arm_arch_timer: " fmt
> +
>   #include <linux/init.h>
>   #include <linux/kernel.h>
>   #include <linux/device.h>
> @@ -362,14 +365,32 @@ static bool arch_timer_has_nonsecure_ppi(void)
>   		arch_timer_ppi[PHYS_NONSECURE_PPI]);
>   }
>
> +static u32 check_ppi_trigger(int irq)
> +{
> +	u32 flags = irq_get_trigger_type(irq);
> +
> +	if (flags != IRQF_TRIGGER_HIGH && flags != IRQF_TRIGGER_LOW) {
> +		pr_warn("WARNING: Invalid trigger for IRQ%d, assuming level low\n", irq);
> +		pr_warn("WARNING: Please fix your firmware\n");
> +		flags = IRQF_TRIGGER_LOW;
> +	}
> +
> +	return flags;
> +}
> +
>   static int arch_timer_setup(struct clock_event_device *clk)
>   {
> +	u32 flags;
> +
>   	__arch_timer_setup(ARCH_CP15_TIMER, clk);
>
> -	enable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], 0);
> +	flags = check_ppi_trigger(arch_timer_ppi[arch_timer_uses_ppi]);
> +	enable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], flags);
>
> -	if (arch_timer_has_nonsecure_ppi())
> -		enable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI], 0);
> +	if (arch_timer_has_nonsecure_ppi()) {
> +		flags = check_ppi_trigger(arch_timer_ppi[PHYS_NONSECURE_PPI]);
> +		enable_percpu_irq(arch_timer_ppi[PHYS_NONSECURE_PPI], flags);
> +	}
>
>   	arch_counter_set_user_access();
>   	if (IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM))
>
