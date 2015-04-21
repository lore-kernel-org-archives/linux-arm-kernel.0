From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Apr 2015 15:50:14 +0100
Subject: [RESEND PATCH 4.0-rc7 v20 3/6] irqchip: gic: Introduce plumbing
 for IPI FIQ
In-Reply-To: <1428659511-9590-4-git-send-email-daniel.thompson@linaro.org>
References: <1427216014-5324-1-git-send-email-daniel.thompson@linaro.org>
 <1428659511-9590-1-git-send-email-daniel.thompson@linaro.org>
 <1428659511-9590-4-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150421145007.GB10164@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Apr 10, 2015 at 10:51:48AM +0100, Daniel Thompson wrote:
> Currently it is not possible to exploit FIQ for systems with a GIC, even if
> the systems are otherwise capable of it. This patch makes it possible
> for IPIs to be delivered using FIQ.
> 
> To do so it modifies the register state so that normal interrupts are
> placed in group 1 and specific IPIs are placed into group 0. It also
> configures the controller to raise group 0 interrupts using the FIQ
> signal. It provides a means for architecture code to define which IPIs
> shall use FIQ and to acknowledge any IPIs that are raised.
> 
> All GIC hardware except GICv1-without-TrustZone support provides a means
> to group exceptions into group 0 and group 1 but the hardware
> functionality is unavailable to the kernel when a secure monitor is
> present because access to the grouping registers are prohibited outside
> "secure world". However when grouping is not available (or in the case
> of early GICv1 implementations is very hard to configure) the code to
> change groups does not deploy and all IPIs will be raised via IRQ.
> 
> It has been tested and shown working on two systems capable of
> supporting grouping (Freescale i.MX6 and STiH416). It has also been
> tested for boot regressions on two systems that do not support grouping
> (vexpress-a9 and Qualcomm Snapdragon 600).

I just gave this a spin on my (non-MCPM) TC2, and secondaries don't come
up:

CPU1: failed to boot: -38
CPU2: failed to boot: -38
CPU3: failed to boot: -38
CPU4: failed to boot: -38
Brought up 1 CPUs
SMP: Total of 1 processors activated (48.00 BogoMIPS).

I tried investigating with a debugger. The unbooted CPUs look to be
stuck at the FW's spin loop, but the text doesn't look right (I see a
load of ADDEQ r0, r0, r0, #LSL 1 where there was previously a WFI loop).
That could be a bug with my debugger though.

If I pause the CPUs at the right point, they sometimes enter the kernel
successfully. I don't have a good explanation for that.

[...]

> @@ -427,6 +535,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>         void __iomem *base = gic_data_cpu_base(gic);
>         unsigned int cpu_mask, cpu = smp_processor_id();
>         int i;
> +       unsigned long secure_irqs, secure_irq;

I think secure_irq(s) is a misnomer here. It's just a mask of FIQ bits.

> 
>         /*
>          * Get what the GIC says our CPU mask is.
> @@ -445,6 +554,20 @@ static void gic_cpu_init(struct gic_chip_data *gic)
> 
>         gic_cpu_config(dist_base, NULL);
> 
> +       /*
> +        * If the distributor is configured to support interrupt grouping
> +        * then set any PPI and SGI interrupts not set in SMP_IPI_FIQ_MASK
> +        * to be group1 and ensure any remaining group 0 interrupts have
> +        * the right priority.
> +        */
> +       if (GICD_ENABLE_GRP1 & readl_relaxed(dist_base + GIC_DIST_CTRL)) {
> +               secure_irqs = SMP_IPI_FIQ_MASK;
> +               writel_relaxed(~secure_irqs, dist_base + GIC_DIST_IGROUP + 0);
> +               gic->igroup0_shadow = ~secure_irqs;
> +               for_each_set_bit(secure_irq, &secure_irqs, 16)
> +                       gic_set_group_irq(gic, secure_irq, 0);
> +       }

This only pokes GICD registers. Why isn't this in gic_dist_init?

Mark.
