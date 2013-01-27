From: gmbnomis@gmail.com (Simon Baatz)
Date: Sun, 27 Jan 2013 11:40:23 +0100
Subject: [PATCH v2 2/2] clk: mvebu: Do not gate runit clock on Kirkwood
In-Reply-To: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
References: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <1359283223-23082-3-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f479db "ARM: Kirkwood: Ensure runit clock always ticks."
made sure that the runit clock always ticks on Kirkwood.

When moving the clock gating to clk-gating-ctrl.c for Kirkwood DT
devices, this change was disabled.  Set the CLK_IGNORE_UNUSED flag for
"runit" to ensure that it always ticks.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 drivers/clk/mvebu/clk-gating-ctrl.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
index 8fa5408..da5f807 100644
--- a/drivers/clk/mvebu/clk-gating-ctrl.c
+++ b/drivers/clk/mvebu/clk-gating-ctrl.c
@@ -97,8 +97,11 @@ static void __init mvebu_clk_gating_setup(
 		 * isn't taken by any driver, but should anyway be
 		 * kept enabled, so we mark it as IGNORE_UNUSED for
 		 * now.
+		 * Do the same for the "runit" clock on Kirkwood;
+		 * gating this clock causes an immediate lockup.
 		 */
-		if (!strcmp(descr[n].name, "ddr"))
+		if (!strcmp(descr[n].name, "ddr")
+		    || !strcmp(descr[n].name, "runit"))
 			flags |= CLK_IGNORE_UNUSED;
 
 		ctrl->gates[n] = clk_register_gate(NULL, descr[n].name, parent,
-- 
1.7.9.5
