From: digetx@gmail.com (Dmitry Osipenko)
Date: Fri, 10 Oct 2014 17:24:47 +0400
Subject: [PATCH V3] ARM: tegra: Re-add removed SoC id macro to tegra_resume()
Message-ID: <1412947487-24287-1-git-send-email-digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d127e9c ("ARM: tegra: make tegra_resume can work with current and later
chips") removed tegra_get_soc_id macro leaving used cpu register corrupted after
branching to v7_invalidate_l1() and as result causing execution of unintended
code on tegra20. Possibly it was expected that r6 would be SoC id func argument
since common cpu reset handler is setting r6 before branching to tegra_resume(),
but neither tegra20_lp1_reset() nor tegra30_lp1_reset() aren't setting r6
register before jumping to resume function. Fix it by re-adding macro.

Fixes: d127e9c (ARM: tegra: make tegra_resume can work with current and later chips)
Cc: <stable@vger.kernel.org> # v3.13+
Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
V2: added Cc's for lakml and stable, added "Reviewed-by:" Felipe Balbi
V3: changed commit description, tested on real hw

PS: It wasn't a bug in my emulator :)

 arch/arm/mach-tegra/reset-handler.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 7b2baab..71be4af 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -51,6 +51,7 @@ ENTRY(tegra_resume)
  THUMB(	it	ne )
 	bne	cpu_resume			@ no
 
+	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
 	/* Are we on Tegra20? */
 	cmp	r6, #TEGRA20
 	beq	1f				@ Yes
-- 
2.1.1
