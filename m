From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 5 Apr 2013 16:22:48 +0200
Subject: [PATCH 06/14] mfd: db8500-prcmu: get base address from resource
In-Reply-To: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
References: <1365171776-8463-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1365171776-8463-7-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

We cannot use a global variable stored in <mach/hardware.h> to
find the base address of the PRCMU. The real resource is already
there from the board, so use this to look up the base address
instead.

Currently the patch is kept minimal so as not to interfere with
other work being done on refactoring this driver, but at a later
point the defines using (prcmu_base + 0xnnn) need to be replaced
by pure offset defined for (0xnnn) and the base inlined with the
readl()/writel() and similar codepaths.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Sam, I'm requesting an ACK for taking this through the
ARM SoC tree.
---
 arch/arm/mach-ux500/cpu-db8500.c            |   2 -
 arch/arm/mach-ux500/cpu.c                   |   2 -
 arch/arm/mach-ux500/include/mach/hardware.h |   2 -
 drivers/mfd/db8500-prcmu.c                  |  47 ++++---
 drivers/mfd/dbx500-prcmu-regs.h             | 208 ++++++++++++++--------------
 5 files changed, 131 insertions(+), 130 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 19235cf..8c58dff 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -94,8 +94,6 @@ void __init u8500_map_io(void)
 		iotable_init(u9540_io_desc, ARRAY_SIZE(u9540_io_desc));
 	else
 		iotable_init(u8500_io_desc, ARRAY_SIZE(u8500_io_desc));
-
-	_PRCMU_BASE = __io_address(U8500_PRCMU_BASE);
 }
 
 static struct resource db8500_pmu_resources[] = {
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index af13b6d..38459e9 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -30,8 +30,6 @@
 #include "board-mop500.h"
 #include "id.h"
 
-void __iomem *_PRCMU_BASE;
-
 /*
  * FIXME: Should we set up the GPIO domain here?
  *
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index 5201dda..4eece2a 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -39,8 +39,6 @@
 
 #ifndef __ASSEMBLY__
 
-extern void __iomem *_PRCMU_BASE;
-
 #define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
 
 #endif				/* __ASSEMBLY__ */
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 9166427..acb8ef7 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -422,9 +422,10 @@ static DEFINE_SPINLOCK(clkout_lock);
 
 /* Global var to runtime determine TCDM base for v2 or v1 */
 static __iomem void *tcdm_base;
+static __iomem void *prcmu_base;
 
 struct clk_mgt {
-	void __iomem *reg;
+	u32 offset;
 	u32 pllsw;
 	int branch;
 	bool clk38div;
@@ -599,9 +600,9 @@ int db8500_prcmu_set_display_clocks(void)
 	while ((readl(PRCM_SEM) & PRCM_SEM_PRCM_SEM) != 0)
 		cpu_relax();
 
-	writel(PRCMU_DSI_CLOCK_SETTING, PRCM_HDMICLK_MGT);
-	writel(PRCMU_DSI_LP_CLOCK_SETTING, PRCM_TVCLK_MGT);
-	writel(PRCMU_DPI_CLOCK_SETTING, PRCM_LCDCLK_MGT);
+	writel(PRCMU_DSI_CLOCK_SETTING, prcmu_base + PRCM_HDMICLK_MGT);
+	writel(PRCMU_DSI_LP_CLOCK_SETTING, prcmu_base + PRCM_TVCLK_MGT);
+	writel(PRCMU_DPI_CLOCK_SETTING, prcmu_base + PRCM_LCDCLK_MGT);
 
 	/* Release the HW semaphore. */
 	writel(0, PRCM_SEM);
@@ -613,7 +614,7 @@ int db8500_prcmu_set_display_clocks(void)
 
 u32 db8500_prcmu_read(unsigned int reg)
 {
-	return readl(_PRCMU_BASE + reg);
+	return readl(prcmu_base + reg);
 }
 
 void db8500_prcmu_write(unsigned int reg, u32 value)
@@ -621,7 +622,7 @@ void db8500_prcmu_write(unsigned int reg, u32 value)
 	unsigned long flags;
 
 	spin_lock_irqsave(&prcmu_lock, flags);
-	writel(value, (_PRCMU_BASE + reg));
+	writel(value, (prcmu_base + reg));
 	spin_unlock_irqrestore(&prcmu_lock, flags);
 }
 
@@ -631,9 +632,9 @@ void db8500_prcmu_write_masked(unsigned int reg, u32 mask, u32 value)
 	unsigned long flags;
 
 	spin_lock_irqsave(&prcmu_lock, flags);
-	val = readl(_PRCMU_BASE + reg);
+	val = readl(prcmu_base + reg);
 	val = ((val & ~mask) | (value & mask));
-	writel(val, (_PRCMU_BASE + reg));
+	writel(val, (prcmu_base + reg));
 	spin_unlock_irqrestore(&prcmu_lock, flags);
 }
 
