From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 7 Jan 2016 13:48:57 +0000
Subject: [PATCH v8 07/20] KVM: ARM64: PMU: Add perf event map and
 introduce perf event creating function
In-Reply-To: <1450771695-11948-8-git-send-email-zhaoshenglong@huawei.com>
References: <1450771695-11948-1-git-send-email-zhaoshenglong@huawei.com>
 <1450771695-11948-8-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160107134857.2c18d752@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Dec 2015 16:08:02 +0800
Shannon Zhao <zhaoshenglong@huawei.com> wrote:

> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> When we use tools like perf on host, perf passes the event type and the
> id of this event type category to kernel, then kernel will map them to
> hardware event number and write this number to PMU PMEVTYPER<n>_EL0
> register. When getting the event number in KVM, directly use raw event
> type to create a perf_event for it.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  arch/arm64/include/asm/pmu.h |   3 ++
>  arch/arm64/kvm/Makefile      |   1 +
>  include/kvm/arm_pmu.h        |  11 ++++
>  virt/kvm/arm/pmu.c           | 122 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 137 insertions(+)
>  create mode 100644 virt/kvm/arm/pmu.c
> 
> diff --git a/arch/arm64/include/asm/pmu.h b/arch/arm64/include/asm/pmu.h
> index 4406184..2588f9c 100644
> --- a/arch/arm64/include/asm/pmu.h
> +++ b/arch/arm64/include/asm/pmu.h
> @@ -21,6 +21,7 @@
>  
>  #define ARMV8_MAX_COUNTERS      32
>  #define ARMV8_COUNTER_MASK      (ARMV8_MAX_COUNTERS - 1)
> +#define ARMV8_CYCLE_IDX         (ARMV8_MAX_COUNTERS - 1)
>  
>  /*
>   * Per-CPU PMCR: config reg
> @@ -31,6 +32,8 @@
>  #define ARMV8_PMCR_D		(1 << 3) /* CCNT counts every 64th cpu cycle */
>  #define ARMV8_PMCR_X		(1 << 4) /* Export to ETM */
>  #define ARMV8_PMCR_DP		(1 << 5) /* Disable CCNT if non-invasive debug*/
> +/* Determines which PMCCNTR_EL0 bit generates an overflow */
> +#define ARMV8_PMCR_LC		(1 << 6)
>  #define	ARMV8_PMCR_N_SHIFT	11	 /* Number of counters supported */
>  #define	ARMV8_PMCR_N_MASK	0x1f
>  #define	ARMV8_PMCR_MASK		0x3f	 /* Mask for writable bits */
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index caee9ee..122cff4 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -26,3 +26,4 @@ kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/vgic-v2-emul.o
>  kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/vgic-v3.o
>  kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/vgic-v3-emul.o
>  kvm-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/arch_timer.o
> +kvm-$(CONFIG_KVM_ARM_PMU) += $(KVM)/arm/pmu.o
> diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> index ddcb5b2..14bedb0 100644
> --- a/include/kvm/arm_pmu.h
> +++ b/include/kvm/arm_pmu.h
> @@ -34,9 +34,20 @@ struct kvm_pmu {
>  	int irq_num;
>  	struct kvm_pmc pmc[ARMV8_MAX_COUNTERS];
>  };
> +
> +u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx);
> +void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
> +				    u64 select_idx);
>  #else
>  struct kvm_pmu {
>  };
> +
> +u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
> +{
> +	return 0;
> +}
> +void kvm_pmu_set_counter_event_type(struct kvm_vcpu *vcpu, u64 data,
> +				    u64 select_idx) {}
>  #endif
>  
>  #endif
> diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
> new file mode 100644
> index 0000000..9d27999
> --- /dev/null
> +++ b/virt/kvm/arm/pmu.c
> @@ -0,0 +1,122 @@
> +/*
> + * Copyright (C) 2015 Linaro Ltd.
> + * Author: Shannon Zhao <shannon.zhao@linaro.org>
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
> +#include <linux/cpu.h>
> +#include <linux/kvm.h>
> +#include <linux/kvm_host.h>
> +#include <linux/perf_event.h>
> +#include <asm/kvm_emulate.h>
> +#include <kvm/arm_pmu.h>
> +
> +/**
> + * kvm_pmu_get_counter_value - get PMU counter value
> + * @vcpu: The vcpu pointer
> + * @select_idx: The counter index
> + */
> +u64 kvm_pmu_get_counter_value(struct kvm_vcpu *vcpu, u64 select_idx)
> +{
> +	u64 counter, reg, enabled, running;
> +	struct kvm_pmu *pmu = &vcpu->arch.pmu;
> +	struct kvm_pmc *pmc = &pmu->pmc[select_idx];
> +
> +	reg = (select_idx == ARMV8_CYCLE_IDX)
> +	      ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + select_idx;
> +	counter = vcpu_sys_reg(vcpu, reg);
> +
> +	/* The real counter value is equal to the value of counter register plus
> +	 * the value perf event counts.
> +	 */
> +	if (pmc->perf_event)
> +		counter += perf_event_read_value(pmc->perf_event, &enabled,
> +						 &running);
> +
> +	return counter & pmc->bitmask;
> +}
> +
> +/**
> + * kvm_pmu_stop_counter - stop PMU counter
> + * @pmc: The PMU counter pointer
> + *
> + * If this counter has been configured to monitor some event, release it here.
> + */
> +static void kvm_pmu_stop_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc)
> +{
> +	u64 counter, reg;
> +
> +	if (pmc->perf_event) {
> +		counter = kvm_pmu_get_counter_value(vcpu, pmc->idx);
> +		reg = (pmc->idx == ARMV8_CYCLE_IDX)
> +		       ? PMCCNTR_EL0 : PMEVCNTR0_EL0 + pmc->idx;
> +		vcpu_sys_reg(vcpu, reg) = counter;
> +		perf_event_release_kernel(pmc->perf_event);

I'm having second thoughts about this one. Don't you need to first
disable the event? You seem to be doing it on the destroy path, and it
worries me that we're not doing the same thing on both paths.

Thoughts?

	M.
-- 
Jazz is not dead. It just smells funny.
