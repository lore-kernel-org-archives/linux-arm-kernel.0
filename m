From: frans.klaver@xsens.com (Frans Klaver)
Date: Fri, 28 Aug 2015 12:10:32 +0200
Subject: [PATCH] arm: omap2: vc: fix 'or' always true warning
In-Reply-To: <DUB128-W519E183FDD98EF80BD4CB79C6E0@phx.gbl>
References: <DUB128-W519E183FDD98EF80BD4CB79C6E0@phx.gbl>
Message-ID: <1440756632-14043-1-git-send-email-frans.klaver@xsens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frans Klaver <fransklaver@gmail.com>

Fix the warning:
arch/arm/mach-omap2/vc.c:302:47: warning: logical ?or? of collectively exhaustive tests is always true [-Wlogical-op]

As we're toggling both CLKREQ and OFFMODE, we should also be checking
OFFMODE.

Signed-off-by: Frans Klaver <fransklaver@gmail.com>
---
 arch/arm/mach-omap2/vc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 076fd20d7e5a..807bc79e3e3d 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -300,7 +300,7 @@ static void __init omap3_vc_init_pmic_signaling(struct voltagedomain *voltdm)
 
 	val = voltdm->read(OMAP3_PRM_POLCTRL_OFFSET);
 	if (!(val & OMAP3430_PRM_POLCTRL_CLKREQ_POL) ||
-	    (val & OMAP3430_PRM_POLCTRL_CLKREQ_POL)) {
+	    (val & OMAP3430_PRM_POLCTRL_OFFMODE_POL)) {
 		val |= OMAP3430_PRM_POLCTRL_CLKREQ_POL;
 		val &= ~OMAP3430_PRM_POLCTRL_OFFMODE_POL;
 		pr_debug("PM: fixing sys_clkreq and sys_off_mode polarity to 0x%x\n",
-- 
2.3.4
