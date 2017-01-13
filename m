From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 13 Jan 2017 11:03:30 +0000
Subject: [PATCH RFC 4/5] pinctrl: mvebu: switch drivers to generic simple mmio
In-Reply-To: <20170113110240.GA29164@n2100.armlinux.org.uk>
References: <20170113110240.GA29164@n2100.armlinux.org.uk>
Message-ID: <E1cRzdq-0002Yl-Lv@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the mvebu pinctrl drivers over to the generic simple mmio
implementation, saving a substantial number of lines of code in
the process.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pinctrl/mvebu/pinctrl-armada-370.c | 24 ++------------
 drivers/pinctrl/mvebu/pinctrl-armada-375.c | 24 ++------------
 drivers/pinctrl/mvebu/pinctrl-armada-38x.c | 24 ++------------
 drivers/pinctrl/mvebu/pinctrl-armada-39x.c | 24 ++------------
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c  | 31 ++++--------------
 drivers/pinctrl/mvebu/pinctrl-dove.c       | 52 +++++++++++++++---------------
 drivers/pinctrl/mvebu/pinctrl-kirkwood.c   | 28 +++-------------
 drivers/pinctrl/mvebu/pinctrl-mvebu.h      | 24 --------------
 8 files changed, 45 insertions(+), 186 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-370.c b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
index 4dc083ffd561..c2de4f8ee488 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-370.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-370.c
@@ -23,20 +23,6 @@
 
 #include "pinctrl-mvebu.h"
 
