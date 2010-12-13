From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 13 Dec 2010 14:35:10 -0800
Subject: [PATCH v2 4/5] msm: add handling for clocks tagged as CLK_MINMAX
In-Reply-To: <1292279711-4460-1-git-send-email-dwalker@codeaurora.org>
References: <1292279711-4460-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <1292279711-4460-4-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CLK_MINMAX is used to denote clocks that have a wide variation
in possible frequencies. This handling just sets the min and
max values to the same value.

This code was original created by Saravana Kannan.

Cc: Saravana Kannan <skannan@codeaurora.org>
Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mach-msm/clock.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/clock.c b/arch/arm/mach-msm/clock.c
index c57210f..2069bfa 100644
--- a/arch/arm/mach-msm/clock.c
+++ b/arch/arm/mach-msm/clock.c
@@ -120,6 +120,21 @@ EXPORT_SYMBOL(clk_get_rate);
 
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
+	int ret;
+	if (clk->flags & CLKFLAG_MAX) {
+		ret = clk->ops->set_max_rate(clk->id, rate);
+		if (ret)
+			return ret;
+	}
+	if (clk->flags & CLKFLAG_MIN) {
+		ret = clk->ops->set_min_rate(clk->id, rate);
+		if (ret)
+			return ret;
+	}
+
+	if (clk->flags & CLKFLAG_MAX || clk->flags & CLKFLAG_MIN)
+		return ret;
+
 	return clk->ops->set_rate(clk->id, rate);
 }
 EXPORT_SYMBOL(clk_set_rate);
-- 
1.7.1
