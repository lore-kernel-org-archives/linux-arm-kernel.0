From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 16 May 2017 22:06:49 +0200
Subject: [PATCH-RFT 2/2] pinctrl: samsung: Split Exynos drivers per ARMv7 and
 ARMv8
In-Reply-To: <20170516200649.4730-1-krzk@kernel.org>
References: <20170516200649.4730-1-krzk@kernel.org>
Message-ID: <20170516200649.4730-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos pinctrl drivers contain pretty big per-SoC data structures.  The
pinctrl-exynos object file contained code and data for both ARMv7 and
ARMv8 SoCs thus it grew big.  There will not be a shared image between
ARMv7 and ARMv8 so there is no need to combine all of this into one
driver.

Splitting the data allows to make it more granular (e.g. code related to
ARMv8 Exynos is self-contained), slightly speed up the compilation and
reduce the effective size of compiled kernel.

The common data structures and functions reside still in existing
pinctrl-exynos.c.  Only the SoC-specific parts were moved out to new
files.  Except marking few functions non-static and adding them to
header, there were no functional changes in the code.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Not tested on ARMv8 (Exynos5433, Exynos7).

---
 drivers/pinctrl/samsung/Kconfig                |   10 +
 drivers/pinctrl/samsung/Makefile               |    2 +
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c   |  815 +++++++++++++++++
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c |  399 ++++++++
 drivers/pinctrl/samsung/pinctrl-exynos.c       | 1163 +-----------------------
 drivers/pinctrl/samsung/pinctrl-exynos.h       |    8 +
 drivers/pinctrl/samsung/pinctrl-samsung.c      |    8 +-
 7 files changed, 1245 insertions(+), 1160 deletions(-)
 create mode 100644 drivers/pinctrl/samsung/pinctrl-exynos-arm.c
 create mode 100644 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c

diff --git a/drivers/pinctrl/samsung/Kconfig b/drivers/pinctrl/samsung/Kconfig
index d0461cd5d707..c33ee6293c30 100644
--- a/drivers/pinctrl/samsung/Kconfig
+++ b/drivers/pinctrl/samsung/Kconfig
@@ -10,6 +10,16 @@ config PINCTRL_EXYNOS
 	bool "Pinctrl driver data for Samsung EXYNOS SoCs other than 5440"
 	depends on OF && GPIOLIB && (ARCH_EXYNOS || ARCH_S5PV210)
 	select PINCTRL_SAMSUNG
+	select PINCTRL_EXYNOS_ARM if ARM && ARCH_EXYNOS
+	select PINCTRL_EXYNOS_ARM64 if ARM64 && ARCH_EXYNOS
+
+config PINCTRL_EXYNOS_ARM
+	bool "ARMv7-specific pinctrl driver data for Exynos (except Exynos5440)" if COMPILE_TEST
+	depends on PINCTRL_EXYNOS
+
+config PINCTRL_EXYNOS_ARM64
+	bool "ARMv8-specific pinctrl driver data for Exynos" if COMPILE_TEST
+	depends on PINCTRL_EXYNOS
 
 config PINCTRL_EXYNOS5440
 	bool "Samsung EXYNOS5440 SoC pinctrl driver"
diff --git a/drivers/pinctrl/samsung/Makefile b/drivers/pinctrl/samsung/Makefile
index 70160c059edd..595995851ea5 100644
--- a/drivers/pinctrl/samsung/Makefile
+++ b/drivers/pinctrl/samsung/Makefile
@@ -2,6 +2,8 @@
 
 obj-$(CONFIG_PINCTRL_SAMSUNG)	+= pinctrl-samsung.o
 obj-$(CONFIG_PINCTRL_EXYNOS)	+= pinctrl-exynos.o
