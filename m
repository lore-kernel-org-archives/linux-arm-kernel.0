From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 30 Sep 2013 18:03:29 -0300
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet ge0 and
 ge1 clocks
In-Reply-To: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These clocks should never be gated, since the ethernet interfaces forget
the assigned MAC address assigned if their clock source is turned off.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Cc: Mike Turquette <mturquette@linaro.org>

 drivers/clk/mvebu/kirkwood.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/kirkwood.c b/drivers/clk/mvebu/kirkwood.c
index 2636a55..69d9603 100644
--- a/drivers/clk/mvebu/kirkwood.c
+++ b/drivers/clk/mvebu/kirkwood.c
@@ -220,7 +220,12 @@ CLK_OF_DECLARE(mv88f6180_core_clk, "marvell,mv88f6180-core-clock",
  */
 
 static const struct clk_gating_soc_desc kirkwood_gating_desc[] __initconst = {
-	{ "ge0", NULL, 0, 0 },
+	/*
+	 * The ethernet interfaces forget their assigned MAC address
+	 * if the clocks are turned off. Until proper DT support
+	 * is available we prevent ge0 and ge1 gating for now.
+	 */
+	{ "ge0", NULL, 0, CLK_IGNORE_UNUSED },
 	{ "pex0", NULL, 2, 0 },
 	{ "usb0", NULL, 3, 0 },
 	{ "sdio", NULL, 4, 0 },
@@ -234,7 +239,7 @@ static const struct clk_gating_soc_desc kirkwood_gating_desc[] __initconst = {
 	{ "xor1", NULL, 16, 0 },
 	{ "crypto", NULL, 17, 0 },
 	{ "pex1", NULL, 18, 0 },
-	{ "ge1", NULL, 19, 0 },
+	{ "ge1", NULL, 19, CLK_IGNORE_UNUSED },
 	{ "tdm", NULL, 20, 0 },
 	{ }
 };
-- 
1.8.1.5
