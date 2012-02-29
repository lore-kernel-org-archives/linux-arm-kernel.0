From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 29 Feb 2012 23:33:49 +0100
Subject: [PATCH 13/13] ARM: OMAP3+: SmartReflex: fix error handling
In-Reply-To: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
References: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
Message-ID: <1330554829-11347-14-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the code to correctly use IS_ERR and PTR_ERR on the return
values pointers

Reported-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index eaefb1a..56ecfbc 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -421,7 +421,7 @@ int sr_configure_errgen(struct voltagedomain *voltdm)
 	if (IS_ERR(sr)) {
 		pr_warning("%s: omap_sr struct for sr_%s not found\n",
 			__func__, voltdm->name);
-		return -EINVAL;
+		return PTR_ERR(sr);
 	}
 
 	if (!sr->clk_length)
@@ -489,7 +489,7 @@ int sr_disable_errgen(struct voltagedomain *voltdm)
 	if (IS_ERR(sr)) {
 		pr_warning("%s: omap_sr struct for sr_%s not found\n",
 			__func__, voltdm->name);
-		return -EINVAL;
+		return PTR_ERR(sr);
 	}
 
 	switch (sr->ip_type) {
@@ -540,7 +540,7 @@ int sr_configure_minmax(struct voltagedomain *voltdm)
 	if (IS_ERR(sr)) {
 		pr_warning("%s: omap_sr struct for sr_%s not found\n",
 			__func__, voltdm->name);
-		return -EINVAL;
+		return PTR_ERR(sr);
 	}
 
 	if (!sr->clk_length)
@@ -626,7 +626,7 @@ int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
 	if (IS_ERR(sr)) {
 		pr_warning("%s: omap_sr struct for sr_%s not found\n",
 			__func__, voltdm->name);
-		return -EINVAL;
+		return PTR_ERR(sr);
 	}
 
 	volt_data = omap_voltage_get_voltdata(sr->voltdm, volt);
@@ -634,7 +634,7 @@ int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
 	if (IS_ERR(volt_data)) {
 		dev_warn(&sr->pdev->dev, "%s: Unable to get voltage table"
 			"for nominal voltage %ld\n", __func__, volt);
-		return -ENODATA;
+		return PTR_ERR(volt_data);
 	}
 
 	nvalue_reciprocal = sr_retrieve_nvalue(sr, volt_data->sr_efuse_offs);
@@ -1079,7 +1079,7 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 	if (IS_ERR(sr_info)) {
 		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
 			__func__);
-		return -EINVAL;
+		return PTR_ERR(sr_info);
 	}
 
 	if (sr_info->autocomp_active)
-- 
1.7.5.4
