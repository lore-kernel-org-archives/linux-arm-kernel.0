From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 17:01:01 +0530
Subject: [PATCH V6 12/17] ST SPEAr: Adding machine support for keyboard
In-Reply-To: <cover.1298977727.git.viresh.kumar@st.com>
References: <cover.1298977727.git.viresh.kumar@st.com>
Message-ID: <f05a88f07331775a0c64d7272f9197c57b9bb368.1298977728.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajeev Kumar <rajeev-dlh.kumar@st.com>

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |   20 ++++++++++++++++++++
 arch/arm/mach-spear13xx/spear1310_evb.c        |   20 ++++++++++++++++++++
 arch/arm/mach-spear13xx/spear13xx.c            |   19 +++++++++++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    1 +
 arch/arm/mach-spear3xx/spear300.c              |   19 +++++++++++++++++++
 arch/arm/mach-spear3xx/spear300_evb.c          |   20 ++++++++++++++++++++
 arch/arm/plat-spear/include/plat/keyboard.h    |    7 -------
 8 files changed, 100 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 9a9b6a3..f86f097 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -226,6 +226,7 @@ extern struct amba_device spear13xx_uart_device;
 extern struct platform_device spear13xx_ehci0_device;
 extern struct platform_device spear13xx_ehci1_device;
 extern struct platform_device spear13xx_i2c_device;
+extern struct platform_device spear13xx_kbd_device;
 extern struct platform_device spear13xx_ohci0_device;
 extern struct platform_device spear13xx_ohci1_device;
 extern struct platform_device spear13xx_rtc_device;
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index c0066a6..19be757 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <plat/keyboard.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
 #include <mach/pcie.h>
@@ -47,11 +48,24 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear13xx_ehci0_device,
 	&spear13xx_ehci1_device,
 	&spear13xx_i2c_device,
+	&spear13xx_kbd_device,
 	&spear13xx_ohci0_device,
 	&spear13xx_ohci1_device,
 	&spear13xx_rtc_device,
 };
 
+/* keyboard specific platform data */
+static const __initconst DECLARE_KEYMAP(keymap);
+static const struct matrix_keymap_data keymap_data __initconst = {
+	.keymap = keymap,
+	.keymap_size = ARRAY_SIZE(keymap),
+};
+
+static const struct kbd_platform_data kbd_data __initconst = {
+	.keymap = &keymap_data,
+	.rep = 1,
+};
+
 #ifdef CONFIG_PCIEPORTBUS
 /*
  * This function is needed for PCIE host and device driver. Same
@@ -83,6 +97,12 @@ static void __init spear1300_evb_init(void)
 	/* call spear1300 machine init function */
 	spear1300_init(NULL, pmx_devs, ARRAY_SIZE(pmx_devs));
 
+	/* set keyboard plat data */
+	if (platform_device_add_data(&spear13xx_kbd_device, &kbd_data,
+				sizeof(kbd_data)))
+		printk(KERN_WARNING "%s: couldn't add plat_data",
+				spear13xx_kbd_device.name);
+
 #ifdef CONFIG_PCIEPORTBUS
 	/* Enable PCIE0 clk */
 	enable_pcie0_clk();
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index d58d3ff..e196223 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <plat/keyboard.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
 #include <mach/pcie.h>
@@ -62,6 +63,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear13xx_ehci0_device,
 	&spear13xx_ehci1_device,
 	&spear13xx_i2c_device,
+	&spear13xx_kbd_device,
 	&spear13xx_ohci0_device,
 	&spear13xx_ohci1_device,
 	&spear13xx_rtc_device,
@@ -72,6 +74,18 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear1310_i2c1_device,
 };
 
+/* keyboard specific platform data */
+static const __initconst DECLARE_KEYMAP(keymap);
+static const struct matrix_keymap_data keymap_data __initconst = {
+	.keymap = keymap,
+	.keymap_size = ARRAY_SIZE(keymap),
+};
+
+static const struct kbd_platform_data kbd_data __initconst = {
+	.keymap = &keymap_data,
+	.rep = 1,
+};
+
 #ifdef CONFIG_PCIEPORTBUS
 /*
  * This function is needed for PCIE host and device driver. Same
@@ -103,6 +117,12 @@ static void __init spear1310_evb_init(void)
 	/* call spear1310 machine init function */
 	spear1310_init(NULL, pmx_devs, ARRAY_SIZE(pmx_devs));
 
