From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 19 Jul 2011 15:04:10 +0900
Subject: [PATCH v2 2/2] ARM: EXYNOS4: Add more registers to be saved and
	restored for PM
In-Reply-To: <CAJ0PZbRsnO-W4P=3kZvcSn+st4p38ARjsE458TzSreHAche1gw@mail.gmail.com>
References: <CAJ0PZbRsnO-W4P=3kZvcSn+st4p38ARjsE458TzSreHAche1gw@mail.gmail.com>
Message-ID: <1311055450-11751-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need more registers to be saved and restored for PM of Exynos4210.
Otherwise, with additional drivers running, suspend-to-RAM fails to wake
up properly. This patch adds registers omitted in the initial PM
patches.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
--
Changed from v1
- removed unnecessary registers
- As the patch 1/2 is not changed, it is not re-sent.

---
 arch/arm/mach-exynos4/pm.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/pm.c b/arch/arm/mach-exynos4/pm.c
index a103c13..5d6f768 100644
--- a/arch/arm/mach-exynos4/pm.c
+++ b/arch/arm/mach-exynos4/pm.c
@@ -27,6 +27,7 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 #include <plat/pll.h>
+#include <plat/regs-srom.h>
 
 #include <mach/regs-irq.h>
 #include <mach/regs-gpio.h>
@@ -67,7 +68,9 @@ static struct sleep_save exynos4_core_save[] = {
 	SAVE_ITEM(S5P_CLKSRC_TOP0),
 	SAVE_ITEM(S5P_CLKSRC_TOP1),
 	SAVE_ITEM(S5P_CLKSRC_CAM),
+	SAVE_ITEM(S5P_CLKSRC_TV),
 	SAVE_ITEM(S5P_CLKSRC_MFC),
+	SAVE_ITEM(S5P_CLKSRC_G3D),
 	SAVE_ITEM(S5P_CLKSRC_IMAGE),
 	SAVE_ITEM(S5P_CLKSRC_LCD0),
 	SAVE_ITEM(S5P_CLKSRC_LCD1),
@@ -94,6 +97,7 @@ static struct sleep_save exynos4_core_save[] = {
 	SAVE_ITEM(S5P_CLKDIV_PERIL4),
 	SAVE_ITEM(S5P_CLKDIV_PERIL5),
 	SAVE_ITEM(S5P_CLKDIV_TOP),
+	SAVE_ITEM(S5P_CLKSRC_MASK_TOP),
 	SAVE_ITEM(S5P_CLKSRC_MASK_CAM),
 	SAVE_ITEM(S5P_CLKSRC_MASK_TV),
 	SAVE_ITEM(S5P_CLKSRC_MASK_LCD0),
@@ -102,6 +106,7 @@ static struct sleep_save exynos4_core_save[] = {
 	SAVE_ITEM(S5P_CLKSRC_MASK_FSYS),
 	SAVE_ITEM(S5P_CLKSRC_MASK_PERIL0),
 	SAVE_ITEM(S5P_CLKSRC_MASK_PERIL1),
+	SAVE_ITEM(S5P_CLKDIV2_RATIO),
 	SAVE_ITEM(S5P_CLKGATE_SCLKCAM),
 	SAVE_ITEM(S5P_CLKGATE_IP_CAM),
 	SAVE_ITEM(S5P_CLKGATE_IP_TV),
@@ -122,8 +127,10 @@ static struct sleep_save exynos4_core_save[] = {
 	SAVE_ITEM(S5P_CLKGATE_IP_DMC),
 	SAVE_ITEM(S5P_CLKSRC_CPU),
 	SAVE_ITEM(S5P_CLKDIV_CPU),
+	SAVE_ITEM(S5P_CLKDIV_CPU + 0x4),
 	SAVE_ITEM(S5P_CLKGATE_SCLKCPU),
 	SAVE_ITEM(S5P_CLKGATE_IP_CPU),
+
 	/* GIC side */
 	SAVE_ITEM(S5P_VA_GIC_CPU + 0x000),
 	SAVE_ITEM(S5P_VA_GIC_CPU + 0x004),
@@ -232,11 +239,17 @@ static struct sleep_save exynos4_core_save[] = {
 	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC20),
 	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC24),
 
-
 	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x000),
 	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x010),
 	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x020),
 	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x030),
+
+	/* SROM side */
+	SAVE_ITEM(S5P_SROM_BW),
+	SAVE_ITEM(S5P_SROM_BC0),
+	SAVE_ITEM(S5P_SROM_BC1),
+	SAVE_ITEM(S5P_SROM_BC2),
+	SAVE_ITEM(S5P_SROM_BC3),
 };
 
 static struct sleep_save exynos4_l2cc_save[] = {
-- 
1.7.4.1
