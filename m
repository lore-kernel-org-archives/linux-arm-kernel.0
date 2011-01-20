From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 20 Jan 2011 12:55:59 +0530
Subject: [PATCH V5 21/63] ST SPEAr: Adding machine support for keyboard
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <e675ab3a6fd037563ab262fd870847c389fcaf6d.1295499394.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajeev Kumar <rajeev-dlh.kumar@st.com>

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |   17 +++++++++++++++++
 arch/arm/mach-spear13xx/spear13xx.c            |   19 +++++++++++++++++++
 arch/arm/mach-spear3xx/include/mach/generic.h  |    1 +
 arch/arm/mach-spear3xx/spear300.c              |   19 +++++++++++++++++++
 arch/arm/mach-spear3xx/spear300_evb.c          |   17 +++++++++++++++++
 6 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 6473316..0d21b79 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -33,6 +33,7 @@ extern struct amba_device spear13xx_uart_device;
 extern struct platform_device spear13xx_ehci0_device;
 extern struct platform_device spear13xx_ehci1_device;
 extern struct platform_device spear13xx_i2c_device;
+extern struct platform_device spear13xx_kbd_device;
 extern struct platform_device spear13xx_ohci0_device;
 extern struct platform_device spear13xx_ohci1_device;
 extern struct platform_device spear13xx_rtc_device;
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index 1518044..2d4b4cf 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -16,6 +16,7 @@
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/keyboard.h>
 
 static struct amba_device *amba_devs[] __initdata = {
 	&spear13xx_uart_device,
@@ -25,15 +26,31 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear13xx_ehci0_device,
 	&spear13xx_ehci1_device,
 	&spear13xx_i2c_device,
+	&spear13xx_kbd_device,
 	&spear13xx_ohci0_device,
 	&spear13xx_ohci1_device,
 	&spear13xx_rtc_device,
 };
 
+/* keyboard specific platform data */
+static DECLARE_KEYMAP(keymap);
+static struct matrix_keymap_data keymap_data = {
+	.keymap = keymap,
+	.keymap_size = ARRAY_SIZE(keymap),
+};
+
+static struct kbd_platform_data kbd_data = {
+	.keymap = &keymap_data,
+	.rep = 1,
+};
+
 static void __init spear1300_evb_init(void)
 {
 	unsigned int i;
 
+	/* set keyboard plat data */
+	kbd_set_plat_data(&spear13xx_kbd_device, &kbd_data);
+
 	/* call spear1300 machine init function */
 	spear1300_init();
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 2ebe8db..a0ef36d 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -166,6 +166,25 @@ struct platform_device spear13xx_ohci1_device = {
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
index b65a884..e82a900 100644
--- a/arch/arm/mach-spear3xx/include/mach/generic.h
+++ b/arch/arm/mach-spear3xx/include/mach/generic.h
@@ -108,6 +108,7 @@ extern struct pmx_driver pmx_driver;
 /* Add spear300 machine device structure declarations here */
 extern struct amba_device clcd_device;
 extern struct amba_device gpio1_device;
+extern struct platform_device kbd_device;
 
 /* pad mux modes */
 extern struct pmx_mode nand_mode;
diff --git a/arch/arm/mach-spear3xx/spear300.c b/arch/arm/mach-spear3xx/spear300.c
index 1921cf8..fab998c 100644
--- a/arch/arm/mach-spear3xx/spear300.c
+++ b/arch/arm/mach-spear3xx/spear300.c
@@ -407,6 +407,25 @@ struct amba_device gpio1_device = {
 	.irq = {VIRQ_GPIO1, NO_IRQ},
 };
 
+/* keyboard device registration */
+static struct resource kbd_resources[] = {
+	{
+		.start = SPEAR300_KEYBOARD_BASE,
+		.end = SPEAR300_KEYBOARD_BASE + SZ_1K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = VIRQ_KEYBOARD,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device kbd_device = {
+	.name = "keyboard",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(kbd_resources),
+	.resource = kbd_resources,
+};
+
 /* spear3xx shared irq */
 struct shirq_dev_config shirq_ras1_config[] = {
 	{
diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
index caa7000..330b677 100644
--- a/arch/arm/mach-spear3xx/spear300_evb.c
+++ b/arch/arm/mach-spear3xx/spear300_evb.c
@@ -15,6 +15,7 @@
 #include <asm/mach-types.h>
 #include <mach/generic.h>
 #include <mach/spear.h>
+#include <plat/keyboard.h>
 
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
@@ -51,6 +52,19 @@ static struct platform_device *plat_devs[] __initdata = {
 	&rtc_device,
 
 	/* spear300 specific devices */
+	&kbd_device,
+};
+
+/* keyboard specific platform data */
+static DECLARE_KEYMAP(keymap);
+static struct matrix_keymap_data keymap_data = {
+	.keymap = keymap,
+	.keymap_size = ARRAY_SIZE(keymap),
+};
+
+static struct kbd_platform_data kbd_data = {
+	.keymap = &keymap_data,
+	.rep = 1,
 };
 
 static void __init spear300_evb_init(void)
@@ -62,6 +76,9 @@ static void __init spear300_evb_init(void)
 	pmx_driver.devs = pmx_devs;
 	pmx_driver.devs_count = ARRAY_SIZE(pmx_devs);
 
+	/* set keyboard plat data */
+	kbd_set_plat_data(&kbd_device, &kbd_data);
+
 	/* call spear300 machine init function */
 	spear300_init();
 
-- 
1.7.3.4
