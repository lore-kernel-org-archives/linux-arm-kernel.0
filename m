From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 7 Oct 2010 20:21:37 +0200
Subject: [PATCH] i.MX35: Add mx35_revision function to query the
	silicon revision
In-Reply-To: <20101007091413.GD28242@pengutronix.de>
References: <20101007091413.GD28242@pengutronix.de>
Message-ID: <20101007182137.GU29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Sascha,

I put you patch in my (still private) tree and suggest the following on
top of the two.  If you're OK I'd squash the hunks into the respective
patches and send them to you.

Best regards
Uwe

diff --git a/arch/arm/mach-mx3/cpu.c b/arch/arm/mach-mx3/cpu.c
index 161dfff..2872863 100644
--- a/arch/arm/mach-mx3/cpu.c
+++ b/arch/arm/mach-mx3/cpu.c
@@ -73,11 +73,11 @@ void __init mx35_read_cpu_rev(void)
 	rev = readl(rom + MX35_ROM_SI_REV);
 	switch (rev) {
 	case 0x1:
-		mx35_cpu_rev = MX35_CHIP_REV_1_0;
+		mx35_cpu_rev = MX3x_CHIP_REV_1_0;
 		srev = "1.0";
 		break;
 	case 0x2:
-		mx35_cpu_rev = MX35_CHIP_REV_2_0;
+		mx35_cpu_rev = MX3x_CHIP_REV_2_0;
 		srev = "2.0";
 		break;
 	}
@@ -86,4 +86,3 @@ void __init mx35_read_cpu_rev(void)
 
 	iounmap(rom);
 }
-
diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index 95f35c8..02d9890 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -50,8 +50,8 @@ struct imx_imx_sdma_data imx31_imx_sdma_data __initdata =
 #endif /* ifdef CONFIG_ARCH_MX31 */
 
 #ifdef CONFIG_ARCH_MX35
-const struct imx_imx_sdma_data imx35_imx_sdma_data __initconst =
-	imx_imx_sdma_data_entry_single(MX35, 2, "imx35", 2);
+struct imx_imx_sdma_data imx35_imx_sdma_data __initdata =
+	imx_imx_sdma_data_entry_single(MX35, 2, "imx35", 0);
 #endif /* ifdef CONFIG_ARCH_MX35 */
 
 #ifdef CONFIG_ARCH_MX51
@@ -108,9 +108,10 @@ static int __init imxXX_add_imx_dma(void)
 #endif
 
 #if defined(CONFIG_ARCH_MX35)
-	if (cpu_is_mx35())
+	if (cpu_is_mx35()) {
+		imx35_imx_sdma_data.pdata.to_version = mx35_revision() >> 4;
 		ret = imx_add_imx_sdma(&imx35_imx_sdma_data);
-	else
+	} else
 #endif
 
 #if defined(CONFIG_ARCH_MX51)
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index f740455..b651ee4 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -188,11 +188,7 @@
 
 #define MX35_PROD_SIGNATURE		0x1	/* For MX31 */
 
-/* silicon revisions specific to i.MX35 */
-#define MX35_CHIP_REV_1_0		0x1
-#define MX35_CHIP_REV_2_0		0x2
-
-#define MX35_SYSTEM_REV_MIN		MX35_CHIP_REV_1_0
+#define MX35_SYSTEM_REV_MIN		MX3x_CHIP_REV_1_0
 #define MX35_SYSTEM_REV_NUM		3
 
 #ifdef IMX_NEEDS_DEPRECATED_SYMBOLS

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
