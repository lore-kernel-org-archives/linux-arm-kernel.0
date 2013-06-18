From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 18 Jun 2013 00:25:22 -0400 (EDT)
Subject: [RFC PATCH v4 2/2] drivers: mfd: vexpress: add Serial Power
 Controller (SPC) support
In-Reply-To: <1371484269-11743-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1371484269-11743-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1371484269-11743-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.03.1306180001410.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Jun 2013, Lorenzo Pieralisi wrote:

> The TC2 versatile express core tile integrates a logic block that provides the
> interface between the dual cluster test-chip and the M3 microcontroller that
> carries out power management. The logic block, called Serial Power Controller
> (SPC), contains several memory mapped registers to control among other things
> low-power states, operating points and reset control.

[...]

I slightly modified the following before committing this patch to my TC2 
branch:

> +/**
> + * ve_spc_cpu_wakeup_irq()
> + *
> + * Function to set/clear per-CPU wake-up IRQs. Not protected by locking since
> + * it might be used in code paths where normal cacheable locks are not
> + * working. Locking must be provided by the caller to ensure atomicity.
> + *
> + * @cpu: mpidr[7:0] bitfield describing cpu affinity level
> + * @cluster: mpidr[15:8] bitfield describing cluster affinity level
> + * @set: if true, wake-up IRQs are set, if false they are cleared
> + */
> +void ve_spc_cpu_wakeup_irq(u32 cpu, u32 cluster, bool set)
> +{

I made cluster first then cpu.  All the other functions have the cluster 
argument first, and ve_spc_set_resume_addr() already uses that order.

[...]
> +#ifdef CONFIG_VEXPRESS_SPC
> +int ve_spc_probe(void);
> +int ve_spc_get_freq(u32 cluster);
> +int ve_spc_set_freq(u32 cluster, u32 freq);
> +int ve_spc_get_freq_table(u32 cluster, const u32 **fptr);
> +void ve_spc_global_wakeup_irq(bool set);
> +void ve_spc_cpu_wakeup_irq(u32 cpu, u32 cluster, bool set);
> +void ve_spc_set_resume_addr(u32 cluster, u32 cpu, u32 addr);
> +u32 ve_spc_get_nr_cpus(u32 cluster);
> +void ve_spc_powerdown(u32 cluster, bool enable);
> +#else
> +static inline bool ve_spc_probe(void) { return -ENODEV; }

s/bool/int/


Nicolas
