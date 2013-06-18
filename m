From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Tue, 18 Jun 2013 18:58:37 +0200
Subject: linux-next: origen build failed at
 drivers/pinctrl/pinctrl-exynos.c
In-Reply-To: <CA+G9fYu3_-RZxFyRENuqJvzsM=YToT7PG+5fUytMzhsFu3=z7g@mail.gmail.com>
References: <CA+G9fYu3_-RZxFyRENuqJvzsM=YToT7PG+5fUytMzhsFu3=z7g@mail.gmail.com>
Message-ID: <201306181858.37999.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Naresh Kamboju wrote:
> Hi,
> 
> linux-next branch failed to build origen build
> 
> defconfig: exynos_defconfig
> 
> full build log:
> ----------------
> https://ci.linaro.org/jenkins/job/linux-next/hwpack=origen,label=kernel_cloud/72/console
> 
> build error log:
> --------------------
> 05:02:12 /mnt/ci_build/workspace/linux-next/hwpack/origen/label/kernel_cloud/drivers/pinctrl/pinctrl-exynos.c:
> In function ?exynos_wkup_irq_mask?:
> 05:02:12 /mnt/ci_build/workspace/linux-next/hwpack/origen/label/kernel_cloud/drivers/pinctrl/pinctrl-exynos.c:299:3:
> error: implicit declaration of function ?exynos_wkup_irq_ack?
> [-Werror=implicit-function-declaration]
> 05:02:12    exynos_wkup_irq_ack(irqd);
> 05:02:12    ^
> 05:02:12 /mnt/ci_build/workspace/linux-next/hwpack/origen/label/kernel_cloud/drivers/pinctrl/pinctrl-exynos.c:
> At top level:
> 05:02:12 /mnt/ci_build/workspace/linux-next/hwpack/origen/label/kernel_cloud/drivers/pinctrl/pinctrl-exynos.c:310:13:
> warning: conflicting types for ?exynos_wkup_irq_ack? [enabled by
> default]
> 05:02:12  static void exynos_wkup_irq_ack(struct irq_data *irqd)
> 05:02:12              ^
> 05:02:12 /mnt/ci_build/workspace/linux-next/hwpack/origen/label/kernel_cloud/drivers/pinctrl/pinctrl-exynos.c:310:13:
> error: static declaration of ?exynos_wkup_irq_ack? follows non-static
> declaration
> 05:02:12 /mnt/ci_build/workspace/linux-next/hwpack/origen/label/kernel_cloud/drivers/pinctrl/pinctrl-exynos.c:299:3:
> note: previous implicit declaration of ?exynos_wkup_irq_ack? was here
> 05:02:12    exynos_wkup_irq_ack(irqd);
> 05:02:12    ^
> 05:02:12 cc1: some warnings being treated as errors
> 05:02:12 make[3]: *** [drivers/pinctrl/pinctrl-exynos.o] Error 1
> 05:02:12 make[2]: *** [drivers/pinctrl] Error 2
> 
> Best regards
> Naresh kamboju
> 

I got the same thing and used this patch to fix it up.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---

Linus, could you fold that into Doug's patch?

diff --git a/drivers/pinctrl/pinctrl-exynos.c b/drivers/pinctrl/pinctrl-exynos.c
index ef75321..00cd89a 100644
--- a/drivers/pinctrl/pinctrl-exynos.c
+++ b/drivers/pinctrl/pinctrl-exynos.c
@@ -279,6 +279,15 @@ err_domains:
 	return ret;
 }
 
+static void exynos_wkup_irq_ack(struct irq_data *irqd)
+{
+	struct samsung_pin_bank *b = irq_data_get_irq_chip_data(irqd);
+	struct samsung_pinctrl_drv_data *d = b->drvdata;
+	unsigned long pend = d->ctrl->weint_pend + b->eint_offset;
+
+	writel(1 << irqd->hwirq, d->virt_base + pend);
+}
+
 static void exynos_wkup_irq_mask(struct irq_data *irqd)
 {
 	struct samsung_pin_bank *b = irq_data_get_irq_chip_data(irqd);
@@ -296,15 +305,6 @@ static void exynos_wkup_irq_mask(struct irq_data *irqd)
 	spin_unlock_irqrestore(&b->slock, flags);
 }
 
-static void exynos_wkup_irq_ack(struct irq_data *irqd)
-{
-	struct samsung_pin_bank *b = irq_data_get_irq_chip_data(irqd);
-	struct samsung_pinctrl_drv_data *d = b->drvdata;
-	unsigned long pend = d->ctrl->weint_pend + b->eint_offset;
-
-	writel(1 << irqd->hwirq, d->virt_base + pend);
-}
-
 static void exynos_wkup_irq_unmask(struct irq_data *irqd)
 {
 	struct samsung_pin_bank *b = irq_data_get_irq_chip_data(irqd);
