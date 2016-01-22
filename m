From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Jan 2016 11:53:06 +0100
Subject: [PATCH] soc: qcom/spm: shut up uninitialized variable warning
Message-ID: <2156542.o6ovXGcSIl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gcc warns about the 'found' variable possibly being used uninitialized:

drivers/soc/qcom/spm.c: In function 'spm_dev_probe':
drivers/soc/qcom/spm.c:305:5: error: 'found' may be used uninitialized in this function [-Werror=maybe-uninitialized]

However, the code is correct because we know that there is
always at least one online CPU. This initializes the 'found'
variable to zero before the loop so the compiler knows
it does not have to warn about it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'd like to send this with the bug fixes for 4.4-rc1 to shut up one of
the remaining warnings we get from kernelci.

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index 0ad66fa9bb1a..5548a31e1a39 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -288,7 +288,7 @@ static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
 	struct spm_driver_data *drv = NULL;
 	struct device_node *cpu_node, *saw_node;
 	int cpu;
-	bool found;
+	bool found = 0;
 
 	for_each_possible_cpu(cpu) {
 		cpu_node = of_cpu_device_node_get(cpu);
