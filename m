From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 1 Mar 2013 17:40:53 +0530
Subject: [PATCH 04/15] ARM: OMAP5: PM: Set MPUSS-EMIF clock-domain static
 dependency
In-Reply-To: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1362139864-9233-5-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With EMIF clock-domain put under hardware supervised control, memory
corruption and untraceable crashes are observed on OMAP5. Further
investigation revealed that there is a weakness in the PRCM on this
specific dynamic depedency.

The recommendation is to set MPUSS static dependency towards EMIF
clock-domain to avoid issues.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/pm_omap4plus.c |   36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm_omap4plus.c b/arch/arm/mach-omap2/pm_omap4plus.c
index 95d2712..4c37c47 100644
--- a/arch/arm/mach-omap2/pm_omap4plus.c
+++ b/arch/arm/mach-omap2/pm_omap4plus.c
@@ -168,6 +168,32 @@ static inline int omap4_init_static_deps(void)
 }
 
 /**
+ * omap5_init_static_deps - Init static clkdm dependencies on OMAP5
+ *
+ * The dynamic dependency between MPUSS -> EMIF is broken and has
+ * not worked as expected. The hardware recommendation is to
+ * enable static dependencies for these to avoid system
+ * lock ups or random crashes.
+ */
+static inline int omap5_init_static_deps(void)
+{
+	struct clockdomain *mpuss_clkdm, *emif_clkdm;
+	int ret;
+
+	mpuss_clkdm = clkdm_lookup("mpu_clkdm");
+	emif_clkdm = clkdm_lookup("emif_clkdm");
+	if (!mpuss_clkdm || !emif_clkdm)
+		return -EINVAL;
+
+	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
+	if (ret)
+		pr_err("Failed to add MPUSS -> EMIF wakeup dependency\n");
+
+	return ret;
+}
+
+
+/**
  * omap4_pm_init - Init routine for OMAP4+ devices
  *
  * Initializes all powerdomain and clockdomain target states
@@ -190,10 +216,14 @@ int __init omap4_pm_init(void)
 		goto err2;
 	}
 
-	if (cpu_is_omap44xx()) {
+	if (cpu_is_omap44xx())
 		ret = omap4_init_static_deps();
-		if (ret)
-			goto err2;
+	else if (soc_is_omap54xx())
+		ret = omap5_init_static_deps();
+
+	if (ret) {
+		pr_err("Failed to initialise static dependencies.\n");
+		goto err2;
 	}
 
 	ret = omap4_mpuss_init();
-- 
1.7.9.5
