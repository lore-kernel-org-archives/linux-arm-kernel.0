From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  1 Dec 2014 17:11:25 +0530
Subject: [RFC V1 4/8] cpufreq: mvebu: reuse dt_device.c to create cpufreq
 platform device
In-Reply-To: <cover.1417433163.git.viresh.kumar@linaro.org>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
Message-ID: <862271735f97759b517ef8c9eb8ee66bdd8cbec3.1417433163.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have a common interface for create platform device required to probe
cpufreq-dt driver (and others as well). Lets create devices from dt_device.c
instead of platform specific code.

For marvell, we are updating the blacklist instead of DT because the newer
kernel should be backwards compatible with older DT as well. We can update the
"compatible" property in DT but it wouldn't make a difference as we already have
imx in the blacklist.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-mvebu/pmsu.c  | 1 -
 drivers/cpufreq/dt_device.c | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index bbd8664..9d02618 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -644,7 +644,6 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 		}
 	}
 
-	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 	return 0;
 }
 
diff --git a/drivers/cpufreq/dt_device.c b/drivers/cpufreq/dt_device.c
index cf01bed..33fc046 100644
--- a/drivers/cpufreq/dt_device.c
+++ b/drivers/cpufreq/dt_device.c
@@ -27,6 +27,8 @@ static const struct of_device_id compatible_machine_match[] = {
 	{ .compatible = "fsl,imx27",		.data = "cpufreq-dt" },
 	{ .compatible = "fsl,imx51",		.data = "cpufreq-dt" },
 
+	{ .compatible = "marvell,armadaxp",	.data = "cpufreq-dt" },
+
 	/* BLACKLIST of existing users of arm-bL-cpufreq-dt below */
 
 	/* BLACKLIST of existing users of other drivers below */
-- 
2.0.3.693.g996b0fd
