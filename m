From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Jan 2013 22:56:39 +0530
Subject: [PATCH 02/16] ARM: b.L: introduce the CPU/cluster power API
In-Reply-To: <1357777251-13541-3-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-3-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <50F04B4F.2070300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 January 2013 05:50 AM, Nicolas Pitre wrote:
> This is the basic API used to handle the powering up/down of individual
> CPUs in a big.LITTLE system.  The platform specific backend implementation
> has the responsibility to also handle the cluster level power as well when
> the first/last CPU in a cluster is brought up/down.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>   arch/arm/common/bL_entry.c      | 88 +++++++++++++++++++++++++++++++++++++++
>   arch/arm/include/asm/bL_entry.h | 92 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 180 insertions(+)
>
> diff --git a/arch/arm/common/bL_entry.c b/arch/arm/common/bL_entry.c
> index 80fff49417..41de0622de 100644
> --- a/arch/arm/common/bL_entry.c
> +++ b/arch/arm/common/bL_entry.c
> @@ -11,11 +11,13 @@
>
>   #include <linux/kernel.h>
>   #include <linux/init.h>
> +#include <linux/irqflags.h>
>
>   #include <asm/bL_entry.h>
>   #include <asm/barrier.h>
>   #include <asm/proc-fns.h>
>   #include <asm/cacheflush.h>
> +#include <asm/idmap.h>
>
>   extern volatile unsigned long bL_entry_vectors[BL_NR_CLUSTERS][BL_CPUS_PER_CLUSTER];
>
> @@ -28,3 +30,89 @@ void bL_set_entry_vector(unsigned cpu, unsigned cluster, void *ptr)
>   	outer_clean_range(__pa(&bL_entry_vectors[cluster][cpu]),
>   			  __pa(&bL_entry_vectors[cluster][cpu + 1]));
>   }
> +
> +static const struct bL_platform_power_ops *platform_ops;
> +
> +int __init bL_platform_power_register(const struct bL_platform_power_ops *ops)
> +{
> +	if (platform_ops)
> +		return -EBUSY;
> +	platform_ops = ops;
> +	return 0;
> +}
> +
> +int bL_cpu_power_up(unsigned int cpu, unsigned int cluster)
> +{
> +	if (!platform_ops)
> +		return -EUNATCH;
> +	might_sleep();
> +	return platform_ops->power_up(cpu, cluster);
> +}
> +
> +typedef void (*phys_reset_t)(unsigned long);
> +
> +void bL_cpu_power_down(void)
> +{
> +	phys_reset_t phys_reset;
> +
> +	BUG_ON(!platform_ops);
> +	BUG_ON(!irqs_disabled());
> +
> +	/*
> +	 * Do this before calling into the power_down method,
> +	 * as it might not always be safe to do afterwards.
> +	 */
> +	setup_mm_for_reboot();
> +
> +	platform_ops->power_down();
> +
> +	/*
> +	 * It is possible for a power_up request to happen concurrently
> +	 * with a power_down request for the same CPU. In this case the
> +	 * power_down method might not be able to actually enter a
> +	 * powered down state with the WFI instruction if the power_up
> +	 * method has removed the required reset condition.  The
> +	 * power_down method is then allowed to return. We must perform
> +	 * a re-entry in the kernel as if the power_up method just had
> +	 * deasserted reset on the CPU.
> +	 *
> +	 * To simplify race issues, the platform specific implementation
> +	 * must accommodate for the possibility of unordered calls to
> +	 * power_down and power_up with a usage count. Therefore, if a
> +	 * call to power_up is issued for a CPU that is not down, then
> +	 * the next call to power_down must not attempt a full shutdown
> +	 * but only do the minimum (normally disabling L1 cache and CPU
> +	 * coherency) and return just as if a concurrent power_up request
> +	 * had happened as described above.
> +	 */
> +
> +	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
> +	phys_reset(virt_to_phys(bL_entry_point));
> +
> +	/* should never get here */
> +	BUG();
> +}
> +
> +void bL_cpu_suspend(u64 expected_residency)
> +{
> +	phys_reset_t phys_reset;
> +
> +	BUG_ON(!platform_ops);
> +	BUG_ON(!irqs_disabled());
> +
> +	/* Very similar to bL_cpu_power_down() */
> +	setup_mm_for_reboot();
> +	platform_ops->suspend(expected_residency);
> +	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
> +	phys_reset(virt_to_phys(bL_entry_point));
> +	BUG();
>
I might be missing all the rationales behind not having a recovery for
CPUs entering suspend if they actualy come here because of some events.
This is pretty much possible in many scenario's and hence letting CPU
cpu come out of suspend should be possible. May be switcher code don't
have such requirement but it appeared bit off to me.

Regards
Santosh
