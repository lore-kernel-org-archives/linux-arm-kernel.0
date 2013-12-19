From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 19 Dec 2013 04:36:47 -0800
Subject: [PATCH 1/6] ARM: tegra: fuse: add functions to read speedo ID and
 process ID
In-Reply-To: <20131219122857.3226.42830.stgit@tamien>
References: <20131219122857.3226.42830.stgit@tamien>
Message-ID: <20131219123639.3226.75285.stgit@tamien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Danny Huang <dahuang@nvidia.com>

Add functions to read the speedo and process id of both the CPU and the SoC.
There might be some drivers need the information as well.

Signed-off-by: Danny Huang <dahuang@nvidia.com>
[pwalmsley at nvidia.com: cleaned up the patch description; removed functions
 not used by the DFLL code for now]
Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
---
 arch/arm/mach-tegra/fuse.c |   15 +++++++++++++++
 include/linux/tegra-soc.h  |    4 +++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index c9ac23b385be..e3ca8abe858f 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -250,3 +250,18 @@ void __init tegra_init_fuse(void)
 		tegra_sku_id, tegra_cpu_process_id,
 		tegra_core_process_id);
 }
+
+int tegra_get_cpu_process_id(void)
+{
+	return tegra_cpu_process_id;
+}
+EXPORT_SYMBOL(tegra_get_cpu_process_id);
+
+int tegra_get_cpu_speedo_id(void)
+{
+	if (tegra_chip_id == TEGRA20)
+		return -EINVAL;
+
+	return tegra_cpu_speedo_id;
+}
+EXPORT_SYMBOL(tegra_get_cpu_speedo_id);
diff --git a/include/linux/tegra-soc.h b/include/linux/tegra-soc.h
index 95f611d78f3a..ec856fdf2ce7 100644
--- a/include/linux/tegra-soc.h
+++ b/include/linux/tegra-soc.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2012-2013 NVIDIA CORPORATION.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -18,5 +18,7 @@
 #define __LINUX_TEGRA_SOC_H_
 
 u32 tegra_read_chipid(void);
+int tegra_get_cpu_process_id(void);
+int tegra_get_cpu_speedo_id(void);
 
 #endif /* __LINUX_TEGRA_SOC_H_ */
