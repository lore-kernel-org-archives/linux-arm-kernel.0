From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 May 2014 17:40:19 -0500
Subject: [PATCH v2 09/11] ARM: timer-sp: allow getting timer1 clock from DT to
 fallback to legacy clock
In-Reply-To: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
Message-ID: <1401403221-27523-10-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

The sp804 clocks may be specified in DT, but the kernel may still be using
legacy clocks. This is handled if a single clock for sp804 is present,
but not when 3 clocks are present.

This prevents Versatile platforms from breaking when the DT has clocks
added.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
v2:
- New patch necessary to handle DT with 3 clocks in sp804 node and still
  use the legacy non-DT clocks.

 arch/arm/common/timer-sp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index fd6bff0..1921132 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -233,13 +233,13 @@ static void __init sp804_of_init(struct device_node *np)
 	if (IS_ERR(clk1))
 		clk1 = NULL;
 
-	/* Get the 2nd clock if the timer has 2 timer clocks */
+	/* Get the 2nd clock if the timer has 3 timer clocks */
 	if (of_count_phandle_with_args(np, "clocks", "#clock-cells") == 3) {
 		clk2 = of_clk_get(np, 1);
 		if (IS_ERR(clk2)) {
 			pr_err("sp804: %s clock not found: %d\n", np->name,
 				(int)PTR_ERR(clk2));
-			goto err;
+			clk2 = NULL;
 		}
 	} else
 		clk2 = clk1;
-- 
1.9.1
