From: ddaney.cavm@gmail.com (David Daney)
Date: Thu, 09 Jun 2016 14:10:48 -0700
Subject: [PATCH v3 1/2] clocksource/arm_arch_timer: Force per-CPU interrupt
 to be level-triggered
In-Reply-To: <1465235791-7064-2-git-send-email-marc.zyngier@arm.com>
References: <1465235791-7064-1-git-send-email-marc.zyngier@arm.com>
 <1465235791-7064-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <5759DB58.5070906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016 10:56 AM, Marc Zyngier wrote:
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


I tried to test this patch, but there is a problem somewhere that I have 
not yet tracked down.  On Cavium Thunder (gic-v3 based) I have tested 
with the device tree interrupt type of both 4 and 8 and get the same result:


[    0.000000] arm_arch_timer: WARNING: Invalid trigger for IRQ2, 
assuming level low
[    0.000000] arm_arch_timer: WARNING: Please fix your firmware
[    0.000000] arm_arch_timer: WARNING: Invalid trigger for IRQ3, 
assuming level low
[    0.000000] arm_arch_timer: WARNING: Please fix your firmware
[    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 
100.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff 
max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
[    0.000002] sched_clock: 56 bits at 100MHz, resolution 10ns, wraps 
every 4398046511100ns

It could be that the gic-v3 irq mapping code is broken.  I will try to 
look into it, but there may be other fixes needed before we would 
consider this patch to be an improvement.

> ---
>   drivers/clocksource/arm_arch_timer.c | 27 ++++++++++++++++++++++++---
>   1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 3628ac8..1310641 100644
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
> @@ -462,14 +465,32 @@ static bool arch_timer_has_nonsecure_ppi(void)
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
