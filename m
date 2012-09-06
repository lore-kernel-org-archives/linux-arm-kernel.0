From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 6 Sep 2012 17:55:29 +0300
Subject: [PATCH 2/2] ARM: tegra: fix debugfs entry for Tegra30
In-Reply-To: <1346943329-4898-1-git-send-email-pdeschrijver@nvidia.com>
References: <1346943329-4898-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1346943329-4898-2-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra30 has more powerdomains than Tegra20. The debugfs code did not take this
into account.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/mach-tegra/powergate.c |   40 ++++++++++++++++++++++++++++++++++----
 1 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
index 27aee4a..de0662d 100644
--- a/arch/arm/mach-tegra/powergate.c
+++ b/arch/arm/mach-tegra/powergate.c
@@ -199,7 +199,9 @@ int __init tegra_powergate_init(void)
 
 #ifdef CONFIG_DEBUG_FS
 
-static const char * const powergate_name[] = {
+static const char * const *powergate_name;
+
+static const char * const powergate_name_t20[] = {
 	[TEGRA_POWERGATE_CPU]	= "cpu",
 	[TEGRA_POWERGATE_3D]	= "3d",
 	[TEGRA_POWERGATE_VENC]	= "venc",
@@ -209,6 +211,23 @@ static const char * const powergate_name[] = {
 	[TEGRA_POWERGATE_MPE]	= "mpe",
 };
 
+static const char * const powergate_name_t30[] = {
+	[TEGRA_POWERGATE_CPU]	= "cpu0",
+	[TEGRA_POWERGATE_3D]	= "3d0",
+	[TEGRA_POWERGATE_VENC]	= "venc",
+	[TEGRA_POWERGATE_VDEC]	= "vdec",
+	[TEGRA_POWERGATE_PCIE]	= "pcie",
+	[TEGRA_POWERGATE_L2]	= "l2",
+	[TEGRA_POWERGATE_MPE]	= "mpe",
+	[TEGRA_POWERGATE_HEG]	= "heg",
+	[TEGRA_POWERGATE_SATA]	= "sata",
+	[TEGRA_POWERGATE_CPU1]	= "cpu1",
+	[TEGRA_POWERGATE_CPU2]	= "cpu2",
+	[TEGRA_POWERGATE_CPU3]	= "cpu3",
+	[TEGRA_POWERGATE_CELP]	= "celp",
+	[TEGRA_POWERGATE_3D1]	= "3d1",
+};
+
 static int powergate_show(struct seq_file *s, void *data)
 {
 	int i;
@@ -238,10 +257,21 @@ int __init tegra_powergate_debugfs_init(void)
 {
 	struct dentry *d;
 
-	d = debugfs_create_file("powergate", S_IRUGO, NULL, NULL,
-		&powergate_fops);
-	if (!d)
-		return -ENOMEM;
+	switch (tegra_chip_id) {
+	case TEGRA20:
+		powergate_name = powergate_name_t20;
+		break;
+	case TEGRA30:
+		powergate_name = powergate_name_t30;
+		break;
+	}
+
+	if (powergate_name) {
+		d = debugfs_create_file("powergate", S_IRUGO, NULL, NULL,
+			&powergate_fops);
+		if (!d)
+			return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
1.7.7.rc0.72.g4b5ea.dirty
