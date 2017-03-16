From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 16 Mar 2017 09:30:31 +0100
Subject: [PATCH v2 4/7] mfd: syscon: atmel-smc: Remove unused helpers/macros
In-Reply-To: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1489653034-17777-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All macros prefixed with AT91[SAM9]_SMC have been replaced by equivalent
definitions prefixed with ATMEL_SMC, and the at91sam9_smc_xxxx() helpers
are no longer used.
Drop these definitions before someone starts using them again.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mfd/syscon/atmel-smc.h | 152 -----------------------------------
 1 file changed, 152 deletions(-)

diff --git a/include/linux/mfd/syscon/atmel-smc.h b/include/linux/mfd/syscon/atmel-smc.h
index 00e6e3c8ee6f..afa266169800 100644
--- a/include/linux/mfd/syscon/atmel-smc.h
+++ b/include/linux/mfd/syscon/atmel-smc.h
@@ -17,58 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/regmap.h>
 
-#define AT91SAM9_SMC_GENERIC		0x00
-#define AT91SAM9_SMC_GENERIC_BLK_SZ	0x10
-
-#define SAMA5_SMC_GENERIC		0x600
-#define SAMA5_SMC_GENERIC_BLK_SZ	0x14
-
-#define AT91SAM9_SMC_SETUP(o)		((o) + 0x00)
-#define AT91SAM9_SMC_NWESETUP(x)	(x)
-#define AT91SAM9_SMC_NCS_WRSETUP(x)	((x) << 8)
-#define AT91SAM9_SMC_NRDSETUP(x)	((x) << 16)
-#define AT91SAM9_SMC_NCS_NRDSETUP(x)	((x) << 24)
-
-#define AT91SAM9_SMC_PULSE(o)		((o) + 0x04)
-#define AT91SAM9_SMC_NWEPULSE(x)	(x)
-#define AT91SAM9_SMC_NCS_WRPULSE(x)	((x) << 8)
-#define AT91SAM9_SMC_NRDPULSE(x)	((x) << 16)
-#define AT91SAM9_SMC_NCS_NRDPULSE(x)	((x) << 24)
-
-#define AT91SAM9_SMC_CYCLE(o)		((o) + 0x08)
-#define AT91SAM9_SMC_NWECYCLE(x)	(x)
-#define AT91SAM9_SMC_NRDCYCLE(x)	((x) << 16)
-
-#define AT91SAM9_SMC_MODE(o)		((o) + 0x0c)
-#define SAMA5_SMC_MODE(o)		((o) + 0x10)
-#define AT91_SMC_READMODE		BIT(0)
-#define AT91_SMC_READMODE_NCS		(0 << 0)
-#define AT91_SMC_READMODE_NRD		(1 << 0)
-#define AT91_SMC_WRITEMODE		BIT(1)
-#define AT91_SMC_WRITEMODE_NCS		(0 << 1)
-#define AT91_SMC_WRITEMODE_NWE		(1 << 1)
-#define AT91_SMC_EXNWMODE		GENMASK(5, 4)
-#define AT91_SMC_EXNWMODE_DISABLE	(0 << 4)
-#define AT91_SMC_EXNWMODE_FROZEN	(2 << 4)
-#define AT91_SMC_EXNWMODE_READY		(3 << 4)
-#define AT91_SMC_BAT			BIT(8)
-#define AT91_SMC_BAT_SELECT		(0 << 8)
-#define AT91_SMC_BAT_WRITE		(1 << 8)
-#define AT91_SMC_DBW			GENMASK(13, 12)
-#define AT91_SMC_DBW_8			(0 << 12)
-#define AT91_SMC_DBW_16			(1 << 12)
-#define AT91_SMC_DBW_32			(2 << 12)
-#define AT91_SMC_TDF			GENMASK(19, 16)
-#define AT91_SMC_TDF_(x)		((((x) - 1) << 16) & AT91_SMC_TDF)
-#define AT91_SMC_TDF_MAX		16
-#define AT91_SMC_TDFMODE_OPTIMIZED	BIT(20)
-#define AT91_SMC_PMEN			BIT(24)
-#define AT91_SMC_PS			GENMASK(29, 28)
-#define AT91_SMC_PS_4			(0 << 28)
-#define AT91_SMC_PS_8			(1 << 28)
-#define AT91_SMC_PS_16			(2 << 28)
-#define AT91_SMC_PS_32			(3 << 28)
-
 #define ATMEL_SMC_SETUP(cs)			(((cs) * 0x10))
 #define ATMEL_HSMC_SETUP(cs)			(0x600 + ((cs) * 0x14))
 #define ATMEL_SMC_PULSE(cs)			(((cs) * 0x10) + 0x4)