@@ -1059,7 +1060,7 @@ int db8500_prcmu_set_ddr_opp(u8 opp)
 /* Divide the frequency of certain clocks by 2 for APE_50_PARTLY_25_OPP. */
 static void request_even_slower_clocks(bool enable)
 {
-	void __iomem *clock_reg[] = {
+	u32 clock_reg[] = {
 		PRCM_ACLK_MGT,
 		PRCM_DMACLK_MGT
 	};
@@ -1076,7 +1077,7 @@ static void request_even_slower_clocks(bool enable)
 		u32 val;
 		u32 div;
 
-		val = readl(clock_reg[i]);
+		val = readl(prcmu_base + clock_reg[i]);
 		div = (val & PRCM_CLK_MGT_CLKPLLDIV_MASK);
 		if (enable) {
 			if ((div <= 1) || (div > 15)) {
@@ -1092,7 +1093,7 @@ static void request_even_slower_clocks(bool enable)
 		}
 		val = ((val & ~PRCM_CLK_MGT_CLKPLLDIV_MASK) |
 			(div & PRCM_CLK_MGT_CLKPLLDIV_MASK));
-		writel(val, clock_reg[i]);
+		writel(val, prcmu_base + clock_reg[i]);
 	}
 
 unlock_and_return:
@@ -1446,14 +1447,14 @@ static int request_clock(u8 clock, bool enable)
 	while ((readl(PRCM_SEM) & PRCM_SEM_PRCM_SEM) != 0)
 		cpu_relax();
 
-	val = readl(clk_mgt[clock].reg);
+	val = readl(prcmu_base + clk_mgt[clock].offset);
 	if (enable) {
 		val |= (PRCM_CLK_MGT_CLKEN | clk_mgt[clock].pllsw);
 	} else {
 		clk_mgt[clock].pllsw = (val & PRCM_CLK_MGT_CLKPLLSW_MASK);
 		val &= ~(PRCM_CLK_MGT_CLKEN | PRCM_CLK_MGT_CLKPLLSW_MASK);
 	}
-	writel(val, clk_mgt[clock].reg);
+	writel(val, prcmu_base + clk_mgt[clock].offset);
 
 	/* Release the HW semaphore. */
 	writel(0, PRCM_SEM);
@@ -1629,7 +1630,7 @@ static unsigned long clock_rate(u8 clock)
 	u32 pllsw;
 	unsigned long rate = ROOT_CLOCK_RATE;
 
-	val = readl(clk_mgt[clock].reg);
+	val = readl(prcmu_base + clk_mgt[clock].offset);
 
 	if (val & PRCM_CLK_MGT_CLK38) {
 		if (clk_mgt[clock].clk38div && (val & PRCM_CLK_MGT_CLK38DIV))
@@ -1785,7 +1786,7 @@ static long round_clock_rate(u8 clock, unsigned long rate)
 	unsigned long src_rate;
 	long rounded_rate;
 
-	val = readl(clk_mgt[clock].reg);
+	val = readl(prcmu_base + clk_mgt[clock].offset);
 	src_rate = clock_source_rate((val | clk_mgt[clock].pllsw),
 		clk_mgt[clock].branch);
 	div = clock_divider(src_rate, rate);
@@ -1933,7 +1934,7 @@ static void set_clock_rate(u8 clock, unsigned long rate)
 	while ((readl(PRCM_SEM) & PRCM_SEM_PRCM_SEM) != 0)
 		cpu_relax();
 
-	val = readl(clk_mgt[clock].reg);
+	val = readl(prcmu_base + clk_mgt[clock].offset);
 	src_rate = clock_source_rate((val | clk_mgt[clock].pllsw),
 		clk_mgt[clock].branch);
 	div = clock_divider(src_rate, rate);
@@ -1961,7 +1962,7 @@ static void set_clock_rate(u8 clock, unsigned long rate)
 		val &= ~PRCM_CLK_MGT_CLKPLLDIV_MASK;
 		val |= min(div, (u32)31);
 	}
-	writel(val, clk_mgt[clock].reg);
+	writel(val, prcmu_base + clk_mgt[clock].offset);
 
 	/* Release the HW semaphore. */
 	writel(0, PRCM_SEM);
@@ -3163,8 +3164,18 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 	int irq = 0, err = 0, i;
 	struct resource *res;
 
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "prcmu");
+	if (!res) {
+		dev_err(&pdev->dev, "no prcmu memory region provided\n");
+		return -ENOENT;
+	}
+	prcmu_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!prcmu_base) {
+		dev_err(&pdev->dev,
+			"failed to ioremap prcmu register memory\n");
+		return -ENOENT;
+	}
 	init_prcm_registers();
