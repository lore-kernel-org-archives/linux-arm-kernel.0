From: dahuang@nvidia.com (Danny Huang)
Date: Tue, 19 Mar 2013 10:33:25 +0800
Subject: [PATCH] ARM: tegra: fuse: add fuctions to read speedo id and process
 id
Message-ID: <1363660405-10668-1-git-send-email-dahuang@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add functions to read the speedo and process id of both cpu and soc.
There might be some drivers need the information as well.

Signed-off-by: Danny Huang <dahuang@nvidia.com>
---
 arch/arm/mach-tegra/fuse.c | 24 ++++++++++++++++++++++++
 include/linux/tegra-soc.h  |  6 +++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index f7db078..f0e356e 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -2,6 +2,7 @@
  * arch/arm/mach-tegra/fuse.c
  *
  * Copyright (C) 2010 Google, Inc.
+ * Copyright (c) 2013, NVIDIA CORPORATION.  All rights reserved.
  *
  * Author:
  *	Colin Cross <ccross@android.com>
@@ -161,3 +162,26 @@ unsigned long long tegra_chip_uid(void)
 	return (hi << 32ull) | lo;
 }
 EXPORT_SYMBOL(tegra_chip_uid);
+
+int tegra_get_cpu_process_id(void)
+{
+	return tegra_cpu_process_id;
+}
+
+int tegra_get_core_process_id(void)
+{
+	return tegra_core_process_id;
+}
+
+int tegra_get_cpu_speedo_id(void)
+{
+	if (tegra_chip_id == TEGRA20)
+		return -EINVAL;
+
+	return tegra_cpu_speedo_id;
+}
+
+int tegra_get_soc_speedo_id(void)
+{
+	return tegra_soc_speedo_id;
+}
diff --git a/include/linux/tegra-soc.h b/include/linux/tegra-soc.h
index 95f611d..b3e4b74 100644
--- a/include/linux/tegra-soc.h
+++ b/include/linux/tegra-soc.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2012,2013, NVIDIA CORPORATION.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -18,5 +18,9 @@
 #define __LINUX_TEGRA_SOC_H_
 
 u32 tegra_read_chipid(void);
+int tegra_get_cpu_process_id(void);
+int tegra_get_core_process_id(void);
+int tegra_get_cpu_speedo_id(void);
+int tegra_get_soc_speedo_id(void);
 
 #endif /* __LINUX_TEGRA_SOC_H_ */
-- 
1.8.2
