From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Feb 2014 17:22:43 +0100
Subject: [PATCH 1/5] clk: sun6i: Protect CPU clock
In-Reply-To: <1393258967-4843-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1393258967-4843-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1393258967-4843-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now, AHB is an indirect child clock of the CPU clock. If that happens to
change, since the CPU clock has no other consumers declared in Linux, it would
be shut down, which is not really a good idea.

Prevent this by forcing it enabled.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 23baad9..cedaf4b 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1301,6 +1301,14 @@ static void __init sunxi_clock_protect(void)
 		clk_prepare_enable(clk);
 		clk_put(clk);
 	}
+
+	/* CPU clocks - sun6i */
+	clk = clk_get(NULL, "cpu");
+	if (!IS_ERR(clk)) {
+		clk_prepare_enable(clk);
+		clk_put(clk);
+	}
+
 }
 
 static void __init sunxi_init_clocks(void)
-- 
1.9.0