-
 	dbx500_fw_version_init(pdev, pdata->version_offset);
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "prcmu-tcdm");
 	if (!res) {
diff --git a/drivers/mfd/dbx500-prcmu-regs.h b/drivers/mfd/dbx500-prcmu-regs.h
index 79c76eb..439254d 100644
--- a/drivers/mfd/dbx500-prcmu-regs.h
+++ b/drivers/mfd/dbx500-prcmu-regs.h
@@ -13,136 +13,132 @@
 #ifndef __DB8500_PRCMU_REGS_H
 #define __DB8500_PRCMU_REGS_H
 
-#include <mach/hardware.h>
-
 #define BITS(_start, _end) ((BIT(_end) - BIT(_start)) + BIT(_end))
 
-#define PRCM_CLK_MGT(_offset) (void __iomem *)(IO_ADDRESS(U8500_PRCMU_BASE) \
-	+ _offset)
-#define PRCM_ACLK_MGT		PRCM_CLK_MGT(0x004)
-#define PRCM_SVACLK_MGT		PRCM_CLK_MGT(0x008)
-#define PRCM_SIACLK_MGT		PRCM_CLK_MGT(0x00C)
-#define PRCM_SGACLK_MGT		PRCM_CLK_MGT(0x014)
-#define PRCM_UARTCLK_MGT	PRCM_CLK_MGT(0x018)
-#define PRCM_MSP02CLK_MGT	PRCM_CLK_MGT(0x01C)
-#define PRCM_I2CCLK_MGT		PRCM_CLK_MGT(0x020)
-#define PRCM_SDMMCCLK_MGT	PRCM_CLK_MGT(0x024)
-#define PRCM_SLIMCLK_MGT	PRCM_CLK_MGT(0x028)
-#define PRCM_PER1CLK_MGT	PRCM_CLK_MGT(0x02C)
-#define PRCM_PER2CLK_MGT	PRCM_CLK_MGT(0x030)
-#define PRCM_PER3CLK_MGT	PRCM_CLK_MGT(0x034)
-#define PRCM_PER5CLK_MGT	PRCM_CLK_MGT(0x038)
-#define PRCM_PER6CLK_MGT	PRCM_CLK_MGT(0x03C)
-#define PRCM_PER7CLK_MGT	PRCM_CLK_MGT(0x040)
-#define PRCM_LCDCLK_MGT		PRCM_CLK_MGT(0x044)
-#define PRCM_BMLCLK_MGT		PRCM_CLK_MGT(0x04C)
-#define PRCM_HSITXCLK_MGT	PRCM_CLK_MGT(0x050)
-#define PRCM_HSIRXCLK_MGT	PRCM_CLK_MGT(0x054)
-#define PRCM_HDMICLK_MGT	PRCM_CLK_MGT(0x058)
-#define PRCM_APEATCLK_MGT	PRCM_CLK_MGT(0x05C)
-#define PRCM_APETRACECLK_MGT	PRCM_CLK_MGT(0x060)
-#define PRCM_MCDECLK_MGT	PRCM_CLK_MGT(0x064)
-#define PRCM_IPI2CCLK_MGT	PRCM_CLK_MGT(0x068)
-#define PRCM_DSIALTCLK_MGT	PRCM_CLK_MGT(0x06C)
-#define PRCM_DMACLK_MGT		PRCM_CLK_MGT(0x074)
-#define PRCM_B2R2CLK_MGT	PRCM_CLK_MGT(0x078)
-#define PRCM_TVCLK_MGT		PRCM_CLK_MGT(0x07C)
-#define PRCM_UNIPROCLK_MGT	PRCM_CLK_MGT(0x278)
-#define PRCM_SSPCLK_MGT		PRCM_CLK_MGT(0x280)
-#define PRCM_RNGCLK_MGT		PRCM_CLK_MGT(0x284)
-#define PRCM_UICCCLK_MGT	PRCM_CLK_MGT(0x27C)
-#define PRCM_MSP1CLK_MGT	PRCM_CLK_MGT(0x288)
-
-#define PRCM_ARM_PLLDIVPS	(_PRCMU_BASE + 0x118)
+#define PRCM_ACLK_MGT		(0x004)
+#define PRCM_SVACLK_MGT		(0x008)
+#define PRCM_SIACLK_MGT		(0x00C)
+#define PRCM_SGACLK_MGT		(0x014)
+#define PRCM_UARTCLK_MGT	(0x018)
+#define PRCM_MSP02CLK_MGT	(0x01C)
+#define PRCM_I2CCLK_MGT		(0x020)
+#define PRCM_SDMMCCLK_MGT	(0x024)
+#define PRCM_SLIMCLK_MGT	(0x028)
+#define PRCM_PER1CLK_MGT	(0x02C)
+#define PRCM_PER2CLK_MGT	(0x030)
+#define PRCM_PER3CLK_MGT	(0x034)
+#define PRCM_PER5CLK_MGT	(0x038)
+#define PRCM_PER6CLK_MGT	(0x03C)
+#define PRCM_PER7CLK_MGT	(0x040)
+#define PRCM_LCDCLK_MGT		(0x044)
+#define PRCM_BMLCLK_MGT		(0x04C)
+#define PRCM_HSITXCLK_MGT	(0x050)
+#define PRCM_HSIRXCLK_MGT	(0x054)
+#define PRCM_HDMICLK_MGT	(0x058)
+#define PRCM_APEATCLK_MGT	(0x05C)
+#define PRCM_APETRACECLK_MGT	(0x060)
+#define PRCM_MCDECLK_MGT	(0x064)
+#define PRCM_IPI2CCLK_MGT	(0x068)
+#define PRCM_DSIALTCLK_MGT	(0x06C)
+#define PRCM_DMACLK_MGT		(0x074)
+#define PRCM_B2R2CLK_MGT	(0x078)
+#define PRCM_TVCLK_MGT		(0x07C)
+#define PRCM_UNIPROCLK_MGT	(0x278)
+#define PRCM_SSPCLK_MGT		(0x280)
+#define PRCM_RNGCLK_MGT		(0x284)
+#define PRCM_UICCCLK_MGT	(0x27C)
+#define PRCM_MSP1CLK_MGT	(0x288)
+
+#define PRCM_ARM_PLLDIVPS	(prcmu_base + 0x118)
 #define PRCM_ARM_PLLDIVPS_ARM_BRM_RATE		0x3f
 #define PRCM_ARM_PLLDIVPS_MAX_MASK		0xf
 
