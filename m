From: davidb@codeaurora.org (David Brown)
Date: Wed,  2 Nov 2011 11:36:03 -0700
Subject: [RFC PATCH 06/34] msm: clock: Support clk_[s|g]et_parent() clk_ops
In-Reply-To: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
References: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1320258991-22325-7-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

Voting clocks are linked to the clock they vote on with a parent
pointer. Add support for these functions so the upcoming clock
voter sub driver can use it to initialize clocks.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/clock.c |    7 ++++++-
 arch/arm/mach-msm/clock.h |    2 ++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/clock.c b/arch/arm/mach-msm/clock.c
index aa4a450..8508c17 100644
--- a/arch/arm/mach-msm/clock.c
+++ b/arch/arm/mach-msm/clock.c
@@ -106,13 +106,18 @@ EXPORT_SYMBOL(clk_set_max_rate);
 
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
+	if (clk->ops->set_parent)
+		return clk->ops->set_parent(clk, parent);
 	return -ENOSYS;
 }
 EXPORT_SYMBOL(clk_set_parent);
 
 struct clk *clk_get_parent(struct clk *clk)
 {
-	return ERR_PTR(-ENOSYS);
+	if (clk->ops->get_parent)
+		return clk->ops->get_parent(clk);
+
+	return NULL;
 }
 EXPORT_SYMBOL(clk_get_parent);
 
diff --git a/arch/arm/mach-msm/clock.h b/arch/arm/mach-msm/clock.h
index ab14f15..6a7cbca 100644
--- a/arch/arm/mach-msm/clock.h
+++ b/arch/arm/mach-msm/clock.h
@@ -44,6 +44,8 @@ struct clk_ops {
 	unsigned (*get_rate)(struct clk *clk);
 	unsigned (*is_enabled)(struct clk *clk);
 	long (*round_rate)(struct clk *clk, unsigned rate);
+	int (*set_parent)(struct clk *clk, struct clk *parent);
+	struct clk *(*get_parent)(struct clk *clk);
 	bool (*is_local)(struct clk *clk);
 };
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
