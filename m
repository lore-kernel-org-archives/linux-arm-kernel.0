From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 29 Apr 2015 16:42:31 +0100
Subject: [PATCH v5 2/2] firmware: qcom: scm: Add support for ARM64 SoCs
In-Reply-To: <1430249038-30987-2-git-send-email-galak@codeaurora.org>
References: <1430249038-30987-1-git-send-email-galak@codeaurora.org>
 <1430249038-30987-2-git-send-email-galak@codeaurora.org>
Message-ID: <20150429154231.GB8781@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kumar,

On Tue, Apr 28, 2015 at 08:23:58PM +0100, Kumar Gala wrote:
> Add an implementation of the SCM interface that works on ARM64/64-bit SoCs

What is the intended use of this on arm64 SoCs?

Given the negative reaction to the SMP bringup [1] code that seems to be
the only user, I'm somewhat confused as to why this is being pushed as a
non-RFC in the mean time.

Are there other users of this interface code? If so, could you please
mention that in the commit message. I'd also ask that you would Cc me on
future postings of this series.

[...]

> +static int qcom_scm_set_boot_addr(void *entry, const cpumask_t *cpus, int flags)
> +{
> +       struct qcom_scm_desc desc = {0};
> +       unsigned int cpu = cpumask_first(cpus);
> +       u64 mpidr_el1 = cpu_logical_map(cpu);
> +
> +       /* For now we assume only a single cpu is set in the mask */
> +       WARN_ON(cpumask_weight(cpus) != 1);
> +
> +       if (mpidr_el1 & ~MPIDR_HWID_BITMASK) {
> +               pr_err("CPU%d:Failed to set boot address\n", cpu);
> +               return -ENOSYS;
> +       }
> +
> +       desc.args[0] = virt_to_phys(entry);
> +       desc.args[1] = BIT(MPIDR_AFFINITY_LEVEL(mpidr_el1, 0));
> +       desc.args[2] = BIT(MPIDR_AFFINITY_LEVEL(mpidr_el1, 1));
> +       desc.args[3] = BIT(MPIDR_AFFINITY_LEVEL(mpidr_el1, 2));
> +       desc.args[4] = ~0ULL;
> +       desc.args[5] = QCOM_SCM_FLAG_HLOS | flags;
> +       desc.arginfo = QCOM_SCM_ARGS(6);
> +
> +       return qcom_scm_call(QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_ADDR_MC, &desc);
> +}
> +
> +int __qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
> +{
> +       int flags = QCOM_SCM_FLAG_COLDBOOT_MC;
> +
> +       return qcom_scm_set_boot_addr(entry, cpus, flags);
> +}
> +
> +int __qcom_scm_set_warm_boot_addr(void *entry, const cpumask_t *cpus)
> +{
> +       int flags = QCOM_SCM_FLAG_WARMBOOT_MC;
> +
> +       return qcom_scm_set_boot_addr(entry, cpus, flags);
> +}
> +
> +void __qcom_scm_cpu_power_down(u32 flags)
> +{
> +       struct qcom_scm_desc desc = {0};
> +       desc.args[0] = flags & QCOM_SCM_FLUSH_FLAG_MASK;
> +       desc.arginfo = QCOM_SCM_ARGS(1);
> +
> +       qcom_scm_call_atomic(QCOM_SCM_SVC_BOOT, QCOM_SCM_CMD_TERMINATE_PC, &desc);
> +}

As mentioned in the other thread, I don't want to see this for arm64,
and must NAK this portion.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/336534.html