-#define PRCM_PLLARM_LOCKP       (_PRCMU_BASE + 0x0a8)
+#define PRCM_PLLARM_LOCKP       (prcmu_base + 0x0a8)
 #define PRCM_PLLARM_LOCKP_PRCM_PLLARM_LOCKP3	0x2
 
-#define PRCM_ARM_CHGCLKREQ	(_PRCMU_BASE + 0x114)
+#define PRCM_ARM_CHGCLKREQ	(prcmu_base + 0x114)
 #define PRCM_ARM_CHGCLKREQ_PRCM_ARM_CHGCLKREQ	BIT(0)
 #define PRCM_ARM_CHGCLKREQ_PRCM_ARM_DIVSEL	BIT(16)
 
-#define PRCM_PLLARM_ENABLE	(_PRCMU_BASE + 0x98)
+#define PRCM_PLLARM_ENABLE	(prcmu_base + 0x98)
 #define PRCM_PLLARM_ENABLE_PRCM_PLLARM_ENABLE	0x1
 #define PRCM_PLLARM_ENABLE_PRCM_PLLARM_COUNTON	0x100
 
-#define PRCM_ARMCLKFIX_MGT	(_PRCMU_BASE + 0x0)
-#define PRCM_A9PL_FORCE_CLKEN	(_PRCMU_BASE + 0x19C)
-#define PRCM_A9_RESETN_CLR	(_PRCMU_BASE + 0x1f4)
-#define PRCM_A9_RESETN_SET	(_PRCMU_BASE + 0x1f0)
-#define PRCM_ARM_LS_CLAMP	(_PRCMU_BASE + 0x30c)
-#define PRCM_SRAM_A9		(_PRCMU_BASE + 0x308)
+#define PRCM_ARMCLKFIX_MGT	(prcmu_base + 0x0)
+#define PRCM_A9PL_FORCE_CLKEN	(prcmu_base + 0x19C)
+#define PRCM_A9_RESETN_CLR	(prcmu_base + 0x1f4)
+#define PRCM_A9_RESETN_SET	(prcmu_base + 0x1f0)
+#define PRCM_ARM_LS_CLAMP	(prcmu_base + 0x30c)
+#define PRCM_SRAM_A9		(prcmu_base + 0x308)
 
 #define PRCM_A9PL_FORCE_CLKEN_PRCM_A9PL_FORCE_CLKEN BIT(0)
 #define PRCM_A9PL_FORCE_CLKEN_PRCM_A9AXI_FORCE_CLKEN BIT(1)
 
 /* ARM WFI Standby signal register */