-static void __iomem *mpp_base;
-
-static int armada_370_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
-				   unsigned pid, unsigned long *config)
-{
-	return default_mpp_ctrl_get(mpp_base, pid, config);
-}
-
-static int armada_370_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
-				   unsigned pid, unsigned long config)
-{
-	return default_mpp_ctrl_set(mpp_base, pid, config);
-}
-
 static struct mvebu_mpp_mode mv88f6710_mpp_modes[] = {
 	MPP_MODE(0,
 	   MPP_FUNCTION(0x0, "gpio", NULL),
@@ -387,7 +373,7 @@ static const struct of_device_id armada_370_pinctrl_of_match[] = {
 };
 
 static const struct mvebu_mpp_ctrl mv88f6710_mpp_controls[] = {
-	MPP_FUNC_CTRL(0, 65, NULL, armada_370_mpp_ctrl),
+	MPP_FUNC_CTRL(0, 65, NULL, mvebu_mmio_mpp_ctrl),
 };
 
 static struct pinctrl_gpio_range mv88f6710_mpp_gpio_ranges[] = {
@@ -399,12 +385,6 @@ static struct pinctrl_gpio_range mv88f6710_mpp_gpio_ranges[] = {
 static int armada_370_pinctrl_probe(struct platform_device *pdev)
 {
 	struct mvebu_pinctrl_soc_info *soc = &armada_370_pinctrl_info;
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mpp_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mpp_base))
-		return PTR_ERR(mpp_base);
 
 	soc->variant = 0; /* no variants for Armada 370 */
 	soc->controls = mv88f6710_mpp_controls;
@@ -416,7 +396,7 @@ static int armada_370_pinctrl_probe(struct platform_device *pdev)
 
 	pdev->dev.platform_data = soc;
 
-	return mvebu_pinctrl_probe(pdev);
+	return mvebu_pinctrl_simple_mmio_probe(pdev);
 }
 
 static struct platform_driver armada_370_pinctrl_driver = {
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-375.c b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
index c6168102bd17..30cbf23b0b03 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-375.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
@@ -23,20 +23,6 @@
 
 #include "pinctrl-mvebu.h"
 
-static void __iomem *mpp_base;
-
-static int armada_375_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
-				   unsigned pid, unsigned long *config)
-{
-	return default_mpp_ctrl_get(mpp_base, pid, config);
-}
-
-static int armada_375_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
-				   unsigned pid, unsigned long config)
-{
-	return default_mpp_ctrl_set(mpp_base, pid, config);
-}
-
 static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 	MPP_MODE(0,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
@@ -405,7 +391,7 @@ static const struct of_device_id armada_375_pinctrl_of_match[] = {
 };
 
 static const struct mvebu_mpp_ctrl mv88f6720_mpp_controls[] = {
-	MPP_FUNC_CTRL(0, 69, NULL, armada_375_mpp_ctrl),
+	MPP_FUNC_CTRL(0, 69, NULL, mvebu_mmio_mpp_ctrl),
 };
 
 static struct pinctrl_gpio_range mv88f6720_mpp_gpio_ranges[] = {
@@ -417,12 +403,6 @@ static struct pinctrl_gpio_range mv88f6720_mpp_gpio_ranges[] = {
 static int armada_375_pinctrl_probe(struct platform_device *pdev)
 {
 	struct mvebu_pinctrl_soc_info *soc = &armada_375_pinctrl_info;
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mpp_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mpp_base))
-		return PTR_ERR(mpp_base);
 
 	soc->variant = 0; /* no variants for Armada 375 */
 	soc->controls = mv88f6720_mpp_controls;
@@ -434,7 +414,7 @@ static int armada_375_pinctrl_probe(struct platform_device *pdev)
 
 	pdev->dev.platform_data = soc;
 
-	return mvebu_pinctrl_probe(pdev);
+	return mvebu_pinctrl_simple_mmio_probe(pdev);
 }
 
 static struct platform_driver armada_375_pinctrl_driver = {
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
index 98aee37effef..e66ed239522e 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-38x.c
@@ -22,20 +22,6 @@
 
 #include "pinctrl-mvebu.h"
 
-static void __iomem *mpp_base;
-
-static int armada_38x_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
-				   unsigned pid, unsigned long *config)
-{
-	return default_mpp_ctrl_get(mpp_base, pid, config);
-}
-
-static int armada_38x_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
-				   unsigned pid, unsigned long config)
-{
-	return default_mpp_ctrl_set(mpp_base, pid, config);
-}
-
 enum {
 	V_88F6810 = BIT(0),
 	V_88F6820 = BIT(1),
@@ -412,7 +398,7 @@ static const struct of_device_id armada_38x_pinctrl_of_match[] = {
 };
 
 static const struct mvebu_mpp_ctrl armada_38x_mpp_controls[] = {
-	MPP_FUNC_CTRL(0, 59, NULL, armada_38x_mpp_ctrl),
+	MPP_FUNC_CTRL(0, 59, NULL, mvebu_mmio_mpp_ctrl),
 };
 
 static struct pinctrl_gpio_range armada_38x_mpp_gpio_ranges[] = {
@@ -425,16 +411,10 @@ static int armada_38x_pinctrl_probe(struct platform_device *pdev)
 	struct mvebu_pinctrl_soc_info *soc = &armada_38x_pinctrl_info;
 	const struct of_device_id *match =
 		of_match_device(armada_38x_pinctrl_of_match, &pdev->dev);
-	struct resource *res;
 
 	if (!match)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mpp_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mpp_base))
-		return PTR_ERR(mpp_base);
-
 	soc->variant = (unsigned) match->data & 0xff;
 	soc->controls = armada_38x_mpp_controls;
 	soc->ncontrols = ARRAY_SIZE(armada_38x_mpp_controls);
@@ -445,7 +425,7 @@ static int armada_38x_pinctrl_probe(struct platform_device *pdev)
 
 	pdev->dev.platform_data = soc;
 
-	return mvebu_pinctrl_probe(pdev);
+	return mvebu_pinctrl_simple_mmio_probe(pdev);
 }
 
 static struct platform_driver armada_38x_pinctrl_driver = {
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
index 4b1ba4424e0a..697c8774a4da 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-39x.c
@@ -22,20 +22,6 @@
 
 #include "pinctrl-mvebu.h"
 
-static void __iomem *mpp_base;
-
-static int armada_39x_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
-				   unsigned pid, unsigned long *config)
-{
-	return default_mpp_ctrl_get(mpp_base, pid, config);
-}
-
-static int armada_39x_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
-				   unsigned pid, unsigned long config)
-{
-	return default_mpp_ctrl_set(mpp_base, pid, config);
-}
-
 enum {
 	V_88F6920 = BIT(0),
 	V_88F6925 = BIT(1),
@@ -394,7 +380,7 @@ static const struct of_device_id armada_39x_pinctrl_of_match[] = {
 };
 
 static const struct mvebu_mpp_ctrl armada_39x_mpp_controls[] = {
-	MPP_FUNC_CTRL(0, 59, NULL, armada_39x_mpp_ctrl),
+	MPP_FUNC_CTRL(0, 59, NULL, mvebu_mmio_mpp_ctrl),
 };
 
 static struct pinctrl_gpio_range armada_39x_mpp_gpio_ranges[] = {
@@ -407,16 +393,10 @@ static int armada_39x_pinctrl_probe(struct platform_device *pdev)
 	struct mvebu_pinctrl_soc_info *soc = &armada_39x_pinctrl_info;
 	const struct of_device_id *match =
 		of_match_device(armada_39x_pinctrl_of_match, &pdev->dev);
-	struct resource *res;
 
 	if (!match)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mpp_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mpp_base))
