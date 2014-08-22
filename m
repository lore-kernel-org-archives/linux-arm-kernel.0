From: nm@ti.com (Nishanth Menon)
Date: Fri, 22 Aug 2014 08:49:29 -0500
Subject: [PATCH 3/7] ARM: OMAP2+: powerdomain: pwrdm_for_each_clkdm iterate
 only valid clkdms
In-Reply-To: <1408715373-25791-1-git-send-email-nm@ti.com>
References: <1408715373-25791-1-git-send-email-nm@ti.com>
Message-ID: <1408715373-25791-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No need to invoke callback when the clkdm pointer is NULL.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index faebd5f..f391948 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -546,7 +546,8 @@ int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
 		return -EINVAL;
 
 	for (i = 0; i < PWRDM_MAX_CLKDMS && !ret; i++)
-		ret = (*fn)(pwrdm, pwrdm->pwrdm_clkdms[i]);
+		if (pwrdm->pwrdm_clkdms[i])
+			ret = (*fn)(pwrdm, pwrdm->pwrdm_clkdms[i]);
 
 	return ret;
 }
-- 
1.7.9.5
