From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 8 Jul 2015 14:46:29 +0800
Subject: [RFC PATCH 3/3] arm: psci: add cpuidle_ops support
In-Reply-To: <20150707142345.GG4379@red-moon>
References: <1436014910-1201-1-git-send-email-jszhang@marvell.com>
 <1436014910-1201-4-git-send-email-jszhang@marvell.com>
 <20150707142345.GG4379@red-moon>
Message-ID: <20150708144629.147ebce5@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Lorenzo,

On Tue, 7 Jul 2015 15:23:45 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Sat, Jul 04, 2015 at 02:01:50PM +0100, Jisheng Zhang wrote:
> > This patch implement cpuidle_ops using psci, the code is stolen from
> > arm64. Now we can use cpuidle-arm.c for both arm and arm64.
> 
> You mean cpuidle-arm.c with PSCI back-end. You will have to rewrite
> the commit log anyway since this patch will be significantly trimmed,
> see below.

Will do, thanks for the suggestion.

> 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  arch/arm/kernel/psci.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 116 insertions(+)
> > 
> > diff --git a/arch/arm/kernel/psci.c b/arch/arm/kernel/psci.c
> > index 7f6ff02..7bf744d 100644
> > --- a/arch/arm/kernel/psci.c
> > +++ b/arch/arm/kernel/psci.c
> > @@ -13,16 +13,132 @@
> >   * Author: Will Deacon <will.deacon@arm.com>
> >   */
> >  
> > +#include <linux/cpuidle.h>
> >  #include <linux/init.h>
> >  #include <linux/smp.h>
> >  #include <linux/of.h>
> >  #include <linux/delay.h>
> >  #include <linux/psci.h>
> > +#include <linux/slab.h>
> >  
> >  #include <uapi/linux/psci.h>
> >  
> > +#include <asm/cpuidle.h>
> >  #include <asm/psci.h>
> >  #include <asm/smp_plat.h>
> > +#include <asm/suspend.h>
> > +
> > +#ifdef CONFIG_CPU_IDLE
> > +static bool psci_power_state_loses_context(u32 state)
> > +{
> > +	return state & PSCI_0_2_POWER_STATE_TYPE_MASK;
> > +}
> > +
> > +static bool psci_power_state_is_valid(u32 state)
> > +{
> > +	const u32 valid_mask = PSCI_0_2_POWER_STATE_ID_MASK |
> > +			       PSCI_0_2_POWER_STATE_TYPE_MASK |
> > +			       PSCI_0_2_POWER_STATE_AFFL_MASK;
> > +
> > +	return !(state & ~valid_mask);
> > +}
> 
> Already moved these helpers to drivers/firmware:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/347355.html
> 
> > +
> > +static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> > +
> > +static int __init cpu_psci_cpu_init_idle(struct device_node *cpu_node,
> > +					 int cpu)
> > +{
> > +	int i, ret, count = 0;
> > +	u32 *psci_states;
> > +	struct device_node *state_node;
> > +
> > +	/*
> > +	 * If the PSCI cpu_suspend function hook has not been initialized
> > +	 * idle states must not be enabled, so bail out
> > +	 */
> > +	if (!psci_ops.cpu_suspend)
> > +		return -EOPNOTSUPP;
> > +
> > +	/* Count idle states */
> > +	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
> > +					      count))) {
> > +		count++;
> > +		of_node_put(state_node);
> > +	}
> > +
> > +	if (!count)
> > +		return -ENODEV;
> > +
> > +	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
> > +	if (!psci_states)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		u32 state;
> > +
> > +		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> > +
> > +		ret = of_property_read_u32(state_node,
> > +					   "arm,psci-suspend-param",
> > +					   &state);
> > +		if (ret) {
> > +			pr_warn(" * %s missing arm,psci-suspend-param property\n",
> > +				state_node->full_name);
> > +			of_node_put(state_node);
> > +			goto free_mem;
> > +		}
> > +
> > +		of_node_put(state_node);
> > +		pr_warn("psci-power-state %#x index %d\n", state, i);
> > +		if (!psci_power_state_is_valid(state)) {
> > +			pr_warn("Invalid PSCI power state %#x\n", state);
> > +			ret = -EINVAL;
> > +			goto free_mem;
> > +		}
> > +		psci_states[i] = state;
> > +	}
> > +	/* Idle states parsed correctly, initialize per-cpu pointer */
> > +	per_cpu(psci_power_state, cpu) = psci_states;
> > +	return 0;
> > +
> > +free_mem:
> > +	kfree(psci_states);
> > +	return ret;
> > +}
> > +
> > +static int psci_suspend_finisher(unsigned long index)
> > +{
> > +	u32 *state = __this_cpu_read(psci_power_state);
> > +
> > +	return psci_ops.cpu_suspend(state[index - 1],
> > +				    virt_to_phys(cpu_resume));
> > +}
> > +
> > +static int cpu_psci_cpu_suspend(int cpu, unsigned long index)
> > +{
> > +	int ret;
> > +	u32 *state = __this_cpu_read(psci_power_state);
> > +	/*
> > +	 * idle state index 0 corresponds to wfi, should never be called
> > +	 * from the cpu_suspend operations
> > +	 */
> > +	if (WARN_ON_ONCE(!index))
> > +		return -EINVAL;
> > +
> > +	if (!psci_power_state_loses_context(state[index - 1]))
> > +		ret = psci_ops.cpu_suspend(state[index - 1], 0);
> > +	else
> > +		ret = cpu_suspend(index, psci_suspend_finisher);
> > +
> > +	return ret;
> > +}
> 
> Code above is arch agnostic and should be moved out of arch/arm (and
> arm64).

Got it. the remaining issue is cpuidle_ops.suspend prototype. Does it make
sense to change it from

int (*suspend)(int cpu, unsigned long arg);

to

int (*suspend)(unsigned long arg);

It seems that the to-be-suspended cpu is always the calling cpu itself.

Anyway I won't change the prototype but make a simple glue instead in the next
for patch for review.

> 
> Can you put together a patch to do it or you want me to do it ?
> 
> > +static struct cpuidle_ops psci_cpuidle_ops __initdata = {
> > +	.suspend = cpu_psci_cpu_suspend,
> > +	.init = cpu_psci_cpu_init_idle,
> > +};
> > +CPUIDLE_METHOD_OF_DECLARE(psci_idle, "psci", &psci_cpuidle_ops);
> > +#endif
> 
> This is fine and should stay in arch/arm.

Thanks a lot for the review and tips, I'll cook newer patches for review.

Thanks,
Jisheng
