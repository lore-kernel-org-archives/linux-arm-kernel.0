From: pavel@denx.de (Pavel Machek)
Date: Mon, 28 Jan 2013 20:31:13 +0100
Subject: [PATCHv1 for soc 5/5] arm: socfpga: Add SMP support for actual
 socfpga harware
In-Reply-To: <1359075633-13502-6-git-send-email-dinguyen@altera.com>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-6-git-send-email-dinguyen@altera.com>
Message-ID: <20130128193113.GA26908@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I believe cpu1start_addr should go to the device tree, so that this
code is not neccessary. Proposed patch is below...

Thanks,
								Pavel

> +static void __init init_socfpga_vt(void)
> +{
> +	cpu1start_addr = 0xffd08010;
> +}
> +
> +static void __init init_socfpga(void)
> +{
> +	cpu1start_addr = 0xffd080c4;
> +}
> +
...
> +
> +	if (of_machine_is_compatible("altr,socfpga-vt"))
> +		init_socfpga_vt();
> +	else
> +		init_socfpga();

commit b0d651bb4deeb0d8d08969a47b77d3317cbbc0a2
Author: Pavel <pavel@ucw.cz>
Date:   Mon Jan 28 20:28:06 2013 +0100

    Fix whitespace in socfpga.dtsi.
    
    Move cpu1-start-addr variable to device tree, so that config code is
    not neccessary in kernel.
    
    Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 688729f..35d4bdc 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -180,13 +180,13 @@
 		};
 
 		rstmgr at ffd05000 {
-				compatible = "altr,rst-mgr";
-				reg = <0xffd05000 0x1000>;
-			};
+			compatible = "altr,rst-mgr";
+			reg = <0xffd05000 0x1000>;
+		};
 
 		sysmgr at ffd08000 {
-				compatible = "altr,sys-mgr";
-				reg = <0xffd08000 0x4000>;
-			};
+			compatible = "altr,sys-mgr";
+			reg = <0xffd08000 0x4000>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
index 1a6d088..e922475 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
@@ -56,5 +56,9 @@
 		serial1 at ffc03000 {
 			clock-frequency = <100000000>;
 		};
+
+		sysmgr at ffd08000 {
+			cpu1-start-addr = <0xffd08010>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index df3551f..407ba14 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -56,5 +56,9 @@
 		serial1 at ffc03000 {
 			clock-frequency = <7372800>;
 		};
+
+		sysmgr at ffd08000 {
+			cpu1-start-addr = <0xffd08010>;
+		};
 	};
 };
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 2d1e8db..bb17810 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -56,16 +56,6 @@ static void __init socfpga_scu_map_io(void)
 	iotable_init(&scu_io_desc, 1);
 }
 
-static void __init init_socfpga_vt(void)
-{
-	cpu1start_addr = 0xffd08010;
-}
-
-static void __init init_socfpga(void)
-{
-	cpu1start_addr = 0xffd080c4;
-}
-
 static void __init socfpga_map_io(void)
 {
 	socfpga_scu_map_io();
@@ -83,6 +73,11 @@ void __init socfpga_sysmgr_init(void)
 	struct device_node *np;
 
 	np = of_find_compatible_node(NULL, NULL, "altr,sys-mgr");
+
+	if (of_property_read_u32(np, "cpu1-start-addr", (u32 *) &cpu1start_addr)) {
+		early_printk("Need cpu1-start-addr in device tree.\n");
+		panic("Need cpu1-start-addr in device tree.\n");
+	}
 	sys_manager_base_addr = of_iomap(np, 0);
 
 	np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");
@@ -93,11 +88,6 @@ static void __init gic_init_irq(void)
 {
 	of_irq_init(irq_match);
 	socfpga_sysmgr_init();
-
-	if (of_machine_is_compatible("altr,socfpga-vt"))
-		init_socfpga_vt();
-	else
-		init_socfpga();
 }
 
 static void socfpga_cyclone5_restart(char mode, const char *cmd)


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
