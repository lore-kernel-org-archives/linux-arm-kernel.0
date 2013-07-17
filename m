From: Sudeep.KarkadaNagesha@arm.com (Sudeep.KarkadaNagesha at arm.com)
Date: Wed, 17 Jul 2013 15:06:19 +0100
Subject: [RFC PATCH v2 10/15] cpufreq: spear-cpufreq: remove device tree
 parsing for cpu nodes
In-Reply-To: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1374069984-20567-11-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Cc: Deepak Sikri <deepak.sikri@st.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/spear-cpufreq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index c3efa7f..eb73c47 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/clk.h>
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -218,12 +219,19 @@ static struct cpufreq_driver spear_cpufreq_driver = {
 static int spear_cpufreq_driver_init(void)
 {
 	struct device_node *np;
+	struct device *cpu_dev;
 	const struct property *prop;
 	struct cpufreq_frequency_table *freq_tbl;
 	const __be32 *val;
 	int cnt, i, ret;
 
-	np = of_find_node_by_path("/cpus/cpu at 0");
+	cpu_dev = get_cpu_device(0);
+	if (!cpu_dev) {
+		pr_err("failed to get cpu device\n");
+		return -ENODEV;
+	}
+
+	np = of_node_get(cpu_dev->of_node);
 	if (!np) {
 		pr_err("No cpu node found");
 		return -ENODEV;
-- 
1.8.1.2
