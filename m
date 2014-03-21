From: balbi@ti.com (Felipe Balbi)
Date: Fri, 21 Mar 2014 00:52:42 -0500
Subject: [PATCH] ARM: dts: am437x-gp-evm: Do not reset gpio5
In-Reply-To: <1395379213-15451-1-git-send-email-lokeshvutla@ti.com>
References: <1395379213-15451-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <20140321055242.GA1959@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 10:50:13AM +0530, Lokesh Vutla wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Do not reset GPIO5 at boot-up because GPIO5_7 is used
> on AM437x GP-EVM to control VTT regulators on DDR3.
> Without this some GP-EVM boards will fail to boot because
> of DDR3 corruption.
> 
> Reported-by: Nishanth Menon <nm@ti.com>
> Tested-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>

every now and again we see a patch like this because yet another board
is using a GPIO to toggle DDR regulators.

Instead of constantly patching things like this, how about we try
something like below (build-tested only):

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 1f33f5d..f5962ff 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2610,6 +2610,10 @@ static int __init _setup_reset(struct omap_hwmod *oh)
 	if (oh->flags & HWMOD_EXT_OPT_MAIN_CLK)
 		return -EPERM;
 
+	/* NEVER reset GPIO blocks */
+	if (strncmp(oh->name, "gpio", 4) == 0)
+		return 0;
+
 	if (oh->rst_lines_cnt == 0) {
 		r = _enable(oh);
 		if (r) {
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 4243190..ce8b53a 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1130,6 +1130,29 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 
 static const struct of_device_id omap_gpio_match[];
 
+static void omap_gpio_init_context(struct gpio_bank *p)
+{
+	struct omap_gpio_reg_offs *regs = p->regs;
+	void __iomem *base = p->base;
+
+	p->context.ctrl		= readl_relaxed(base + regs->ctrl);
+	p->context.oe		= readl_relaxed(base + regs->direction);
+	p->context.wake_en	= readl_relaxed(base + regs->wkup_en);
+	p->context.leveldetect0	= readl_relaxed(base + regs->leveldetect0);
+	p->context.leveldetect1	= readl_relaxed(base + regs->leveldetect1);
+	p->context.risingdetect	= readl_relaxed(base + regs->risingdetect);
+	p->context.fallingdetect = readl_relaxed(base + regs->fallingdetect);
+	p->context.irqenable1	= readl_relaxed(base + regs->irqenable);
+	p->context.irqenable2	= readl_relaxed(base + regs->irqenable2);
+
+	if (regs->set_dataout && p->regs->clr_dataout)
+		p->context.dataout = readl_relaxed(base + regs->set_dataout);
+	else
+		p->context.dataout = readl_relaxed(base + regs->dataout);
+
+	p->context_valid = true;
+}
+
 static int omap_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1246,6 +1269,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	omap_gpio_mod_init(bank);
 	omap_gpio_chip_init(bank);
 	omap_gpio_show_rev(bank);
+	omap_gpio_init_context(bank);
 
 	pm_runtime_put(bank->dev);
 
@@ -1325,8 +1349,6 @@ update_gpio_context_count:
 	return 0;
 }
 
-static void omap_gpio_init_context(struct gpio_bank *p);
-
 static int omap_gpio_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -1466,29 +1488,6 @@ void omap2_gpio_resume_after_idle(void)
 }
 
 #if defined(CONFIG_PM_RUNTIME)
-static void omap_gpio_init_context(struct gpio_bank *p)
-{
-	struct omap_gpio_reg_offs *regs = p->regs;
-	void __iomem *base = p->base;
-
-	p->context.ctrl		= readl_relaxed(base + regs->ctrl);
-	p->context.oe		= readl_relaxed(base + regs->direction);
-	p->context.wake_en	= readl_relaxed(base + regs->wkup_en);
-	p->context.leveldetect0	= readl_relaxed(base + regs->leveldetect0);
-	p->context.leveldetect1	= readl_relaxed(base + regs->leveldetect1);
-	p->context.risingdetect	= readl_relaxed(base + regs->risingdetect);
-	p->context.fallingdetect = readl_relaxed(base + regs->fallingdetect);
-	p->context.irqenable1	= readl_relaxed(base + regs->irqenable);
-	p->context.irqenable2	= readl_relaxed(base + regs->irqenable2);
-
-	if (regs->set_dataout && p->regs->clr_dataout)
-		p->context.dataout = readl_relaxed(base + regs->set_dataout);
-	else
-		p->context.dataout = readl_relaxed(base + regs->dataout);
-
-	p->context_valid = true;
-}
-
 static void omap_gpio_restore_context(struct gpio_bank *bank)
 {
 	writel_relaxed(bank->context.wake_en,

Then, we can even remove ti,no-reset flag from all GPIO DT nodes.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140321/6740694b/attachment.sig>
