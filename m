From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 18 Sep 2012 15:17:54 +0100
Subject: [PATCH v2 12/13] ARM: vexpress: Remove motherboard dependencies in
 the DTS files
In-Reply-To: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1347977875-16855-13-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The way the VE motherboard Device Trees were constructed
enforced naming and structure of daughterboard files. This
patch makes it possible to simply include the motherboard
description anywhere in the main Device Tree and retires
the "arm,v2m-timer" alias - any of the motherboard SP804
timers will be used instead.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi     |   11 ++---------
 arch/arm/boot/dts/vexpress-v2m.dtsi         |   11 ++---------
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts |    6 +++---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts  |    6 +++---
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts     |    6 +++---
 arch/arm/boot/dts/vexpress-v2p-ca9.dts      |    6 +++---
 arch/arm/mach-vexpress/v2m.c                |   16 ++++++++++------
 7 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index fffda1f..03b72de 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -17,13 +17,8 @@
  * CHANGES TO vexpress-v2m.dtsi!
  */
 
-/ {
-	aliases {
-		arm,v2m_timer = &v2m_timer01;
-	};
-
-	motherboard {
-		compatible = "simple-bus";
+		compatible = "arm,vexpress,v2m-p1", "simple-bus";
+		arm,hbi = <0x190>;
 		arm,vexpress,site = <0>;
 		arm,v2m-memory-map = "rs1";
 		#address-cells = <2>; /* SMB chipselect number and offset */
@@ -338,5 +333,3 @@
 				arm,vexpress-sysreg,func = <11 0>;
 			};
 		};
-	};
-};
diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index 10e05d9..b3b223a 100644
--- a/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -17,13 +17,8 @@
  * CHANGES TO vexpress-v2m-rs1.dtsi!
  */
 
-/ {
-	aliases {
-		arm,v2m_timer = &v2m_timer01;
-	};
-
-	motherboard {
-		compatible = "simple-bus";
+		compatible = "arm,vexpress,v2m-p1", "simple-bus";
+		arm,hbi = <0x190>;
 		arm,vexpress,site = <0>;
 		#address-cells = <2>; /* SMB chipselect number and offset */
 		#size-cells = <1>;
@@ -337,5 +332,3 @@
 				arm,vexpress-sysreg,func = <11 0>;
 			};
 		};
-	};
-};
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
index 7c237af..959bcb0 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
@@ -219,7 +219,7 @@
 		};
 	};
 
-	motherboard {
+	smb {
 		ranges = <0 0 0 0x08000000 0x04000000>,
 			 <1 0 0 0x14000000 0x04000000>,
 			 <2 0 0 0x18000000 0x04000000>,
@@ -271,7 +271,7 @@
 				<0 0 40 &gic 0 40 4>,
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
+
+		/include/ "vexpress-v2m-rs1.dtsi"
 	};
 };
-
-/include/ "vexpress-v2m-rs1.dtsi"
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index c41a82d..8a6d66d 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -303,7 +303,7 @@
 		};
 	};
 
-	motherboard {
+	smb {
 		ranges = <0 0 0 0x08000000 0x04000000>,
 			 <1 0 0 0x14000000 0x04000000>,
 			 <2 0 0 0x18000000 0x04000000>,
@@ -355,7 +355,7 @@
 				<0 0 40 &gic 0 40 4>,
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
+
+		/include/ "vexpress-v2m-rs1.dtsi"
 	};
 };
-
-/include/ "vexpress-v2m-rs1.dtsi"
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
index 94486d6..e389066 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -182,7 +182,7 @@
 		};
 	};
 
-	motherboard {
+	smb {
 		ranges = <0 0 0x08000000 0x04000000>,
 			 <1 0 0x14000000 0x04000000>,
 			 <2 0 0x18000000 0x04000000>,
@@ -234,7 +234,7 @@
 				<0 0 40 &gic 0 40 4>,
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
+
+		/include/ "vexpress-v2m-rs1.dtsi"
 	};
 };
-
-/include/ "vexpress-v2m-rs1.dtsi"
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index bebbea4..8ab7995 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -259,7 +259,7 @@
 		};
 	};
 
-	motherboard {
+	smb {
 		ranges = <0 0 0x40000000 0x04000000>,
 			 <1 0 0x44000000 0x04000000>,
 			 <2 0 0x48000000 0x04000000>,
@@ -310,7 +310,7 @@
 				<0 0 40 &gic 0 40 4>,
 				<0 0 41 &gic 0 41 4>,
 				<0 0 42 &gic 0 42 4>;
+
+		/include/ "vexpress-v2m.dtsi"
 	};
 };
-
-/include/ "vexpress-v2m.dtsi"
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 827d02f..32ec333 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -393,7 +393,7 @@ static int __init v2m_dt_scan_memory_map(unsigned long node, const char *uname,
 {
 	const char **map = data;
 
-	if (strcmp(uname, "motherboard") != 0)
+	if (!of_flat_dt_is_compatible(node, "arm,vexpress,v2m-p1"))
 		return 0;
 
 	*map = of_get_flat_dt_prop(node, "arm,v2m-memory-map", NULL);
@@ -449,12 +449,16 @@ static void __init v2m_dt_timer_init(void)
 
 	vexpress_clk_of_init();
 
+	do {
+		node = of_find_compatible_node(node, NULL, "arm,sp804");
+	} while (node && vexpress_get_site_by_node(node) != VEXPRESS_SITE_MB);
+	if (node) {
+		pr_info("Using SP804 '%s' as a clock & events source\n",
+				node->full_name);
+		v2m_sp804_init(of_iomap(node, 0),
+				irq_of_parse_and_map(node, 0));
+	}
 
-	err = of_property_read_string(of_aliases, "arm,v2m_timer", &path);
-	if (WARN_ON(err))
-		return;
-	node = of_find_node_by_path(path);
-	v2m_sp804_init(of_iomap(node, 0), irq_of_parse_and_map(node, 0));
 	if (arch_timer_of_register() != 0)
 		twd_local_timer_of_register();
 
-- 
1.7.9.5
