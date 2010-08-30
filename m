From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:09:14 +0530
Subject: [PATCH 51/74] ST SPEAr1310: Adding fsmc nor support
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <d164d6bec35ab2dc319ea0e0b416d3a1b38fcf35.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipin Kumar <vipin.kumar@st.com>

Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/spear1310_evb.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-spear13xx/spear1310_evb.c b/arch/arm/mach-spear13xx/spear1310_evb.c
index 8b02104..fb4b7c0 100644
--- a/arch/arm/mach-spear13xx/spear1310_evb.c
+++ b/arch/arm/mach-spear13xx/spear1310_evb.c
@@ -23,9 +23,19 @@
 #include <mach/pcie.h>
 #include <plat/keyboard.h>
 #include <plat/nand.h>
+#include <plat/fsmc.h>
 #include <plat/smi.h>
 #include <plat/spi.h>
 
+#define PARTITION(n, off, sz)	{.name = n, .offset = off, .size = sz}
+
+static struct mtd_partition partition_info[] = {
+	PARTITION("X-loader", 0, 1 * 0x20000),
+	PARTITION("U-Boot", 0x20000, 3 * 0x20000),
+	PARTITION("Kernel", 0x80000, 24 * 0x20000),
+	PARTITION("Root File System", 0x380000, 84 * 0x20000),
+};
+
 static struct amba_device *amba_devs[] __initdata = {
 	/* spear13xx specific devices */
 	&gpio_device[0],
@@ -143,6 +153,10 @@ static void __init spear1310_evb_init(void)
 
 	/* initialize serial nor related data in smi plat data */
 	smi_init_board_info(&smi_device);
+	/* initialize fsmc related data in fsmc plat data */
+	fsmc_init_board_info(&fsmc_nor_device, partition_info,
+			ARRAY_SIZE(partition_info), FSMC_FLASH_WIDTH8);
+
 #ifdef CONFIG_PCIEPORTBUS
 	/* Enable PCIE0 clk */
 	enable_pcie0_clk();
@@ -155,6 +169,10 @@ static void __init spear1310_evb_init(void)
 	/* Add Amba Devices */
 	spear_amba_device_register(amba_devs, ARRAY_SIZE(amba_devs));
 
+	/* Initialize fsmc regiters */
+	fsmc_nor_init(&fsmc_nor_device, SPEAR13XX_FSMC_BASE, 0,
+			FSMC_FLASH_WIDTH8);
+
 	spi_init();
 }
 
-- 
1.7.2.2