-		return PTR_ERR(mpp_base);
-
 	soc->variant = (unsigned) match->data & 0xff;
 	soc->controls = armada_39x_mpp_controls;
 	soc->ncontrols = ARRAY_SIZE(armada_39x_mpp_controls);
@@ -427,7 +407,7 @@ static int armada_39x_pinctrl_probe(struct platform_device *pdev)
 
 	pdev->dev.platform_data = soc;
 
-	return mvebu_pinctrl_probe(pdev);
+	return mvebu_pinctrl_simple_mmio_probe(pdev);
 }
 
 static struct platform_driver armada_39x_pinctrl_driver = {
diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
index a777925e0f34..63e1bd506983 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-xp.c
@@ -30,21 +30,8 @@
 
 #include "pinctrl-mvebu.h"
 
-static void __iomem *mpp_base;
 static u32 *mpp_saved_regs;
 
-static int armada_xp_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
-				  unsigned pid, unsigned long *config)
-{
-	return default_mpp_ctrl_get(mpp_base, pid, config);
-}
-
-static int armada_xp_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
-				  unsigned pid, unsigned long config)
-{
-	return default_mpp_ctrl_set(mpp_base, pid, config);
-}
-
 enum armada_xp_variant {
 	V_MV78230	= BIT(0),
 	V_MV78260	= BIT(1),
@@ -381,7 +368,7 @@ static const struct of_device_id armada_xp_pinctrl_of_match[] = {
 };
 
 static const struct mvebu_mpp_ctrl mv78230_mpp_controls[] = {
-	MPP_FUNC_CTRL(0, 48, NULL, armada_xp_mpp_ctrl),
+	MPP_FUNC_CTRL(0, 48, NULL, mvebu_mmio_mpp_ctrl),
 };
 
 static struct pinctrl_gpio_range mv78230_mpp_gpio_ranges[] = {
@@ -390,7 +377,7 @@ static struct pinctrl_gpio_range mv78230_mpp_gpio_ranges[] = {
 };
 
 static const struct mvebu_mpp_ctrl mv78260_mpp_controls[] = {
-	MPP_FUNC_CTRL(0, 66, NULL, armada_xp_mpp_ctrl),
+	MPP_FUNC_CTRL(0, 66, NULL, mvebu_mmio_mpp_ctrl),
 };
 
 static struct pinctrl_gpio_range mv78260_mpp_gpio_ranges[] = {
@@ -400,7 +387,7 @@ static struct pinctrl_gpio_range mv78260_mpp_gpio_ranges[] = {
 };
 
 static const struct mvebu_mpp_ctrl mv78460_mpp_controls[] = {
-	MPP_FUNC_CTRL(0, 66, NULL, armada_xp_mpp_ctrl),
+	MPP_FUNC_CTRL(0, 66, NULL, mvebu_mmio_mpp_ctrl),
 };
 
 static struct pinctrl_gpio_range mv78460_mpp_gpio_ranges[] = {
@@ -419,7 +406,7 @@ static int armada_xp_pinctrl_suspend(struct platform_device *pdev,
 	nregs = DIV_ROUND_UP(soc->nmodes, MVEBU_MPPS_PER_REG);
 
 	for (i = 0; i < nregs; i++)
-		mpp_saved_regs[i] = readl(mpp_base + i * 4);
+		mpp_saved_regs[i] = readl(soc->control_data[0].base + i * 4);
 
 	return 0;
 }
@@ -433,7 +420,7 @@ static int armada_xp_pinctrl_resume(struct platform_device *pdev)
 	nregs = DIV_ROUND_UP(soc->nmodes, MVEBU_MPPS_PER_REG);
 
 	for (i = 0; i < nregs; i++)
-		writel(mpp_saved_regs[i], mpp_base + i * 4);
+		writel(mpp_saved_regs[i], soc->control_data[0].base + i * 4);
 
 	return 0;
 }
@@ -443,17 +430,11 @@ static int armada_xp_pinctrl_probe(struct platform_device *pdev)
 	struct mvebu_pinctrl_soc_info *soc = &armada_xp_pinctrl_info;
 	const struct of_device_id *match =
 		of_match_device(armada_xp_pinctrl_of_match, &pdev->dev);
-	struct resource *res;
 	int nregs;
 
 	if (!match)
 		return -ENODEV;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mpp_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mpp_base))
-		return PTR_ERR(mpp_base);
-
 	soc->variant = (unsigned) match->data & 0xff;
 
 	switch (soc->variant) {
@@ -501,7 +482,7 @@ static int armada_xp_pinctrl_probe(struct platform_device *pdev)
 
 	pdev->dev.platform_data = soc;
 
-	return mvebu_pinctrl_probe(pdev);
+	return mvebu_pinctrl_simple_mmio_probe(pdev);
 }
 
 static struct platform_driver armada_xp_pinctrl_driver = {
diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index fb0b42c24405..89ae93c49f2f 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -61,33 +61,20 @@
 
 #define CONFIG_PMU	BIT(4)
 
-static void __iomem *mpp_base;
 static void __iomem *mpp4_base;
 static void __iomem *pmu_base;
 static struct regmap *gconfmap;
 
-static int dove_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data, unsigned pid,
-			     unsigned long *config)
-{
-	return default_mpp_ctrl_get(mpp_base, pid, config);
-}
-
-static int dove_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data, unsigned pid,
-			     unsigned long config)
-{
-	return default_mpp_ctrl_set(mpp_base, pid, config);
-}
-
 static int dove_pmu_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
 				 unsigned pid, unsigned long *config)
 {
 	unsigned off = (pid / MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
 	unsigned shift = (pid % MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
-	unsigned long pmu = readl(mpp_base + PMU_MPP_GENERAL_CTRL);
+	unsigned long pmu = readl(data->base + PMU_MPP_GENERAL_CTRL);
 	unsigned long func;
 
 	if ((pmu & BIT(pid)) == 0)
-		return default_mpp_ctrl_get(mpp_base, pid, config);
+		return mvebu_mmio_mpp_ctrl_get(data, pid, config);
 
 	func = readl(pmu_base + PMU_SIGNAL_SELECT_0 + off);
 	*config = (func >> shift) & MVEBU_MPP_MASK;
@@ -101,15 +88,15 @@ static int dove_pmu_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
 {
 	unsigned off = (pid / MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
 	unsigned shift = (pid % MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
-	unsigned long pmu = readl(mpp_base + PMU_MPP_GENERAL_CTRL);
+	unsigned long pmu = readl(data->base + PMU_MPP_GENERAL_CTRL);
 	unsigned long func;
 
 	if ((config & CONFIG_PMU) == 0) {
-		writel(pmu & ~BIT(pid), mpp_base + PMU_MPP_GENERAL_CTRL);
-		return default_mpp_ctrl_set(mpp_base, pid, config);
+		writel(pmu & ~BIT(pid), data->base + PMU_MPP_GENERAL_CTRL);
+		return mvebu_mmio_mpp_ctrl_set(data, pid, config);
 	}
 
-	writel(pmu | BIT(pid), mpp_base + PMU_MPP_GENERAL_CTRL);
+	writel(pmu | BIT(pid), data->base + PMU_MPP_GENERAL_CTRL);
 	func = readl(pmu_base + PMU_SIGNAL_SELECT_0 + off);
 	func &= ~(MVEBU_MPP_MASK << shift);
 	func |= (config & MVEBU_MPP_MASK) << shift;
@@ -207,7 +194,7 @@ static int dove_nand_ctrl_set(struct mvebu_mpp_ctrl_data *data, unsigned pid,
 static int dove_audio0_ctrl_get(struct mvebu_mpp_ctrl_data *data, unsigned pid,
 				unsigned long *config)
 {
-	unsigned long pmu = readl(mpp_base + PMU_MPP_GENERAL_CTRL);
+	unsigned long pmu = readl(data->base + PMU_MPP_GENERAL_CTRL);
 
 	*config = ((pmu & AU0_AC97_SEL) != 0);
 
@@ -217,12 +204,12 @@ static int dove_audio0_ctrl_get(struct mvebu_mpp_ctrl_data *data, unsigned pid,
 static int dove_audio0_ctrl_set(struct mvebu_mpp_ctrl_data *data, unsigned pid,
 				unsigned long config)
 {
-	unsigned long pmu = readl(mpp_base + PMU_MPP_GENERAL_CTRL);
+	unsigned long pmu = readl(data->base + PMU_MPP_GENERAL_CTRL);
 
 	pmu &= ~AU0_AC97_SEL;
 	if (config)
 		pmu |= AU0_AC97_SEL;
-	writel(pmu, mpp_base + PMU_MPP_GENERAL_CTRL);
+	writel(pmu, data->base + PMU_MPP_GENERAL_CTRL);
 
 	return 0;
 }
@@ -372,7 +359,7 @@ static int dove_twsi_ctrl_set(struct mvebu_mpp_ctrl_data *data, unsigned pid,
 
 static const struct mvebu_mpp_ctrl dove_mpp_controls[] = {
 	MPP_FUNC_CTRL(0, 15, NULL, dove_pmu_mpp_ctrl),
-	MPP_FUNC_CTRL(16, 23, NULL, dove_mpp_ctrl),
+	MPP_FUNC_CTRL(16, 23, NULL, mvebu_mmio_mpp_ctrl),
 	MPP_FUNC_CTRL(24, 39, "mpp_camera", dove_mpp4_ctrl),
 	MPP_FUNC_CTRL(40, 45, "mpp_sdio0", dove_mpp4_ctrl),
 	MPP_FUNC_CTRL(46, 51, "mpp_sdio1", dove_mpp4_ctrl),
@@ -785,6 +772,10 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 	struct resource fb_res;
 	const struct of_device_id *match =
 		of_match_device(dove_pinctrl_of_match, &pdev->dev);
+	struct mvebu_mpp_ctrl_data *mpp_data;
+	void __iomem *base;
+	int i;
+
 	pdev->dev.platform_data = (void *)match->data;
 
 	/*
@@ -799,9 +790,18 @@ static int dove_pinctrl_probe(struct platform_device *pdev)
 	clk_prepare_enable(clk);
 
 	mpp_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mpp_base = devm_ioremap_resource(&pdev->dev, mpp_res);
-	if (IS_ERR(mpp_base))
-		return PTR_ERR(mpp_base);
+	base = devm_ioremap_resource(&pdev->dev, mpp_res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	mpp_data = devm_kcalloc(&pdev->dev, dove_pinctrl_info.ncontrols,
+				sizeof(*mpp_data), GFP_KERNEL);
+	if (!mpp_data)
+		return -ENOMEM;
+
+	dove_pinctrl_info.control_data = mpp_data;
+	for (i = 0; i < ARRAY_SIZE(dove_mpp_controls); i++)
+		mpp_data[i].base = base;
 
 	/* prepare fallback resource */
 	memcpy(&fb_res, mpp_res, sizeof(struct resource));
diff --git a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
index 89101f36f5d0..dad38d6dc646 100644
--- a/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
+++ b/drivers/pinctrl/mvebu/pinctrl-kirkwood.c
@@ -21,20 +21,6 @@
 
 #include "pinctrl-mvebu.h"
 
-static void __iomem *mpp_base;
-
-static int kirkwood_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data,
-				 unsigned pid, unsigned long *config)
-{
-	return default_mpp_ctrl_get(mpp_base, pid, config);
-}
-
-static int kirkwood_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data,
-				 unsigned pid, unsigned long config)
-{
-	return default_mpp_ctrl_set(mpp_base, pid, config);
-}
-
 #define V(f6180, f6190, f6192, f6281, f6282, dx4122)	\
 	((f6180 << 0) | (f6190 << 1) | (f6192 << 2) |	\
 	 (f6281 << 3) | (f6282 << 4) | (dx4122 << 5))
@@ -373,7 +359,7 @@ static struct mvebu_mpp_mode mv88f6xxx_mpp_modes[] = {
 };
 
 static const struct mvebu_mpp_ctrl mv88f6180_mpp_controls[] = {
-	MPP_FUNC_CTRL(0, 44, NULL, kirkwood_mpp_ctrl),
+	MPP_FUNC_CTRL(0, 44, NULL, mvebu_mmio_mpp_ctrl),
 };
 
 static struct pinctrl_gpio_range mv88f6180_gpio_ranges[] = {
@@ -382,7 +368,7 @@ static struct pinctrl_gpio_range mv88f6180_gpio_ranges[] = {
 };
 
 static const struct mvebu_mpp_ctrl mv88f619x_mpp_controls[] = {
-	MPP_FUNC_CTRL(0, 35, NULL, kirkwood_mpp_ctrl),
+	MPP_FUNC_CTRL(0, 35, NULL, mvebu_mmio_mpp_ctrl),
 };
 
 static struct pinctrl_gpio_range mv88f619x_gpio_ranges[] = {
@@ -391,7 +377,7 @@ static struct pinctrl_gpio_range mv88f619x_gpio_ranges[] = {
 };
 
 static const struct mvebu_mpp_ctrl mv88f628x_mpp_controls[] = {
-	MPP_FUNC_CTRL(0, 49, NULL, kirkwood_mpp_ctrl),
+	MPP_FUNC_CTRL(0, 49, NULL, mvebu_mmio_mpp_ctrl),
 };
 
 static struct pinctrl_gpio_range mv88f628x_gpio_ranges[] = {
@@ -474,14 +460,10 @@ static int kirkwood_pinctrl_probe(struct platform_device *pdev)
 	struct resource *res;
 	const struct of_device_id *match =
 		of_match_device(kirkwood_pinctrl_of_match, &pdev->dev);
-	pdev->dev.platform_data = (void *)match->data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mpp_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mpp_base))
-		return PTR_ERR(mpp_base);
+	pdev->dev.platform_data = (void *)match->data;
 
-	return mvebu_pinctrl_probe(pdev);
+	return mvebu_pinctrl_simple_mmio_probe(pdev);
 }
 
 static struct platform_driver kirkwood_pinctrl_driver = {
diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.h b/drivers/pinctrl/mvebu/pinctrl-mvebu.h
index c055581cf887..a9304cdc23e2 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.h
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.h
@@ -190,30 +190,6 @@ struct mvebu_pinctrl_soc_info {
 #define MVEBU_MPP_BITS		4
 #define MVEBU_MPP_MASK		0xf
 
-static inline int default_mpp_ctrl_get(void __iomem *base, unsigned int pid,
-				       unsigned long *config)
-{
-	unsigned off = (pid / MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
-	unsigned shift = (pid % MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
-
-	*config = (readl(base + off) >> shift) & MVEBU_MPP_MASK;
-
-	return 0;
-}
-
-static inline int default_mpp_ctrl_set(void __iomem *base, unsigned int pid,
-				       unsigned long config)
-{
-	unsigned off = (pid / MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
-	unsigned shift = (pid % MVEBU_MPPS_PER_REG) * MVEBU_MPP_BITS;
-	unsigned long reg;
-
-	reg = readl(base + off) & ~(MVEBU_MPP_MASK << shift);
-	writel(reg | (config << shift), base + off);
-
-	return 0;
-}
-
 int mvebu_mmio_mpp_ctrl_get(struct mvebu_mpp_ctrl_data *data, unsigned pid,
 			       unsigned long *config);
 int mvebu_mmio_mpp_ctrl_set(struct mvebu_mpp_ctrl_data *data, unsigned pid,
-- 
2.7.4
