From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 09 Jan 2018 16:58:59 +0900
Subject: [PATCH 2/9] soc: samsung: pmu: Add powerup_conf callback
In-Reply-To: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
References: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
 <CGME20180109075905epcas1p4e601230d86dd686db28796165178dafa@epcas1p4.samsung.com>
Message-ID: <1515484746-10656-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the powerup_conf callback which is used to re-initialize
the PMU registers during the resume state.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/soc/samsung/exynos-pmu.c       | 8 ++++++++
 drivers/soc/samsung/exynos-pmu.h       | 1 +
 include/linux/soc/samsung/exynos-pmu.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index f56adbd9fb8b..cfc9de518344 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -58,6 +58,14 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 		pmu_data->powerdown_conf_extra(mode);
 }
 
+void exynos_sys_powerup_conf(enum sys_powerdown mode)
+{
+	const struct exynos_pmu_data *pmu_data = pmu_context->pmu_data;
+
+	if (pmu_data->powerup_conf)
+		pmu_data->powerup_conf(mode);
+}
+
 /*
  * Split the data between ARM architectures because it is relatively big
  * and useless on other arch.
diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
index 977e4daf5a0f..efbaf8929252 100644
--- a/drivers/soc/samsung/exynos-pmu.h
+++ b/drivers/soc/samsung/exynos-pmu.h
@@ -24,6 +24,7 @@ struct exynos_pmu_data {
 	void (*pmu_init)(void);
 	void (*powerdown_conf)(enum sys_powerdown);
 	void (*powerdown_conf_extra)(enum sys_powerdown);
+	void (*powerup_conf)(enum sys_powerdown);
 };
 
 extern void __iomem *pmu_base_addr;
diff --git a/include/linux/soc/samsung/exynos-pmu.h b/include/linux/soc/samsung/exynos-pmu.h
index e57eb4b6cc5a..3aacf7b18401 100644
--- a/include/linux/soc/samsung/exynos-pmu.h
+++ b/include/linux/soc/samsung/exynos-pmu.h
@@ -22,6 +22,7 @@ enum sys_powerdown {
 };
 
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
+extern void exynos_sys_powerup_conf(enum sys_powerdown mode);
 #ifdef CONFIG_EXYNOS_PMU
 extern struct regmap *exynos_get_pmu_regmap(void);
 #else
-- 
1.9.1