@@ -157,104 +105,4 @@ void atmel_smc_cs_conf_get(struct regmap *regmap, int cs,
 void atmel_hsmc_cs_conf_get(struct regmap *regmap, int cs,
 			    struct atmel_smc_cs_conf *conf);
 
-/*
- * This function converts a setup timing expressed in nanoseconds into an
- * encoded value that can be written in the SMC_SETUP register.
- *
- * The following formula is described in atmel datasheets (section
- * "SMC Setup Register"):
- *
- * setup length = (128* SETUP[5] + SETUP[4:0])
- *
- * where setup length is the timing expressed in cycles.
- */
-static inline u32 at91sam9_smc_setup_ns_to_cycles(unsigned int clk_rate,
-						  u32 timing_ns)
-{
-	u32 clk_period = DIV_ROUND_UP(NSEC_PER_SEC, clk_rate);
-	u32 coded_cycles = 0;
-	u32 cycles;
-
-	cycles = DIV_ROUND_UP(timing_ns, clk_period);
-	if (cycles / 32) {
-		coded_cycles |= 1 << 5;
-		if (cycles < 128)
-			cycles = 0;
-	}
-
-	coded_cycles |= cycles % 32;
-
-	return coded_cycles;
-}
-
-/*
- * This function converts a pulse timing expressed in nanoseconds into an
- * encoded value that can be written in the SMC_PULSE register.
- *
- * The following formula is described in atmel datasheets (section
- * "SMC Pulse Register"):
- *
- * pulse length = (256* PULSE[6] + PULSE[5:0])
- *
- * where pulse length is the timing expressed in cycles.
- */
-static inline u32 at91sam9_smc_pulse_ns_to_cycles(unsigned int clk_rate,
-						  u32 timing_ns)
-{
-	u32 clk_period = DIV_ROUND_UP(NSEC_PER_SEC, clk_rate);
-	u32 coded_cycles = 0;
-	u32 cycles;
-
-	cycles = DIV_ROUND_UP(timing_ns, clk_period);
-	if (cycles / 64) {
-		coded_cycles |= 1 << 6;
-		if (cycles < 256)
-			cycles = 0;
-	}
-
-	coded_cycles |= cycles % 64;
-
-	return coded_cycles;
-}
-
-/*
- * This function converts a cycle timing expressed in nanoseconds into an
- * encoded value that can be written in the SMC_CYCLE register.
- *
- * The following formula is described in atmel datasheets (section
- * "SMC Cycle Register"):
- *
- * cycle length = (CYCLE[8:7]*256 + CYCLE[6:0])
- *
- * where cycle length is the timing expressed in cycles.
- */
-static inline u32 at91sam9_smc_cycle_ns_to_cycles(unsigned int clk_rate,
-						  u32 timing_ns)
-{
-	u32 clk_period = DIV_ROUND_UP(NSEC_PER_SEC, clk_rate);
-	u32 coded_cycles = 0;
-	u32 cycles;
-
-	cycles = DIV_ROUND_UP(timing_ns, clk_period);
-	if (cycles / 128) {
-		coded_cycles = cycles / 256;
-		cycles %= 256;
-		if (cycles >= 128) {
-			coded_cycles++;
-			cycles = 0;
-		}
-
-		if (coded_cycles > 0x3) {
-			coded_cycles = 0x3;
-			cycles = 0x7f;
-		}
-
-		coded_cycles <<= 7;
-	}
-
-	coded_cycles |= cycles % 128;
-
-	return coded_cycles;
-}
-
 #endif /* _LINUX_MFD_SYSCON_ATMEL_SMC_H_ */
-- 
2.7.4
