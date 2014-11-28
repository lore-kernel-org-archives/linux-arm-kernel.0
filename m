From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 28 Nov 2014 10:33:04 +0000
Subject: [PATCH v2 1/2] arm: ls1: add CPU hotplug platform support
In-Reply-To: <1416806890-26920-1-git-send-email-Zhuoyu.Zhang@freescale.com>
References: <1416806890-26920-1-git-send-email-Zhuoyu.Zhang@freescale.com>
Message-ID: <20141128103304.GA25883@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 05:28:09AM +0000, Zhuoyu Zhang wrote:
> From: Zhang Zhuoyu <Zhuoyu.Zhang@freescale.com>
> 
> This implements CPU hotplug for ls1. When cpu is down, it will be put
> in WFI state. When cpu is up, it will always soft reset and boots up
> the same path as a cold boot.
> 
> Signed-off-by: Zhang Zhuoyu <Zhuoyu.Zhang@freescale.com>
> ---
>  arch/arm/mach-imx/common.h  |   4 ++
>  arch/arm/mach-imx/hotplug.c |  25 +++++++++
>  arch/arm/mach-imx/platsmp.c | 132 +++++++++++++++++++++++++++++++++++++++-----
>  arch/arm/mach-imx/src.c     |  21 +++++++
>  4 files changed, 169 insertions(+), 13 deletions(-)
> 

[...]

> +
> +/*
> + * For LS102x platforms, shutdowning a CPU is not supported by hardware.
> + * So we just put the offline CPU into lower-power state here.
> + */
> +void __ref ls1021a_cpu_die(unsigned int cpu)
> +{
> +       v7_exit_coherency_flush(louis);
> +
> +       /* LS1021a platform can't really power down a CPU, so we
> +        * just put it into WFI state here.
> +        */
> +       wfi();
> +}
> +
> +int ls1021a_cpu_kill(unsigned int cpu)
> +{
> +       unsigned long timeout = jiffies + msecs_to_jiffies(50);
> +
> +       while (!ls1_get_cpu_arg(cpu))
> +               if (time_after(jiffies, timeout))
> +                       return 0;
> +       return 1;
> +}

While simpler than the last posting [1], this is still no better, and
Russell's comments [2] still apply, so this is still unacceptable.

If the CPU does not leave the kernel entirely, it is not CPU hotplug.
As this stands, this is completely incompatible with kexec and suspend.

[...]

> +static int ls1021a_reset_secondary(unsigned int cpu)
> +{
> +       u32 tmp;
> +
> +       if (!scfg_base || !dcfg_base)
> +               return -ENOMEM;
> +
> +       writel_relaxed(secondary_pre_boot_entry,
> +                       dcfg_base + DCFG_CCSR_SCRATCHRW1);
> +
> +       /* Apply LS1021A specific to write to the BE SCFG space */
> +       tmp = ioread32be(scfg_base + SCFG_REVCR);
> +       iowrite32be(0xffffffff, scfg_base + SCFG_REVCR);
> +
> +       /* Soft reset secondary core */
> +       iowrite32be(0x80000000, scfg_base + SCFG_CORESRENCR);
> +       iowrite32be(0x80000000, scfg_base +
> +                               SCFG_CORE0_SFT_RST + STRIDE_4B * cpu);
> +
> +       /* Release secondary core */
> +       iowrite32be(1 << cpu, dcfg_base + DCFG_CCSR_BRR);
> +
> +       ls1021a_set_secondary_entry();
> +
> +       /* Disable core soft reset register */
> +       iowrite32be(0x0, scfg_base + SCFG_CORESRENCR);
> +
> +       /* Revert back to the default */
> +       iowrite32be(tmp, scfg_base + SCFG_REVCR);
> +
> +       return 0;
> +}
> +
> +static int ls1021a_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +       int ret = 0;
> +
> +       if (system_state == SYSTEM_RUNNING)
> +               ret = ls1021a_reset_secondary(cpu);
> +
> +       udelay(1);
> +
> +       arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> +
> +       return ret;
> +}

How does this interact with the pseudo-hotplug above?

Mark.
