From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 01 Dec 2014 18:14:34 +0100
Subject: [PATCH] ARM: imx: irq: fix buggy usage of irq_data irq field
In-Reply-To: <547C9F58.5070903@arm.com>
References: <1417451109-30276-1-git-send-email-marc.zyngier@arm.com>
 <CAOMZO5DoR57Afc3SH-gV3-dZkHvBab1LXKCWDajpf_sRDKpzSw@mail.gmail.com>
 <547C9F58.5070903@arm.com>
Message-ID: <1417454074.4624.28.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 01.12.2014, 17:03 +0000 schrieb Marc Zyngier:
> On 01/12/14 17:00, Fabio Estevam wrote:
> > Hi Marc,
> > 
> > On Mon, Dec 1, 2014 at 2:25 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >> mach-imx directly references to the irq field in
> >> struct irq_data, and uses this to directly poke hardware register.
> >>
> >> But irq is the *virtual* irq number, something that has nothing
> >> to do with the actual HW irq (stored in the hwirq field). And once
> >> we put the stacked domain code in action, the whole thing explodes,
> >> as these two values are *very* different.
> >>
> >> Just replacing all instances of irq with hwirq fixes the issue.
> >>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > I tested your patch and I still have the following problem on a mx6q:
> 
> [...]
> 
> > This issue does not happen on linux-next 20141126, but it stats at 201411267.
> > 
> > I haven't bisect it yet, but if you have any ideas, please let me know. Thanks
> 
> I do have an idea indeed, as well as a patch for this. I'll put you on
> Cc, watch that space.

I've just arrived att his workaround for the issue by just directly
going to hwirq 32, please put me on Cc, too.

regards
Philipp

---8<---
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 59ce8f3..53c31d1 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -13,7 +13,6 @@
 
 #include <linux/reboot.h>
 
-struct irq_data;
 struct platform_device;
 struct pt_regs;
 struct clk;
@@ -107,8 +106,8 @@ void imx_gpc_pre_suspend(bool arm_power_off);
 void imx_gpc_post_resume(void);
 void imx_gpc_mask_all(void);
 void imx_gpc_restore_all(void);
-void imx_gpc_irq_mask(struct irq_data *d);
-void imx_gpc_irq_unmask(struct irq_data *d);
+void imx_gpc_irq_mask(unsigned int hwirq);
+void imx_gpc_irq_unmask(unsigned int hwirq);
 void imx_anatop_init(void);
 void imx_anatop_pre_suspend(void);
 void imx_anatop_post_resume(void);
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 1455829..e927e00 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -91,34 +91,44 @@ void imx_gpc_restore_all(void)
 		writel_relaxed(gpc_saved_imrs[i], reg_imr1 + i * 4);
 }
 
-void imx_gpc_irq_unmask(struct irq_data *d)
+void imx_gpc_irq_unmask(unsigned int hwirq)
 {
 	void __iomem *reg;
 	u32 val;
 
+	reg = gpc_base + GPC_IMR1 + (hwirq / 32 - 1) * 4;
+	val = readl_relaxed(reg);
+	val &= ~(1 << hwirq % 32);
+	writel_relaxed(val, reg);
+}
+
+static void gpc_irq_unmask(struct irq_data *d)
+{
 	/* Sanity check for SPI irq */
 	if (d->hwirq < 32)
 		return;
 
-	reg = gpc_base + GPC_IMR1 + (d->hwirq / 32 - 1) * 4;
-	val = readl_relaxed(reg);
-	val &= ~(1 << d->hwirq % 32);
-	writel_relaxed(val, reg);
+	imx_gpc_irq_unmask(d->hwirq);
 }
 
-void imx_gpc_irq_mask(struct irq_data *d)
+void imx_gpc_irq_mask(unsigned int hwirq)
 {
 	void __iomem *reg;
 	u32 val;
 
+	reg = gpc_base + GPC_IMR1 + (hwirq / 32 - 1) * 4;
+	val = readl_relaxed(reg);
+	val |= 1 << (hwirq % 32);
+	writel_relaxed(val, reg);
+}
+
+static void gpc_irq_mask(struct irq_data *d)
+{
 	/* Sanity check for SPI irq */
 	if (d->hwirq < 32)
 		return;
 
-	reg = gpc_base + GPC_IMR1 + (d->hwirq / 32 - 1) * 4;
-	val = readl_relaxed(reg);
-	val |= 1 << (d->hwirq % 32);
-	writel_relaxed(val, reg);
+	imx_gpc_irq_mask(d->hwirq);
 }
 
 void __init imx_gpc_init(void)
@@ -135,7 +145,7 @@ void __init imx_gpc_init(void)
 		writel_relaxed(~0, gpc_base + GPC_IMR1 + i * 4);
 
 	/* Register GPC as the secondary interrupt controller behind GIC */
-	gic_arch_extn.irq_mask = imx_gpc_irq_mask;
-	gic_arch_extn.irq_unmask = imx_gpc_irq_unmask;
+	gic_arch_extn.irq_mask = gpc_irq_mask;
+	gic_arch_extn.irq_unmask = gpc_irq_unmask;
 	gic_arch_extn.irq_set_wake = imx_gpc_irq_set_wake;
 }
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index c653dd4..0046a5c 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -257,7 +257,6 @@ static void imx6q_enable_wb(bool enable)
 
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 {
-	struct irq_data *iomuxc_irq_data = irq_get_irq_data(32);
 	u32 val = readl_relaxed(ccm_base + CLPCR);
 
 	val &= ~BM_CLPCR_LPM;
@@ -312,9 +311,9 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 	 * 3) Software should mask IRQ #32 right after CCM Low-Power mode
 	 *    is set (set bits 0-1 of CCM_CLPCR).
 	 */
-	imx_gpc_irq_unmask(iomuxc_irq_data);
+	imx_gpc_irq_unmask(32);
 	writel_relaxed(val, ccm_base + CLPCR);
-	imx_gpc_irq_mask(iomuxc_irq_data);
+	imx_gpc_irq_mask(32);
 
 	return 0;
 }
