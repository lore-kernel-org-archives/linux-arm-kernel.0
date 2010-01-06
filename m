From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:55 -0800
Subject: [PATCH 13/35] davinci: make /proc/davinci_clocks display multi-rooted
	clock tree
In-Reply-To: <1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

This patch modifies clock dump to take care of
clock tress rooted at multiple oscillators.
Current code assumes the entire tree is rooted
on a single oscillator. When using off-chip
clock synthesizers, some of the clocks can
be obtained from a different on-board oscillator.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 46c95e0..f7a04c2 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -504,12 +504,15 @@ dump_clock(struct seq_file *s, unsigned nest, struct clk *parent)
 
 static int davinci_ck_show(struct seq_file *m, void *v)
 {
-	/* Show clock tree; we know the main oscillator is first.
-	 * We trust nonzero usecounts equate to PSC enables...
+	struct clk *clk;
+
+	/*
+	 * Show clock tree; We trust nonzero usecounts equate to PSC enables...
 	 */
 	mutex_lock(&clocks_mutex);
-	if (!list_empty(&clocks))
-		dump_clock(m, 0, list_first_entry(&clocks, struct clk, node));
+	list_for_each_entry(clk, &clocks, node)
+		if (!clk->parent)
+			dump_clock(m, 0, clk);
 	mutex_unlock(&clocks_mutex);
 
 	return 0;
-- 
1.6.6.rc2.1.g42108
