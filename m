From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Fri, 28 Feb 2014 12:12:45 +0100
Subject: [PATCH] CNS3xxx: Fix PCIe early iotable_init().
In-Reply-To: <m3eh2nqz7n.fsf@t19.piap.pl> ("Krzysztof =?utf-8?Q?Ha=C5=82as?=
 =?utf-8?Q?a=22's?= message of "Fri, 28 Feb 2014 12:00:12 +0100")
References: <m3eh2nqz7n.fsf@t19.piap.pl>
Message-ID: <m3sir3pk2a.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -240,7 +240,7 @@ static void __init cns3420_map_io(void)
 {
 	cns3xxx_map_io();
 	iotable_init(cns3420_io_desc, ARRAY_SIZE(cns3420_io_desc));
-
+	cns3xxx_pcie_iotable_init();
 	cns3420_early_serial_setup();
 }
 
--- a/arch/arm/mach-cns3xxx/core.h
+++ b/arch/arm/mach-cns3xxx/core.h
@@ -14,6 +14,7 @@
 #include <linux/reboot.h>
 
 extern void cns3xxx_timer_init(void);
+extern void cns3xxx_pcie_iotable_init(void);
 
 #ifdef CONFIG_CACHE_L2X0
 void __init cns3xxx_l2x0_init(void);
--- a/arch/arm/mach-cns3xxx/pcie.c
+++ b/arch/arm/mach-cns3xxx/pcie.c
@@ -357,6 +357,15 @@ static int cns3xxx_pcie_abort_handler(unsigned long addr, unsigned int fsr,
 	return 0;
 }
 
+void __init cns3xxx_pcie_iotable_init()
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cns3xxx_pcie); i++)
+		iotable_init(cns3xxx_pcie[i].cfg_bases,
+			     ARRAY_SIZE(cns3xxx_pcie[i].cfg_bases));
+}
+
 static int __init cns3xxx_pcie_init(void)
 {
 	int i;
@@ -368,8 +377,6 @@ static int __init cns3xxx_pcie_init(void)
 			"imprecise external abort");
 
 	for (i = 0; i < ARRAY_SIZE(cns3xxx_pcie); i++) {
-		iotable_init(cns3xxx_pcie[i].cfg_bases,
-			     ARRAY_SIZE(cns3xxx_pcie[i].cfg_bases));
 		cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_PCIE(i));
 		cns3xxx_pwr_soft_rst(0x1 << PM_SOFT_RST_REG_OFFST_PCIE(i));
 		cns3xxx_pcie_check_link(&cns3xxx_pcie[i]);
