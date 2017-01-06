From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri,  6 Jan 2017 12:34:30 +0000
Subject: [PATCH] clk: scpi: don't add cpufreq device if the scpi dvfs node is
 disabled
Message-ID: <1483706070-12357-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we add the virtual cpufreq device unconditionally even when
the SCPI DVFS clock provider node is disabled. This will cause cpufreq
driver to throw errors when it gets initailised on boot/modprobe and
also when the CPUs are hot-plugged back in.

This patch fixes the issue by adding the virtual cpufreq device only if
the SCPI DVFS clock provider is available and registered.

Fixes: 9490f01e2471 ("clk: scpi: add support for cpufreq virtual device")
Reported-by: Micha? Zegan <webczat_200@poczta.onet.pl>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/clk/clk-scpi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
index 2a3e9d8e88b0..96d37175d0ad 100644
--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -290,13 +290,15 @@ static int scpi_clocks_probe(struct platform_device *pdev)
 			of_node_put(child);
 			return ret;
 		}
-	}
-	/* Add the virtual cpufreq device */
-	cpufreq_dev = platform_device_register_simple("scpi-cpufreq",
-						      -1, NULL, 0);
-	if (IS_ERR(cpufreq_dev))
-		pr_warn("unable to register cpufreq device");
 
+		if (match->data != &scpi_dvfs_ops)
+			continue;
+		/* Add the virtual cpufreq device if it's DVFS clock provider */
+		cpufreq_dev = platform_device_register_simple("scpi-cpufreq",
+							      -1, NULL, 0);
+		if (IS_ERR(cpufreq_dev))
+			pr_warn("unable to register cpufreq device");
+	}
 	return 0;
 }
 
-- 
2.7.4