-#define PRCM_ARM_WFI_STANDBY    (_PRCMU_BASE + 0x130)
+#define PRCM_ARM_WFI_STANDBY    (prcmu_base + 0x130)
 #define PRCM_ARM_WFI_STANDBY_WFI0               0x08
 #define PRCM_ARM_WFI_STANDBY_WFI1               0x10
-#define PRCM_IOCR		(_PRCMU_BASE + 0x310)
+#define PRCM_IOCR		(prcmu_base + 0x310)
 #define PRCM_IOCR_IOFORCE			0x1
 
 /* CPU mailbox registers */
-#define PRCM_MBOX_CPU_VAL	(_PRCMU_BASE + 0x0fc)
-#define PRCM_MBOX_CPU_SET	(_PRCMU_BASE + 0x100)
-#define PRCM_MBOX_CPU_CLR	(_PRCMU_BASE + 0x104)
+#define PRCM_MBOX_CPU_VAL	(prcmu_base + 0x0fc)
+#define PRCM_MBOX_CPU_SET	(prcmu_base + 0x100)
+#define PRCM_MBOX_CPU_CLR	(prcmu_base + 0x104)
 
 /* Dual A9 core interrupt management unit registers */
-#define PRCM_A9_MASK_REQ	(_PRCMU_BASE + 0x328)
+#define PRCM_A9_MASK_REQ	(prcmu_base + 0x328)
 #define PRCM_A9_MASK_REQ_PRCM_A9_MASK_REQ	0x1
 
