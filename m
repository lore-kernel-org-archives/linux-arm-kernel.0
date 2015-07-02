From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 2 Jul 2015 14:31:40 +0100
Subject: [RESEND PATCH 4.0-rc7 v20 3/6] irqchip: gic: Introduce plumbing
 for IPI FIQ
In-Reply-To: <20150422103841.GC27345@leverpostej>
References: <1427216014-5324-1-git-send-email-daniel.thompson@linaro.org>
 <1428659511-9590-1-git-send-email-daniel.thompson@linaro.org>
 <1428659511-9590-4-git-send-email-daniel.thompson@linaro.org>
 <20150421145007.GB10164@leverpostej> <5536BDE8.2030403@linaro.org>
 <20150422103841.GC27345@leverpostej>
Message-ID: <55953D3C.9080800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/04/15 11:38, Mark Rutland wrote:
>>> I just gave this a spin on my (non-MCPM) TC2, and secondaries don't come
>>> up:
>>>
>>> CPU1: failed to boot: -38
>>> CPU2: failed to boot: -38
>>> CPU3: failed to boot: -38
>>> CPU4: failed to boot: -38
>>> Brought up 1 CPUs
>>> SMP: Total of 1 processors activated (48.00 BogoMIPS).
>>>
>>> I tried investigating with a debugger. The unbooted CPUs look to be
>>> stuck at the FW's spin loop, but the text doesn't look right (I see a
>>> load of ADDEQ r0, r0, r0, #LSL 1 where there was previously a WFI loop).
>>> That could be a bug with my debugger though.
>>>
>>> If I pause the CPUs at the right point, they sometimes enter the kernel
>>> successfully. I don't have a good explanation for that.
>>>
>>> [...]
>>
>> Rats!
>>
>> I presume it is patch 3 that causes the regression? Patch 3 is the one
>> that causes the GIC to adopt a different configuration if it find the
>> kernel running in secure world (it sets all interrupts to group 1 and
>> routes group 0 to FIQ).
>>
>> I only ask because it isn't until patch 6 that we actually place any
>> interrupt sources into group 0.
>
> Patch 3 appears to be to blame. I see the issue with patches 1-3 alone
> applied atop of v4.0. With patch 3 reverted secondaries come up as
> expected.

So I'm back looking at this after a bit of a break.

The problem is almost certainly due to mismanaging the NSATT bit within 
GICD_SGIR. Specifically we must use a different value for NSATT before a CPU is 
booted for the first time because that CPU will not have setup its banked copy 
of IGROUP[0] yet.

I have played with a couple of fixes but I think the simplest
is to detect if we are running from secure mode and, if we are, to write
to GICD_SGIR twice (once without NSATT, once with).

Note that we do have to detect ourselves to be running from secure mode before 
trying the double-write approach. If we were running from non-secure mode then 
the double write could risk two IPIs being generated.

Anyhow the main benefit of this approach is that it is stateless so we don't 
have to do any state tracking (which I think would require using rwlocks).

I plan to react to the outstanding review comments and roll the fix into the 
existing patches but, for clarity, here are the fixes that I think are needed to 
solve the TC2 boot problems. I have tested both from secure and non-secure modes 
but have not been able to test on TC2.

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4f9e4296438c..a7d721e43db6 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -73,6 +73,7 @@ struct gic_chip_data {
  	struct irq_domain *domain;
  	unsigned int gic_irqs;
  	u32 igroup0_shadow;
+	bool sgi_with_nsatt;
  #ifdef CONFIG_GIC_NON_BANKED
  	void __iomem *(*get_base)(union gic_base *);
  #endif
@@ -512,16 +513,27 @@ static void __init gic_dist_init(struct gic_chip_data
  	writel_relaxed(GICD_ENABLE_GRP1 | GICD_ENABLE, base + GIC_DIST_CTRL);

  	/*
-	 * Set all global interrupts to be group 1 if (and only if) it
-	 * is possible to enable group 1 interrupts. This register is RAZ/WI
-	 * if not accessible or not implemented, however some GICv1 devices
-	 * do not implement the EnableGrp1 bit making it unsafe to set
-	 * this register unconditionally.
+	 * Some GICv1 devices (even those with security extensions) do not
+	 * implement EnableGrp1 meaning some parts of the above write might
+	 * be ignored. We will only enable FIQ support if the bit can be set.
  	 */
-	if (GICD_ENABLE_GRP1 & readl_relaxed(base + GIC_DIST_CTRL))
+	if (GICD_ENABLE_GRP1 & readl_relaxed(base + GIC_DIST_CTRL)) {
+		/*
+		 * Set all global interrupts to be group 1 (signalled with
+		 * IRQ).
+		 */
  		for (i = 32; i < gic_irqs; i += 32)
  			writel_relaxed(0xffffffff,
  				       base + GIC_DIST_IGROUP + i * 4 / 32);
+
+		/*
+		 * If the GIC supports the security extension then SGIs
+		 * will be filtered based on the value of NSATT. If the
+		 * GIC has this support then enable NSATT support.
+		 */
+		if (GICD_SECURITY_EXTN & readl_relaxed(base + GIC_DIST_CTR))
+			gic->sgi_with_nsatt = true;
+	}
  }

  static void gic_cpu_init(struct gic_chip_data *gic)
@@ -782,6 +794,7 @@ static void gic_raise_softirq(const struct cpumask *mask,
  	int cpu;
  	unsigned long map = 0;
  	unsigned long softint;
+	void __iomem *dist_base;

  	gic_migration_lock();

@@ -789,20 +802,20 @@ static void gic_raise_softirq(const struct cpumask *mask,
  	for_each_cpu(cpu, mask)
  		map |= gic_cpu_map[cpu];

+	/* This always happens on GIC0 */
+	dist_base = gic_data_dist_base(&gic_data[0]);
+
  	/*
  	 * Ensure that stores to Normal memory are visible to the
  	 * other CPUs before they observe us issuing the IPI.
  	 */
  	dmb(ishst);

-	/* We avoid a readl here by using the shadow copy of IGROUP[0] */
  	softint = map << 16 | irq;
-	if (gic_data[0].igroup0_shadow & BIT(irq))
-		softint |= 0x8000;

-	/* This always happens on GIC0 */
-	writel_relaxed(softint,
-		       gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
+	writel_relaxed(softint, dist_base + GIC_DIST_SOFTINT);
+	if (gic_data[0].sgi_with_nsatt)
+		writel_relaxed(softint | 0x8000, dist_base + GIC_DIST_SOFTINT);

  	gic_migration_unlock();
  }
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 361dddfe205a..22cf475e1deb 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -50,6 +50,7 @@
  #define GICD_ENABLE			0x1
  #define GICD_ENABLE_GRP1		0x2
  #define GICD_DISABLE			0x0
+#define GICD_SECURITY_EXTN		0x400
  #define GICD_INT_ACTLOW_LVLTRIG		0x0
  #define GICD_INT_EN_CLR_X32		0xffffffff
  #define GICD_INT_EN_SET_SGI		0x0000ffff
--

Daniel.