+obj-$(CONFIG_PINCTRL_EXYNOS_ARM)	+= pinctrl-exynos-arm.o
+obj-$(CONFIG_PINCTRL_EXYNOS_ARM64)	+= pinctrl-exynos-arm64.o
 obj-$(CONFIG_PINCTRL_EXYNOS5440)	+= pinctrl-exynos5440.o
 obj-$(CONFIG_PINCTRL_S3C24XX)	+= pinctrl-s3c24xx.o
 obj-$(CONFIG_PINCTRL_S3C64XX)	+= pinctrl-s3c64xx.o
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
new file mode 100644
index 000000000000..62e1cc376e2e
--- /dev/null
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
@@ -0,0 +1,815 @@
+/*
+ * Exynos specific support for Samsung pinctrl/gpiolib driver with eint support.
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2012 Linaro Ltd
+ *		http://www.linaro.org
+ *
+ * Author: Thomas Abraham <thomas.ab@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This file contains the Samsung Exynos specific information required by the
+ * the Samsung pinctrl/gpiolib driver. It also includes the implementation of
+ * external gpio and wakeup interrupt support.
+ */
+
+#include <linux/device.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
+
+#include "pinctrl-samsung.h"
+#include "pinctrl-exynos.h"
+
+static const struct samsung_pin_bank_type bank_type_off = {
+	.fld_width = { 4, 1, 2, 2, 2, 2, },
+	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, },
+};
+
+static const struct samsung_pin_bank_type bank_type_alive = {
+	.fld_width = { 4, 1, 2, 2, },
+	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, },
+};
+
+/* Retention control for S5PV210 are located at the end of clock controller */
+#define S5P_OTHERS 0xE000
+
+#define S5P_OTHERS_RET_IO		(1 << 31)
+#define S5P_OTHERS_RET_CF		(1 << 30)
+#define S5P_OTHERS_RET_MMC		(1 << 29)
+#define S5P_OTHERS_RET_UART		(1 << 28)
+
+static void s5pv210_retention_disable(struct samsung_pinctrl_drv_data *drvdata)
+{
+	void *clk_base = drvdata->retention_ctrl->priv;
+	u32 tmp;
+
+	tmp = __raw_readl(clk_base + S5P_OTHERS);
+	tmp |= (S5P_OTHERS_RET_IO | S5P_OTHERS_RET_CF | S5P_OTHERS_RET_MMC |
+		S5P_OTHERS_RET_UART);
+	__raw_writel(tmp, clk_base + S5P_OTHERS);
+}
+
+static struct samsung_retention_ctrl *
+s5pv210_retention_init(struct samsung_pinctrl_drv_data *drvdata,
+		       const struct samsung_retention_data *data)
+{
+	struct samsung_retention_ctrl *ctrl;
+	struct device_node *np;
+	void *clk_base;
+
+	ctrl = devm_kzalloc(drvdata->dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return ERR_PTR(-ENOMEM);
+
+	np = of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
+	if (!np) {
+		pr_err("%s: failed to find clock controller DT node\n",
+			__func__);
+		return ERR_PTR(-ENODEV);
+	}
+
+	clk_base = of_iomap(np, 0);
+	if (!clk_base) {
+		pr_err("%s: failed to map clock registers\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	ctrl->priv = clk_base;
+	ctrl->disable = s5pv210_retention_disable;
+
+	return ctrl;
+}
+
+static const struct samsung_retention_data s5pv210_retention_data __initconst = {
+	.init	 = s5pv210_retention_init,
+};
+
+/* pin banks of s5pv210 pin-controller */
+static const struct samsung_pin_bank_data s5pv210_pin_bank[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpa1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb", 0x08),
+	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpc0", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpc1", 0x10),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0a0, "gpd0", 0x14),
+	EXYNOS_PIN_BANK_EINTG(6, 0x0c0, "gpd1", 0x18),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0e0, "gpe0", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(5, 0x100, "gpe1", 0x20),
+	EXYNOS_PIN_BANK_EINTG(8, 0x120, "gpf0", 0x24),
+	EXYNOS_PIN_BANK_EINTG(8, 0x140, "gpf1", 0x28),
+	EXYNOS_PIN_BANK_EINTG(8, 0x160, "gpf2", 0x2c),
+	EXYNOS_PIN_BANK_EINTG(6, 0x180, "gpf3", 0x30),
+	EXYNOS_PIN_BANK_EINTG(7, 0x1a0, "gpg0", 0x34),
+	EXYNOS_PIN_BANK_EINTG(7, 0x1c0, "gpg1", 0x38),
+	EXYNOS_PIN_BANK_EINTG(7, 0x1e0, "gpg2", 0x3c),
+	EXYNOS_PIN_BANK_EINTG(7, 0x200, "gpg3", 0x40),
+	EXYNOS_PIN_BANK_EINTN(7, 0x220, "gpi"),
+	EXYNOS_PIN_BANK_EINTG(8, 0x240, "gpj0", 0x44),
+	EXYNOS_PIN_BANK_EINTG(6, 0x260, "gpj1", 0x48),
+	EXYNOS_PIN_BANK_EINTG(8, 0x280, "gpj2", 0x4c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x2a0, "gpj3", 0x50),
+	EXYNOS_PIN_BANK_EINTG(5, 0x2c0, "gpj4", 0x54),
+	EXYNOS_PIN_BANK_EINTN(8, 0x2e0, "mp01"),
+	EXYNOS_PIN_BANK_EINTN(4, 0x300, "mp02"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x320, "mp03"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x340, "mp04"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x360, "mp05"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x380, "mp06"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x3a0, "mp07"),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc00, "gph0", 0x00),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc20, "gph1", 0x04),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc40, "gph2", 0x08),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc60, "gph3", 0x0c),
+};
+
+const struct samsung_pin_ctrl s5pv210_pin_ctrl[] __initconst = {
+	{
+		/* pin-controller instance 0 data */
+		.pin_banks	= s5pv210_pin_bank,
+		.nr_banks	= ARRAY_SIZE(s5pv210_pin_bank),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &s5pv210_retention_data,
+	},
+};
+
+/* Pad retention control code for accessing PMU regmap */
+static atomic_t exynos_shared_retention_refcnt;
+
+/* pin banks of exynos3250 pin-controller 0 */
+static const struct samsung_pin_bank_data exynos3250_pin_banks0[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb",  0x08),
+	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpc0", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpc1", 0x10),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0a0, "gpd0", 0x14),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0c0, "gpd1", 0x18),
+};
+
+/* pin banks of exynos3250 pin-controller 1 */
+static const struct samsung_pin_bank_data exynos3250_pin_banks1[] __initconst = {
+	EXYNOS_PIN_BANK_EINTN(8, 0x120, "gpe0"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x140, "gpe1"),
+	EXYNOS_PIN_BANK_EINTN(3, 0x180, "gpe2"),
+	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpk0", 0x08),
+	EXYNOS_PIN_BANK_EINTG(7, 0x060, "gpk1", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(7, 0x080, "gpk2", 0x10),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0c0, "gpl0", 0x18),
+	EXYNOS_PIN_BANK_EINTG(8, 0x260, "gpm0", 0x24),
+	EXYNOS_PIN_BANK_EINTG(7, 0x280, "gpm1", 0x28),
+	EXYNOS_PIN_BANK_EINTG(5, 0x2a0, "gpm2", 0x2c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x2c0, "gpm3", 0x30),
+	EXYNOS_PIN_BANK_EINTG(8, 0x2e0, "gpm4", 0x34),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc00, "gpx0", 0x00),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc20, "gpx1", 0x04),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc40, "gpx2", 0x08),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc60, "gpx3", 0x0c),
+};
+
+/*
+ * PMU pad retention groups for Exynos3250 doesn't match pin banks, so handle
+ * them all together
+ */
+static const u32 exynos3250_retention_regs[] = {
+	S5P_PAD_RET_MAUDIO_OPTION,
+	S5P_PAD_RET_GPIO_OPTION,
+	S5P_PAD_RET_UART_OPTION,
+	S5P_PAD_RET_MMCA_OPTION,
+	S5P_PAD_RET_MMCB_OPTION,
+	S5P_PAD_RET_EBIA_OPTION,
+	S5P_PAD_RET_EBIB_OPTION,
+	S5P_PAD_RET_MMC2_OPTION,
+	S5P_PAD_RET_SPI_OPTION,
+};
+
+static const struct samsung_retention_data exynos3250_retention_data __initconst = {
+	.regs	 = exynos3250_retention_regs,
+	.nr_regs = ARRAY_SIZE(exynos3250_retention_regs),
+	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
+	.refcnt	 = &exynos_shared_retention_refcnt,
+	.init	 = exynos_retention_init,
+};
+
+/*
+ * Samsung pinctrl driver data for Exynos3250 SoC. Exynos3250 SoC includes
+ * two gpio/pin-mux/pinconfig controllers.
+ */
+const struct samsung_pin_ctrl exynos3250_pin_ctrl[] __initconst = {
+	{
+		/* pin-controller instance 0 data */
+		.pin_banks	= exynos3250_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynos3250_pin_banks0),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos3250_retention_data,
+	}, {
+		/* pin-controller instance 1 data */
+		.pin_banks	= exynos3250_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynos3250_pin_banks1),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos3250_retention_data,
+	},
+};
+
+/* pin banks of exynos4210 pin-controller 0 */
+static const struct samsung_pin_bank_data exynos4210_pin_banks0[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb", 0x08),
+	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpc0", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpc1", 0x10),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0A0, "gpd0", 0x14),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0C0, "gpd1", 0x18),
+	EXYNOS_PIN_BANK_EINTG(5, 0x0E0, "gpe0", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x100, "gpe1", 0x20),
+	EXYNOS_PIN_BANK_EINTG(6, 0x120, "gpe2", 0x24),
+	EXYNOS_PIN_BANK_EINTG(8, 0x140, "gpe3", 0x28),
+	EXYNOS_PIN_BANK_EINTG(8, 0x160, "gpe4", 0x2c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpf0", 0x30),
+	EXYNOS_PIN_BANK_EINTG(8, 0x1A0, "gpf1", 0x34),
+	EXYNOS_PIN_BANK_EINTG(8, 0x1C0, "gpf2", 0x38),
+	EXYNOS_PIN_BANK_EINTG(6, 0x1E0, "gpf3", 0x3c),
+};
+
+/* pin banks of exynos4210 pin-controller 1 */
+static const struct samsung_pin_bank_data exynos4210_pin_banks1[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpj0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(5, 0x020, "gpj1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpk0", 0x08),
+	EXYNOS_PIN_BANK_EINTG(7, 0x060, "gpk1", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(7, 0x080, "gpk2", 0x10),
+	EXYNOS_PIN_BANK_EINTG(7, 0x0A0, "gpk3", 0x14),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0C0, "gpl0", 0x18),
+	EXYNOS_PIN_BANK_EINTG(3, 0x0E0, "gpl1", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x100, "gpl2", 0x20),
+	EXYNOS_PIN_BANK_EINTN(6, 0x120, "gpy0"),
+	EXYNOS_PIN_BANK_EINTN(4, 0x140, "gpy1"),
+	EXYNOS_PIN_BANK_EINTN(6, 0x160, "gpy2"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x180, "gpy3"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x1A0, "gpy4"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x1C0, "gpy5"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x1E0, "gpy6"),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC00, "gpx0", 0x00),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC20, "gpx1", 0x04),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC40, "gpx2", 0x08),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC60, "gpx3", 0x0c),
+};
+
+/* pin banks of exynos4210 pin-controller 2 */
+static const struct samsung_pin_bank_data exynos4210_pin_banks2[] __initconst = {
+	EXYNOS_PIN_BANK_EINTN(7, 0x000, "gpz"),
+};
+
+/* PMU pad retention groups registers for Exynos4 (without audio) */
+static const u32 exynos4_retention_regs[] = {
+	S5P_PAD_RET_GPIO_OPTION,
+	S5P_PAD_RET_UART_OPTION,
+	S5P_PAD_RET_MMCA_OPTION,
+	S5P_PAD_RET_MMCB_OPTION,
+	S5P_PAD_RET_EBIA_OPTION,
+	S5P_PAD_RET_EBIB_OPTION,
+};
+
+static const struct samsung_retention_data exynos4_retention_data __initconst = {
+	.regs	 = exynos4_retention_regs,
+	.nr_regs = ARRAY_SIZE(exynos4_retention_regs),
+	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
+	.refcnt	 = &exynos_shared_retention_refcnt,
+	.init	 = exynos_retention_init,
+};
+
+/* PMU retention control for audio pins can be tied to audio pin bank */
+static const u32 exynos4_audio_retention_regs[] = {
+	S5P_PAD_RET_MAUDIO_OPTION,
+};
+
+static const struct samsung_retention_data exynos4_audio_retention_data __initconst = {
+	.regs	 = exynos4_audio_retention_regs,
+	.nr_regs = ARRAY_SIZE(exynos4_audio_retention_regs),
+	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
+	.init	 = exynos_retention_init,
+};
+
+/*
+ * Samsung pinctrl driver data for Exynos4210 SoC. Exynos4210 SoC includes
+ * three gpio/pin-mux/pinconfig controllers.
+ */
+const struct samsung_pin_ctrl exynos4210_pin_ctrl[] __initconst = {
+	{
+		/* pin-controller instance 0 data */
+		.pin_banks	= exynos4210_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynos4210_pin_banks0),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_retention_data,
+	}, {
+		/* pin-controller instance 1 data */
+		.pin_banks	= exynos4210_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynos4210_pin_banks1),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_retention_data,
+	}, {
+		/* pin-controller instance 2 data */
+		.pin_banks	= exynos4210_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(exynos4210_pin_banks2),
+		.retention_data	= &exynos4_audio_retention_data,
+	},
+};
+
+/* pin banks of exynos4x12 pin-controller 0 */
+static const struct samsung_pin_bank_data exynos4x12_pin_banks0[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb", 0x08),
+	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpc0", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpc1", 0x10),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0A0, "gpd0", 0x14),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0C0, "gpd1", 0x18),
+	EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpf0", 0x30),
+	EXYNOS_PIN_BANK_EINTG(8, 0x1A0, "gpf1", 0x34),
+	EXYNOS_PIN_BANK_EINTG(8, 0x1C0, "gpf2", 0x38),
+	EXYNOS_PIN_BANK_EINTG(6, 0x1E0, "gpf3", 0x3c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x240, "gpj0", 0x40),
+	EXYNOS_PIN_BANK_EINTG(5, 0x260, "gpj1", 0x44),
+};
+
+/* pin banks of exynos4x12 pin-controller 1 */
+static const struct samsung_pin_bank_data exynos4x12_pin_banks1[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpk0", 0x08),
+	EXYNOS_PIN_BANK_EINTG(7, 0x060, "gpk1", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(7, 0x080, "gpk2", 0x10),
+	EXYNOS_PIN_BANK_EINTG(7, 0x0A0, "gpk3", 0x14),
+	EXYNOS_PIN_BANK_EINTG(7, 0x0C0, "gpl0", 0x18),
+	EXYNOS_PIN_BANK_EINTG(2, 0x0E0, "gpl1", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x100, "gpl2", 0x20),
+	EXYNOS_PIN_BANK_EINTG(8, 0x260, "gpm0", 0x24),
+	EXYNOS_PIN_BANK_EINTG(7, 0x280, "gpm1", 0x28),
+	EXYNOS_PIN_BANK_EINTG(5, 0x2A0, "gpm2", 0x2c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x2C0, "gpm3", 0x30),
+	EXYNOS_PIN_BANK_EINTG(8, 0x2E0, "gpm4", 0x34),
+	EXYNOS_PIN_BANK_EINTN(6, 0x120, "gpy0"),
+	EXYNOS_PIN_BANK_EINTN(4, 0x140, "gpy1"),
+	EXYNOS_PIN_BANK_EINTN(6, 0x160, "gpy2"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x180, "gpy3"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x1A0, "gpy4"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x1C0, "gpy5"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x1E0, "gpy6"),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC00, "gpx0", 0x00),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC20, "gpx1", 0x04),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC40, "gpx2", 0x08),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC60, "gpx3", 0x0c),
+};
+
+/* pin banks of exynos4x12 pin-controller 2 */
+static const struct samsung_pin_bank_data exynos4x12_pin_banks2[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
+};
+
+/* pin banks of exynos4x12 pin-controller 3 */
+static const struct samsung_pin_bank_data exynos4x12_pin_banks3[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpv0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpv1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpv2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpv3", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(2, 0x080, "gpv4", 0x10),
+};
+
+/*
+ * Samsung pinctrl driver data for Exynos4x12 SoC. Exynos4x12 SoC includes
+ * four gpio/pin-mux/pinconfig controllers.
+ */
+const struct samsung_pin_ctrl exynos4x12_pin_ctrl[] __initconst = {
+	{
+		/* pin-controller instance 0 data */
+		.pin_banks	= exynos4x12_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynos4x12_pin_banks0),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_retention_data,
+	}, {
+		/* pin-controller instance 1 data */
+		.pin_banks	= exynos4x12_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynos4x12_pin_banks1),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_retention_data,
+	}, {
+		/* pin-controller instance 2 data */
+		.pin_banks	= exynos4x12_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(exynos4x12_pin_banks2),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_audio_retention_data,
+	}, {
+		/* pin-controller instance 3 data */
+		.pin_banks	= exynos4x12_pin_banks3,
+		.nr_banks	= ARRAY_SIZE(exynos4x12_pin_banks3),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	},
+};
+
+/* pin banks of exynos5250 pin-controller 0 */
+static const struct samsung_pin_bank_data exynos5250_pin_banks0[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpb0", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpb1", 0x10),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0A0, "gpb2", 0x14),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0C0, "gpb3", 0x18),
+	EXYNOS_PIN_BANK_EINTG(7, 0x0E0, "gpc0", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(4, 0x100, "gpc1", 0x20),
+	EXYNOS_PIN_BANK_EINTG(7, 0x120, "gpc2", 0x24),
+	EXYNOS_PIN_BANK_EINTG(7, 0x140, "gpc3", 0x28),
+	EXYNOS_PIN_BANK_EINTG(4, 0x160, "gpd0", 0x2c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpd1", 0x30),
+	EXYNOS_PIN_BANK_EINTG(7, 0x2E0, "gpc4", 0x34),
+	EXYNOS_PIN_BANK_EINTN(6, 0x1A0, "gpy0"),
+	EXYNOS_PIN_BANK_EINTN(4, 0x1C0, "gpy1"),
+	EXYNOS_PIN_BANK_EINTN(6, 0x1E0, "gpy2"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x200, "gpy3"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x220, "gpy4"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x240, "gpy5"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x260, "gpy6"),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC00, "gpx0", 0x00),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC20, "gpx1", 0x04),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC40, "gpx2", 0x08),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC60, "gpx3", 0x0c),
+};
+
+/* pin banks of exynos5250 pin-controller 1 */
+static const struct samsung_pin_bank_data exynos5250_pin_banks1[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpe0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(2, 0x020, "gpe1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(4, 0x040, "gpf0", 0x08),
+	EXYNOS_PIN_BANK_EINTG(4, 0x060, "gpf1", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x080, "gpg0", 0x10),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0A0, "gpg1", 0x14),
+	EXYNOS_PIN_BANK_EINTG(2, 0x0C0, "gpg2", 0x18),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0E0, "gph0", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x100, "gph1", 0x20),
+};
+
+/* pin banks of exynos5250 pin-controller 2 */
+static const struct samsung_pin_bank_data exynos5250_pin_banks2[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpv0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpv1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpv2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(8, 0x080, "gpv3", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(2, 0x0C0, "gpv4", 0x10),
+};
+
+/* pin banks of exynos5250 pin-controller 3 */
+static const struct samsung_pin_bank_data exynos5250_pin_banks3[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
+};
+
+/*
+ * Samsung pinctrl driver data for Exynos5250 SoC. Exynos5250 SoC includes
+ * four gpio/pin-mux/pinconfig controllers.
+ */
+const struct samsung_pin_ctrl exynos5250_pin_ctrl[] __initconst = {
+	{
+		/* pin-controller instance 0 data */
+		.pin_banks	= exynos5250_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks0),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_retention_data,
+	}, {
+		/* pin-controller instance 1 data */
+		.pin_banks	= exynos5250_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks1),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_retention_data,
+	}, {
+		/* pin-controller instance 2 data */
+		.pin_banks	= exynos5250_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks2),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 3 data */
+		.pin_banks	= exynos5250_pin_banks3,
+		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks3),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos4_audio_retention_data,
+	},
+};
+
+/* pin banks of exynos5260 pin-controller 0 */
+static const struct samsung_pin_bank_data exynos5260_pin_banks0[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpa0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(7, 0x020, "gpa1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpb0", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(4, 0x080, "gpb1", 0x10),
+	EXYNOS_PIN_BANK_EINTG(5, 0x0a0, "gpb2", 0x14),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0c0, "gpb3", 0x18),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0e0, "gpb4", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x100, "gpb5", 0x20),
+	EXYNOS_PIN_BANK_EINTG(8, 0x120, "gpd0", 0x24),
+	EXYNOS_PIN_BANK_EINTG(7, 0x140, "gpd1", 0x28),
+	EXYNOS_PIN_BANK_EINTG(5, 0x160, "gpd2", 0x2c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpe0", 0x30),
+	EXYNOS_PIN_BANK_EINTG(5, 0x1a0, "gpe1", 0x34),
+	EXYNOS_PIN_BANK_EINTG(4, 0x1c0, "gpf0", 0x38),
+	EXYNOS_PIN_BANK_EINTG(8, 0x1e0, "gpf1", 0x3c),
+	EXYNOS_PIN_BANK_EINTG(2, 0x200, "gpk0", 0x40),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc00, "gpx0", 0x00),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc20, "gpx1", 0x04),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc40, "gpx2", 0x08),
+	EXYNOS_PIN_BANK_EINTW(8, 0xc60, "gpx3", 0x0c),
+};
+
+/* pin banks of exynos5260 pin-controller 1 */
+static const struct samsung_pin_bank_data exynos5260_pin_banks1[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpc0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpc1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpc2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(4, 0x060, "gpc3", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(4, 0x080, "gpc4", 0x10),
+};
+
+/* pin banks of exynos5260 pin-controller 2 */
+static const struct samsung_pin_bank_data exynos5260_pin_banks2[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
+};
+
+/*
+ * Samsung pinctrl driver data for Exynos5260 SoC. Exynos5260 SoC includes
+ * three gpio/pin-mux/pinconfig controllers.
+ */
+const struct samsung_pin_ctrl exynos5260_pin_ctrl[] __initconst = {
+	{
+		/* pin-controller instance 0 data */
+		.pin_banks	= exynos5260_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynos5260_pin_banks0),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.eint_wkup_init = exynos_eint_wkup_init,
+	}, {
+		/* pin-controller instance 1 data */
+		.pin_banks	= exynos5260_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynos5260_pin_banks1),
+		.eint_gpio_init = exynos_eint_gpio_init,
+	}, {
+		/* pin-controller instance 2 data */
+		.pin_banks	= exynos5260_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(exynos5260_pin_banks2),
+		.eint_gpio_init = exynos_eint_gpio_init,
+	},
+};
+
+/* pin banks of exynos5410 pin-controller 0 */
+static const struct samsung_pin_bank_data exynos5410_pin_banks0[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpb0", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpb1", 0x10),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0A0, "gpb2", 0x14),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0C0, "gpb3", 0x18),
+	EXYNOS_PIN_BANK_EINTG(7, 0x0E0, "gpc0", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(4, 0x100, "gpc3", 0x20),
+	EXYNOS_PIN_BANK_EINTG(7, 0x120, "gpc1", 0x24),
+	EXYNOS_PIN_BANK_EINTG(7, 0x140, "gpc2", 0x28),
+	EXYNOS_PIN_BANK_EINTN(2, 0x160, "gpm5"),
+	EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpd1", 0x2c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x1A0, "gpe0", 0x30),
+	EXYNOS_PIN_BANK_EINTG(2, 0x1C0, "gpe1", 0x34),
+	EXYNOS_PIN_BANK_EINTG(6, 0x1E0, "gpf0", 0x38),
+	EXYNOS_PIN_BANK_EINTG(8, 0x200, "gpf1", 0x3c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x220, "gpg0", 0x40),
+	EXYNOS_PIN_BANK_EINTG(8, 0x240, "gpg1", 0x44),
+	EXYNOS_PIN_BANK_EINTG(2, 0x260, "gpg2", 0x48),
+	EXYNOS_PIN_BANK_EINTG(4, 0x280, "gph0", 0x4c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x2A0, "gph1", 0x50),
+	EXYNOS_PIN_BANK_EINTN(8, 0x2C0, "gpm7"),
+	EXYNOS_PIN_BANK_EINTN(6, 0x2E0, "gpy0"),
+	EXYNOS_PIN_BANK_EINTN(4, 0x300, "gpy1"),
+	EXYNOS_PIN_BANK_EINTN(6, 0x320, "gpy2"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x340, "gpy3"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x360, "gpy4"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x380, "gpy5"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x3A0, "gpy6"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x3C0, "gpy7"),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC00, "gpx0", 0x00),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC20, "gpx1", 0x04),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC40, "gpx2", 0x08),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC60, "gpx3", 0x0c),
+};
+
+/* pin banks of exynos5410 pin-controller 1 */
+static const struct samsung_pin_bank_data exynos5410_pin_banks1[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(5, 0x000, "gpj0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpj1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpj2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpj3", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(2, 0x080, "gpj4", 0x10),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0A0, "gpk0", 0x14),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0C0, "gpk1", 0x18),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0E0, "gpk2", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(7, 0x100, "gpk3", 0x20),
+};
+
+/* pin banks of exynos5410 pin-controller 2 */
+static const struct samsung_pin_bank_data exynos5410_pin_banks2[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpv0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpv1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpv2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(8, 0x080, "gpv3", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(2, 0x0C0, "gpv4", 0x10),
+};
+
+/* pin banks of exynos5410 pin-controller 3 */
+static const struct samsung_pin_bank_data exynos5410_pin_banks3[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
+};
+
+/*
+ * Samsung pinctrl driver data for Exynos5410 SoC. Exynos5410 SoC includes
+ * four gpio/pin-mux/pinconfig controllers.
+ */
+const struct samsung_pin_ctrl exynos5410_pin_ctrl[] __initconst = {
+	{
+		/* pin-controller instance 0 data */
+		.pin_banks	= exynos5410_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynos5410_pin_banks0),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 1 data */
+		.pin_banks	= exynos5410_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynos5410_pin_banks1),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 2 data */
+		.pin_banks	= exynos5410_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(exynos5410_pin_banks2),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	}, {
+		/* pin-controller instance 3 data */
+		.pin_banks	= exynos5410_pin_banks3,
+		.nr_banks	= ARRAY_SIZE(exynos5410_pin_banks3),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+	},
+};
+
+/* pin banks of exynos5420 pin-controller 0 */
+static const struct samsung_pin_bank_data exynos5420_pin_banks0[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpy7", 0x00),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC00, "gpx0", 0x00),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC20, "gpx1", 0x04),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC40, "gpx2", 0x08),
+	EXYNOS_PIN_BANK_EINTW(8, 0xC60, "gpx3", 0x0c),
+};
+
+/* pin banks of exynos5420 pin-controller 1 */
+static const struct samsung_pin_bank_data exynos5420_pin_banks1[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpc0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpc1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpc2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(4, 0x060, "gpc3", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(2, 0x080, "gpc4", 0x10),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0A0, "gpd1", 0x14),
+	EXYNOS_PIN_BANK_EINTN(6, 0x0C0, "gpy0"),
+	EXYNOS_PIN_BANK_EINTN(4, 0x0E0, "gpy1"),
+	EXYNOS_PIN_BANK_EINTN(6, 0x100, "gpy2"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x120, "gpy3"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x140, "gpy4"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x160, "gpy5"),
+	EXYNOS_PIN_BANK_EINTN(8, 0x180, "gpy6"),
+};
+
+/* pin banks of exynos5420 pin-controller 2 */
+static const struct samsung_pin_bank_data exynos5420_pin_banks2[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpe0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(2, 0x020, "gpe1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(6, 0x040, "gpf0", 0x08),
+	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpf1", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x080, "gpg0", 0x10),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0A0, "gpg1", 0x14),
+	EXYNOS_PIN_BANK_EINTG(2, 0x0C0, "gpg2", 0x18),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0E0, "gpj4", 0x1c),
+};
+
+/* pin banks of exynos5420 pin-controller 3 */
+static const struct samsung_pin_bank_data exynos5420_pin_banks3[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpb0", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpb1", 0x10),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0A0, "gpb2", 0x14),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0C0, "gpb3", 0x18),
+	EXYNOS_PIN_BANK_EINTG(2, 0x0E0, "gpb4", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x100, "gph0", 0x20),
+};
+
+/* pin banks of exynos5420 pin-controller 4 */
+static const struct samsung_pin_bank_data exynos5420_pin_banks4[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
+};
+
+/* PMU pad retention groups registers for Exynos5420 (without audio) */
+static const u32 exynos5420_retention_regs[] = {
+	EXYNOS_PAD_RET_DRAM_OPTION,
+	EXYNOS_PAD_RET_JTAG_OPTION,
+	EXYNOS5420_PAD_RET_GPIO_OPTION,
+	EXYNOS5420_PAD_RET_UART_OPTION,
+	EXYNOS5420_PAD_RET_MMCA_OPTION,
+	EXYNOS5420_PAD_RET_MMCB_OPTION,
+	EXYNOS5420_PAD_RET_MMCC_OPTION,
+	EXYNOS5420_PAD_RET_HSI_OPTION,
+	EXYNOS_PAD_RET_EBIA_OPTION,
+	EXYNOS_PAD_RET_EBIB_OPTION,
+	EXYNOS5420_PAD_RET_SPI_OPTION,
+	EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION,
+};
+
+static const struct samsung_retention_data exynos5420_retention_data __initconst = {
+	.regs	 = exynos5420_retention_regs,
+	.nr_regs = ARRAY_SIZE(exynos5420_retention_regs),
+	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
+	.refcnt	 = &exynos_shared_retention_refcnt,
+	.init	 = exynos_retention_init,
+};
+
+/*
+ * Samsung pinctrl driver data for Exynos5420 SoC. Exynos5420 SoC includes
+ * four gpio/pin-mux/pinconfig controllers.
+ */
+const struct samsung_pin_ctrl exynos5420_pin_ctrl[] __initconst = {
+	{
+		/* pin-controller instance 0 data */
+		.pin_banks	= exynos5420_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks0),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.eint_wkup_init = exynos_eint_wkup_init,
+		.retention_data	= &exynos5420_retention_data,
+	}, {
+		/* pin-controller instance 1 data */
+		.pin_banks	= exynos5420_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks1),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.retention_data	= &exynos5420_retention_data,
+	}, {
+		/* pin-controller instance 2 data */
+		.pin_banks	= exynos5420_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks2),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.retention_data	= &exynos5420_retention_data,
+	}, {
+		/* pin-controller instance 3 data */
+		.pin_banks	= exynos5420_pin_banks3,
+		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks3),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.retention_data	= &exynos5420_retention_data,
+	}, {
+		/* pin-controller instance 4 data */
+		.pin_banks	= exynos5420_pin_banks4,
+		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks4),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.retention_data	= &exynos4_audio_retention_data,
+	},
+};
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
new file mode 100644
index 000000000000..08e9fdb58fd2
--- /dev/null
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
@@ -0,0 +1,399 @@
+/*
+ * Exynos ARMv8 specific support for Samsung pinctrl/gpiolib driver
+ * with eint support.
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2012 Linaro Ltd
+ *		http://www.linaro.org
+ * Copyright (c) 2017 Krzysztof Kozlowski <krzk@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This file contains the Samsung Exynos specific information required by the
+ * the Samsung pinctrl/gpiolib driver. It also includes the implementation of
+ * external gpio and wakeup interrupt support.
+ */
+
+#include <linux/slab.h>
+#include <linux/soc/samsung/exynos-regs-pmu.h>
+
+#include "pinctrl-samsung.h"
+#include "pinctrl-exynos.h"
+
+static const struct samsung_pin_bank_type bank_type_off = {
+	.fld_width = { 4, 1, 2, 2, 2, 2, },
+	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, },
+};
+
+static const struct samsung_pin_bank_type bank_type_alive = {
+	.fld_width = { 4, 1, 2, 2, },
+	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, },
+};
+
+/* Exynos5433 has the 4bit widths for PINCFG_TYPE_DRV bitfields. */
+static const struct samsung_pin_bank_type exynos5433_bank_type_off = {
+	.fld_width = { 4, 1, 2, 4, 2, 2, },
+	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, },
+};
+
+static const struct samsung_pin_bank_type exynos5433_bank_type_alive = {
+	.fld_width = { 4, 1, 2, 4, },
+	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, },
+};
+
+/* Pad retention control code for accessing PMU regmap */
+static atomic_t exynos_shared_retention_refcnt;
+
+/* pin banks of exynos5433 pin-controller - ALIVE */
+static const struct samsung_pin_bank_data exynos5433_pin_banks0[] __initconst = {
+	EXYNOS5433_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
+	EXYNOS5433_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
+	EXYNOS5433_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
+	EXYNOS5433_PIN_BANK_EINTW(8, 0x060, "gpa3", 0x0c),
+	EXYNOS5433_PIN_BANK_EINTW_EXT(8, 0x020, "gpf1", 0x1004, 1),
+	EXYNOS5433_PIN_BANK_EINTW_EXT(4, 0x040, "gpf2", 0x1008, 1),
+	EXYNOS5433_PIN_BANK_EINTW_EXT(4, 0x060, "gpf3", 0x100c, 1),
+	EXYNOS5433_PIN_BANK_EINTW_EXT(8, 0x080, "gpf4", 0x1010, 1),
+	EXYNOS5433_PIN_BANK_EINTW_EXT(8, 0x0a0, "gpf5", 0x1014, 1),
+};
+
+/* pin banks of exynos5433 pin-controller - AUD */
+static const struct samsung_pin_bank_data exynos5433_pin_banks1[] __initconst = {
+	EXYNOS5433_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
+	EXYNOS5433_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
+};
+
+/* pin banks of exynos5433 pin-controller - CPIF */
+static const struct samsung_pin_bank_data exynos5433_pin_banks2[] __initconst = {
+	EXYNOS5433_PIN_BANK_EINTG(2, 0x000, "gpv6", 0x00),
+};
+
+/* pin banks of exynos5433 pin-controller - eSE */
+static const struct samsung_pin_bank_data exynos5433_pin_banks3[] __initconst = {
+	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj2", 0x00),
+};
+
+/* pin banks of exynos5433 pin-controller - FINGER */
+static const struct samsung_pin_bank_data exynos5433_pin_banks4[] __initconst = {
+	EXYNOS5433_PIN_BANK_EINTG(4, 0x000, "gpd5", 0x00),
+};
+
+/* pin banks of exynos5433 pin-controller - FSYS */
+static const struct samsung_pin_bank_data exynos5433_pin_banks5[] __initconst = {
+	EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gph1", 0x00),
+	EXYNOS5433_PIN_BANK_EINTG(7, 0x020, "gpr4", 0x04),
+	EXYNOS5433_PIN_BANK_EINTG(5, 0x040, "gpr0", 0x08),
+	EXYNOS5433_PIN_BANK_EINTG(8, 0x060, "gpr1", 0x0c),
+	EXYNOS5433_PIN_BANK_EINTG(2, 0x080, "gpr2", 0x10),
+	EXYNOS5433_PIN_BANK_EINTG(8, 0x0a0, "gpr3", 0x14),
+};
+
+/* pin banks of exynos5433 pin-controller - IMEM */
+static const struct samsung_pin_bank_data exynos5433_pin_banks6[] __initconst = {
+	EXYNOS5433_PIN_BANK_EINTG(8, 0x000, "gpf0", 0x00),
+};
+
+/* pin banks of exynos5433 pin-controller - NFC */
+static const struct samsung_pin_bank_data exynos5433_pin_banks7[] __initconst = {
+	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
+};
+
+/* pin banks of exynos5433 pin-controller - PERIC */
+static const struct samsung_pin_bank_data exynos5433_pin_banks8[] __initconst = {
+	EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gpv7", 0x00),
+	EXYNOS5433_PIN_BANK_EINTG(5, 0x020, "gpb0", 0x04),
+	EXYNOS5433_PIN_BANK_EINTG(8, 0x040, "gpc0", 0x08),
+	EXYNOS5433_PIN_BANK_EINTG(2, 0x060, "gpc1", 0x0c),
+	EXYNOS5433_PIN_BANK_EINTG(6, 0x080, "gpc2", 0x10),
+	EXYNOS5433_PIN_BANK_EINTG(8, 0x0a0, "gpc3", 0x14),
+	EXYNOS5433_PIN_BANK_EINTG(2, 0x0c0, "gpg0", 0x18),
+	EXYNOS5433_PIN_BANK_EINTG(4, 0x0e0, "gpd0", 0x1c),
+	EXYNOS5433_PIN_BANK_EINTG(6, 0x100, "gpd1", 0x20),
+	EXYNOS5433_PIN_BANK_EINTG(8, 0x120, "gpd2", 0x24),
+	EXYNOS5433_PIN_BANK_EINTG(5, 0x140, "gpd4", 0x28),
+	EXYNOS5433_PIN_BANK_EINTG(2, 0x160, "gpd8", 0x2c),
+	EXYNOS5433_PIN_BANK_EINTG(7, 0x180, "gpd6", 0x30),
+	EXYNOS5433_PIN_BANK_EINTG(3, 0x1a0, "gpd7", 0x34),
+	EXYNOS5433_PIN_BANK_EINTG(5, 0x1c0, "gpg1", 0x38),
+	EXYNOS5433_PIN_BANK_EINTG(2, 0x1e0, "gpg2", 0x3c),
+	EXYNOS5433_PIN_BANK_EINTG(8, 0x200, "gpg3", 0x40),
+};
+
+/* pin banks of exynos5433 pin-controller - TOUCH */
+static const struct samsung_pin_bank_data exynos5433_pin_banks9[] __initconst = {
+	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
+};
+
+/* PMU pin retention groups registers for Exynos5433 (without audio & fsys) */
+static const u32 exynos5433_retention_regs[] = {
+	EXYNOS5433_PAD_RETENTION_TOP_OPTION,
+	EXYNOS5433_PAD_RETENTION_UART_OPTION,
+	EXYNOS5433_PAD_RETENTION_EBIA_OPTION,
+	EXYNOS5433_PAD_RETENTION_EBIB_OPTION,
+	EXYNOS5433_PAD_RETENTION_SPI_OPTION,
+	EXYNOS5433_PAD_RETENTION_MIF_OPTION,
+	EXYNOS5433_PAD_RETENTION_USBXTI_OPTION,
+	EXYNOS5433_PAD_RETENTION_BOOTLDO_OPTION,
+	EXYNOS5433_PAD_RETENTION_UFS_OPTION,
+	EXYNOS5433_PAD_RETENTION_FSYSGENIO_OPTION,
+};
+
+static const struct samsung_retention_data exynos5433_retention_data __initconst = {
+	.regs	 = exynos5433_retention_regs,
+	.nr_regs = ARRAY_SIZE(exynos5433_retention_regs),
+	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
+	.refcnt	 = &exynos_shared_retention_refcnt,
+	.init	 = exynos_retention_init,
+};
+
+/* PMU retention control for audio pins can be tied to audio pin bank */
+static const u32 exynos5433_audio_retention_regs[] = {
+	EXYNOS5433_PAD_RETENTION_AUD_OPTION,
+};
+
+static const struct samsung_retention_data exynos5433_audio_retention_data __initconst = {
+	.regs	 = exynos5433_audio_retention_regs,
+	.nr_regs = ARRAY_SIZE(exynos5433_audio_retention_regs),
+	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
+	.init	 = exynos_retention_init,
+};
+
+/* PMU retention control for mmc pins can be tied to fsys pin bank */
+static const u32 exynos5433_fsys_retention_regs[] = {
+	EXYNOS5433_PAD_RETENTION_MMC0_OPTION,
+	EXYNOS5433_PAD_RETENTION_MMC1_OPTION,
+	EXYNOS5433_PAD_RETENTION_MMC2_OPTION,
+};
+
+static const struct samsung_retention_data exynos5433_fsys_retention_data __initconst = {
+	.regs	 = exynos5433_fsys_retention_regs,
+	.nr_regs = ARRAY_SIZE(exynos5433_fsys_retention_regs),
+	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
+	.init	 = exynos_retention_init,
+};
+
+/*
+ * Samsung pinctrl driver data for Exynos5433 SoC. Exynos5433 SoC includes
+ * ten gpio/pin-mux/pinconfig controllers.
+ */
+const struct samsung_pin_ctrl exynos5433_pin_ctrl[] __initconst = {
+	{
+		/* pin-controller instance 0 data */
+		.pin_banks	= exynos5433_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks0),
+		.eint_wkup_init = exynos_eint_wkup_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.nr_ext_resources = 1,
+		.retention_data	= &exynos5433_retention_data,
+	}, {
+		/* pin-controller instance 1 data */
+		.pin_banks	= exynos5433_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks1),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos5433_audio_retention_data,
+	}, {
+		/* pin-controller instance 2 data */
+		.pin_banks	= exynos5433_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks2),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos5433_retention_data,
+	}, {
+		/* pin-controller instance 3 data */
+		.pin_banks	= exynos5433_pin_banks3,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks3),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos5433_retention_data,
+	}, {
+		/* pin-controller instance 4 data */
+		.pin_banks	= exynos5433_pin_banks4,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks4),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos5433_retention_data,
+	}, {
+		/* pin-controller instance 5 data */
+		.pin_banks	= exynos5433_pin_banks5,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks5),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos5433_fsys_retention_data,
+	}, {
+		/* pin-controller instance 6 data */
+		.pin_banks	= exynos5433_pin_banks6,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks6),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos5433_retention_data,
+	}, {
+		/* pin-controller instance 7 data */
+		.pin_banks	= exynos5433_pin_banks7,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks7),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos5433_retention_data,
+	}, {
+		/* pin-controller instance 8 data */
+		.pin_banks	= exynos5433_pin_banks8,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks8),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos5433_retention_data,
+	}, {
+		/* pin-controller instance 9 data */
+		.pin_banks	= exynos5433_pin_banks9,
+		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks9),
+		.eint_gpio_init = exynos_eint_gpio_init,
+		.suspend	= exynos_pinctrl_suspend,
+		.resume		= exynos_pinctrl_resume,
+		.retention_data	= &exynos5433_retention_data,
+	},
+};
+
+/* pin banks of exynos7 pin-controller - ALIVE */
+static const struct samsung_pin_bank_data exynos7_pin_banks0[] __initconst = {
+	EXYNOS_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
+	EXYNOS_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
+	EXYNOS_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
+	EXYNOS_PIN_BANK_EINTW(8, 0x060, "gpa3", 0x0c),
+};
+
+/* pin banks of exynos7 pin-controller - BUS0 */
+static const struct samsung_pin_bank_data exynos7_pin_banks1[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(5, 0x000, "gpb0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpc0", 0x04),
+	EXYNOS_PIN_BANK_EINTG(2, 0x040, "gpc1", 0x08),
+	EXYNOS_PIN_BANK_EINTG(6, 0x060, "gpc2", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x080, "gpc3", 0x10),
+	EXYNOS_PIN_BANK_EINTG(4, 0x0a0, "gpd0", 0x14),
+	EXYNOS_PIN_BANK_EINTG(6, 0x0c0, "gpd1", 0x18),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0e0, "gpd2", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(5, 0x100, "gpd4", 0x20),
+	EXYNOS_PIN_BANK_EINTG(4, 0x120, "gpd5", 0x24),
+	EXYNOS_PIN_BANK_EINTG(6, 0x140, "gpd6", 0x28),
+	EXYNOS_PIN_BANK_EINTG(3, 0x160, "gpd7", 0x2c),
+	EXYNOS_PIN_BANK_EINTG(2, 0x180, "gpd8", 0x30),
+	EXYNOS_PIN_BANK_EINTG(2, 0x1a0, "gpg0", 0x34),
+	EXYNOS_PIN_BANK_EINTG(4, 0x1c0, "gpg3", 0x38),
+};
+
+/* pin banks of exynos7 pin-controller - NFC */
+static const struct samsung_pin_bank_data exynos7_pin_banks2[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
+};
+
+/* pin banks of exynos7 pin-controller - TOUCH */
+static const struct samsung_pin_bank_data exynos7_pin_banks3[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
+};
+
+/* pin banks of exynos7 pin-controller - FF */
+static const struct samsung_pin_bank_data exynos7_pin_banks4[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpg4", 0x00),
+};
+
+/* pin banks of exynos7 pin-controller - ESE */
+static const struct samsung_pin_bank_data exynos7_pin_banks5[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(5, 0x000, "gpv7", 0x00),
+};
+
+/* pin banks of exynos7 pin-controller - FSYS0 */
+static const struct samsung_pin_bank_data exynos7_pin_banks6[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpr4", 0x00),
+};
+
+/* pin banks of exynos7 pin-controller - FSYS1 */
+static const struct samsung_pin_bank_data exynos7_pin_banks7[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpr0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpr1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(5, 0x040, "gpr2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpr3", 0x0c),
+};
+
+/* pin banks of exynos7 pin-controller - BUS1 */
+static const struct samsung_pin_bank_data exynos7_pin_banks8[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpf0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpf1", 0x04),
+	EXYNOS_PIN_BANK_EINTG(4, 0x060, "gpf2", 0x08),
+	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpf3", 0x0c),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0a0, "gpf4", 0x10),
+	EXYNOS_PIN_BANK_EINTG(8, 0x0c0, "gpf5", 0x14),
+	EXYNOS_PIN_BANK_EINTG(5, 0x0e0, "gpg1", 0x18),
+	EXYNOS_PIN_BANK_EINTG(5, 0x100, "gpg2", 0x1c),
+	EXYNOS_PIN_BANK_EINTG(6, 0x120, "gph1", 0x20),
+	EXYNOS_PIN_BANK_EINTG(3, 0x140, "gpv6", 0x24),
+};
+
+static const struct samsung_pin_bank_data exynos7_pin_banks9[] __initconst = {
+	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
+	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
+};
+
+const struct samsung_pin_ctrl exynos7_pin_ctrl[] __initconst = {
+	{
+		/* pin-controller instance 0 Alive data */
+		.pin_banks	= exynos7_pin_banks0,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks0),
+		.eint_wkup_init = exynos_eint_wkup_init,
+	}, {
+		/* pin-controller instance 1 BUS0 data */
+		.pin_banks	= exynos7_pin_banks1,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks1),
+		.eint_gpio_init = exynos_eint_gpio_init,
+	}, {
+		/* pin-controller instance 2 NFC data */
+		.pin_banks	= exynos7_pin_banks2,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks2),
+		.eint_gpio_init = exynos_eint_gpio_init,
+	}, {
+		/* pin-controller instance 3 TOUCH data */
+		.pin_banks	= exynos7_pin_banks3,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks3),
+		.eint_gpio_init = exynos_eint_gpio_init,
+	}, {
+		/* pin-controller instance 4 FF data */
+		.pin_banks	= exynos7_pin_banks4,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks4),
+		.eint_gpio_init = exynos_eint_gpio_init,
+	}, {
+		/* pin-controller instance 5 ESE data */
+		.pin_banks	= exynos7_pin_banks5,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks5),
+		.eint_gpio_init = exynos_eint_gpio_init,
+	}, {
+		/* pin-controller instance 6 FSYS0 data */
+		.pin_banks	= exynos7_pin_banks6,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks6),
+		.eint_gpio_init = exynos_eint_gpio_init,
+	}, {
+		/* pin-controller instance 7 FSYS1 data */
+		.pin_banks	= exynos7_pin_banks7,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks7),
+		.eint_gpio_init = exynos_eint_gpio_init,
+	}, {
+		/* pin-controller instance 8 BUS1 data */
+		.pin_banks	= exynos7_pin_banks8,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks8),
+		.eint_gpio_init = exynos_eint_gpio_init,
+	}, {
+		/* pin-controller instance 9 AUD data */
+		.pin_banks	= exynos7_pin_banks9,
+		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks9),
+		.eint_gpio_init = exynos_eint_gpio_init,
+	},
+};
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 7b0e6cc35e04..0dbd1f58dad5 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -18,21 +18,18 @@
  * external gpio and wakeup interrupt support.
  */
 
