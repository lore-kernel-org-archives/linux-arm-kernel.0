From: zonque@gmail.com (Daniel Mack)
Date: Sun, 18 Dec 2011 20:13:48 +0100
Subject: [PATCH] ARM: OMAP: avoid NULL pointer dereference when no PMIC is
 configured
Message-ID: <1324235628-26439-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/vp.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 66bd700..5407173 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -41,6 +41,11 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 	u32 val, sys_clk_rate, timeout, waittime;
 	u32 vddmin, vddmax, vstepmin, vstepmax;
 
+	if (!voltdm->pmic) {
+		pr_err("%s: No PMIC configured.\n", __func__, voltdm->name);
+		return;
+	}
+
 	if (!voltdm->read || !voltdm->write) {
 		pr_err("%s: No read/write API for accessing vdd_%s regs\n",
 			__func__, voltdm->name);
-- 
1.7.7.4
