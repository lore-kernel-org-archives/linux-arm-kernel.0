From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Mar 2016 17:38:24 +0100
Subject: [PATCH v3 01/19] clk: composite: Add unregister function
In-Reply-To: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1458751122-23976-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The composite clock didn't have any unregistration function, which forced
us to use clk_unregister directly on it.

While it was already not great from an API point of view, it also meant
that we were leaking the clk_composite structure allocated in
clk_register_composite.

Add a clk_unregister_composite function to fix this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/clk-composite.c  | 15 +++++++++++++++
 include/linux/clk-provider.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 1f903e1f86a2..b0f3b84ebd13 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -286,3 +286,18 @@ err:
 	kfree(composite);
 	return clk;
 }
+
+void clk_unregister_composite(struct clk *clk)
+{
+	struct clk_composite *composite;
+	struct clk_hw *hw;
+
+	hw = __clk_get_hw(clk);
+	if (!hw)
+		return;
+
+	composite = to_clk_composite(hw);
+
+	clk_unregister(clk);
+	kfree(composite);
+}
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index da95258127aa..26a8c9b7be71 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -603,6 +603,7 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 		struct clk_hw *rate_hw, const struct clk_ops *rate_ops,
 		struct clk_hw *gate_hw, const struct clk_ops *gate_ops,
 		unsigned long flags);
+void clk_unregister_composite(struct clk *clk);
 
 /***
  * struct clk_gpio_gate - gpio gated clock
-- 
2.7.3
