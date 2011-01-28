From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Fri, 28 Jan 2011 18:24:11 +0200
Subject: [PATCH] arm: mach-omap2: voltage: debugfs: fix memory leak
Message-ID: <1296231851-20632-1-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The temporary string holding the directory name to be created should
be released.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/voltage.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index ed6079c..12be525 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -471,6 +471,7 @@ static void __init vdd_debugfs_init(struct omap_vdd_info *vdd)
 	strcat(name, vdd->voltdm.name);
 
 	vdd->debug_dir = debugfs_create_dir(name, voltage_dir);
+	kfree(name);
 	if (IS_ERR(vdd->debug_dir)) {
 		pr_warning("%s: Unable to create debugfs directory for"
 			" vdd_%s\n", __func__, vdd->voltdm.name);
-- 
1.5.6.5