-#include <linux/module.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/regmap.h>
 #include <linux/err.h>
 #include <linux/soc/samsung/exynos-pmu.h>
-#include <linux/soc/samsung/exynos-regs-pmu.h>
 
 #include "pinctrl-samsung.h"
 #include "pinctrl-exynos.h"
@@ -50,27 +47,6 @@ static inline struct exynos_irq_chip *to_exynos_irq_chip(struct irq_chip *chip)
 	return container_of(chip, struct exynos_irq_chip, chip);
 }
 
-static const struct samsung_pin_bank_type bank_type_off = {
-	.fld_width = { 4, 1, 2, 2, 2, 2, },
-	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, },
-};
-
-static const struct samsung_pin_bank_type bank_type_alive = {
-	.fld_width = { 4, 1, 2, 2, },
-	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, },
-};
-
-/* Exynos5433 has the 4bit widths for PINCFG_TYPE_DRV bitfields. */
-static const struct samsung_pin_bank_type exynos5433_bank_type_off = {
-	.fld_width = { 4, 1, 2, 4, 2, 2, },
-	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, },
-};
-
-static const struct samsung_pin_bank_type exynos5433_bank_type_alive = {
-	.fld_width = { 4, 1, 2, 4, },
-	.reg_offset = { 0x00, 0x04, 0x08, 0x0c, },
-};
-
 static void exynos_irq_mask(struct irq_data *irqd)
 {
 	struct irq_chip *chip = irq_data_get_irq_chip(irqd);
@@ -308,7 +284,7 @@ struct exynos_eint_gpio_save {
  * exynos_eint_gpio_init() - setup handling of external gpio interrupts.
  * @d: driver data of samsung pinctrl driver.
  */
-static int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
+int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
 {
 	struct samsung_pin_bank *bank;
 	struct device *dev = d->dev;
@@ -483,7 +459,7 @@ static void exynos_irq_demux_eint16_31(struct irq_desc *desc)
  * exynos_eint_wkup_init() - setup handling of external wakeup interrupts.
  * @d: driver data of samsung pinctrl driver.
  */
-static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
+int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 {
 	struct device *dev = d->dev;
 	struct device_node *wkup_np = NULL;
@@ -599,7 +575,7 @@ static void exynos_pinctrl_suspend_bank(
 	pr_debug("%s: save fltcon1 %#010x\n", bank->name, save->eint_fltcon1);
 }
 
-static void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
+void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata)
 {
 	struct samsung_pin_bank *bank = drvdata->pin_banks;
 	int i;
@@ -634,7 +610,7 @@ static void exynos_pinctrl_resume_bank(
 						+ 2 * bank->eint_offset + 4);
 }
 
-static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
+void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 {
 	struct samsung_pin_bank *bank = drvdata->pin_banks;
 	int i;
@@ -644,114 +620,6 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 			exynos_pinctrl_resume_bank(drvdata, bank);
 }
 
-/* Retention control for S5PV210 are located at the end of clock controller */
-#define S5P_OTHERS 0xE000
-
-#define S5P_OTHERS_RET_IO		(1 << 31)
-#define S5P_OTHERS_RET_CF		(1 << 30)
-#define S5P_OTHERS_RET_MMC		(1 << 29)
-#define S5P_OTHERS_RET_UART		(1 << 28)
-
-static void s5pv210_retention_disable(struct samsung_pinctrl_drv_data *drvdata)
-{
-	void *clk_base = drvdata->retention_ctrl->priv;
-	u32 tmp;
-
-	tmp = __raw_readl(clk_base + S5P_OTHERS);
-	tmp |= (S5P_OTHERS_RET_IO | S5P_OTHERS_RET_CF | S5P_OTHERS_RET_MMC |
-		S5P_OTHERS_RET_UART);
-	__raw_writel(tmp, clk_base + S5P_OTHERS);
-}
-
-static struct samsung_retention_ctrl *
-s5pv210_retention_init(struct samsung_pinctrl_drv_data *drvdata,
-		       const struct samsung_retention_data *data)
-{
-	struct samsung_retention_ctrl *ctrl;
-	struct device_node *np;
-	void *clk_base;
-
-	ctrl = devm_kzalloc(drvdata->dev, sizeof(*ctrl), GFP_KERNEL);
-	if (!ctrl)
-		return ERR_PTR(-ENOMEM);
-
-	np = of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
-	if (!np) {
-		pr_err("%s: failed to find clock controller DT node\n",
-			__func__);
-		return ERR_PTR(-ENODEV);
-	}
-
-	clk_base = of_iomap(np, 0);
-	if (!clk_base) {
-		pr_err("%s: failed to map clock registers\n", __func__);
-		return ERR_PTR(-EINVAL);
-	}
-
-	ctrl->priv = clk_base;
-	ctrl->disable = s5pv210_retention_disable;
-
-	return ctrl;
-}
-
-static const struct samsung_retention_data s5pv210_retention_data __initconst = {
-	.init	 = s5pv210_retention_init,
-};
-
-/* pin banks of s5pv210 pin-controller */
-static const struct samsung_pin_bank_data s5pv210_pin_bank[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpa1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb", 0x08),
-	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpc0", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpc1", 0x10),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0a0, "gpd0", 0x14),
-	EXYNOS_PIN_BANK_EINTG(6, 0x0c0, "gpd1", 0x18),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0e0, "gpe0", 0x1c),
-	EXYNOS_PIN_BANK_EINTG(5, 0x100, "gpe1", 0x20),
-	EXYNOS_PIN_BANK_EINTG(8, 0x120, "gpf0", 0x24),
-	EXYNOS_PIN_BANK_EINTG(8, 0x140, "gpf1", 0x28),
-	EXYNOS_PIN_BANK_EINTG(8, 0x160, "gpf2", 0x2c),
-	EXYNOS_PIN_BANK_EINTG(6, 0x180, "gpf3", 0x30),
-	EXYNOS_PIN_BANK_EINTG(7, 0x1a0, "gpg0", 0x34),
-	EXYNOS_PIN_BANK_EINTG(7, 0x1c0, "gpg1", 0x38),
-	EXYNOS_PIN_BANK_EINTG(7, 0x1e0, "gpg2", 0x3c),
-	EXYNOS_PIN_BANK_EINTG(7, 0x200, "gpg3", 0x40),
-	EXYNOS_PIN_BANK_EINTN(7, 0x220, "gpi"),
-	EXYNOS_PIN_BANK_EINTG(8, 0x240, "gpj0", 0x44),
-	EXYNOS_PIN_BANK_EINTG(6, 0x260, "gpj1", 0x48),
-	EXYNOS_PIN_BANK_EINTG(8, 0x280, "gpj2", 0x4c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x2a0, "gpj3", 0x50),
-	EXYNOS_PIN_BANK_EINTG(5, 0x2c0, "gpj4", 0x54),
-	EXYNOS_PIN_BANK_EINTN(8, 0x2e0, "mp01"),
-	EXYNOS_PIN_BANK_EINTN(4, 0x300, "mp02"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x320, "mp03"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x340, "mp04"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x360, "mp05"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x380, "mp06"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x3a0, "mp07"),
-	EXYNOS_PIN_BANK_EINTW(8, 0xc00, "gph0", 0x00),
-	EXYNOS_PIN_BANK_EINTW(8, 0xc20, "gph1", 0x04),
-	EXYNOS_PIN_BANK_EINTW(8, 0xc40, "gph2", 0x08),
-	EXYNOS_PIN_BANK_EINTW(8, 0xc60, "gph3", 0x0c),
-};
-
-const struct samsung_pin_ctrl s5pv210_pin_ctrl[] __initconst = {
-	{
-		/* pin-controller instance 0 data */
-		.pin_banks	= s5pv210_pin_bank,
-		.nr_banks	= ARRAY_SIZE(s5pv210_pin_bank),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.eint_wkup_init = exynos_eint_wkup_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &s5pv210_retention_data,
-	},
-};
-
-/* Pad retention control code for accessing PMU regmap */
-static atomic_t exynos_shared_retention_refcnt;
-
 static void exynos_retention_enable(struct samsung_pinctrl_drv_data *drvdata)
 {
 	if (drvdata->retention_ctrl->refcnt)
@@ -771,7 +639,7 @@ static void exynos_retention_disable(struct samsung_pinctrl_drv_data *drvdata)
 		regmap_write(pmu_regs, ctrl->regs[i], ctrl->value);
 }
 
