From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Tue, 03 Apr 2012 16:48:05 +0200
Subject: [PATCH v2 3/3] ep93xx: Add IDE support to edb93xx boards
In-Reply-To: <4F7B0C54.8010804@metasoft.pl>
References: <4F7B0C54.8010804@metasoft.pl>
Message-ID: <4F7B0DA5.6080703@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>

---
 arch/arm/mach-ep93xx/edb93xx.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

Index: linux-2.6/arch/arm/mach-ep93xx/edb93xx.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-ep93xx/edb93xx.c
+++ linux-2.6/arch/arm/mach-ep93xx/edb93xx.c
@@ -233,6 +233,29 @@ static void __init edb93xx_register_fb(v
 }
 
 
+/*************************************************************************
+ * EDB93xx IDE
+ *************************************************************************/
+static int __init edb93xx_has_ide(void)
+{
+	/*
+	 * Although EDB9312 and EDB9315 do have IDE capability, they have
+	 * INTRQ line wired as pull-up, which makes using IDE interface
+	 * problematic.
+	 */
+	return machine_is_edb9312() || machine_is_edb9315 ||
+	       machine_is_edb9315a();
+}
+
+static void __init edb93xx_register_ide(void)
+{
+	if (!edb93xx_has_ide())
+		return;
+
+	ep93xx_register_ide();
+}
+
+
 static void __init edb93xx_init_machine(void)
 {
 	ep93xx_init_devices();
@@ -243,6 +266,7 @@ static void __init edb93xx_init_machine(
 	edb93xx_register_i2s();
 	edb93xx_register_pwm();
 	edb93xx_register_fb();
+	edb93xx_register_ide();
 }
 
 
