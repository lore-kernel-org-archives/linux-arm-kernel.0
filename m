From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 17 Feb 2012 18:50:07 +0100
Subject: [PATCH 15/18] ARM: at91: merge SRAM Memory banks thanks to mirroring
In-Reply-To: <1329501010-30468-1-git-send-email-nicolas.ferre@atmel.com>
References: <1329501010-30468-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <f3e34185733168991e0a35d60bbcd5f63f79fe4c.1329500622.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

On at91sam9260 and at91sam9g20 the SRAM banks are mirrored. We can
merge them together to be able to have bigger and continuous
internal RAM.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9260.c              |   13 +++++--------
 arch/arm/mach-at91/include/mach/at91sam9260.h |    4 ++++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 14882ae..4ade265 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -310,15 +310,12 @@ static void __init at91sam9xe_map_io(void)
 
 static void __init at91sam9260_map_io(void)
 {
-	if (cpu_is_at91sam9xe()) {
+	if (cpu_is_at91sam9xe())
 		at91sam9xe_map_io();
-	} else if (cpu_is_at91sam9g20()) {
-		at91_init_sram(0, AT91SAM9G20_SRAM0_BASE, AT91SAM9G20_SRAM0_SIZE);
-		at91_init_sram(1, AT91SAM9G20_SRAM1_BASE, AT91SAM9G20_SRAM1_SIZE);
-	} else {
-		at91_init_sram(0, AT91SAM9260_SRAM0_BASE, AT91SAM9260_SRAM0_SIZE);
-		at91_init_sram(1, AT91SAM9260_SRAM1_BASE, AT91SAM9260_SRAM1_SIZE);
-	}
+	else if (cpu_is_at91sam9g20())
+		at91_init_sram(0, AT91SAM9G20_SRAM_BASE, AT91SAM9G20_SRAM_SIZE);
+	else
+		at91_init_sram(0, AT91SAM9260_SRAM_BASE, AT91SAM9260_SRAM_SIZE);
 }
 
 static void __init at91sam9260_ioremap_registers(void)
diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
index 2e47b6d..08ae9af 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9260.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
@@ -113,6 +113,8 @@
 #define AT91SAM9260_SRAM0_SIZE	SZ_4K		/* Internal SRAM 0 size (4Kb) */
 #define AT91SAM9260_SRAM1_BASE	0x00300000	/* Internal SRAM 1 base address */
 #define AT91SAM9260_SRAM1_SIZE	SZ_4K		/* Internal SRAM 1 size (4Kb) */
+#define AT91SAM9260_SRAM_BASE	0x002FF000	/* Internal SRAM base address */
+#define AT91SAM9260_SRAM_SIZE	SZ_8K		/* Internal SRAM size (8Kb) */
 
 #define AT91SAM9260_UHP_BASE	0x00500000	/* USB Host controller */
 
@@ -126,6 +128,8 @@
 #define AT91SAM9G20_SRAM0_SIZE	SZ_16K		/* Internal SRAM 0 size (16Kb) */
 #define AT91SAM9G20_SRAM1_BASE	0x00300000	/* Internal SRAM 1 base address */
 #define AT91SAM9G20_SRAM1_SIZE	SZ_16K		/* Internal SRAM 1 size (16Kb) */
+#define AT91SAM9G20_SRAM_BASE	0x002FC000	/* Internal SRAM base address */
+#define AT91SAM9G20_SRAM_SIZE	SZ_32K		/* Internal SRAM size (32Kb) */
 
 #define AT91SAM9G20_UHP_BASE	0x00500000	/* USB Host controller */
 
-- 
1.7.9
