From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 12 Jun 2012 18:31:34 +0300
Subject: [PATCHv3 19/20] ARM: OMAP4: PM: enable off mode by default
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Message-ID: <1339515095-9908-20-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

System will now enter device off by default during suspend.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm44xx.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 341655e..8054afc 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -114,7 +114,11 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	pwrst->pwrdm = pwrdm;
 	pwrst->next_state = pwrdm_get_achievable_func_pwrst(
 						pwrdm,
-						PWRDM_FUNC_PWRST_OSWR);
+						PWRDM_FUNC_PWRST_OFF);
+
+	if (pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE)
+		pwrst->next_state = PWRDM_FUNC_PWRST_OFF;
+
 	list_add(&pwrst->node, &pwrst_list);
 
 	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
-- 
1.7.4.1