-#define PRCM_A9_MASK_ACK	(_PRCMU_BASE + 0x32c)
-#define PRCM_ARMITMSK31TO0	(_PRCMU_BASE + 0x11c)
-#define PRCM_ARMITMSK63TO32	(_PRCMU_BASE + 0x120)
-#define PRCM_ARMITMSK95TO64	(_PRCMU_BASE + 0x124)
-#define PRCM_ARMITMSK127TO96	(_PRCMU_BASE + 0x128)
-#define PRCM_POWER_STATE_VAL	(_PRCMU_BASE + 0x25C)
-#define PRCM_ARMITVAL31TO0	(_PRCMU_BASE + 0x260)
-#define PRCM_ARMITVAL63TO32	(_PRCMU_BASE + 0x264)
-#define PRCM_ARMITVAL95TO64	(_PRCMU_BASE + 0x268)
-#define PRCM_ARMITVAL127TO96	(_PRCMU_BASE + 0x26C)
-
-#define PRCM_HOSTACCESS_REQ	(_PRCMU_BASE + 0x334)
+#define PRCM_A9_MASK_ACK	(prcmu_base + 0x32c)
+#define PRCM_ARMITMSK31TO0	(prcmu_base + 0x11c)
+#define PRCM_ARMITMSK63TO32	(prcmu_base + 0x120)
+#define PRCM_ARMITMSK95TO64	(prcmu_base + 0x124)
+#define PRCM_ARMITMSK127TO96	(prcmu_base + 0x128)
+#define PRCM_POWER_STATE_VAL	(prcmu_base + 0x25C)
+#define PRCM_ARMITVAL31TO0	(prcmu_base + 0x260)
+#define PRCM_ARMITVAL63TO32	(prcmu_base + 0x264)
+#define PRCM_ARMITVAL95TO64	(prcmu_base + 0x268)
+#define PRCM_ARMITVAL127TO96	(prcmu_base + 0x26C)
+
+#define PRCM_HOSTACCESS_REQ	(prcmu_base + 0x334)
 #define PRCM_HOSTACCESS_REQ_HOSTACCESS_REQ 0x1
 #define PRCM_HOSTACCESS_REQ_WAKE_REQ	BIT(16)
 #define ARM_WAKEUP_MODEM	0x1
 
-#define PRCM_ARM_IT1_CLR	(_PRCMU_BASE + 0x48C)
-#define PRCM_ARM_IT1_VAL	(_PRCMU_BASE + 0x494)
-#define PRCM_HOLD_EVT		(_PRCMU_BASE + 0x174)
+#define PRCM_ARM_IT1_CLR	(prcmu_base + 0x48C)
+#define PRCM_ARM_IT1_VAL	(prcmu_base + 0x494)
+#define PRCM_HOLD_EVT		(prcmu_base + 0x174)
 
-#define PRCM_MOD_AWAKE_STATUS	(_PRCMU_BASE + 0x4A0)
+#define PRCM_MOD_AWAKE_STATUS	(prcmu_base + 0x4A0)
 #define PRCM_MOD_AWAKE_STATUS_PRCM_MOD_COREPD_AWAKE	BIT(0)
 #define PRCM_MOD_AWAKE_STATUS_PRCM_MOD_AAPD_AWAKE	BIT(1)
 #define PRCM_MOD_AWAKE_STATUS_PRCM_MOD_VMODEM_OFF_ISO	BIT(2)
 
-#define PRCM_ITSTATUS0		(_PRCMU_BASE + 0x148)
-#define PRCM_ITSTATUS1		(_PRCMU_BASE + 0x150)
-#define PRCM_ITSTATUS2		(_PRCMU_BASE + 0x158)
-#define PRCM_ITSTATUS3		(_PRCMU_BASE + 0x160)
-#define PRCM_ITSTATUS4		(_PRCMU_BASE + 0x168)
-#define PRCM_ITSTATUS5		(_PRCMU_BASE + 0x484)
-#define PRCM_ITCLEAR5		(_PRCMU_BASE + 0x488)
-#define PRCM_ARMIT_MASKXP70_IT	(_PRCMU_BASE + 0x1018)
+#define PRCM_ITSTATUS0		(prcmu_base + 0x148)
+#define PRCM_ITSTATUS1		(prcmu_base + 0x150)
+#define PRCM_ITSTATUS2		(prcmu_base + 0x158)
+#define PRCM_ITSTATUS3		(prcmu_base + 0x160)
+#define PRCM_ITSTATUS4		(prcmu_base + 0x168)
+#define PRCM_ITSTATUS5		(prcmu_base + 0x484)
+#define PRCM_ITCLEAR5		(prcmu_base + 0x488)
+#define PRCM_ARMIT_MASKXP70_IT	(prcmu_base + 0x1018)
 
 /* System reset register */