-static struct samsung_retention_ctrl *
+struct samsung_retention_ctrl *
 exynos_retention_init(struct samsung_pinctrl_drv_data *drvdata,
 		      const struct samsung_retention_data *data)
 {
@@ -801,1022 +669,3 @@ exynos_retention_init(struct samsung_pinctrl_drv_data *drvdata,
 
 	return ctrl;
 }
-
-/* pin banks of exynos3250 pin-controller 0 */
-static const struct samsung_pin_bank_data exynos3250_pin_banks0[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb",  0x08),
-	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpc0", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpc1", 0x10),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0a0, "gpd0", 0x14),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0c0, "gpd1", 0x18),
-};
-
-/* pin banks of exynos3250 pin-controller 1 */
-static const struct samsung_pin_bank_data exynos3250_pin_banks1[] __initconst = {
-	EXYNOS_PIN_BANK_EINTN(8, 0x120, "gpe0"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x140, "gpe1"),
-	EXYNOS_PIN_BANK_EINTN(3, 0x180, "gpe2"),
-	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpk0", 0x08),
-	EXYNOS_PIN_BANK_EINTG(7, 0x060, "gpk1", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(7, 0x080, "gpk2", 0x10),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0c0, "gpl0", 0x18),
-	EXYNOS_PIN_BANK_EINTG(8, 0x260, "gpm0", 0x24),
-	EXYNOS_PIN_BANK_EINTG(7, 0x280, "gpm1", 0x28),
-	EXYNOS_PIN_BANK_EINTG(5, 0x2a0, "gpm2", 0x2c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x2c0, "gpm3", 0x30),
-	EXYNOS_PIN_BANK_EINTG(8, 0x2e0, "gpm4", 0x34),
-	EXYNOS_PIN_BANK_EINTW(8, 0xc00, "gpx0", 0x00),
-	EXYNOS_PIN_BANK_EINTW(8, 0xc20, "gpx1", 0x04),
-	EXYNOS_PIN_BANK_EINTW(8, 0xc40, "gpx2", 0x08),
-	EXYNOS_PIN_BANK_EINTW(8, 0xc60, "gpx3", 0x0c),
-};
-
-/*
- * PMU pad retention groups for Exynos3250 doesn't match pin banks, so handle
- * them all together
- */
-static const u32 exynos3250_retention_regs[] = {
-	S5P_PAD_RET_MAUDIO_OPTION,
-	S5P_PAD_RET_GPIO_OPTION,
-	S5P_PAD_RET_UART_OPTION,
-	S5P_PAD_RET_MMCA_OPTION,
-	S5P_PAD_RET_MMCB_OPTION,
-	S5P_PAD_RET_EBIA_OPTION,
-	S5P_PAD_RET_EBIB_OPTION,
-	S5P_PAD_RET_MMC2_OPTION,
-	S5P_PAD_RET_SPI_OPTION,
-};
-
-static const struct samsung_retention_data exynos3250_retention_data __initconst = {
-	.regs	 = exynos3250_retention_regs,
-	.nr_regs = ARRAY_SIZE(exynos3250_retention_regs),
-	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
-	.refcnt	 = &exynos_shared_retention_refcnt,
-	.init	 = exynos_retention_init,
-};
-
-/*
- * Samsung pinctrl driver data for Exynos3250 SoC. Exynos3250 SoC includes
- * two gpio/pin-mux/pinconfig controllers.
- */
-const struct samsung_pin_ctrl exynos3250_pin_ctrl[] __initconst = {
-	{
-		/* pin-controller instance 0 data */
-		.pin_banks	= exynos3250_pin_banks0,
-		.nr_banks	= ARRAY_SIZE(exynos3250_pin_banks0),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos3250_retention_data,
-	}, {
-		/* pin-controller instance 1 data */
-		.pin_banks	= exynos3250_pin_banks1,
-		.nr_banks	= ARRAY_SIZE(exynos3250_pin_banks1),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.eint_wkup_init = exynos_eint_wkup_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos3250_retention_data,
-	},
-};
-
-/* pin banks of exynos4210 pin-controller 0 */
-static const struct samsung_pin_bank_data exynos4210_pin_banks0[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb", 0x08),
-	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpc0", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpc1", 0x10),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0A0, "gpd0", 0x14),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0C0, "gpd1", 0x18),
-	EXYNOS_PIN_BANK_EINTG(5, 0x0E0, "gpe0", 0x1c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x100, "gpe1", 0x20),
-	EXYNOS_PIN_BANK_EINTG(6, 0x120, "gpe2", 0x24),
-	EXYNOS_PIN_BANK_EINTG(8, 0x140, "gpe3", 0x28),
-	EXYNOS_PIN_BANK_EINTG(8, 0x160, "gpe4", 0x2c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpf0", 0x30),
-	EXYNOS_PIN_BANK_EINTG(8, 0x1A0, "gpf1", 0x34),
-	EXYNOS_PIN_BANK_EINTG(8, 0x1C0, "gpf2", 0x38),
-	EXYNOS_PIN_BANK_EINTG(6, 0x1E0, "gpf3", 0x3c),
-};
-
-/* pin banks of exynos4210 pin-controller 1 */
-static const struct samsung_pin_bank_data exynos4210_pin_banks1[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpj0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(5, 0x020, "gpj1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpk0", 0x08),
-	EXYNOS_PIN_BANK_EINTG(7, 0x060, "gpk1", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(7, 0x080, "gpk2", 0x10),
-	EXYNOS_PIN_BANK_EINTG(7, 0x0A0, "gpk3", 0x14),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0C0, "gpl0", 0x18),
-	EXYNOS_PIN_BANK_EINTG(3, 0x0E0, "gpl1", 0x1c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x100, "gpl2", 0x20),
-	EXYNOS_PIN_BANK_EINTN(6, 0x120, "gpy0"),
-	EXYNOS_PIN_BANK_EINTN(4, 0x140, "gpy1"),
-	EXYNOS_PIN_BANK_EINTN(6, 0x160, "gpy2"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x180, "gpy3"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x1A0, "gpy4"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x1C0, "gpy5"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x1E0, "gpy6"),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC00, "gpx0", 0x00),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC20, "gpx1", 0x04),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC40, "gpx2", 0x08),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC60, "gpx3", 0x0c),
-};
-
-/* pin banks of exynos4210 pin-controller 2 */
-static const struct samsung_pin_bank_data exynos4210_pin_banks2[] __initconst = {
-	EXYNOS_PIN_BANK_EINTN(7, 0x000, "gpz"),
-};
-
-/* PMU pad retention groups registers for Exynos4 (without audio) */
-static const u32 exynos4_retention_regs[] = {
-	S5P_PAD_RET_GPIO_OPTION,
-	S5P_PAD_RET_UART_OPTION,
-	S5P_PAD_RET_MMCA_OPTION,
-	S5P_PAD_RET_MMCB_OPTION,
-	S5P_PAD_RET_EBIA_OPTION,
-	S5P_PAD_RET_EBIB_OPTION,
-};
-
-static const struct samsung_retention_data exynos4_retention_data __initconst = {
-	.regs	 = exynos4_retention_regs,
-	.nr_regs = ARRAY_SIZE(exynos4_retention_regs),
-	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
-	.refcnt	 = &exynos_shared_retention_refcnt,
-	.init	 = exynos_retention_init,
-};
-
-/* PMU retention control for audio pins can be tied to audio pin bank */
-static const u32 exynos4_audio_retention_regs[] = {
-	S5P_PAD_RET_MAUDIO_OPTION,
-};
-
-static const struct samsung_retention_data exynos4_audio_retention_data __initconst = {
-	.regs	 = exynos4_audio_retention_regs,
-	.nr_regs = ARRAY_SIZE(exynos4_audio_retention_regs),
-	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
-	.init	 = exynos_retention_init,
-};
-
-/*
- * Samsung pinctrl driver data for Exynos4210 SoC. Exynos4210 SoC includes
- * three gpio/pin-mux/pinconfig controllers.
- */
-const struct samsung_pin_ctrl exynos4210_pin_ctrl[] __initconst = {
-	{
-		/* pin-controller instance 0 data */
-		.pin_banks	= exynos4210_pin_banks0,
-		.nr_banks	= ARRAY_SIZE(exynos4210_pin_banks0),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos4_retention_data,
-	}, {
-		/* pin-controller instance 1 data */
-		.pin_banks	= exynos4210_pin_banks1,
-		.nr_banks	= ARRAY_SIZE(exynos4210_pin_banks1),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.eint_wkup_init = exynos_eint_wkup_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos4_retention_data,
-	}, {
-		/* pin-controller instance 2 data */
-		.pin_banks	= exynos4210_pin_banks2,
-		.nr_banks	= ARRAY_SIZE(exynos4210_pin_banks2),
-		.retention_data	= &exynos4_audio_retention_data,
-	},
-};
-
-/* pin banks of exynos4x12 pin-controller 0 */
-static const struct samsung_pin_bank_data exynos4x12_pin_banks0[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpb", 0x08),
-	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpc0", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpc1", 0x10),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0A0, "gpd0", 0x14),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0C0, "gpd1", 0x18),
-	EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpf0", 0x30),
-	EXYNOS_PIN_BANK_EINTG(8, 0x1A0, "gpf1", 0x34),
-	EXYNOS_PIN_BANK_EINTG(8, 0x1C0, "gpf2", 0x38),
-	EXYNOS_PIN_BANK_EINTG(6, 0x1E0, "gpf3", 0x3c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x240, "gpj0", 0x40),
-	EXYNOS_PIN_BANK_EINTG(5, 0x260, "gpj1", 0x44),
-};
-
-/* pin banks of exynos4x12 pin-controller 1 */
-static const struct samsung_pin_bank_data exynos4x12_pin_banks1[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpk0", 0x08),
-	EXYNOS_PIN_BANK_EINTG(7, 0x060, "gpk1", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(7, 0x080, "gpk2", 0x10),
-	EXYNOS_PIN_BANK_EINTG(7, 0x0A0, "gpk3", 0x14),
-	EXYNOS_PIN_BANK_EINTG(7, 0x0C0, "gpl0", 0x18),
-	EXYNOS_PIN_BANK_EINTG(2, 0x0E0, "gpl1", 0x1c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x100, "gpl2", 0x20),
-	EXYNOS_PIN_BANK_EINTG(8, 0x260, "gpm0", 0x24),
-	EXYNOS_PIN_BANK_EINTG(7, 0x280, "gpm1", 0x28),
-	EXYNOS_PIN_BANK_EINTG(5, 0x2A0, "gpm2", 0x2c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x2C0, "gpm3", 0x30),
-	EXYNOS_PIN_BANK_EINTG(8, 0x2E0, "gpm4", 0x34),
-	EXYNOS_PIN_BANK_EINTN(6, 0x120, "gpy0"),
-	EXYNOS_PIN_BANK_EINTN(4, 0x140, "gpy1"),
-	EXYNOS_PIN_BANK_EINTN(6, 0x160, "gpy2"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x180, "gpy3"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x1A0, "gpy4"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x1C0, "gpy5"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x1E0, "gpy6"),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC00, "gpx0", 0x00),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC20, "gpx1", 0x04),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC40, "gpx2", 0x08),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC60, "gpx3", 0x0c),
-};
-
-/* pin banks of exynos4x12 pin-controller 2 */
-static const struct samsung_pin_bank_data exynos4x12_pin_banks2[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
-};
-
-/* pin banks of exynos4x12 pin-controller 3 */
-static const struct samsung_pin_bank_data exynos4x12_pin_banks3[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpv0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpv1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpv2", 0x08),
-	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpv3", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(2, 0x080, "gpv4", 0x10),
-};
-
-/*
- * Samsung pinctrl driver data for Exynos4x12 SoC. Exynos4x12 SoC includes
- * four gpio/pin-mux/pinconfig controllers.
- */
-const struct samsung_pin_ctrl exynos4x12_pin_ctrl[] __initconst = {
-	{
-		/* pin-controller instance 0 data */
-		.pin_banks	= exynos4x12_pin_banks0,
-		.nr_banks	= ARRAY_SIZE(exynos4x12_pin_banks0),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos4_retention_data,
-	}, {
-		/* pin-controller instance 1 data */
-		.pin_banks	= exynos4x12_pin_banks1,
-		.nr_banks	= ARRAY_SIZE(exynos4x12_pin_banks1),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.eint_wkup_init = exynos_eint_wkup_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos4_retention_data,
-	}, {
-		/* pin-controller instance 2 data */
-		.pin_banks	= exynos4x12_pin_banks2,
-		.nr_banks	= ARRAY_SIZE(exynos4x12_pin_banks2),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos4_audio_retention_data,
-	}, {
-		/* pin-controller instance 3 data */
-		.pin_banks	= exynos4x12_pin_banks3,
-		.nr_banks	= ARRAY_SIZE(exynos4x12_pin_banks3),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-	},
-};
-
-/* pin banks of exynos5250 pin-controller 0 */
-static const struct samsung_pin_bank_data exynos5250_pin_banks0[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
-	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpb0", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpb1", 0x10),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0A0, "gpb2", 0x14),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0C0, "gpb3", 0x18),
-	EXYNOS_PIN_BANK_EINTG(7, 0x0E0, "gpc0", 0x1c),
-	EXYNOS_PIN_BANK_EINTG(4, 0x100, "gpc1", 0x20),
-	EXYNOS_PIN_BANK_EINTG(7, 0x120, "gpc2", 0x24),
-	EXYNOS_PIN_BANK_EINTG(7, 0x140, "gpc3", 0x28),
-	EXYNOS_PIN_BANK_EINTG(4, 0x160, "gpd0", 0x2c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpd1", 0x30),
-	EXYNOS_PIN_BANK_EINTG(7, 0x2E0, "gpc4", 0x34),
-	EXYNOS_PIN_BANK_EINTN(6, 0x1A0, "gpy0"),
-	EXYNOS_PIN_BANK_EINTN(4, 0x1C0, "gpy1"),
-	EXYNOS_PIN_BANK_EINTN(6, 0x1E0, "gpy2"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x200, "gpy3"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x220, "gpy4"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x240, "gpy5"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x260, "gpy6"),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC00, "gpx0", 0x00),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC20, "gpx1", 0x04),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC40, "gpx2", 0x08),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC60, "gpx3", 0x0c),
-};
-
-/* pin banks of exynos5250 pin-controller 1 */
-static const struct samsung_pin_bank_data exynos5250_pin_banks1[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpe0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(2, 0x020, "gpe1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(4, 0x040, "gpf0", 0x08),
-	EXYNOS_PIN_BANK_EINTG(4, 0x060, "gpf1", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x080, "gpg0", 0x10),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0A0, "gpg1", 0x14),
-	EXYNOS_PIN_BANK_EINTG(2, 0x0C0, "gpg2", 0x18),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0E0, "gph0", 0x1c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x100, "gph1", 0x20),
-};
-
-/* pin banks of exynos5250 pin-controller 2 */
-static const struct samsung_pin_bank_data exynos5250_pin_banks2[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpv0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpv1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpv2", 0x08),
-	EXYNOS_PIN_BANK_EINTG(8, 0x080, "gpv3", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(2, 0x0C0, "gpv4", 0x10),
-};
-
-/* pin banks of exynos5250 pin-controller 3 */
-static const struct samsung_pin_bank_data exynos5250_pin_banks3[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
-};
-
-/*
- * Samsung pinctrl driver data for Exynos5250 SoC. Exynos5250 SoC includes
- * four gpio/pin-mux/pinconfig controllers.
- */
-const struct samsung_pin_ctrl exynos5250_pin_ctrl[] __initconst = {
-	{
-		/* pin-controller instance 0 data */
-		.pin_banks	= exynos5250_pin_banks0,
-		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks0),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.eint_wkup_init = exynos_eint_wkup_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos4_retention_data,
-	}, {
-		/* pin-controller instance 1 data */
-		.pin_banks	= exynos5250_pin_banks1,
-		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks1),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos4_retention_data,
-	}, {
-		/* pin-controller instance 2 data */
-		.pin_banks	= exynos5250_pin_banks2,
-		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks2),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-	}, {
-		/* pin-controller instance 3 data */
-		.pin_banks	= exynos5250_pin_banks3,
-		.nr_banks	= ARRAY_SIZE(exynos5250_pin_banks3),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos4_audio_retention_data,
-	},
-};
-
-/* pin banks of exynos5260 pin-controller 0 */
-static const struct samsung_pin_bank_data exynos5260_pin_banks0[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpa0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(7, 0x020, "gpa1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
-	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpb0", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(4, 0x080, "gpb1", 0x10),
-	EXYNOS_PIN_BANK_EINTG(5, 0x0a0, "gpb2", 0x14),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0c0, "gpb3", 0x18),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0e0, "gpb4", 0x1c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x100, "gpb5", 0x20),
-	EXYNOS_PIN_BANK_EINTG(8, 0x120, "gpd0", 0x24),
-	EXYNOS_PIN_BANK_EINTG(7, 0x140, "gpd1", 0x28),
-	EXYNOS_PIN_BANK_EINTG(5, 0x160, "gpd2", 0x2c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpe0", 0x30),
-	EXYNOS_PIN_BANK_EINTG(5, 0x1a0, "gpe1", 0x34),
-	EXYNOS_PIN_BANK_EINTG(4, 0x1c0, "gpf0", 0x38),
-	EXYNOS_PIN_BANK_EINTG(8, 0x1e0, "gpf1", 0x3c),
-	EXYNOS_PIN_BANK_EINTG(2, 0x200, "gpk0", 0x40),
-	EXYNOS_PIN_BANK_EINTW(8, 0xc00, "gpx0", 0x00),
-	EXYNOS_PIN_BANK_EINTW(8, 0xc20, "gpx1", 0x04),
-	EXYNOS_PIN_BANK_EINTW(8, 0xc40, "gpx2", 0x08),
-	EXYNOS_PIN_BANK_EINTW(8, 0xc60, "gpx3", 0x0c),
-};
-
-/* pin banks of exynos5260 pin-controller 1 */
-static const struct samsung_pin_bank_data exynos5260_pin_banks1[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpc0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpc1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpc2", 0x08),
-	EXYNOS_PIN_BANK_EINTG(4, 0x060, "gpc3", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(4, 0x080, "gpc4", 0x10),
-};
-
-/* pin banks of exynos5260 pin-controller 2 */
-static const struct samsung_pin_bank_data exynos5260_pin_banks2[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
-};
-
-/*
- * Samsung pinctrl driver data for Exynos5260 SoC. Exynos5260 SoC includes
- * three gpio/pin-mux/pinconfig controllers.
- */
-const struct samsung_pin_ctrl exynos5260_pin_ctrl[] __initconst = {
-	{
-		/* pin-controller instance 0 data */
-		.pin_banks	= exynos5260_pin_banks0,
-		.nr_banks	= ARRAY_SIZE(exynos5260_pin_banks0),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.eint_wkup_init = exynos_eint_wkup_init,
-	}, {
-		/* pin-controller instance 1 data */
-		.pin_banks	= exynos5260_pin_banks1,
-		.nr_banks	= ARRAY_SIZE(exynos5260_pin_banks1),
-		.eint_gpio_init = exynos_eint_gpio_init,
-	}, {
-		/* pin-controller instance 2 data */
-		.pin_banks	= exynos5260_pin_banks2,
-		.nr_banks	= ARRAY_SIZE(exynos5260_pin_banks2),
-		.eint_gpio_init = exynos_eint_gpio_init,
-	},
-};
-
-/* pin banks of exynos5410 pin-controller 0 */
-static const struct samsung_pin_bank_data exynos5410_pin_banks0[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
-	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpb0", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpb1", 0x10),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0A0, "gpb2", 0x14),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0C0, "gpb3", 0x18),
-	EXYNOS_PIN_BANK_EINTG(7, 0x0E0, "gpc0", 0x1c),
-	EXYNOS_PIN_BANK_EINTG(4, 0x100, "gpc3", 0x20),
-	EXYNOS_PIN_BANK_EINTG(7, 0x120, "gpc1", 0x24),
-	EXYNOS_PIN_BANK_EINTG(7, 0x140, "gpc2", 0x28),
-	EXYNOS_PIN_BANK_EINTN(2, 0x160, "gpm5"),
-	EXYNOS_PIN_BANK_EINTG(8, 0x180, "gpd1", 0x2c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x1A0, "gpe0", 0x30),
-	EXYNOS_PIN_BANK_EINTG(2, 0x1C0, "gpe1", 0x34),
-	EXYNOS_PIN_BANK_EINTG(6, 0x1E0, "gpf0", 0x38),
-	EXYNOS_PIN_BANK_EINTG(8, 0x200, "gpf1", 0x3c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x220, "gpg0", 0x40),
-	EXYNOS_PIN_BANK_EINTG(8, 0x240, "gpg1", 0x44),
-	EXYNOS_PIN_BANK_EINTG(2, 0x260, "gpg2", 0x48),
-	EXYNOS_PIN_BANK_EINTG(4, 0x280, "gph0", 0x4c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x2A0, "gph1", 0x50),
-	EXYNOS_PIN_BANK_EINTN(8, 0x2C0, "gpm7"),
-	EXYNOS_PIN_BANK_EINTN(6, 0x2E0, "gpy0"),
-	EXYNOS_PIN_BANK_EINTN(4, 0x300, "gpy1"),
-	EXYNOS_PIN_BANK_EINTN(6, 0x320, "gpy2"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x340, "gpy3"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x360, "gpy4"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x380, "gpy5"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x3A0, "gpy6"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x3C0, "gpy7"),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC00, "gpx0", 0x00),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC20, "gpx1", 0x04),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC40, "gpx2", 0x08),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC60, "gpx3", 0x0c),
-};
-
-/* pin banks of exynos5410 pin-controller 1 */
-static const struct samsung_pin_bank_data exynos5410_pin_banks1[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(5, 0x000, "gpj0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpj1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpj2", 0x08),
-	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpj3", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(2, 0x080, "gpj4", 0x10),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0A0, "gpk0", 0x14),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0C0, "gpk1", 0x18),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0E0, "gpk2", 0x1c),
-	EXYNOS_PIN_BANK_EINTG(7, 0x100, "gpk3", 0x20),
-};
-
-/* pin banks of exynos5410 pin-controller 2 */
-static const struct samsung_pin_bank_data exynos5410_pin_banks2[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpv0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpv1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpv2", 0x08),
-	EXYNOS_PIN_BANK_EINTG(8, 0x080, "gpv3", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(2, 0x0C0, "gpv4", 0x10),
-};
-
-/* pin banks of exynos5410 pin-controller 3 */
-static const struct samsung_pin_bank_data exynos5410_pin_banks3[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
-};
-
-/*
- * Samsung pinctrl driver data for Exynos5410 SoC. Exynos5410 SoC includes
- * four gpio/pin-mux/pinconfig controllers.
- */
-const struct samsung_pin_ctrl exynos5410_pin_ctrl[] __initconst = {
-	{
-		/* pin-controller instance 0 data */
-		.pin_banks	= exynos5410_pin_banks0,
-		.nr_banks	= ARRAY_SIZE(exynos5410_pin_banks0),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.eint_wkup_init = exynos_eint_wkup_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-	}, {
-		/* pin-controller instance 1 data */
-		.pin_banks	= exynos5410_pin_banks1,
-		.nr_banks	= ARRAY_SIZE(exynos5410_pin_banks1),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-	}, {
-		/* pin-controller instance 2 data */
-		.pin_banks	= exynos5410_pin_banks2,
-		.nr_banks	= ARRAY_SIZE(exynos5410_pin_banks2),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-	}, {
-		/* pin-controller instance 3 data */
-		.pin_banks	= exynos5410_pin_banks3,
-		.nr_banks	= ARRAY_SIZE(exynos5410_pin_banks3),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-	},
-};
-
-/* pin banks of exynos5420 pin-controller 0 */
-static const struct samsung_pin_bank_data exynos5420_pin_banks0[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpy7", 0x00),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC00, "gpx0", 0x00),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC20, "gpx1", 0x04),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC40, "gpx2", 0x08),
-	EXYNOS_PIN_BANK_EINTW(8, 0xC60, "gpx3", 0x0c),
-};
-
-/* pin banks of exynos5420 pin-controller 1 */
-static const struct samsung_pin_bank_data exynos5420_pin_banks1[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpc0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpc1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(7, 0x040, "gpc2", 0x08),
-	EXYNOS_PIN_BANK_EINTG(4, 0x060, "gpc3", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(2, 0x080, "gpc4", 0x10),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0A0, "gpd1", 0x14),
-	EXYNOS_PIN_BANK_EINTN(6, 0x0C0, "gpy0"),
-	EXYNOS_PIN_BANK_EINTN(4, 0x0E0, "gpy1"),
-	EXYNOS_PIN_BANK_EINTN(6, 0x100, "gpy2"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x120, "gpy3"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x140, "gpy4"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x160, "gpy5"),
-	EXYNOS_PIN_BANK_EINTN(8, 0x180, "gpy6"),
-};
-
-/* pin banks of exynos5420 pin-controller 2 */
-static const struct samsung_pin_bank_data exynos5420_pin_banks2[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpe0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(2, 0x020, "gpe1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(6, 0x040, "gpf0", 0x08),
-	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpf1", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x080, "gpg0", 0x10),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0A0, "gpg1", 0x14),
-	EXYNOS_PIN_BANK_EINTG(2, 0x0C0, "gpg2", 0x18),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0E0, "gpj4", 0x1c),
-};
-
-/* pin banks of exynos5420 pin-controller 3 */
-static const struct samsung_pin_bank_data exynos5420_pin_banks3[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x000, "gpa0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(6, 0x020, "gpa1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpa2", 0x08),
-	EXYNOS_PIN_BANK_EINTG(5, 0x060, "gpb0", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpb1", 0x10),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0A0, "gpb2", 0x14),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0C0, "gpb3", 0x18),
-	EXYNOS_PIN_BANK_EINTG(2, 0x0E0, "gpb4", 0x1c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x100, "gph0", 0x20),
-};
-
-/* pin banks of exynos5420 pin-controller 4 */
-static const struct samsung_pin_bank_data exynos5420_pin_banks4[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz", 0x00),
-};
-
-/* PMU pad retention groups registers for Exynos5420 (without audio) */
-static const u32 exynos5420_retention_regs[] = {
-	EXYNOS_PAD_RET_DRAM_OPTION,
-	EXYNOS_PAD_RET_JTAG_OPTION,
-	EXYNOS5420_PAD_RET_GPIO_OPTION,
-	EXYNOS5420_PAD_RET_UART_OPTION,
-	EXYNOS5420_PAD_RET_MMCA_OPTION,
-	EXYNOS5420_PAD_RET_MMCB_OPTION,
-	EXYNOS5420_PAD_RET_MMCC_OPTION,
-	EXYNOS5420_PAD_RET_HSI_OPTION,
-	EXYNOS_PAD_RET_EBIA_OPTION,
-	EXYNOS_PAD_RET_EBIB_OPTION,
-	EXYNOS5420_PAD_RET_SPI_OPTION,
-	EXYNOS5420_PAD_RET_DRAM_COREBLK_OPTION,
-};
-
-static const struct samsung_retention_data exynos5420_retention_data __initconst = {
-	.regs	 = exynos5420_retention_regs,
-	.nr_regs = ARRAY_SIZE(exynos5420_retention_regs),
-	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
-	.refcnt	 = &exynos_shared_retention_refcnt,
-	.init	 = exynos_retention_init,
-};
-
-/*
- * Samsung pinctrl driver data for Exynos5420 SoC. Exynos5420 SoC includes
- * four gpio/pin-mux/pinconfig controllers.
- */
-const struct samsung_pin_ctrl exynos5420_pin_ctrl[] __initconst = {
-	{
-		/* pin-controller instance 0 data */
-		.pin_banks	= exynos5420_pin_banks0,
-		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks0),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.eint_wkup_init = exynos_eint_wkup_init,
-		.retention_data	= &exynos5420_retention_data,
-	}, {
-		/* pin-controller instance 1 data */
-		.pin_banks	= exynos5420_pin_banks1,
-		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks1),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.retention_data	= &exynos5420_retention_data,
-	}, {
-		/* pin-controller instance 2 data */
-		.pin_banks	= exynos5420_pin_banks2,
-		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks2),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.retention_data	= &exynos5420_retention_data,
-	}, {
-		/* pin-controller instance 3 data */
-		.pin_banks	= exynos5420_pin_banks3,
-		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks3),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.retention_data	= &exynos5420_retention_data,
-	}, {
-		/* pin-controller instance 4 data */
-		.pin_banks	= exynos5420_pin_banks4,
-		.nr_banks	= ARRAY_SIZE(exynos5420_pin_banks4),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.retention_data	= &exynos4_audio_retention_data,
-	},
-};
-
-/* pin banks of exynos5433 pin-controller - ALIVE */
-static const struct samsung_pin_bank_data exynos5433_pin_banks0[] __initconst = {
-	EXYNOS5433_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
-	EXYNOS5433_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
-	EXYNOS5433_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
-	EXYNOS5433_PIN_BANK_EINTW(8, 0x060, "gpa3", 0x0c),
-	EXYNOS5433_PIN_BANK_EINTW_EXT(8, 0x020, "gpf1", 0x1004, 1),
-	EXYNOS5433_PIN_BANK_EINTW_EXT(4, 0x040, "gpf2", 0x1008, 1),
-	EXYNOS5433_PIN_BANK_EINTW_EXT(4, 0x060, "gpf3", 0x100c, 1),
-	EXYNOS5433_PIN_BANK_EINTW_EXT(8, 0x080, "gpf4", 0x1010, 1),
-	EXYNOS5433_PIN_BANK_EINTW_EXT(8, 0x0a0, "gpf5", 0x1014, 1),
-};
-
-/* pin banks of exynos5433 pin-controller - AUD */
-static const struct samsung_pin_bank_data exynos5433_pin_banks1[] __initconst = {
-	EXYNOS5433_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
-	EXYNOS5433_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
-};
-
-/* pin banks of exynos5433 pin-controller - CPIF */
-static const struct samsung_pin_bank_data exynos5433_pin_banks2[] __initconst = {
-	EXYNOS5433_PIN_BANK_EINTG(2, 0x000, "gpv6", 0x00),
-};
-
-/* pin banks of exynos5433 pin-controller - eSE */
-static const struct samsung_pin_bank_data exynos5433_pin_banks3[] __initconst = {
-	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj2", 0x00),
-};
-
-/* pin banks of exynos5433 pin-controller - FINGER */
-static const struct samsung_pin_bank_data exynos5433_pin_banks4[] __initconst = {
-	EXYNOS5433_PIN_BANK_EINTG(4, 0x000, "gpd5", 0x00),
-};
-
-/* pin banks of exynos5433 pin-controller - FSYS */
-static const struct samsung_pin_bank_data exynos5433_pin_banks5[] __initconst = {
-	EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gph1", 0x00),
-	EXYNOS5433_PIN_BANK_EINTG(7, 0x020, "gpr4", 0x04),
-	EXYNOS5433_PIN_BANK_EINTG(5, 0x040, "gpr0", 0x08),
-	EXYNOS5433_PIN_BANK_EINTG(8, 0x060, "gpr1", 0x0c),
-	EXYNOS5433_PIN_BANK_EINTG(2, 0x080, "gpr2", 0x10),
-	EXYNOS5433_PIN_BANK_EINTG(8, 0x0a0, "gpr3", 0x14),
-};
-
-/* pin banks of exynos5433 pin-controller - IMEM */
-static const struct samsung_pin_bank_data exynos5433_pin_banks6[] __initconst = {
-	EXYNOS5433_PIN_BANK_EINTG(8, 0x000, "gpf0", 0x00),
-};
-
-/* pin banks of exynos5433 pin-controller - NFC */
-static const struct samsung_pin_bank_data exynos5433_pin_banks7[] __initconst = {
-	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
-};
-
-/* pin banks of exynos5433 pin-controller - PERIC */
-static const struct samsung_pin_bank_data exynos5433_pin_banks8[] __initconst = {
-	EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gpv7", 0x00),
-	EXYNOS5433_PIN_BANK_EINTG(5, 0x020, "gpb0", 0x04),
-	EXYNOS5433_PIN_BANK_EINTG(8, 0x040, "gpc0", 0x08),
-	EXYNOS5433_PIN_BANK_EINTG(2, 0x060, "gpc1", 0x0c),
-	EXYNOS5433_PIN_BANK_EINTG(6, 0x080, "gpc2", 0x10),
-	EXYNOS5433_PIN_BANK_EINTG(8, 0x0a0, "gpc3", 0x14),
-	EXYNOS5433_PIN_BANK_EINTG(2, 0x0c0, "gpg0", 0x18),
-	EXYNOS5433_PIN_BANK_EINTG(4, 0x0e0, "gpd0", 0x1c),
-	EXYNOS5433_PIN_BANK_EINTG(6, 0x100, "gpd1", 0x20),
-	EXYNOS5433_PIN_BANK_EINTG(8, 0x120, "gpd2", 0x24),
-	EXYNOS5433_PIN_BANK_EINTG(5, 0x140, "gpd4", 0x28),
-	EXYNOS5433_PIN_BANK_EINTG(2, 0x160, "gpd8", 0x2c),
-	EXYNOS5433_PIN_BANK_EINTG(7, 0x180, "gpd6", 0x30),
-	EXYNOS5433_PIN_BANK_EINTG(3, 0x1a0, "gpd7", 0x34),
-	EXYNOS5433_PIN_BANK_EINTG(5, 0x1c0, "gpg1", 0x38),
-	EXYNOS5433_PIN_BANK_EINTG(2, 0x1e0, "gpg2", 0x3c),
-	EXYNOS5433_PIN_BANK_EINTG(8, 0x200, "gpg3", 0x40),
-};
-
-/* pin banks of exynos5433 pin-controller - TOUCH */
-static const struct samsung_pin_bank_data exynos5433_pin_banks9[] __initconst = {
-	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
-};
-
-/* PMU pin retention groups registers for Exynos5433 (without audio & fsys) */
-static const u32 exynos5433_retention_regs[] = {
-	EXYNOS5433_PAD_RETENTION_TOP_OPTION,
-	EXYNOS5433_PAD_RETENTION_UART_OPTION,
-	EXYNOS5433_PAD_RETENTION_EBIA_OPTION,
-	EXYNOS5433_PAD_RETENTION_EBIB_OPTION,
-	EXYNOS5433_PAD_RETENTION_SPI_OPTION,
-	EXYNOS5433_PAD_RETENTION_MIF_OPTION,
-	EXYNOS5433_PAD_RETENTION_USBXTI_OPTION,
-	EXYNOS5433_PAD_RETENTION_BOOTLDO_OPTION,
-	EXYNOS5433_PAD_RETENTION_UFS_OPTION,
-	EXYNOS5433_PAD_RETENTION_FSYSGENIO_OPTION,
-};
-
-static const struct samsung_retention_data exynos5433_retention_data __initconst = {
-	.regs	 = exynos5433_retention_regs,
-	.nr_regs = ARRAY_SIZE(exynos5433_retention_regs),
-	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
-	.refcnt	 = &exynos_shared_retention_refcnt,
-	.init	 = exynos_retention_init,
-};
-
-/* PMU retention control for audio pins can be tied to audio pin bank */
-static const u32 exynos5433_audio_retention_regs[] = {
-	EXYNOS5433_PAD_RETENTION_AUD_OPTION,
-};
-
-static const struct samsung_retention_data exynos5433_audio_retention_data __initconst = {
-	.regs	 = exynos5433_audio_retention_regs,
-	.nr_regs = ARRAY_SIZE(exynos5433_audio_retention_regs),
-	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
-	.init	 = exynos_retention_init,
-};
-
-/* PMU retention control for mmc pins can be tied to fsys pin bank */
-static const u32 exynos5433_fsys_retention_regs[] = {
-	EXYNOS5433_PAD_RETENTION_MMC0_OPTION,
-	EXYNOS5433_PAD_RETENTION_MMC1_OPTION,
-	EXYNOS5433_PAD_RETENTION_MMC2_OPTION,
-};
-
-static const struct samsung_retention_data exynos5433_fsys_retention_data __initconst = {
-	.regs	 = exynos5433_fsys_retention_regs,
-	.nr_regs = ARRAY_SIZE(exynos5433_fsys_retention_regs),
-	.value	 = EXYNOS_WAKEUP_FROM_LOWPWR,
-	.init	 = exynos_retention_init,
-};
-
-/*
- * Samsung pinctrl driver data for Exynos5433 SoC. Exynos5433 SoC includes
- * ten gpio/pin-mux/pinconfig controllers.
- */
-const struct samsung_pin_ctrl exynos5433_pin_ctrl[] __initconst = {
-	{
-		/* pin-controller instance 0 data */
-		.pin_banks	= exynos5433_pin_banks0,
-		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks0),
-		.eint_wkup_init = exynos_eint_wkup_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.nr_ext_resources = 1,
-		.retention_data	= &exynos5433_retention_data,
-	}, {
-		/* pin-controller instance 1 data */
-		.pin_banks	= exynos5433_pin_banks1,
-		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks1),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos5433_audio_retention_data,
-	}, {
-		/* pin-controller instance 2 data */
-		.pin_banks	= exynos5433_pin_banks2,
-		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks2),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos5433_retention_data,
-	}, {
-		/* pin-controller instance 3 data */
-		.pin_banks	= exynos5433_pin_banks3,
-		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks3),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos5433_retention_data,
-	}, {
-		/* pin-controller instance 4 data */
-		.pin_banks	= exynos5433_pin_banks4,
-		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks4),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos5433_retention_data,
-	}, {
-		/* pin-controller instance 5 data */
-		.pin_banks	= exynos5433_pin_banks5,
-		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks5),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos5433_fsys_retention_data,
-	}, {
-		/* pin-controller instance 6 data */
-		.pin_banks	= exynos5433_pin_banks6,
-		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks6),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos5433_retention_data,
-	}, {
-		/* pin-controller instance 7 data */
-		.pin_banks	= exynos5433_pin_banks7,
-		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks7),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos5433_retention_data,
-	}, {
-		/* pin-controller instance 8 data */
-		.pin_banks	= exynos5433_pin_banks8,
-		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks8),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos5433_retention_data,
-	}, {
-		/* pin-controller instance 9 data */
-		.pin_banks	= exynos5433_pin_banks9,
-		.nr_banks	= ARRAY_SIZE(exynos5433_pin_banks9),
-		.eint_gpio_init = exynos_eint_gpio_init,
-		.suspend	= exynos_pinctrl_suspend,
-		.resume		= exynos_pinctrl_resume,
-		.retention_data	= &exynos5433_retention_data,
-	},
-};
-
-/* pin banks of exynos7 pin-controller - ALIVE */
-static const struct samsung_pin_bank_data exynos7_pin_banks0[] __initconst = {
-	EXYNOS_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
-	EXYNOS_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
-	EXYNOS_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
-	EXYNOS_PIN_BANK_EINTW(8, 0x060, "gpa3", 0x0c),
-};
-
-/* pin banks of exynos7 pin-controller - BUS0 */
-static const struct samsung_pin_bank_data exynos7_pin_banks1[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(5, 0x000, "gpb0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpc0", 0x04),
-	EXYNOS_PIN_BANK_EINTG(2, 0x040, "gpc1", 0x08),
-	EXYNOS_PIN_BANK_EINTG(6, 0x060, "gpc2", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x080, "gpc3", 0x10),
-	EXYNOS_PIN_BANK_EINTG(4, 0x0a0, "gpd0", 0x14),
-	EXYNOS_PIN_BANK_EINTG(6, 0x0c0, "gpd1", 0x18),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0e0, "gpd2", 0x1c),
-	EXYNOS_PIN_BANK_EINTG(5, 0x100, "gpd4", 0x20),
-	EXYNOS_PIN_BANK_EINTG(4, 0x120, "gpd5", 0x24),
-	EXYNOS_PIN_BANK_EINTG(6, 0x140, "gpd6", 0x28),
-	EXYNOS_PIN_BANK_EINTG(3, 0x160, "gpd7", 0x2c),
-	EXYNOS_PIN_BANK_EINTG(2, 0x180, "gpd8", 0x30),
-	EXYNOS_PIN_BANK_EINTG(2, 0x1a0, "gpg0", 0x34),
-	EXYNOS_PIN_BANK_EINTG(4, 0x1c0, "gpg3", 0x38),
-};
-
-/* pin banks of exynos7 pin-controller - NFC */
-static const struct samsung_pin_bank_data exynos7_pin_banks2[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
-};
-
-/* pin banks of exynos7 pin-controller - TOUCH */
-static const struct samsung_pin_bank_data exynos7_pin_banks3[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
-};
-
-/* pin banks of exynos7 pin-controller - FF */
-static const struct samsung_pin_bank_data exynos7_pin_banks4[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpg4", 0x00),
-};
-
-/* pin banks of exynos7 pin-controller - ESE */
-static const struct samsung_pin_bank_data exynos7_pin_banks5[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(5, 0x000, "gpv7", 0x00),
-};
-
-/* pin banks of exynos7 pin-controller - FSYS0 */
-static const struct samsung_pin_bank_data exynos7_pin_banks6[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpr4", 0x00),
-};
-
-/* pin banks of exynos7 pin-controller - FSYS1 */
-static const struct samsung_pin_bank_data exynos7_pin_banks7[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(4, 0x000, "gpr0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpr1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(5, 0x040, "gpr2", 0x08),
-	EXYNOS_PIN_BANK_EINTG(8, 0x060, "gpr3", 0x0c),
-};
-
-/* pin banks of exynos7 pin-controller - BUS1 */
-static const struct samsung_pin_bank_data exynos7_pin_banks8[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(8, 0x020, "gpf0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(8, 0x040, "gpf1", 0x04),
-	EXYNOS_PIN_BANK_EINTG(4, 0x060, "gpf2", 0x08),
-	EXYNOS_PIN_BANK_EINTG(5, 0x080, "gpf3", 0x0c),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0a0, "gpf4", 0x10),
-	EXYNOS_PIN_BANK_EINTG(8, 0x0c0, "gpf5", 0x14),
-	EXYNOS_PIN_BANK_EINTG(5, 0x0e0, "gpg1", 0x18),
-	EXYNOS_PIN_BANK_EINTG(5, 0x100, "gpg2", 0x1c),
-	EXYNOS_PIN_BANK_EINTG(6, 0x120, "gph1", 0x20),
-	EXYNOS_PIN_BANK_EINTG(3, 0x140, "gpv6", 0x24),
-};
-
-static const struct samsung_pin_bank_data exynos7_pin_banks9[] __initconst = {
-	EXYNOS_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
-	EXYNOS_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
-};
-
-const struct samsung_pin_ctrl exynos7_pin_ctrl[] __initconst = {
-	{
-		/* pin-controller instance 0 Alive data */
-		.pin_banks	= exynos7_pin_banks0,
-		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks0),
-		.eint_wkup_init = exynos_eint_wkup_init,
-	}, {
-		/* pin-controller instance 1 BUS0 data */
-		.pin_banks	= exynos7_pin_banks1,
-		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks1),
-		.eint_gpio_init = exynos_eint_gpio_init,
-	}, {
-		/* pin-controller instance 2 NFC data */
-		.pin_banks	= exynos7_pin_banks2,
-		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks2),
-		.eint_gpio_init = exynos_eint_gpio_init,
-	}, {
-		/* pin-controller instance 3 TOUCH data */
-		.pin_banks	= exynos7_pin_banks3,
-		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks3),
-		.eint_gpio_init = exynos_eint_gpio_init,
-	}, {
-		/* pin-controller instance 4 FF data */
-		.pin_banks	= exynos7_pin_banks4,
-		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks4),
-		.eint_gpio_init = exynos_eint_gpio_init,
-	}, {
-		/* pin-controller instance 5 ESE data */
-		.pin_banks	= exynos7_pin_banks5,
-		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks5),
-		.eint_gpio_init = exynos_eint_gpio_init,
-	}, {
-		/* pin-controller instance 6 FSYS0 data */
-		.pin_banks	= exynos7_pin_banks6,
-		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks6),
-		.eint_gpio_init = exynos_eint_gpio_init,
-	}, {
-		/* pin-controller instance 7 FSYS1 data */
-		.pin_banks	= exynos7_pin_banks7,
-		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks7),
-		.eint_gpio_init = exynos_eint_gpio_init,
-	}, {
-		/* pin-controller instance 8 BUS1 data */
-		.pin_banks	= exynos7_pin_banks8,
-		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks8),
-		.eint_gpio_init = exynos_eint_gpio_init,
-	}, {
-		/* pin-controller instance 9 AUD data */
-		.pin_banks	= exynos7_pin_banks9,
-		.nr_banks	= ARRAY_SIZE(exynos7_pin_banks9),
-		.eint_gpio_init = exynos_eint_gpio_init,
-	},
-};
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index ffad70458129..b90139715c8f 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -135,4 +135,12 @@ struct exynos_muxed_weint_data {
 	struct samsung_pin_bank *banks[];
 };
 
