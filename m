From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  8 May 2011 16:15:38 +0200
Subject: [PATCH 11/14] [orion] Consolidate setup of the crypto engine.
In-Reply-To: <1304864141-1121-1-git-send-email-andrew@lunn.ch>
References: <1304864141-1121-1-git-send-email-andrew@lunn.ch>
Message-ID: <1304864141-1121-12-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-kirkwood/common.c           |   30 +-------------------------
 arch/arm/mach-orion5x/common.c            |   32 ++++------------------------
 arch/arm/plat-orion/common.c              |   31 ++++++++++++++++++++++++++++
 arch/arm/plat-orion/include/plat/common.h |    5 ++++
 4 files changed, 43 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index e0562e4..c77d62a 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -270,37 +270,11 @@ void __init kirkwood_uart1_init(void)
 /*****************************************************************************
  * Cryptographic Engines and Security Accelerator (CESA)
  ****************************************************************************/
-
-static struct resource kirkwood_crypto_res[] = {
-	{
-		.name   = "regs",
-		.start  = CRYPTO_PHYS_BASE,
-		.end    = CRYPTO_PHYS_BASE + 0xffff,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.name   = "sram",
-		.start  = KIRKWOOD_SRAM_PHYS_BASE,
-		.end    = KIRKWOOD_SRAM_PHYS_BASE + KIRKWOOD_SRAM_SIZE - 1,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.name   = "crypto interrupt",
-		.start  = IRQ_KIRKWOOD_CRYPTO,
-		.end    = IRQ_KIRKWOOD_CRYPTO,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device kirkwood_crypto_device = {
-	.name           = "mv_crypto",
-	.id             = -1,
-	.num_resources  = ARRAY_SIZE(kirkwood_crypto_res),
-	.resource       = kirkwood_crypto_res,
-};
-
 void __init kirkwood_crypto_init(void)
 {
 	kirkwood_clk_ctrl |= CGC_CRYPTO;
-	platform_device_register(&kirkwood_crypto_device);
+	orion_crypto_init(CRYPTO_PHYS_BASE, KIRKWOOD_SRAM_PHYS_BASE,
+			  KIRKWOOD_SRAM_SIZE, IRQ_KIRKWOOD_CRYPTO);
 }
 
 
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 1c4945c..33954f3 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -164,32 +164,9 @@ void __init orion5x_xor_init(void)
 			IRQ_ORION5X_XOR0, IRQ_ORION5X_XOR1);
 }
 
-static struct resource orion5x_crypto_res[] = {
-	{
-		.name   = "regs",
-		.start  = ORION5X_CRYPTO_PHYS_BASE,
-		.end    = ORION5X_CRYPTO_PHYS_BASE + 0xffff,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.name   = "sram",
-		.start  = ORION5X_SRAM_PHYS_BASE,
-		.end    = ORION5X_SRAM_PHYS_BASE + SZ_8K - 1,
-		.flags  = IORESOURCE_MEM,
-	}, {
-		.name   = "crypto interrupt",
-		.start  = IRQ_ORION5X_CESA,
-		.end    = IRQ_ORION5X_CESA,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device orion5x_crypto_device = {
-	.name           = "mv_crypto",
-	.id             = -1,
-	.num_resources  = ARRAY_SIZE(orion5x_crypto_res),
-	.resource       = orion5x_crypto_res,
-};
-
+/*****************************************************************************
+ * Cryptographic Engines and Security Accelerator (CESA)
+ ****************************************************************************/
 static int __init orion5x_crypto_init(void)
 {
 	int ret;
@@ -198,7 +175,8 @@ static int __init orion5x_crypto_init(void)
 	if (ret)
 		return ret;
 
-	return platform_device_register(&orion5x_crypto_device);
+	orion_crypto_init(ORION5X_CRYPTO_PHYS_BASE, ORION5X_SRAM_PHYS_BASE,
+			  SZ_8K, IRQ_ORION5X_CESA);
 }
 
 /*****************************************************************************
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 0984232..c21d4a7 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -927,4 +927,35 @@ void __init orion_sata_init(struct mv_sata_platform_data *sata_data,
 	platform_device_register(&orion_sata);
 }
 
+/*****************************************************************************
+ * Cryptographic Engines and Security Accelerator (CESA)
+ ****************************************************************************/
+static struct resource orion_crypto_resources[] = {
+	{
+		.name   = "regs",
+	}, {
+		.name   = "crypto interrupt",
+	}, {
+		.name   = "sram",
+		.flags  = IORESOURCE_MEM,
+	},
+};
 
+static struct platform_device orion_crypto = {
+	.name           = "mv_crypto",
+	.id             = -1,
+};
+
+void __init orion_crypto_init(unsigned long mapbase,
+			      unsigned long srambase,
+			      unsigned long sram_size,
+			      unsigned long irq)
+{
+	fill_resources(&orion_crypto, orion_crypto_resources,
+		       mapbase, 0xffff, irq);
+	orion_crypto.num_resources = 3;
+	orion_crypto_resources[2].start = srambase;
+	orion_crypto_resources[2].end = srambase + sram_size - 1;
+
+	platform_device_register(&orion_crypto);
+}
diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-orion/include/plat/common.h
index b93837a..cdbf649 100644
--- a/arch/arm/plat-orion/include/plat/common.h
+++ b/arch/arm/plat-orion/include/plat/common.h
@@ -113,4 +113,9 @@ void __init orion_sata_init(struct mv_sata_platform_data *sata_data,
 			    struct mbus_dram_target_info *mbus_dram_info,
 			    unsigned long mapbase,
 			    unsigned long irq);
+
+void __init orion_crypto_init(unsigned long mapbase,
+			      unsigned long srambase,
+			      unsigned long sram_size,
+			      unsigned long irq);
 #endif
-- 
1.7.4.4