-#define PRCM_APE_SOFTRST	(_PRCMU_BASE + 0x228)
+#define PRCM_APE_SOFTRST	(prcmu_base + 0x228)
 
 /* Level shifter and clamp control registers */
-#define PRCM_MMIP_LS_CLAMP_SET     (_PRCMU_BASE + 0x420)
-#define PRCM_MMIP_LS_CLAMP_CLR     (_PRCMU_BASE + 0x424)
+#define PRCM_MMIP_LS_CLAMP_SET     (prcmu_base + 0x420)
+#define PRCM_MMIP_LS_CLAMP_CLR     (prcmu_base + 0x424)
 
 #define PRCM_MMIP_LS_CLAMP_DSIPLL_CLAMP		BIT(11)
 #define PRCM_MMIP_LS_CLAMP_DSIPLL_CLAMPI	BIT(22)
 
 /* PRCMU clock/PLL/reset registers */
-#define PRCM_PLLSOC0_FREQ	   (_PRCMU_BASE + 0x080)
-#define PRCM_PLLSOC1_FREQ	   (_PRCMU_BASE + 0x084)
-#define PRCM_PLLARM_FREQ	   (_PRCMU_BASE + 0x088)
-#define PRCM_PLLDDR_FREQ	   (_PRCMU_BASE + 0x08C)
+#define PRCM_PLLSOC0_FREQ	   (prcmu_base + 0x080)
+#define PRCM_PLLSOC1_FREQ	   (prcmu_base + 0x084)
+#define PRCM_PLLARM_FREQ	   (prcmu_base + 0x088)
+#define PRCM_PLLDDR_FREQ	   (prcmu_base + 0x08C)
 #define PRCM_PLL_FREQ_D_SHIFT	0
 #define PRCM_PLL_FREQ_D_MASK	BITS(0, 7)
 #define PRCM_PLL_FREQ_N_SHIFT	8
@@ -152,14 +148,14 @@
 #define PRCM_PLL_FREQ_SELDIV2	BIT(24)
 #define PRCM_PLL_FREQ_DIV2EN	BIT(25)
 
-#define PRCM_PLLDSI_FREQ           (_PRCMU_BASE + 0x500)
-#define PRCM_PLLDSI_ENABLE         (_PRCMU_BASE + 0x504)
-#define PRCM_PLLDSI_LOCKP          (_PRCMU_BASE + 0x508)
-#define PRCM_DSI_PLLOUT_SEL        (_PRCMU_BASE + 0x530)
-#define PRCM_DSITVCLK_DIV          (_PRCMU_BASE + 0x52C)
-#define PRCM_PLLDSI_LOCKP          (_PRCMU_BASE + 0x508)
-#define PRCM_APE_RESETN_SET        (_PRCMU_BASE + 0x1E4)
-#define PRCM_APE_RESETN_CLR        (_PRCMU_BASE + 0x1E8)
+#define PRCM_PLLDSI_FREQ           (prcmu_base + 0x500)
+#define PRCM_PLLDSI_ENABLE         (prcmu_base + 0x504)
+#define PRCM_PLLDSI_LOCKP          (prcmu_base + 0x508)
+#define PRCM_DSI_PLLOUT_SEL        (prcmu_base + 0x530)
+#define PRCM_DSITVCLK_DIV          (prcmu_base + 0x52C)
+#define PRCM_PLLDSI_LOCKP          (prcmu_base + 0x508)
+#define PRCM_APE_RESETN_SET        (prcmu_base + 0x1E4)
+#define PRCM_APE_RESETN_CLR        (prcmu_base + 0x1E8)
 
 #define PRCM_PLLDSI_ENABLE_PRCM_PLLDSI_ENABLE BIT(0)
 