+int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d);
+int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d);
+void exynos_pinctrl_suspend(struct samsung_pinctrl_drv_data *drvdata);
+void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata);
+struct samsung_retention_ctrl *
+exynos_retention_init(struct samsung_pinctrl_drv_data *drvdata,
+		      const struct samsung_retention_data *data);
+
 #endif /* __PINCTRL_SAMSUNG_EXYNOS_H */
diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 96279905fcc9..00919e1f030a 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1183,7 +1183,7 @@ static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
 }
 
 static const struct of_device_id samsung_pinctrl_dt_match[] = {
-#ifdef CONFIG_PINCTRL_EXYNOS
+#ifdef CONFIG_PINCTRL_EXYNOS_ARM
 	{ .compatible = "samsung,exynos3250-pinctrl",
 		.data = exynos3250_pin_ctrl },
 	{ .compatible = "samsung,exynos4210-pinctrl",
@@ -1198,10 +1198,12 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
 		.data = exynos5410_pin_ctrl },
 	{ .compatible = "samsung,exynos5420-pinctrl",
 		.data = exynos5420_pin_ctrl },
-	{ .compatible = "samsung,exynos5433-pinctrl",
-		.data = exynos5433_pin_ctrl },
 	{ .compatible = "samsung,s5pv210-pinctrl",
 		.data = s5pv210_pin_ctrl },
+#endif
+#ifdef CONFIG_PINCTRL_EXYNOS_ARM64
+	{ .compatible = "samsung,exynos5433-pinctrl",
+		.data = exynos5433_pin_ctrl },
 	{ .compatible = "samsung,exynos7-pinctrl",
 		.data = exynos7_pin_ctrl },
 #endif
-- 
2.9.3
