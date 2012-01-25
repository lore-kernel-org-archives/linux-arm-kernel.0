From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:33:28 +0000
Subject: [PATCH 10/33] MFD: mcp-sa11x0: move setup of PPC unit out of
 mcp-sa11x0.c
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3ui-0000YI-Q2@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch taken from af9081ae64 (ARM: sa1100: Refactor mcp-sa11x0 to use
platform resources.) by Jochen Friedrich <jochen@scram.de>, and
consolidated to use a common function.

Move the setup of the PPC unit out of mcp-sa11x0 into the core SA11x0
code, and call it from each platforms initialization file.  This
centralizes the setup of the PPC unit while not polluting the mcp-sa11x0
driver with these details.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/assabet.c |    2 ++
 arch/arm/mach-sa1100/cerf.c    |    1 +
 arch/arm/mach-sa1100/collie.c  |    2 ++
 arch/arm/mach-sa1100/generic.c |   10 ++++++++++
 arch/arm/mach-sa1100/generic.h |    1 +
 arch/arm/mach-sa1100/lart.c    |    1 +
 arch/arm/mach-sa1100/shannon.c |    1 +
 arch/arm/mach-sa1100/simpad.c  |    1 +
 drivers/mfd/mcp-sa11x0.c       |    9 ---------
 9 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 0c4b76a..3a19145 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -231,6 +231,8 @@ static void __init assabet_init(void)
 	PPDR |= PPC_TXD3 | PPC_TXD1;
 	PPSR |= PPC_TXD3 | PPC_TXD1;
 
+	sa11x0_ppc_configure_mcp();
+
 	sa1100fb_lcd_power = assabet_lcd_power;
 	sa1100fb_backlight_power = assabet_backlight_power;
 
diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index 11bb6d0..bc11879 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -128,6 +128,7 @@ static struct mcp_plat_data cerf_mcp_data = {
 
 static void __init cerf_init(void)
 {
+	sa11x0_ppc_configure_mcp();
 	platform_add_devices(cerf_devices, ARRAY_SIZE(cerf_devices));
 	sa11x0_register_mtd(&cerf_flash_data, &cerf_flash_resource, 1);
 	sa11x0_register_mcp(&cerf_mcp_data);
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index b9060e2..efa2bc1 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -341,6 +341,8 @@ static void __init collie_init(void)
 
 	GPSR |= _COLLIE_GPIO_UCB1x00_RESET;
 
+	sa11x0_ppc_configure_mcp();
+
 
 	platform_scoop_config = &collie_pcmcia_config;
 
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 480d2ea..1416094 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -240,6 +240,16 @@ static struct platform_device sa11x0mcp_device = {
 	.resource	= sa11x0mcp_resources,
 };
 
+void __init sa11x0_ppc_configure_mcp(void)
+{
+	/* Setup the PPC unit for the MCP */
+	PPDR &= ~PPC_RXD4;
+	PPDR |= PPC_TXD4 | PPC_SCLK | PPC_SFRM;
+	PSDR |= PPC_RXD4;
+	PSDR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+	PPSR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
+}
+
 void sa11x0_register_mcp(struct mcp_plat_data *data)
 {
 	sa11x0_register_device(&sa11x0mcp_device, data);
diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index 33268cf..9236ff4 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -39,4 +39,5 @@ struct irda_platform_data;
 void sa11x0_register_irda(struct irda_platform_data *irda);
 
 struct mcp_plat_data;
+void sa11x0_ppc_configure_mcp(void);
 void sa11x0_register_mcp(struct mcp_plat_data *data);
diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index af4e276..eba64b7 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -28,6 +28,7 @@ static struct mcp_plat_data lart_mcp_data = {
 
 static void __init lart_init(void)
 {
+	sa11x0_ppc_configure_mcp();
 	sa11x0_register_mcp(&lart_mcp_data);
 }
 
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index 318b2b7..3efb4ac 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -59,6 +59,7 @@ static struct mcp_plat_data shannon_mcp_data = {
 
 static void __init shannon_init(void)
 {
+	sa11x0_ppc_configure_mcp();
 	sa11x0_register_mtd(&shannon_flash_data, &shannon_flash_resource, 1);
 	sa11x0_register_mcp(&shannon_mcp_data);
 }
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index e17c04d..3aa36ec 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -376,6 +376,7 @@ static int __init simpad_init(void)
 
 	pm_power_off = simpad_power_off;
 
+	sa11x0_ppc_configure_mcp();
 	sa11x0_register_mtd(&simpad_flash_data, simpad_flash_resources,
 			      ARRAY_SIZE(simpad_flash_resources));
 	sa11x0_register_mcp(&simpad_mcp_data);
diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index d2ebc64..5373a7a 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -166,15 +166,6 @@ static int mcp_sa11x0_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * Setup the PPC unit correctly.
-	 */
-	PPDR &= ~PPC_RXD4;
-	PPDR |= PPC_TXD4 | PPC_SCLK | PPC_SFRM;
-	PSDR |= PPC_RXD4;
-	PSDR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
-	PPSR &= ~(PPC_TXD4 | PPC_SCLK | PPC_SFRM);
-
-	/*
 	 * Initialise device.  Note that we initially
 	 * set the sampling rate to minimum.
 	 */
-- 
1.7.4.4