+	/* set keyboard plat data */
+	if (platform_device_add_data(&spear13xx_kbd_device, &kbd_data,
+				sizeof(kbd_data)))
+		printk(KERN_WARNING "%s: couldn't add plat_data",
+				spear13xx_kbd_device.name);
+
 #ifdef CONFIG_PCIEPORTBUS
 	/* Enable PCIE0 clk */
 	enable_pcie0_clk();
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 69ead0f..3856161 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -204,6 +204,25 @@ struct platform_device spear13xx_ohci1_device = {
 	.resource = ohci1_resources,
 };
 
+/* keyboard device registration */
+static struct resource kbd_resources[] = {
+	{
+		.start = SPEAR13XX_KBD_BASE,
+		.end = SPEAR13XX_KBD_BASE + SZ_1K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_KBD,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear13xx_kbd_device = {
+	.name = "keyboard",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(kbd_resources),
+	.resource = kbd_resources,
+};
+
 /* rtc device registration */
 static struct resource rtc_resources[] = {
 	{
diff --git a/arch/arm/mach-spear3xx/include/mach/generic.h b/arch/arm/mach-spear3xx/include/mach/generic.h
index ea21478..0307f7e 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -107,6 +107,7 @@ extern struct pmx_dev spear3xx_pmx_plgpio_45_46_49_50;
 #ifdef CONFIG_MACH_SPEAR300
 /* Add spear300 machine device structure declarations here */
 extern struct amba_device spear300_gpio1_device;
+extern struct platform_device spear300_kbd_device;
 
 /* pad mux modes */
 extern struct pmx_mode spear300_nand_mode;
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 89999bf..6b75fe8 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -595,6 +595,25 @@ struct amba_device spear300_gpio1_device = {
 	.irq = {SPEAR300_VIRQ_GPIO1, NO_IRQ},
 };
 
+/* keyboard device registration */
+static struct resource kbd_resources[] = {
+	{
+		.start = SPEAR300_KEYBOARD_BASE,
+		.end = SPEAR300_KEYBOARD_BASE + SZ_1K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = SPEAR300_VIRQ_KEYBOARD,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device spear300_kbd_device = {
+	.name = "keyboard",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(kbd_resources),
+	.resource = kbd_resources,
+};
+
 /* spear300 routines */
 void __init spear300_init(struct pmx_mode *pmx_mode, struct pmx_dev **pmx_devs,
 		u8 pmx_dev_count)
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index 1dd0e18..280bf80 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -13,6 +13,7 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <plat/keyboard.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
 
@@ -51,6 +52,19 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear3xx_rtc_device,
 
 	/* spear300 specific devices */
+	&spear300_kbd_device,
+};
+
+/* keyboard specific platform data */
+static const __initconst DECLARE_KEYMAP(keymap);
+static const struct matrix_keymap_data keymap_data __initconst = {
+	.keymap = keymap,
+	.keymap_size = ARRAY_SIZE(keymap),
+};
+
+static const struct kbd_platform_data kbd_data __initconst = {
+	.keymap = &keymap_data,
+	.rep = 1,
 };
 
 static void __init spear300_evb_init(void)
@@ -61,6 +75,12 @@ static void __init spear300_evb_init(void)
 	spear300_init(&spear300_photo_frame_mode, pmx_devs,
 			ARRAY_SIZE(pmx_devs));
 
+	/* set keyboard plat data */
+	if (platform_device_add_data(&spear300_kbd_device, &kbd_data,
+				sizeof(kbd_data)))
+		printk(KERN_WARNING "%s: couldn't add plat_data",
+				spear300_kbd_device.name);
+
 	/* Register slave devices on the I2C buses */
 	i2c_register_default_devices();
 
diff --git a/arch/arm/plat-spear/include/plat/keyboard.h b/arch/arm/plat-spear/include/plat/keyboard.h
index 68b5394..63908cc 100644
--- a/arch/arm/plat-spear/include/plat/keyboard.h
+++ b/arch/arm/plat-spear/include/plat/keyboard.h
@@ -131,11 +131,4 @@ struct kbd_platform_data {
 	bool rep;
 };
 
-/* This function is used to set platform data field of pdev->dev */
-static inline void
-kbd_set_plat_data(struct platform_device *pdev, struct kbd_platform_data *data)
-{
-	pdev->dev.platform_data = data;
-}
-
 #endif /* __PLAT_KEYBOARD_H */
-- 
1.7.2.2