@@ -188,30 +184,30 @@
 
 #define PRCM_APE_RESETN_DSIPLL_RESETN BIT(14)
 
-#define PRCM_CLKOCR		   (_PRCMU_BASE + 0x1CC)
+#define PRCM_CLKOCR		   (prcmu_base + 0x1CC)
 #define PRCM_CLKOCR_CLKOUT0_REF_CLK	(1 << 0)
 #define PRCM_CLKOCR_CLKOUT0_MASK	BITS(0, 13)
 #define PRCM_CLKOCR_CLKOUT1_REF_CLK	(1 << 16)
 #define PRCM_CLKOCR_CLKOUT1_MASK	BITS(16, 29)
 
 /* ePOD and memory power signal control registers */
-#define PRCM_EPOD_C_SET            (_PRCMU_BASE + 0x410)
-#define PRCM_SRAM_LS_SLEEP         (_PRCMU_BASE + 0x304)
+#define PRCM_EPOD_C_SET            (prcmu_base + 0x410)
+#define PRCM_SRAM_LS_SLEEP         (prcmu_base + 0x304)
 
 /* Debug power control unit registers */
-#define PRCM_POWER_STATE_SET       (_PRCMU_BASE + 0x254)
+#define PRCM_POWER_STATE_SET       (prcmu_base + 0x254)
 
 /* Miscellaneous unit registers */
-#define PRCM_DSI_SW_RESET          (_PRCMU_BASE + 0x324)
-#define PRCM_GPIOCR                (_PRCMU_BASE + 0x138)
+#define PRCM_DSI_SW_RESET          (prcmu_base + 0x324)
+#define PRCM_GPIOCR                (prcmu_base + 0x138)
 #define PRCM_GPIOCR_DBG_STM_MOD_CMD1            0x800
 #define PRCM_GPIOCR_DBG_UARTMOD_CMD0            0x1
 
 /* PRCMU HW semaphore */
-#define PRCM_SEM                   (_PRCMU_BASE + 0x400)
+#define PRCM_SEM                   (prcmu_base + 0x400)
 #define PRCM_SEM_PRCM_SEM BIT(0)
 
-#define PRCM_TCR                   (_PRCMU_BASE + 0x1C8)
+#define PRCM_TCR                   (prcmu_base + 0x1C8)
 #define PRCM_TCR_TENSEL_MASK       BITS(0, 7)
 #define PRCM_TCR_STOP_TIMERS       BIT(16)
 #define PRCM_TCR_DOZE_MODE         BIT(17)
@@ -239,15 +235,15 @@
 /* GPIOCR register */
 #define PRCM_GPIOCR_SPI2_SELECT BIT(23)
 
-#define PRCM_DDR_SUBSYS_APE_MINBW	(_PRCMU_BASE + 0x438)
-#define PRCM_CGATING_BYPASS		(_PRCMU_BASE + 0x134)
+#define PRCM_DDR_SUBSYS_APE_MINBW	(prcmu_base + 0x438)
+#define PRCM_CGATING_BYPASS		(prcmu_base + 0x134)
 #define PRCM_CGATING_BYPASS_ICN2	BIT(6)
 
 /* Miscellaneous unit registers */
-#define PRCM_RESOUTN_SET		(_PRCMU_BASE + 0x214)
-#define PRCM_RESOUTN_CLR		(_PRCMU_BASE + 0x218)
+#define PRCM_RESOUTN_SET		(prcmu_base + 0x214)
+#define PRCM_RESOUTN_CLR		(prcmu_base + 0x218)
 
 /* System reset register */
-#define PRCM_APE_SOFTRST		(_PRCMU_BASE + 0x228)
+#define PRCM_APE_SOFTRST		(prcmu_base + 0x228)
 
 #endif /* __DB8500_PRCMU_REGS_H */
-- 
1.7.11.3
