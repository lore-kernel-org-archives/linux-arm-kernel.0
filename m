From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 13 Dec 2017 18:29:13 +0100
Subject: [PATCH 1/2] cpufreq: mvebu: Free the clock reference in the normal
 path
In-Reply-To: <20171213172914.6148-1-gregory.clement@free-electrons.com>
References: <20171213172914.6148-1-gregory.clement@free-electrons.com>
Message-ID: <20171213172914.6148-2-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of error the clock reference was freed but not in normal path
once it was nor more used. This patch fixes it.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/cpufreq/mvebu-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
index ed915ee85dd9..c043aad8e3a0 100644
--- a/drivers/cpufreq/mvebu-cpufreq.c
+++ b/drivers/cpufreq/mvebu-cpufreq.c
@@ -99,6 +99,7 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 		if (ret)
 			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
 				__func__, ret);
+		clk_put(clk);
 	}
 
 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
-- 
2.15.1
