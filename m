From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 23:18:14 +0200
Subject: [PATCH 3/4] ARM: at91/smc: add DT support
In-Reply-To: <20111016210819.GM1459@game.jcrosoft.org>
References: <20111016210819.GM1459@game.jcrosoft.org>
Message-ID: <1318799895-5121-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9m10g45ek.dts |   16 ++++++
 arch/arm/boot/dts/usb_a9g20.dts        |   16 ++++++
 arch/arm/mach-at91/board-dt.c          |   28 ----------
 arch/arm/mach-at91/sam9_smc.c          |   85 ++++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index fb0042d..d98d115 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -32,6 +32,22 @@
 			usart3: serial at fff98000 {
 				status = "disabled";
 			};
+			smc03: smc at ffffec30 {
+				compatible = "atmel,at91sam9260-smc";
+				reg = <0xffffec30 0x10>;
+				ncs_read_setup = <0>;
+				nrd_setup = <2>;
+				ncs_write_setup = <0>;
+				nwe_setup = <2>;
+				ncs_read_pulse = <4>;
+				nrd_pulse = <4>;
+				ncs_write_pulse = <4>;
+				nwe_pulse = <4>;
+				read_cycle = <7>;
+				write_cycle = <7>;
+				mode = <3>;
+				tdf_cycles = <3>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index 4432a29..89a3620 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -40,6 +40,22 @@
 			usart5: serial at fffd8000 {
 				status = "disabled";
 			};
+			smc03: smc at ffffec30 {
+				compatible = "atmel,at91sam9260-smc";
+				reg = <0xffffec30 0x10>;
+				ncs_read_setup = <0>;
+				nrd_setup = <2>;
+				ncs_write_setup = <0>;
+				nwe_setup = <2>;
+				ncs_read_pulse = <4>;
+				nrd_pulse = <4>;
+				ncs_write_pulse = <4>;
+				nwe_pulse = <4>;
+				read_cycle = <7>;
+				write_cycle = <7>;
+				mode = <3>;
+				tdf_cycles = <3>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/mach-at91/board-dt.c b/arch/arm/mach-at91/board-dt.c
index fdcbf72..f0a8e09 100644
--- a/arch/arm/mach-at91/board-dt.c
+++ b/arch/arm/mach-at91/board-dt.c
@@ -54,36 +54,8 @@ static struct atmel_nand_data __initdata ek_nand_data = {
 	.enable_pin	= AT91_PIN_PC14,
 };
 
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
 static void __init ek_add_device_nand(void)
 {
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
 	at91_add_device_nand(&ek_nand_data);
 }
 
diff --git a/arch/arm/mach-at91/sam9_smc.c b/arch/arm/mach-at91/sam9_smc.c
index 86d7d9e..0e6dcf6 100644
--- a/arch/arm/mach-at91/sam9_smc.c
+++ b/arch/arm/mach-at91/sam9_smc.c
@@ -61,3 +61,88 @@ void __init sam9_smc_init(int id, u32 addr)
 		return;
 	smc_base_addr[id] = ioremap(addr, 512);
 }
+
+#ifdef CONFIG_OF
+static struct of_device_id smc_ids[]  = {
+	{ .compatible = "atmel,at91sam9260-smc" },
+};
+
+int __init sam9_smc_of_config(struct device_node *np)
+{
+	struct sam9_smc_config config;
+	const unsigned int *prop;
+	void __iomem *base;
+
+	if (!np)
+		return -EIO;
+
+	prop = of_get_property(np, "ncs_read_setup", NULL);
+	if (prop)
+		config.ncs_read_setup = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "nrd_setup", NULL);
+	if (prop)
+		config.nrd_setup = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "ncs_write_setup", NULL);
+	if (prop)
+		config.ncs_write_setup = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "nwe_setup", NULL);
+	if (prop)
+		config.nwe_setup = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "ncs_read_pulse", NULL);
+	if (prop)
+		config.ncs_read_pulse = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "nrd_pulse", NULL);
+	if (prop)
+		config.nrd_pulse = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "ncs_write_pulse", NULL);
+	if (prop)
+		config.ncs_write_pulse = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "nwe_pulse", NULL);
+	if (prop)
+		config.nwe_pulse = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "read_cycle", NULL);
+	if (prop)
+		config.read_cycle = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "write_cycle", NULL);
+	if (prop)
+		config.write_cycle = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "mode", NULL);
+	if (prop)
+		config.mode = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "tdf_cycles", NULL);
+	if (prop)
+		config.tdf_cycles = be32_to_cpup(prop);
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		panic("unable to map smc registers\n");
+		return -EIO;
+	}
+
+	sam9_smc_cs_configure(base, &config);
+
+	return 0;
+}
+
+static int __init sam9_smc_of_init(void)
+{
+	struct device_node *np;
+
+	for_each_matching_node(np, smc_ids)
+		sam9_smc_of_config(np);
+
+	return 0;
+}
+early_initcall(sam9_smc_of_init);
+#endif
-- 
1.7.7
