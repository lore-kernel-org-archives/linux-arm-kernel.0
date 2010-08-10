From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 10 Aug 2010 14:44:08 +0900
Subject: [PATCH v7 5/6] ARM: S5PV210: clock registers (CLK_DIV/SRC/STAT)
In-Reply-To: <1281419049-11562-5-git-send-email-myungjoo.ham@samsung.com>
References: <1281419049-11562-1-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-2-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-3-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-4-git-send-email-myungjoo.ham@samsung.com>
	<1281419049-11562-5-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <1281419049-11562-6-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously, most of CLK_DIV/SRC register accessing mask and shift
values were used at arch/arm/mach-s5pv210/clock.c only; thus we
had not been using macros for these. However, as CPUFREQ uses
those shift and mask values as well, we'd better define them at a single
location, whose proper location would be regs-clock.h.

Note that only the information about registers used by CPUFREQ are
defined. However, we may need to define other registers later if we add
other parts. Besides, later, we will probably need to use these macros
at arch/arm/mach-s5pv210/clock.c as well especially for entries that are
used out of clock.c as well.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
--
v7:
	- Removed unnecessary defines.

---
 arch/arm/mach-s5pv210/include/mach/regs-clock.h |   45 +++++++++++++++++++++--
 1 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
index 2a25ab4..853128d 100644
--- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
@@ -63,12 +63,16 @@
 #define S5P_CLKGATE_IP4		S5P_CLKREG(0x470)
 
 #define S5P_CLKGATE_BLOCK	S5P_CLKREG(0x480)
-#define S5P_CLKGATE_BUS0	S5P_CLKREG(0x484)
-#define S5P_CLKGATE_BUS1	S5P_CLKREG(0x488)
-#define S5P_CLK_OUT		S5P_CLKREG(0x500)
+#define S5P_CLK_DIV_STAT0   S5P_CLKREG(0x1000)
+#define S5P_CLK_DIV_STAT1   S5P_CLKREG(0x1004)
+#define S5P_CLK_MUX_STAT0   S5P_CLKREG(0x1100)
+#define S5P_CLK_MUX_STAT1   S5P_CLKREG(0x1104)
+
+#define S5P_ARM_MCS_CON		S5P_CLKREG(0x6100)
 
 /* CLKSRC0 */
 #define S5P_CLKSRC0_MUX200_MASK		(0x1<<16)
+#define S5P_CLKSRC0_MUX200_SHIFT	(16)
 #define S5P_CLKSRC0_MUX166_MASK		(0x1<<20)
 #define S5P_CLKSRC0_MUX133_MASK		(0x1<<24)
 
@@ -90,6 +94,41 @@
 #define S5P_CLKDIV0_PCLK66_SHIFT	(28)
 #define S5P_CLKDIV0_PCLK66_MASK		(0x7 << S5P_CLKDIV0_PCLK66_SHIFT)
 
+/* CLKSRC2 */
+#define S5P_CLKSRC2_G3D_MASK		(0x3 << 0)
+#define S5P_CLKSRC2_G3D_SHIFT		(0)
+#define S5P_CLKSRC2_MFC_MASK		(0x3 << 4)
+#define S5P_CLKSRC2_MFC_SHIFT		(4)
+#define S5P_CLKSRC2_G2D_MASK		(0x3 << 8)
+#define S5P_CLKSRC2_G2D_SHIFT		(8)
+
+/* CLKDIV2 */
+#define S5P_CLKDIV2_G3D_MASK		(0xF << 0)
+#define S5P_CLKDIV2_G3D_SHIFT		(0)
+#define S5P_CLKDIV2_MFC_MASK		(0xF << 4)
+#define S5P_CLKDIV2_MFC_SHIFT		(4)
+#define S5P_CLKDIV2_G2D_MASK		(0xF << 8)
+#define S5P_CLKDIV2_G2D_SHIFT		(8)
+
+/* CLKDIV6 */
+#define S5P_CLKDIV6_ONEDRAM_MASK	(0xf<<28)
+#define S5P_CLKDIV6_ONEDRAM_SHIFT	(28)
+
+/* CLK_DIV_STAT0 */
+#define S5P_CLKDIV_STAT0_G3D		(1 << 16)
+#define S5P_CLKDIV_STAT0_MFC		(1 << 17)
+
+/* CLK_DIV_STAT1 */
+#define S5P_CLKDIV_STAT1_G2D		(1 << 20)
+
+/* CLK_MUX_STAT0 */
+#define S5P_CLKMUX_STAT0_MUX200		(1 << 18)
+
+/* CLK_MUX_STAT1 */
+#define S5P_CLKMUX_STAT1_G3D		(1 << 3)
+#define S5P_CLKMUX_STAT1_MFC		(1 << 7)
+#define S5P_CLKMUX_STAT1_G2D		(1 << 27)
+
 /* Registers related to power management */
 #define S5P_PWR_CFG		S5P_CLKREG(0xC000)
 #define S5P_EINT_WAKEUP_MASK	S5P_CLKREG(0xC004)
-- 
1.6.3.3
