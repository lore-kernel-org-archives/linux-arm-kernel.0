From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Jan 2011 16:20:55 -0800
Subject: [PATCHv2 4/5] msm: clock: Invert debugfs directory layout
In-Reply-To: <1296087656-3693-1-git-send-email-sboyd@codeaurora.org>
References: <1296087656-3693-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1296087656-3693-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are currently 3 separate directories for clock debugging in
debugfs: clk_enable, clk_rate, and clk_local. Each of these
directories contains a list of clocks. This is rather annoying
when you are focusing on one clock and want to enable/disable it
and then check its rate. You either have to cd to the other
directory or cat ../clk_rate/<clk>.

Invert the layout so that there is one clock directory containing
a directory for each clock. Inside each respective clock
directory place an enable, rate, and is_local file relating to
the clk_enable, clk_disable, and clk_local directories that exist
today.

Reviewed-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/clock-debug.c |   48 ++++++++++++++++++--------------------
 1 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-msm/clock-debug.c b/arch/arm/mach-msm/clock-debug.c
index 6f603ed..b67b9e82 100644
--- a/arch/arm/mach-msm/clock-debug.c
+++ b/arch/arm/mach-msm/clock-debug.c
@@ -87,47 +87,45 @@ static int clock_debug_local_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(clock_local_fops, clock_debug_local_get,
 			NULL, "%llu\n");
 
-static struct dentry *dent_rate, *dent_enable, *dent_local;
+static struct dentry *debugfs_base;
 
 int __init clock_debug_init(void)
 {
-	dent_rate = debugfs_create_dir("clk_rate", 0);
-	if (!dent_rate)
-		goto err;
-
-	dent_enable = debugfs_create_dir("clk_enable", 0);
-	if (!dent_enable)
-		goto err;
-
-	dent_local = debugfs_create_dir("clk_local", NULL);
-	if (!dent_local)
-		goto err;
-
+	debugfs_base = debugfs_create_dir("clk", NULL);
+	if (!debugfs_base)
+		return -ENOMEM;
 	return 0;
-err:
-	debugfs_remove(dent_local);
-	debugfs_remove(dent_enable);
-	debugfs_remove(dent_rate);
-	return -ENOMEM;
 }
 
 int __init clock_debug_add(struct clk *clock)
 {
 	char temp[50], *ptr;
+	struct dentry *clk_dir;
 
-	if (!dent_rate || !dent_enable || !dent_local)
+	if (!debugfs_base)
 		return -ENOMEM;
 
 	strncpy(temp, clock->dbg_name, ARRAY_SIZE(temp)-1);
 	for (ptr = temp; *ptr; ptr++)
 		*ptr = tolower(*ptr);
 
-	debugfs_create_file(temp, S_IRUGO | S_IWUSR, dent_rate,
-			    clock, &clock_rate_fops);
-	debugfs_create_file(temp, S_IRUGO | S_IWUSR, dent_enable,
-			    clock, &clock_enable_fops);
-	debugfs_create_file(temp, S_IRUGO, dent_local,
-			    clock, &clock_local_fops);
+	clk_dir = debugfs_create_dir(temp, debugfs_base);
+	if (!clk_dir)
+		return -ENOMEM;
+
+	if (!debugfs_create_file("rate", S_IRUGO | S_IWUSR, clk_dir,
+				clock, &clock_rate_fops))
+		goto error;
 
+	if (!debugfs_create_file("enable", S_IRUGO | S_IWUSR, clk_dir,
+				clock, &clock_enable_fops))
+		goto error;
+
+	if (!debugfs_create_file("is_local", S_IRUGO, clk_dir, clock,
+				&clock_local_fops))
+		goto error;
 	return 0;
+error:
+	debugfs_remove_recursive(clk_dir);
+	return -ENOMEM;
 }
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
