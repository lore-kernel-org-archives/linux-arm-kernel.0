From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 03 Dec 2009 06:45:39 -0700
Subject: [PATCH 6/9] OMAP2/3 powerdomain: return errors rather than returning
	the output of IS_ERR()
In-Reply-To: <20091203134321.16229.87539.stgit@localhost.localdomain>
References: <20091203134321.16229.87539.stgit@localhost.localdomain>
Message-ID: <20091203134537.16229.73790.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roel Kluin <roel.kluin@gmail.com>

IS_ERR returns only 1 or 0, and the functions return a negative error
in other cases anyways.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 1dd1a38..47d5768 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -478,7 +478,7 @@ int pwrdm_add_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 	if (IS_ERR(p)) {
 		pr_debug("powerdomain: hardware cannot set/clear wake up of "
 			 "%s when %s wakes up\n", pwrdm1->name, pwrdm2->name);
-		return IS_ERR(p);
+		return PTR_ERR(p);
 	}
 
 	pr_debug("powerdomain: hardware will wake up %s when %s wakes up\n",
@@ -511,7 +511,7 @@ int pwrdm_del_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 	if (IS_ERR(p)) {
 		pr_debug("powerdomain: hardware cannot set/clear wake up of "
 			 "%s when %s wakes up\n", pwrdm1->name, pwrdm2->name);
-		return IS_ERR(p);
+		return PTR_ERR(p);
 	}
 
 	pr_debug("powerdomain: hardware will no longer wake up %s after %s "
@@ -548,7 +548,7 @@ int pwrdm_read_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 	if (IS_ERR(p)) {
 		pr_debug("powerdomain: hardware cannot set/clear wake up of "
 			 "%s when %s wakes up\n", pwrdm1->name, pwrdm2->name);
-		return IS_ERR(p);
+		return PTR_ERR(p);
 	}
 
 	return prm_read_mod_bits_shift(pwrdm1->prcm_offs, PM_WKDEP,
@@ -582,7 +582,7 @@ int pwrdm_add_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 		pr_debug("powerdomain: hardware cannot set/clear sleep "
 			 "dependency affecting %s from %s\n", pwrdm1->name,
 			 pwrdm2->name);
-		return IS_ERR(p);
+		return PTR_ERR(p);
 	}
 
 	pr_debug("powerdomain: will prevent %s from sleeping if %s is active\n",
@@ -621,7 +621,7 @@ int pwrdm_del_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 		pr_debug("powerdomain: hardware cannot set/clear sleep "
 			 "dependency affecting %s from %s\n", pwrdm1->name,
 			 pwrdm2->name);
-		return IS_ERR(p);
+		return PTR_ERR(p);
 	}
 
 	pr_debug("powerdomain: will no longer prevent %s from sleeping if "
@@ -664,7 +664,7 @@ int pwrdm_read_sleepdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2)
 		pr_debug("powerdomain: hardware cannot set/clear sleep "
 			 "dependency affecting %s from %s\n", pwrdm1->name,
 			 pwrdm2->name);
-		return IS_ERR(p);
+		return PTR_ERR(p);
 	}
 
 	return prm_read_mod_bits_shift(pwrdm1->prcm_offs, OMAP3430_CM_SLEEPDEP,
