From: nm@ti.com (Nishanth Menon)
Date: Fri, 18 May 2012 14:33:20 -0500
Subject: [PATCH 2/3] ARM: OMAP3+: PM: VP: check to ensure VP is idle before
 forceupdate
In-Reply-To: <1337369601-14915-1-git-send-email-nm@ti.com>
References: <[PATCH] ARM: OMAP3+: PM: VP: ensure VP is idle before disable>
 <1337369601-14915-1-git-send-email-nm@ti.com>
Message-ID: <1337369601-14915-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ideally in the flow of DVFS programming, VP should be in idle state
(since we disabled it) before entering forceupdate. Ensure that
this is the case. Not doing this could cause VP statemachine
to enter invalid states.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: linux-omap at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org

Signed-off-by: Vinay Amancha <vinaykumar@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/vp.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 925d869..985091b 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -123,6 +123,18 @@ int omap_vp_forceupdate_scale(struct voltagedomain *voltdm,
 	u8 target_vsel, current_vsel;
 	int ret, timeout = 0;
 
+/*
+	 * Wait for VP idle Typical latency is <2us. Maximum latency is ~100us
+	 * This is an additional allowance to ensure we are in proper state
+	 * to enter into forceupdate state transition.
+	 */
+	omap_test_timeout((voltdm->read(vp->vstatus)),
+			  VP_IDLE_TIMEOUT, timeout);
+
+	if (timeout >= VP_IDLE_TIMEOUT)
+		pr_warning("%s: vdd_%s idle timedout forceupdate(v=%ld)\n",
+			   __func__, voltdm->name, target_volt);
+
 	ret = omap_vc_pre_scale(voltdm, target_volt, &target_vsel, &current_vsel);
 	if (ret)
 		return ret;
-- 
1.7.9.5
