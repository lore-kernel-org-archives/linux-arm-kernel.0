From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 28 Sep 2016 00:20:13 +0930
Subject: [PATCH 1/8] pinctrl: aspeed: "Not enabled" is a significant mux state
In-Reply-To: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
References: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
Message-ID: <a2fce70d4285ec2321a64a4f7145ea8a90d988b3.1474986045.git-series.andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consider a scenario with one pin P that has two signals A and B, where A
is defined to be higher priority than B: That is, if the mux IP is in a
state that would consider both A and B to be active on P, then A will be
the active signal.

To instead configure B as the active signal we must configure the mux so
that A is inactive. The mux state for signals can be described by
logical operations on one or more bits from one or more registers (a
"signal expression"), which in some cases leads to aliased mux states for
a particular signal. Further, signals described by multi-bit bitfields
often do not only need to record the states that would make them active
(the "enable" expressions), but also the states that makes them inactive
(the "disable" expressions). All of this combined leads to four possible
states for a signal:

         1. A signal is active with respect to an "enable" expression
         2. A signal is not active with respect to an "enable" expression
         3. A signal is inactive with respect to a "disable" expression
         4. A signal is not inactive with respect to a "disable" expression

In the case of P, if we are looking to activate B without explicitly
having configured A it's enough to consider A inactive if all of A's
"enable" signal expressions evaluate to "not active". If any evaluate to
"active" then the corresponding "disable" states must be applied so it
becomes inactive.

For example, on the AST2400 the pins composing GPIO bank H provide
signals ROMD8 through ROMD15 (high priority) and those for UART6 (low
priority). The mux states for ROMD8 through ROMD15 are aliased, i.e.
there are two mux states that result in the respective signals being
configured:

         A. SCU90[6]=1
         B. Strap[4,1:0]=100

Further, the second mux state is a 3-bit bitfield that explicitly
defines the enabled state but the disabled state is implicit, i.e. if
Strap[4,1:0] is not exactly "100" then ROMD8 through ROMD15 are not
considered active. This requires the mux function evaluation logic to
use approach 2. above, however the existing code was using approach 3.
The problem was brought to light on the Palmetto machines where the
strap register value is 0x120ce416, and prevented GPIO requests in bank
H from succeeding despite the hardware being in a position to allow
them.

Fixes: 318398c09a8d ("pinctrl: Add core pinctrl support for Aspeed SoCs")
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
index 0391f9f13f3e..49aeba912531 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
@@ -166,13 +166,9 @@ static bool aspeed_sig_expr_set(const struct aspeed_sig_expr *expr,
 				bool enable, struct regmap *map)
 {
 	int i;
-	bool ret;
-
-	ret = aspeed_sig_expr_eval(expr, enable, map);
-	if (ret)
-		return ret;
 
 	for (i = 0; i < expr->ndescs; i++) {
+		bool ret;
 		const struct aspeed_sig_desc *desc = &expr->descs[i];
 		u32 pattern = enable ? desc->enable : desc->disable;
 
@@ -199,12 +195,18 @@ static bool aspeed_sig_expr_set(const struct aspeed_sig_expr *expr,
 static bool aspeed_sig_expr_enable(const struct aspeed_sig_expr *expr,
 				   struct regmap *map)
 {
+	if (aspeed_sig_expr_eval(expr, true, map))
+		return true;
+
 	return aspeed_sig_expr_set(expr, true, map);
 }
 
 static bool aspeed_sig_expr_disable(const struct aspeed_sig_expr *expr,
 				    struct regmap *map)
 {
+	if (!aspeed_sig_expr_eval(expr, true, map))
+		return true;
+
 	return aspeed_sig_expr_set(expr, false, map);
 }
 
-- 
git-series 0.8.10
