From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 24 Feb 2015 16:53:38 -0500 (EST)
Subject: [PATCH 2/4] arm-cci: Get rid of secure transactions for PMU driver
In-Reply-To: <1424783863-9894-3-git-send-email-suzuki.poulose@arm.com>
References: <1424783863-9894-1-git-send-email-suzuki.poulose@arm.com>
 <1424783863-9894-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <alpine.LFD.2.11.1502241646190.25484@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Feb 2015, Suzuki K. Poulose wrote:

> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> 
> Avoid secure transactions while probing the CCI PMU. The
> existing code makes use of the Peripheral ID2 (PID2) register
> to determine the revision of the CCI400, which requires a
> secure transaction. This puts a limitation on the usage of the
> driver on systems running non-secure Linux(e.g, ARM64).
> 
> Updated the device-tree binding for cci pmu node to add the explicit
> revision number for the compatible field.
> 
> The supported strings are :
> 	arm,cci-400-pmu,r0
> 	arm,cci-400-pmu,r1
> 	arm,cci-400-pmu - DEPRECATED. See NOTE below
> 
> NOTE: If the revision is not mentioned, we need to probe the cci revision,
> which could be fatal on a platform running non-secure. We need a reliable way
> to know if we can poke the CCI registers at runtime on ARM32. We depend on
> 'mcpm_is_available()' when it is available. mcpm_is_available() returns true
> only when there is a registered driver for mcpm. Otherwise, we assume that we
> don't have secure access, and skips probing the revision number(ARM64 case).
> 
> The MCPM should figure out if it is safe to access the CCI. Unfortunately
> there isn't a reliable way to indicate the same via dtb. This patch doesn't
> address/change the current situation. It only deals with the CCI-PMU, leaving
> the assumptions about the secure access as it has been, prior to this patch.

This is an extensive commit log about secure access issues which is nice 
and appreciated.  However the patch does quite some more code reorg not 
mentioned here.  Could you please move this code reorg to a separate 
patch and then have a patch on top introducing these probing changes?  
This should make the implication of what is said above clearer.

