From: ta.omasab@gmail.com (Thomas Abraham)
Date: Wed, 14 May 2014 06:41:09 +0530
Subject: [PATCH v4 1/8] cpufreq: cpufreq-cpu0: allow use of optional boost
 mode frequencies
In-Reply-To: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1400029876-5830-2-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Lookup for the optional boost-frequency property in cpu0 node and if
available, enable support for boost mode frequencies. The frequencies
usable in boost mode are determined while preparing the cpufreq table
from the list of operating points available.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |    2 ++
 drivers/cpufreq/Kconfig                            |   11 +++++++++++
 drivers/cpufreq/cpufreq-cpu0.c                     |    5 +++++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
index f055515..60f321a 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
@@ -19,6 +19,8 @@ Optional properties:
 - cooling-min-level:
 - cooling-max-level:
      Please refer to Documentation/devicetree/bindings/thermal/thermal.txt.
+- boost-frequency:
+     Please refer to Documentation/devicetree/bindings/cpufreq/cpufreq-boost.txt
 
 Examples:
 
diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 1fbe11f..0ca4485 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -194,6 +194,17 @@ config GENERIC_CPUFREQ_CPU0
 
 	  If in doubt, say N.
 
+config GENERIC_CPUFREQ_CPU0_BOOST
+	bool "Boost frequency support for generic CPU0 cpufreq driver"
+	depends on GENERIC_CPUFREQ_CPU0
+	select CPU_FREQ_BOOST_SW
+	help
+	  This enables support for software managed overclocking (BOOST). It
+	  allows usage of special frequencies (those beyond the normal operating
+	  frequencies).
+
+	  If in doubt, say N.
+
 menu "x86 CPU frequency scaling drivers"
 depends on X86
 source "drivers/cpufreq/Kconfig.x86"
diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index 1bf6bba..e6c21a8 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -194,6 +194,11 @@ static int cpu0_cpufreq_probe(struct platform_device *pdev)
 			transition_latency += ret * 1000;
 	}
 
+#ifdef CONFIG_GENERIC_CPUFREQ_CPU0_BOOST
+	if (of_find_property(cpu_dev->of_node, "boost-frequency", NULL))
+		cpu0_cpufreq_driver.boost_supported = true;
+#endif
+
 	ret = cpufreq_register_driver(&cpu0_cpufreq_driver);
 	if (ret) {
 		pr_err("failed register driver: %d\n", ret);
-- 
1.7.4.4
