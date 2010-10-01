From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:26:06 +0530
Subject: [PATCH V2 46/69] ST SPEAr13xx: Adding machine support for pci gadget
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <52b8b1701090d726b3af6b79b98cd967229113d8.1285933332.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pratyush Anand <pratyush.anand@st.com>

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/include/mach/generic.h |    3 +
 arch/arm/mach-spear13xx/include/mach/spear.h   |    2 +-
 arch/arm/mach-spear13xx/spear1300_evb.c        |    1 +
 arch/arm/mach-spear13xx/spear1310_evb.c        |    1 +
 arch/arm/mach-spear13xx/spear13xx.c            |   94 ++++++++++++++++++++++++
 5 files changed, 100 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 9b0f009..56ed7a7 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -40,6 +40,9 @@ extern struct platform_device spear13xx_kbd_device;
 extern struct platform_device spear13xx_nand_device;
 extern struct platform_device spear13xx_ohci0_device;
 extern struct platform_device spear13xx_ohci1_device;
+extern struct platform_device spear13xx_pcie_gadget0_device;
+extern struct platform_device spear13xx_pcie_gadget1_device;
+extern struct platform_device spear13xx_pcie_gadget2_device;
 extern struct platform_device spear13xx_rtc_device;
 extern struct platform_device spear13xx_sdhci_device;
 extern struct platform_device spear13xx_smi_device;
diff --git a/arch/arm/mach-spear13xx/include/mach/spear.h b/arch/arm/mach-spear13xx/include/mach/spear.h
index cf25eb5..d043280 100644
--- a/arch/arm/mach-spear13xx/include/mach/spear.h
+++ b/arch/arm/mach-spear13xx/include/mach/spear.h
@@ -60,7 +60,7 @@
 #define SPEAR13XX_SYS_LOCATION		(SPEAR13XX_SYSRAM0_BASE + 0x600)
 
 #define SPEAR13XX_SYSRAM1_BASE		UL(0xE0800000)
-#define SPEAR13XX_SYSRAM1_SIZE		0x00800000
+#define SPEAR13XX_SYSRAM1_SIZE		0x00001000
 #define SPEAR13XX_CLCD_BASE		UL(0xE1000000)
 #define SPEAR13XX_C3_BASE		UL(0xE1800000)
 #define SPEAR13XX_GETH_BASE		UL(0xE2000000)
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index e56fbd4..34e2647 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -52,6 +52,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear13xx_nand_device,
 	&spear13xx_ohci0_device,
 	&spear13xx_ohci1_device,
+	&spear13xx_pcie_gadget0_device,
 	&spear13xx_rtc_device,
 	&spear13xx_sdhci_device,
 	&spear13xx_smi_device,
diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index f6b4323..1af152f 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -53,6 +53,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	&spear13xx_nand_device,
 	&spear13xx_ohci0_device,
 	&spear13xx_ohci1_device,
+	&spear13xx_pcie_gadget0_device,
 	&spear13xx_rtc_device,
 	&spear13xx_sdhci_device,
 	&spear13xx_smi_device,
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 08e87d7..c86bd1c 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -429,6 +429,100 @@ struct platform_device spear13xx_sdhci_device = {
 	.resource = sdhci_resources,
 };
 
+/* pcie gadget registration */
+static struct resource pcie_gadget0_resources[] = {
+	{
+		.start = SPEAR13XX_PCIE0_APP_BASE,
+		.end = SPEAR13XX_PCIE0_APP_BASE + SZ_8K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = SPEAR13XX_PCIE0_BASE,
+		.end = SPEAR13XX_PCIE0_BASE + SZ_8K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_PCIE0,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+/* pcie_gadget0_id defaults to 0, being static variable */
+static int pcie_gadget0_id;
+static u64 pcie_gadget0_dmamask = ~0;
+
+struct platform_device spear13xx_pcie_gadget0_device = {
+	.name = "pcie-gadget-spear",
+	.id = 0,
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.dma_mask = &pcie_gadget0_dmamask,
+		.platform_data = &pcie_gadget0_id,
+	},
+	.num_resources = ARRAY_SIZE(pcie_gadget0_resources),
+	.resource = pcie_gadget0_resources,
+};
+
+static struct resource pcie_gadget1_resources[] = {
+	{
+		.start = SPEAR13XX_PCIE1_APP_BASE,
+		.end = SPEAR13XX_PCIE1_APP_BASE + SZ_8K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = SPEAR13XX_PCIE1_BASE,
+		.end = SPEAR13XX_PCIE1_BASE + SZ_8K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_PCIE1,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+/* pcie_gadget1_id defaults to 0, being static variable */
+static int pcie_gadget1_id;
+static u64 pcie_gadget1_dmamask = ~0;
+
+struct platform_device spear13xx_pcie_gadget1_device = {
+	.name = "pcie-gadget-spear",
+	.id = 1,
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.dma_mask = &pcie_gadget1_dmamask,
+		.platform_data = &pcie_gadget1_id,
+	},
+	.num_resources = ARRAY_SIZE(pcie_gadget1_resources),
+	.resource = pcie_gadget1_resources,
+};
+
+static struct resource pcie_gadget2_resources[] = {
+	{
+		.start = SPEAR13XX_PCIE2_APP_BASE,
+		.end = SPEAR13XX_PCIE2_APP_BASE + SZ_8K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = SPEAR13XX_PCIE2_BASE,
+		.end = SPEAR13XX_PCIE2_BASE + SZ_8K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_PCIE2,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+/* pcie_gadget2_id defaults to 0, being static variable */
+static int pcie_gadget2_id;
+static u64 pcie_gadget2_dmamask = ~0;
+
+struct platform_device spear13xx_pcie_gadget2_device = {
+	.name = "pcie-gadget-spear",
+	.id = 2,
+	.dev = {
+		.coherent_dma_mask = ~0,
+		.dma_mask = &pcie_gadget2_dmamask,
+		.platform_data = &pcie_gadget2_id,
+	},
+	.num_resources = ARRAY_SIZE(pcie_gadget2_resources),
+	.resource = pcie_gadget2_resources,
+};
+
 /* Do spear13xx familiy common initialization part here */
 void __init spear13xx_init(void)
 {
-- 
1.7.2.2
