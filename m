From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 16 Dec 2010 16:49:58 -0800
Subject: [PATCH 14/22] msm: clock: Support clk_set_parent() clk_ops
In-Reply-To: <1292547006-19741-1-git-send-email-sboyd@codeaurora.org>
References: <1292547006-19741-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1292547006-19741-15-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Voting clocks are linked to the clock they vote on with a parent
pointer. Implement this API for sub drivers which wish to use it.

Reviewed-by: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/clock.c |    2 ++
 arch/arm/mach-msm/clock.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/clock.c b/arch/arm/mach-msm/clock.c
index 80e1d64..b6b7e7c 100644
--- a/arch/arm/mach-msm/clock.c
+++ b/arch/arm/mach-msm/clock.c
@@ -119,6 +119,8 @@ EXPORT_SYMBOL(clk_set_max_rate);
 
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
+	if (clk->ops->set_parent)
+		return clk->ops->set_parent(clk->id, parent);
 	return -ENOSYS;
 }
 EXPORT_SYMBOL(clk_set_parent);
diff --git a/arch/arm/mach-msm/clock.h b/arch/arm/mach-msm/clock.h
index 4dc8853..1a9fb72 100644
--- a/arch/arm/mach-msm/clock.h
+++ b/arch/arm/mach-msm/clock.h
@@ -46,6 +46,7 @@ struct clk_ops {
 	unsigned (*is_enabled)(unsigned id);
 	long (*round_rate)(unsigned id, unsigned rate);
 	bool (*is_local)(unsigned id);
+	int (*set_parent)(unsigned id, struct clk *parent);
 };
 
 struct clk {
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
