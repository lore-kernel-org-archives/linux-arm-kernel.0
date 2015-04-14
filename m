From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Apr 2015 17:29:53 +0100
Subject: [RFC PATCH 5/5] arm64: qcom: add cpu operations
In-Reply-To: <1428601031-5366-6-git-send-email-galak@codeaurora.org>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <1428601031-5366-6-git-send-email-galak@codeaurora.org>
Message-ID: <20150414162953.GL28709@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 8b9e0a9..35cabe5 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -185,6 +185,8 @@ nodes to be present and contain the properties described below.
>                           be one of:
>                              "psci"
>                              "spin-table"

In the case of these two, there's documentation on what the OS, FW, and
HW are expected to do. There's a PSCI spec, and spin-table is documented
in booting.txt (which is admittedly not fantastic).

> +                            "qcom,arm-cortex-acc"

However, this has no semantics associated with it. Per the code below
it seems to encompass more than just poking the APSS ACC, so the name
isn't great either.

[...]

> + * Based on arch/arm64/kernel/smp_spin_table.c

This is not a phrase that will ever make me happy.

[...]

> +static DEFINE_RAW_SPINLOCK(boot_lock);

We got rid of this for spin-table. It's pointless.

> +DEFINE_PER_CPU(int, cold_boot_done);

This looks suspicious.

> +#if 0
> +static int cold_boot_flags[] = {
> +       0,
> +       QCOM_SCM_FLAG_COLDBOOT_CPU1,
> +       QCOM_SCM_FLAG_COLDBOOT_CPU2,
> +       QCOM_SCM_FLAG_COLDBOOT_CPU3,
> +};
> +#endif

I take it this shouldn't be here?

[...]

> +static int power_on_l2_msm8916(struct device_node *l2ccc_node, u32 pon_mask,
> +                               int cpu)
> +{
> +       u32 pon_status;
> +       void __iomem *l2_base;
> +
> +       l2_base = of_iomap(l2ccc_node, 0);
> +       if (!l2_base)
> +               return -ENOMEM;

I didn't see any mention of an L2 requiring power-up in the rest of the
series...

[...]

> +static void write_pen_release(u64 val)
> +{
> +       void *start = (void *)&secondary_holding_pen_release;
> +       unsigned long size = sizeof(secondary_holding_pen_release);
> +
> +       secondary_holding_pen_release = val;
> +       smp_wmb();
> +       __flush_dcache_area(start, size);
> +}
> +
> +static int secondary_pen_release(unsigned int cpu)
> +{
> +       unsigned long timeout;
> +
> +       /*
> +        * Set synchronisation state between this boot processor
> +        * and the secondary one
> +        */
> +       raw_spin_lock(&boot_lock);
> +       write_pen_release(cpu_logical_map(cpu));
> +
> +       timeout = jiffies + (1 * HZ);
> +       while (time_before(jiffies, timeout)) {
> +               if (secondary_holding_pen_release == INVALID_HWID)
> +                       break;
> +               udelay(10);
> +       }
> +       raw_spin_unlock(&boot_lock);
> +
> +       return secondary_holding_pen_release != INVALID_HWID ? -ENOSYS : 0;
> +}

So you want to share the pen, but duplicate the code for managing it?

> +static int __init msm_cpu_init(struct device_node *dn, unsigned int cpu)
> +{
> +       /* Mark CPU0 cold boot flag as done */
> +       if (!cpu && !per_cpu(cold_boot_done, cpu))
> +               per_cpu(cold_boot_done, cpu) = true;
> +
> +       return 0;
> +}

[...]

> +static int msm_cpu_boot(unsigned int cpu)
> +{
> +       int ret = 0;
> +
> +       if (per_cpu(cold_boot_done, cpu) == false) {
> +               ret = msm_unclamp_secondary_arm_cpu(cpu);
> +               if (ret)
> +                       return ret;
> +               per_cpu(cold_boot_done, cpu) = true;
> +       }
> +       return secondary_pen_release(cpu);
> +}

Ah, so cold_boot_done is for pseudo-hotplug. Absolute NAK to that.

The only thing this gives you over spin-table is one-time powering up of
the CPUs that can be performed prior to entry to Linux. If you do that,
you can trivially share the spin-table code by setting each CPU's
enable-method to "spin-table".

That won't give you cpuidle or actual hotplug. For those you'll need
PSCI.

Mark.
