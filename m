From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Feb 2016 10:38:08 +0100
Subject: [PATCH] regulator: qcom-saw: avoid uninitialized variable warning
Message-ID: <1455183497-299798-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc cannot know that a for_each_possible_cpu() loop always executes
at least once, so it warns about the use of the "found" variable
in qcom_saw_regulator_probe:

drivers/regulator/qcom_saw-regulator.c: In function 'qcom_saw_regulator_probe':
drivers/regulator/qcom_saw-regulator.c:154:5: error: 'found' is used uninitialized in this function [-Werror=uninitialized]

This adds an explicit initialization to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 18bba3b50355 ("regulator: qcom-saw: Add support for SAW regulators")
---
 drivers/regulator/qcom_saw-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_saw-regulator.c b/drivers/regulator/qcom_saw-regulator.c
index c800f16adaf0..30af1d380f9f 100644
--- a/drivers/regulator/qcom_saw-regulator.c
+++ b/drivers/regulator/qcom_saw-regulator.c
@@ -137,7 +137,7 @@ static struct saw_vreg *saw_get_drv(struct platform_device *pdev,
 	struct saw_vreg *vreg = NULL;
 	struct device_node *cpu_node, *saw_node;
 	int cpu;
-	bool found;
+	bool found = 0;
 
 	for_each_possible_cpu(cpu) {
 		cpu_node = of_cpu_device_node_get(cpu);
-- 
2.7.0
