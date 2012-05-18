From: nm@ti.com (Nishanth Menon)
Date: Fri, 18 May 2012 12:56:39 -0500
Subject: [PATCH] ARM: OMAP: PM: Lock clocks list while generating summary
Message-ID: <1337363799-22085-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Todd Poynor <toddpoynor@google.com>

commit a53025724052b2b1edbc982a4a248784638f563d
(OMAP: Add debugfs node to show the summary of all clocks)

Introduced clock summary, however, we are interested in seeing
snapshot of the clock state, not in dynamically changing clock
configurations as the data provided by clock summary will then be
useless for debugging configuration issues. So, hold the common lock
when dumping the clock summary.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org

[nm at ti.com: added commit message]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 arch/arm/plat-omap/clock.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 62ec5c4..706b7e2 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -461,6 +461,7 @@ static int clk_dbg_show_summary(struct seq_file *s, void *unused)
 	struct clk *c;
 	struct clk *pa;
 
+	mutex_lock(&clocks_mutex);
 	seq_printf(s, "%-30s %-30s %-10s %s\n",
 		"clock-name", "parent-name", "rate", "use-count");
 
@@ -469,6 +470,7 @@ static int clk_dbg_show_summary(struct seq_file *s, void *unused)
 		seq_printf(s, "%-30s %-30s %-10lu %d\n",
 			c->name, pa ? pa->name : "none", c->rate, c->usecount);
 	}
+	mutex_unlock(&clocks_mutex);
 
 	return 0;
 }
-- 
1.7.9.5
