From: zyw@rock-chips.com (Chris Zhong)
Date: Wed, 15 Apr 2015 13:57:11 +0800
Subject: [PATCH] ARM: rockchip: disable dapswjdp during suspend
Message-ID: <1429077431-31326-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reset dapswjdp is controlled by JTAG_TRSTN, if the iomux of this pin is
not "jtag_trstn". the AP would think this pin is always high, so it can
not reset before resume. When system resume, but the dapswjdp is not in
a default state, it may Access some illegal address, it cause system
crash during resume.
Let's disable this jtag function by clear the dapdeviceen bit, it
prohibit the dapswjdp to access memory and registers. This bit would
be enable in MASKROM, so we need clear it in suspend everytime.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>

---

 arch/arm/mach-rockchip/pm.c | 7 +++++++
 arch/arm/mach-rockchip/pm.h | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
index b07d886..b0dcbe2 100644
--- a/arch/arm/mach-rockchip/pm.c
+++ b/arch/arm/mach-rockchip/pm.c
@@ -83,6 +83,13 @@ static void rk3288_slp_mode_set(int level)
 		     SGRF_PCLK_WDT_GATE | SGRF_FAST_BOOT_EN
 		     | SGRF_PCLK_WDT_GATE_WRITE | SGRF_FAST_BOOT_EN_WRITE);
 
+	/*
+	 * The dapswjdp can not auto reset before resume, that cause it may
+	 * access some illegal address during resume. Let's disable it before
+	 * suspend, and the MASKROM will enable it back.
+	 */
+	regmap_write(sgrf_regmap, RK3288_SGRF_CPU_CON0, SGRF_DAPDEVICEEN_WRITE);
+
 	/* booting address of resuming system is from this register value */
 	regmap_write(sgrf_regmap, RK3288_SGRF_FAST_BOOT_ADDR,
 		     rk3288_bootram_phy);
diff --git a/arch/arm/mach-rockchip/pm.h b/arch/arm/mach-rockchip/pm.h
index 03ff31d..3e8d39c 100644
--- a/arch/arm/mach-rockchip/pm.h
+++ b/arch/arm/mach-rockchip/pm.h
@@ -55,6 +55,10 @@ static inline void rockchip_suspend_init(void)
 #define SGRF_FAST_BOOT_EN		BIT(8)
 #define SGRF_FAST_BOOT_EN_WRITE		BIT(24)
 
+#define RK3288_SGRF_CPU_CON0		(0x40)
+#define SGRF_DAPDEVICEEN		BIT(0)
+#define SGRF_DAPDEVICEEN_WRITE		BIT(16)
+
 #define RK3288_CRU_MODE_CON		0x50
 #define RK3288_CRU_SEL0_CON		0x60
 #define RK3288_CRU_SEL1_CON		0x64
-- 
1.9.1
