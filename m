From: khilman@ti.com (Kevin Hilman)
Date: Thu, 22 Sep 2011 14:07:26 -0700
Subject: [PATCH 08/10] cpufreq: OMAP: only supports OPP library
In-Reply-To: <1316725648-26710-1-git-send-email-khilman@ti.com>
References: <1316725648-26710-1-git-send-email-khilman@ti.com>
Message-ID: <1316725648-26710-9-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

OMAP2 is the only family using clk_[init|exit]_cpufreq_table, however,
the cpufreq code does not currently use clk_init_cpufreq_table. As a
result, it is unusuable for OMAP2 and only usable only on platforms
using OPP library.

Remove the unbalanced clk_exit_cpufreq_table().  Any platforms where
OPPs are not availble will fail on init because a freq table will not
be properly initialized.

Signed-off-by: Nishanth Menon <nm@ti.com>
[khilman at ti.com: changelog edits, and graceful failure mode changes]
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 635778d..ce82d50 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -1,5 +1,5 @@
 /*
- *  CPU frequency scaling for OMAP
+ *  CPU frequency scaling for OMAP using OPP information
  *
  *  Copyright (C) 2005 Nokia Corporation
  *  Written by Tony Lindgren <tony@atomide.com>
@@ -197,7 +197,6 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 
 static int omap_cpu_exit(struct cpufreq_policy *policy)
 {
-	clk_exit_cpufreq_table(&freq_table);
 	clk_put(mpu_clk);
 	return 0;
 }
-- 
1.7.6