> Cc: devicetree at vger.kernel.org
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cci.txt |    7 +-
>  arch/arm/include/asm/arm-cci.h                |   42 ++++++++
>  arch/arm64/include/asm/arm-cci.h              |   27 +++++
>  drivers/bus/arm-cci.c                         |  138 ++++++++++++++++---------
>  include/linux/arm-cci.h                       |    2 +
>  5 files changed, 166 insertions(+), 50 deletions(-)
>  create mode 100644 arch/arm/include/asm/arm-cci.h
>  create mode 100644 arch/arm64/include/asm/arm-cci.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt
> index f28d82b..0e4b6a7 100644
> --- a/Documentation/devicetree/bindings/arm/cci.txt
> +++ b/Documentation/devicetree/bindings/arm/cci.txt
> @@ -94,8 +94,11 @@ specific to ARM.
>  		- compatible
>  			Usage: required
>  			Value type: <string>
> -			Definition: must be "arm,cci-400-pmu"
> -
> +			Definition: Supported strings are :
> +				 "arm,cci-400-pmu,r0"
> +				 "arm,cci-400-pmu,r1"
> +				 "arm,cci-400-pmu"  - DEPRECATED, permitted only where OS has
> +						      secure acces to CCI registers
>  		- reg:
>  			Usage: required
>  			Value type: Integer cells. A register entry, expressed
> diff --git a/arch/arm/include/asm/arm-cci.h b/arch/arm/include/asm/arm-cci.h
> new file mode 100644
> index 0000000..b828d7a
> --- /dev/null
> +++ b/arch/arm/include/asm/arm-cci.h
> @@ -0,0 +1,42 @@
> +/*
> + * arch/arm/include/asm/arm-cci.h
> + *
> + * Copyright (C) 2015 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __ASM_ARM_CCI_H
> +#define __ASM_ARM_CCI_H
> +
> +#ifdef CONFIG_MCPM
> +#include <asm/mcpm.h>
> +
> +/*
> + * We don't have a reliable way of detecting, whether
> + * we have access to secure-only registers, unless
> + * mcpm is registered.
> + */
> +static inline int platform_has_secure_cci_access(void)
> +{
> +	return mcpm_is_available();
> +}
> +
> +#else
> +static inline int platform_has_secure_cci_access(void)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#endif
> diff --git a/arch/arm64/include/asm/arm-cci.h b/arch/arm64/include/asm/arm-cci.h
> new file mode 100644
> index 0000000..37bbe37
> --- /dev/null
> +++ b/arch/arm64/include/asm/arm-cci.h
> @@ -0,0 +1,27 @@
> +/*
> + * arch/arm64/include/asm/arm-cci.h
> + *
> + * Copyright (C) 2015 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __ASM_ARM_CCI_H
> +#define __ASM_ARM_CCI_H
> +
> +static inline int platform_has_secure_cci_access(void)
> +{
> +	return 0;
> +}
> +
> +#endif
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index f27cf56..fe9fa46 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -79,19 +79,38 @@ static const struct of_device_id arm_cci_matches[] = {
>  
>  #define CCI_PMU_MAX_HW_EVENTS 5   /* CCI PMU has 4 counters + 1 cycle counter */
>  
> +/* Types of interfaces that can generate events */
> +enum {
> +	CCI_IF_SLAVE,
> +	CCI_IF_MASTER,
> +	CCI_IF_MAX,
> +};
> +
> +struct event_range {
> +	u32 min;
> +	u32 max;
> +};
> +
>  struct cci_pmu_hw_events {
>  	struct perf_event *events[CCI_PMU_MAX_HW_EVENTS];
>  	unsigned long used_mask[BITS_TO_LONGS(CCI_PMU_MAX_HW_EVENTS)];
>  	raw_spinlock_t pmu_lock;
>  };
>  
> +struct cci_pmu_model {
> +	char *name;
> +	struct event_range event_ranges[CCI_IF_MAX];
> +};
> +
> +static struct cci_pmu_model cci_pmu_models[];
> +
>  struct cci_pmu {
>  	void __iomem *base;
>  	struct pmu pmu;
>  	int nr_irqs;
>  	int irqs[CCI_PMU_MAX_HW_EVENTS];
>  	unsigned long active_irqs;
> -	struct pmu_port_event_ranges *port_ranges;
> +	const struct cci_pmu_model *model;
>  	struct cci_pmu_hw_events hw_events;
>  	struct platform_device *plat_device;
>  	int num_events;
> @@ -152,47 +171,16 @@ enum cci400_perf_events {
>  #define CCI_REV_R1_MASTER_PORT_MIN_EV	0x00
>  #define CCI_REV_R1_MASTER_PORT_MAX_EV	0x11
>  
> -struct pmu_port_event_ranges {
> -	u8 slave_min;
> -	u8 slave_max;
> -	u8 master_min;
> -	u8 master_max;
> -};
> -
> -static struct pmu_port_event_ranges port_event_range[] = {
> -	[CCI_REV_R0] = {
> -		.slave_min = CCI_REV_R0_SLAVE_PORT_MIN_EV,
> -		.slave_max = CCI_REV_R0_SLAVE_PORT_MAX_EV,
> -		.master_min = CCI_REV_R0_MASTER_PORT_MIN_EV,
> -		.master_max = CCI_REV_R0_MASTER_PORT_MAX_EV,
> -	},
> -	[CCI_REV_R1] = {
> -		.slave_min = CCI_REV_R1_SLAVE_PORT_MIN_EV,
> -		.slave_max = CCI_REV_R1_SLAVE_PORT_MAX_EV,
> -		.master_min = CCI_REV_R1_MASTER_PORT_MIN_EV,
> -		.master_max = CCI_REV_R1_MASTER_PORT_MAX_EV,
> -	},
> -};
> -
> -/*
> - * Export different PMU names for the different revisions so userspace knows
> - * because the event ids are different
> - */
> -static char *const pmu_names[] = {
> -	[CCI_REV_R0] = "CCI_400",
> -	[CCI_REV_R1] = "CCI_400_r1",
> -};
> -
>  static int pmu_is_valid_slave_event(u8 ev_code)
>  {
> -	return pmu->port_ranges->slave_min <= ev_code &&
> -		ev_code <= pmu->port_ranges->slave_max;
> +	return pmu->model->event_ranges[CCI_IF_SLAVE].min <= ev_code &&
> +		ev_code <= pmu->model->event_ranges[CCI_IF_SLAVE].max;
>  }
>  
>  static int pmu_is_valid_master_event(u8 ev_code)
>  {
> -	return pmu->port_ranges->master_min <= ev_code &&
> -		ev_code <= pmu->port_ranges->master_max;
> +	return pmu->model->event_ranges[CCI_IF_MASTER].min <= ev_code &&
> +		ev_code <= pmu->model->event_ranges[CCI_IF_MASTER].max;
>  }
>  
>  static int pmu_validate_hw_event(u8 hw_event)
> @@ -234,11 +222,11 @@ static int probe_cci_revision(void)
>  		return CCI_REV_R1;
>  }
>  
> -static struct pmu_port_event_ranges *port_range_by_rev(void)
> +static const struct cci_pmu_model *probe_cci_model(struct platform_device *pdev)
>  {
> -	int rev = probe_cci_revision();
> -
> -	return &port_event_range[rev];
> +	if (platform_has_secure_cci_access())
> +		return &cci_pmu_models[probe_cci_revision()];
> +	return NULL;
>  }
>  
>  static int pmu_is_valid_counter(struct cci_pmu *cci_pmu, int idx)
> @@ -807,9 +795,9 @@ static const struct attribute_group *pmu_attr_groups[] = {
>  
>  static int cci_pmu_init(struct cci_pmu *cci_pmu, struct platform_device *pdev)
>  {
> -	char *name = pmu_names[probe_cci_revision()];
> +	char *name = cci_pmu->model->name;
>  	cci_pmu->pmu = (struct pmu) {
> -		.name		= pmu_names[probe_cci_revision()],
> +		.name		= cci_pmu->model->name,
>  		.task_ctx_nr	= perf_invalid_context,
>  		.pmu_enable	= cci_pmu_enable,
>  		.pmu_disable	= cci_pmu_disable,
> @@ -862,13 +850,65 @@ static struct notifier_block cci_pmu_cpu_nb = {
>  	.priority	= CPU_PRI_PERF + 1,
>  };
>  
> +static struct cci_pmu_model cci_pmu_models[] = {
> +	[CCI_REV_R0] = {
> +		.name = "CCI_400",
> +		.event_ranges = {
> +			[CCI_IF_SLAVE] = {
> +				CCI_REV_R0_SLAVE_PORT_MIN_EV,
> +				CCI_REV_R0_SLAVE_PORT_MAX_EV,
> +			},
> +			[CCI_IF_MASTER] = {
> +				CCI_REV_R0_MASTER_PORT_MIN_EV,
> +				CCI_REV_R0_MASTER_PORT_MAX_EV,
> +			},
> +		},
> +	},
> +	[CCI_REV_R1] = {
> +		.name = "CCI_400_r1",
> +		.event_ranges = {
> +			[CCI_IF_SLAVE] = {
> +				CCI_REV_R1_SLAVE_PORT_MIN_EV,
> +				CCI_REV_R1_SLAVE_PORT_MAX_EV,
> +			},
> +			[CCI_IF_MASTER] = {
> +				CCI_REV_R1_MASTER_PORT_MIN_EV,
> +				CCI_REV_R1_MASTER_PORT_MAX_EV,
> +			},
> +		},
> +	},
> +};
> +
>  static const struct of_device_id arm_cci_pmu_matches[] = {
>  	{
>  		.compatible = "arm,cci-400-pmu",
> +		.data	= NULL,
> +	},
> +	{
> +		.compatible = "arm,cci-400-pmu,r0",
> +		.data	= &cci_pmu_models[CCI_REV_R0],
> +	},
> +	{
> +		.compatible = "arm,cci-400-pmu,r1",
> +		.data	= &cci_pmu_models[CCI_REV_R1],
>  	},
>  	{},
>  };
>  
> +static inline const struct cci_pmu_model *get_cci_model(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match = of_match_node(arm_cci_pmu_matches,
> +							pdev->dev.of_node);
> +	if (!match)
> +		return NULL;
> +	if (match->data)
> +		return match->data;
> +
> +	dev_warn(&pdev->dev, "DEPERCATED compatible property,"
> +			 "requires secure access to CCI registers");
> +	return probe_cci_model(pdev);
> +}
> +
>  static bool is_duplicate_irq(int irq, int *irqs, int nr_irqs)
>  {
>  	int i;
> @@ -884,11 +924,19 @@ static int cci_pmu_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
>  	int i, ret, irq;
> +	const struct cci_pmu_model *model;
> +
> +	model = get_cci_model(pdev);
> +	if (!model) {
> +		dev_warn(&pdev->dev, "CCI PMU version not supported\n");
> +		return -EINVAL;
> +	}
>  
>  	pmu = devm_kzalloc(&pdev->dev, sizeof(*pmu), GFP_KERNEL);
>  	if (!pmu)
>  		return -ENOMEM;
>  
> +	pmu->model = model;
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	pmu->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(pmu->base))
> @@ -920,12 +968,6 @@ static int cci_pmu_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	pmu->port_ranges = port_range_by_rev();
> -	if (!pmu->port_ranges) {
> -		dev_warn(&pdev->dev, "CCI PMU version not supported\n");
> -		return -EINVAL;
> -	}
> -
>  	raw_spin_lock_init(&pmu->hw_events.pmu_lock);
>  	mutex_init(&pmu->reserve_mutex);
>  	atomic_set(&pmu->active_events, 0);
> diff --git a/include/linux/arm-cci.h b/include/linux/arm-cci.h
> index 79d6edf..aede5c7 100644
> --- a/include/linux/arm-cci.h
> +++ b/include/linux/arm-cci.h
> @@ -24,6 +24,8 @@
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  
> +#include <asm/arm-cci.h>
> +
>  struct device_node;
>  
>  #ifdef CONFIG_ARM_CCI
> -- 
> 1.7.9.5
> 
> 
> 
