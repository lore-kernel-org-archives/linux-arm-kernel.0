From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 22 Oct 2015 22:52:08 +0300
Subject: [patch] cpufreq: scpi-cpufreq: signedness bug in scpi_get_dvfs_info()
Message-ID: <20151022195208.GB24439@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "domain" variable needs to be signed for the error handling to work.

Fixes: 8def31034d03 ('cpufreq: arm_big_little: add SCPI interface driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 2c3b16f..de5e89b 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -31,7 +31,7 @@ static struct scpi_ops *scpi_ops;
 
 static struct scpi_dvfs_info *scpi_get_dvfs_info(struct device *cpu_dev)
 {
-	u8 domain = topology_physical_package_id(cpu_dev->id);
+	int domain = topology_physical_package_id(cpu_dev->id);
 
 	if (domain < 0)
 		return ERR_PTR(-EINVAL);
