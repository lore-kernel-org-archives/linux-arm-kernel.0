From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 28 Jan 2012 06:10:44 +0100
Subject: [FOR 3.4 PATCH 6/6] ARM: at91: board-dt nand switch to DT
In-Reply-To: <1327727444-23908-1-git-send-email-plagnioj@jcrosoft.com>
References: <1327727444-23908-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1327727444-23908-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remove the C nand devices registration

until we have the pinmux support let the bootloader initialise the pin

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9g20.dtsi     |   17 ++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi     |   15 +++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts |   27 ++++++++++++++++-
 arch/arm/boot/dts/usb_a9g20.dts        |   46 +++++++++++++++++++++++++++-
 arch/arm/mach-at91/board-dt.c          |   52 --------------------------------
 5 files changed, 103 insertions(+), 54 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 557b91f..dfbd4fb 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -178,6 +178,23 @@
 				interrupts = <20>;
 				status = "disabled";
 			};
+
+			nand0: nand at 40000000 {
+				compatible = "atmel,at91rm9200-nand";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x40000000 0x10000000
+				       0xffffe800 0x200
+				      >;
+				atmel,nand-addr-offset = <21>;
+				atmel,nand-cmd-offset = <22>;
+				gpios = <&pioC 13 0
+					 &pioC 14 0
+					 0
+					>;
+				status = "disabled";
+			};
+
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 179ea52..be88fc5 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -178,6 +178,21 @@
 				interrupts = <22>;
 				status = "disabled";
 			};
+
+			nand0: nand at 40000000 {
+				compatible = "atmel,at91rm9200-nand";
+				reg = <0x40000000 0x10000000
+				       0xffffe200 0x200
+				      >;
+				atmel,nand-addr-offset = <21>;
+				atmel,nand-cmd-offset = <22>;
+				gpios = <&pioC 8 0
+					 &pioC 14 0
+					 0
+					>;
+				status = "disabled";
+			};
+
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index e538da8..30d9cd7 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -14,7 +14,7 @@
 	compatible = "atmel,at91sam9m10g45ek", "atmel,at91sam9g45", "atmel,at91sam9";
 
 	chosen {
-		bootargs = "mem=64M console=ttyS0,115200 mtdparts=atmel_nand:4M(bootstrap/uboot/kernel)ro,60M(rootfs),-(data) root=/dev/mtdblock1 rw rootfstype=jffs2";
+		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock1 rw rootfstype=jffs2";
 	};
 
 	memory at 70000000 {
@@ -36,6 +36,31 @@
 				status = "okay";
 			};
 
+			nand0: nand at 40000000 {
+				nand-bus-width = <8>;
+				nand-ecc-mode = "soft";
+				nand-on-flash-bbt = <1>;
+				status = "okay";
+
+				boot at 0 {
+					label = "bootstrap/uboot/kernel";
+					reg = <0x0 0x400000>;
+				};
+
+				rootfs at 400000 {
+					label = "rootfs";
+					reg = <0x400000 0x3C00000>;
+				};
+
+				data at 4000000 {
+					label = "data";
+					reg = <0x4000000 0xC000000>;
+				};
+
+			};
+		};
+	};
+
 			usb0: ohci at 00700000 {
 				status = "okay";
 				num-ports = <2>;
diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index 073afe4e..cf0fda2 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -13,7 +13,7 @@
 	compatible = "calao,usb-a9g20", "atmel,at91sam9g20", "atmel,at91sam9";
 
 	chosen {
-		bootargs = "mem=64M console=ttyS0,115200 mtdparts=atmel_nand:128k(at91bootstrap),256k(barebox)ro,128k(bareboxenv),128k(bareboxenv2),4M(kernel),120M(rootfs),-(data) root=/dev/mtdblock5 rw rootfstype=ubifs";
+		bootargs = "mem=64M console=ttyS0,115200 root=/dev/mtdblock5 rw rootfstype=ubifs";
 	};
 
 	memory at 20000000 {
@@ -35,6 +35,50 @@
 				num-ports = <2>;
 				status = "okay";
 			};
+
+			nand0: nand at 40000000 {
+				nand-bus-width = <8>;
+				nand-ecc-mode = "soft";
+				nand-on-flash-bbt = <1>;
+				status = "okay";
+
+				at91bootstrap at 0 {
+					label = "at91bootstrap";
+					reg = <0x0 0x20000>;
+				};
+
+				barebox at 20000 {
+					label = "barebox";
+					reg = <0x20000 0x40000>;
+				};
+
+				bareboxenv at 60000 {
+					label = "bareboxenv";
+					reg = <0x60000 0x20000>;
+				};
+
+				bareboxenv2 at 80000 {
+					label = "bareboxenv2";
+					reg = <0x80000 0x20000>;
+				};
+
+				kernel at a0000 {
+					label = "kernel";
+					reg = <0xa0000 0x400000>;
+				};
+
+				rootfs at 4a0000 {
+					label = "rootfs";
+					reg = <0x4a0000 0x7800000>;
+				};
+
+				data at 7ca0000 {
+					label = "data";
+					reg = <0x7ca0000 0x8360000>;
+				};
+
+			};
+
 		};
 	};
 };
diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index a42cad8..6aaec27 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -19,10 +19,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
-#include <mach/hardware.h>
 #include <mach/board.h>
-#include <mach/system_rev.h>
-#include <mach/at91sam9_smc.h>
 
 #include <asm/setup.h>
 #include <asm/irq.h>
@@ -30,10 +27,8 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include "sam9_smc.h"
 #include "generic.h"
 
-
 static void __init ek_init_early(void)
 {
 	/* Initialize processor: 12.000 MHz crystal */
@@ -46,50 +41,6 @@ static void __init ek_init_early(void)
 	at91_set_serial_console(0);
 }
 
-/* det_pin is not connected */
-static struct atmel_nand_data __initdata ek_nand_data = {
-	.ale		= 21,
-	.cle		= 22,
-	.det_pin	= -EINVAL,
-	.rdy_pin	= AT91_PIN_PC8,
-	.enable_pin	= AT91_PIN_PC14,
-	.ecc_mode	= NAND_ECC_SOFT,
-	.on_flash_bbt	= 1,
-};
-
-static struct sam9_smc_config __initdata ek_nand_smc_config = {
-	.ncs_read_setup		= 0,
-	.nrd_setup		= 2,
-	.ncs_write_setup	= 0,
-	.nwe_setup		= 2,
-
-	.ncs_read_pulse		= 4,
-	.nrd_pulse		= 4,
-	.ncs_write_pulse	= 4,
-	.nwe_pulse		= 4,
-
-	.read_cycle		= 7,
-	.write_cycle		= 7,
-
-	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE | AT91_SMC_EXNWMODE_DISABLE,
-	.tdf_cycles		= 3,
-};
-
-static void __init ek_add_device_nand(void)
-{
-	ek_nand_data.bus_width_16 = board_have_nand_16bit();
-	/* setup bus-width (8 or 16) */
-	if (ek_nand_data.bus_width_16)
-		ek_nand_smc_config.mode |= AT91_SMC_DBW_16;
-	else
-		ek_nand_smc_config.mode |= AT91_SMC_DBW_8;
-
-	/* configure chip-select 3 (NAND) */
-	sam9_smc_configure(0, 3, &ek_nand_smc_config);
-
-	at91_add_device_nand(&ek_nand_data);
-}
-
 static const struct of_device_id aic_of_match[] __initconst = {
 	{ .compatible = "atmel,at91rm9200-aic", },
 	{},
@@ -104,9 +55,6 @@ static void __init at91_dt_init_irq(void)
 static void __init at91_dt_device_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-
-	/* NAND */
-	ek_add_device_nand();
 }
 
 static const char *at91_dt_board_compat[] __initdata = {
-- 
1.7.7
