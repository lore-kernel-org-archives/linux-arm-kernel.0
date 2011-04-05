From: will.deacon@arm.com (Will Deacon)
Date: Tue, 05 Apr 2011 13:48:17 +0100
Subject: [PATCH 6/6] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <BANLkTimJwCkabdEhQ89NgEaWyYaX6kSgUQ@mail.gmail.com>
References: <1301669441-13744-1-git-send-email-will.deacon@arm.com>
	<1301669441-13744-7-git-send-email-will.deacon@arm.com>
	<BANLkTi=xeCaF4HwOsEnqCzkiywPu6R0XbA@mail.gmail.com>
	<BANLkTimJwCkabdEhQ89NgEaWyYaX6kSgUQ@mail.gmail.com>
Message-ID: <1302007697.23044.35.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,

On Sun, 2011-04-03 at 04:27 +0100, Colin Cross wrote:
> In further testing I found one bug.  d7ed36a added gic_arch_extn,
> which needs to be used in gic_eoi.   arch/arm/mach-tegra/irq.c will
> need to be fixed to replace tegra_ack with tegra_eoi, and any other
> platform that uses gic_arch_extn also needs to be checked (omap4?).

Is something like the following correct for updating mach-tegra/irq.c?


diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index 4330d89..2424a3b 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -48,7 +48,7 @@ static u32 tegra_lp0_wake_level_any;
 
 static void (*tegra_gic_mask_irq)(struct irq_data *d);
 static void (*tegra_gic_unmask_irq)(struct irq_data *d);
-static void (*tegra_gic_ack_irq)(struct irq_data *d);
+static void (*tegra_gic_eoi_irq)(struct irq_data *d);
 
 /* ensures that sufficient time is passed for a register write to
  * serialize into the 32KHz domain */
@@ -113,10 +113,10 @@ static void tegra_unmask(struct irq_data *d)
        tegra_legacy_unmask_irq(d->irq);
 }
 
-static void tegra_ack(struct irq_data *d)
+static void tegra_eoi(struct irq_data *d)
 {
        tegra_legacy_force_irq_clr(d->irq);
-       tegra_gic_ack_irq(d);
+       tegra_gic_eoi_irq(d);
 }
 
 static int tegra_retrigger(struct irq_data *d)
@@ -127,7 +127,7 @@ static int tegra_retrigger(struct irq_data *d)
 
 static struct irq_chip tegra_irq = {
        .name                   = "PPI",
-       .irq_ack                = tegra_ack,
+       .irq_eoi                = tegra_eoi,
        .irq_mask               = tegra_mask,
        .irq_unmask             = tegra_unmask,
        .irq_retrigger          = tegra_retrigger,
@@ -147,14 +147,14 @@ void __init tegra_init_irq(void)
        gic = irq_get_chip(29);
        tegra_gic_unmask_irq = gic->irq_unmask;
        tegra_gic_mask_irq = gic->irq_mask;
-       tegra_gic_ack_irq = gic->irq_ack;
+       tegra_gic_eoi_irq = gic->irq_eoi;
 #ifdef CONFIG_SMP
        tegra_irq.irq_set_affinity = gic->irq_set_affinity;
 #endif
 
        for (i = 0; i < INT_MAIN_NR; i++) {
                irq = INT_PRI_BASE + i;
-               irq_set_chip_and_handler(irq, &tegra_irq, handle_level_irq);
+               irq_set_chip_and_handler(irq, &tegra_irq, handle_fasteoi_irq);
                set_irq_flags(irq, IRQF_VALID);
        }
 }


I'm not 100% about the ordering in tegra_eoi, so I left it alone.

As it stands, this will be a pain to merge because the GIC code may be
out-of-sync with mach-tegra and we could get the flow control type
wrong. Any thoughts about how to resolve that? One [ugly] option is to
check the gic->irq_eoi pointer and choose the flow type based on that,
leaving the irq_ack pointer intact. This could be removed once the GIC
changes are in mainline.

Cheers,

Will
