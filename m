From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 19 Dec 2013 04:36:56 -0800
Subject: [PATCH 2/6] ARM: tegra114: fuse: add DFLL FCPU minimum voltage
 override test function
In-Reply-To: <20131219122857.3226.42830.stgit@tamien>
References: <20131219122857.3226.42830.stgit@tamien>
Message-ID: <20131219123652.3226.98741.stgit@tamien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a function to test the internal Tegra114 chip fuse that indicates
whether the VDD_CPU lower voltage limit for the fast CPU cluster
should be overridden.

Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
---
 arch/arm/mach-tegra/fuse.c |   26 ++++++++++++++++++++++++++
 include/linux/tegra-soc.h  |    2 ++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index e3ca8abe858f..42477aa1b7e9 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -47,6 +47,15 @@
 #define TEGRA20_FUSE_SPARE_BIT		0x200
 #define TEGRA30_FUSE_SPARE_BIT		0x244
 
+/*
+ * TEGRA114_SPARE_FUSE_VDD_CPU_OVERRIDE: Spare eFuse ID that indicates
+ * whether the minimum VDD_CPU voltage level that the DFLL is
+ * characterized for should be overridden to 900mVdc.  If unset, the
+ * voltage shouldn't be overridden - it will be whatever has been
+ * selected by the CPU Speedo and process IDs.
+ */
+#define TEGRA114_SPARE_FUSE_VDD_CPU_OVERRIDE		61
+
 int tegra_sku_id;
 int tegra_cpu_process_id;
 int tegra_core_process_id;
@@ -265,3 +274,20 @@ int tegra_get_cpu_speedo_id(void)
 	return tegra_cpu_speedo_id;
 }
 EXPORT_SYMBOL(tegra_get_cpu_speedo_id);
+
+/**
+ * tegra114_fuse_read_min_vdd_cpu_override - override DFLL VDD_CPU minimum?
+ *
+ * Returns true if the minimum VDD_CPU voltage level that the DFLL is
+ * characterized for is 900mVdc.  If false, the minimum voltage should
+ * be whatever has been selected by the CPU Speedo and process IDs.
+ */
+bool tegra114_fuse_read_min_vdd_cpu_override(void)
+{
+	if (tegra_chip_id != TEGRA114)
+		return -EINVAL;
+
+	return tegra_spare_fuse(TEGRA114_SPARE_FUSE_VDD_CPU_OVERRIDE) ? true :
+		false;
+}
+EXPORT_SYMBOL(tegra114_fuse_read_min_vdd_cpu_override);
diff --git a/include/linux/tegra-soc.h b/include/linux/tegra-soc.h
index ec856fdf2ce7..fe2ab641555e 100644
--- a/include/linux/tegra-soc.h
+++ b/include/linux/tegra-soc.h
@@ -21,4 +21,6 @@ u32 tegra_read_chipid(void);
 int tegra_get_cpu_process_id(void);
 int tegra_get_cpu_speedo_id(void);
 
+bool tegra114_fuse_read_min_vdd_cpu_override(void);
+
 #endif /* __LINUX_TEGRA_SOC_H_ */
