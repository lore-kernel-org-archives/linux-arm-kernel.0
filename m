From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 07 Feb 2011 14:07:57 +0800
Subject: [RFC,
	PATCH 3/3] clk: add warnings for incorrect enable/prepare semantics
In-Reply-To: <201102011711.31258.jeremy.kerr@canonical.com>
Message-ID: <1297058877.800990.238556019385.3.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change adds warnings to check for:

 1) enabling a clock that hasn't been prepared; and

 2) unpreparing a clock that is still enabled

While the correctness can't be guaranteed, these warnings should cover
most situations.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 drivers/clk/clk.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 51dbd33..2369959 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -35,6 +35,8 @@ void clk_unprepare(struct clk *clk)
 	if (!clk->ops->unprepare)
 		return;
 
+	WARN_ON(clk->enable_count);
+
 	mutex_lock(&clk->prepare_lock);
 	if (--clk->prepare_count == 0)
 		clk->ops->unprepare(clk);
@@ -50,6 +52,8 @@ int clk_enable(struct clk *clk)
 	if (!clk->ops->enable)
 		return 0;
 
+	WARN_ON(clk->ops->prepare && clk->prepare_count);
+
 	spin_lock(&clk->enable_lock);
 	if (!clk->enable_count)
 		ret = clk->ops->enable(clk);
