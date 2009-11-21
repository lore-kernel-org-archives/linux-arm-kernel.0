From: roel.kluin@gmail.com (Roel Kluin)
Date: Sat, 21 Nov 2009 23:24:52 +0100
Subject: [PATCH] OMAP: return PTR_ERR rather than IS_ERR
Message-ID: <4B0868B4.6000605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IS_ERR returns only 1 or 0, and the functions return a negative
error in other cases anyways.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/arm/mach-omap2/powerdomain.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Inspired by a patch from Julia Lawall
Can be found with `git grep -n -E "return IS_ERR\([^?]*$"'

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index f00289a..a5a2811 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -480,7 +480,7 @@ int pwrdm_add_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 	if (IS_ERR(p)) {
 		pr_debug("powerdomain: hardware cannot set/clear wake up of "
 			 "%s when %s wakes up\n", pwrdm1->name, pwrdm2->name);
-		return IS_ERR(p);
+		return PTR_ERR(p);
 	}
 
 	pr_debug("powerdomain: hardware will wake up %s when %s wakes up\n",
@@ -513,7 +513,7 @@ int pwrdm_del_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 	if (IS_ERR(p)) {
 		pr_debug("powerdomain: hardware cannot set/clear wake up of "
 			 "%s when %s wakes up\n", pwrdm1->name, pwrdm2->name);
-		return IS_ERR(p);
+		return PTR_ERR(p);
 	}
 
 	pr_debug("powerdomain: hardware will no longer wake up %s after %s "
@@ -550,7 +550,7 @@ int pwrdm_read_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 	if (IS_ERR(p)) {
 		pr_debug("powerdomain: hardware cannot set/clear wake up of "
 			 "%s when %s wakes up\n", pwrdm1->name, pwrdm2->name);
-		return IS_ERR(p);
+		return PTR_ERR(p);
 	}
 
 	return prm_read_mod_bits_shift(pwrdm1->prcm_offs, PM_WKDEP,
@@ -584,7 +584,7 @@ int pwrdm_add_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 		pr_debug("powerdomain: hardware cannot set/clear sleep "
 			 "dependency affecting %s from %s\n", pwrdm1->name,
 			 pwrdm2->name);
-		return IS_ERR(p);
+		return PTR_ERR(p);
 	}
 
 	pr_debug("powerdomain: will prevent %s from sleeping if %s is active\n",
@@ -623,7 +623,7 @@ int pwrdm_del_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 		pr_debug("powerdomain: hardware cannot set/clear sleep "
 			 "dependency affecting %s from %s\n", pwrdm1->name,
 			 pwrdm2->name);
-		return IS_ERR(p);
+		return PTR_ERR(p);
 	}
 
 	pr_debug("powerdomain: will no longer prevent %s from sleeping if "
@@ -666,7 +666,7 @@ int pwrdm_read_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 		pr_debug("powerdomain: hardware cannot set/clear sleep "
 			 "dependency affecting %s from %s\n", pwrdm1->name,
 			 pwrdm2->name);
-		return IS_ERR(p);
+		return PTR_ERR(p);
 	}
 
 	return prm_read_mod_bits_shift(pwrdm1->prcm_offs, OMAP3430_CM_SLEEPDEP,
