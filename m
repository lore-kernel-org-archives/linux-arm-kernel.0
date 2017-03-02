From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu,  2 Mar 2017 18:36:26 +0800
Subject: [PATCH] cpufreq: mt8173: Add support for MT8176 and MT817x compatibles
Message-ID: <20170302103626.69195-1-djkurtz@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Mediatek MT8173 is just on of several SOCs from the same MT817x family,
including the 6-core (4-little/2-big) MT8176.

The mt8173-cpufreq driver supports all of these SOCs, however, machines
using them may use a different machine compatible.

Since this driver checks explicitly for the machine compatible string, add
support for the whole family.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
This patch is based on the compatibles added by the MT8176 series:

 https://patchwork.kernel.org/patch/9573209/
 https://patchwork.kernel.org/patch/9573213/

 drivers/cpufreq/mt8173-cpufreq.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index ab25b1235a5e..07f7aac56f31 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -573,13 +573,34 @@ static struct platform_driver mt8173_cpufreq_platdrv = {
 	.probe		= mt8173_cpufreq_probe,
 };
 
+/* List of machine compatible strings supported by this driver */
+static const char *mt8173_cpufreq_machines[] = {
+	"mediatek,mt817x",
+	"mediatek,mt8173",
+	"mediatek,mt8176",
+};
+
+static int mt8173_cpufreq_is_compatible(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mt8173_cpufreq_machines); i++)
+		if (of_machine_is_compatible(mt8173_cpufreq_machines[i]))
+			return 0;
+
+	return -ENODEV;
+}
+
 static int mt8173_cpufreq_driver_init(void)
 {
 	struct platform_device *pdev;
 	int err;
 
-	if (!of_machine_is_compatible("mediatek,mt8173"))
-		return -ENODEV;
+	err = mt8173_cpufreq_is_compatible();
+	if (err) {
+		pr_err("Machine is not compatible with 'mediatek,mt8173'\n");
+		return err;
+	}
 
 	err = platform_driver_register(&mt8173_cpufreq_platdrv);
 	if (err)
-- 
2.12.0.rc1.440.g5b76565f74-goog
