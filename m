From: code@mmayer.net (Markus Mayer)
Date: Wed, 18 Apr 2018 08:56:43 -0700
Subject: [PATCH 2/2] cpufreq: brcmstb-avs-cpufreq: prefer SCMI cpufreq if
 supported
In-Reply-To: <20180418155643.36464-1-code@mmayer.net>
References: <20180418155643.36464-1-code@mmayer.net>
Message-ID: <20180418155643.36464-3-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jim Quinlan <jim2101024@gmail.com>

If the SCMI cpufreq driver is supported, we bail, so that the new
approach can be used.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index b07559b9ed99..b4861a730162 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -164,6 +164,8 @@
 #define BRCM_AVS_CPU_INTR	"brcm,avs-cpu-l2-intr"
 #define BRCM_AVS_HOST_INTR	"sw_intr"
 
+#define ARM_SCMI_COMPAT		"arm,scmi"
+
 struct pmap {
 	unsigned int mode;
 	unsigned int p1;
@@ -511,6 +513,20 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
 	struct device *dev;
 	int host_irq, ret;
 
+	/*
+	 * If the SCMI cpufreq driver is supported, we bail, so that the more
+	 * modern approach can be used.
+	 */
+	if (IS_ENABLED(CONFIG_ARM_SCMI_PROTOCOL)) {
+		struct device_node *np;
+
+		np = of_find_compatible_node(NULL, NULL, ARM_SCMI_COMPAT);
+		if (np) {
+			of_node_put(np);
+			return -ENXIO;
+		}
+	}
+
 	dev = &pdev->dev;
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
-- 
2.7.4
