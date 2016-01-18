From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 18 Jan 2016 14:28:51 +0000
Subject: [PATCH 3/3] clk: Provide OF helper to mark clocks as CRITICAL
In-Reply-To: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
References: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1453127331-20616-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This call matches clocks which have been marked as critical in DT
and sets the appropriate flag.  These flags can then be used to
mark the clock core flags appropriately prior to registration.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/clk-provider.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index ffa0b2e..6f178b7 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -707,6 +707,23 @@ const char *of_clk_get_parent_name(struct device_node *np, int index);
 
 void of_clk_init(const struct of_device_id *matches);
 
+static inline int of_clk_mark_if_critical(struct device_node *np,
+					  int index, unsigned long *flags)
+{
+	struct property *prop;
+	const __be32 *cur;
+	uint32_t idx;
+
+	if (!np || !flags)
+		return -EINVAL;
+
+	of_property_for_each_u32(np, "critical-clock", prop, cur, idx)
+		if (index == idx)
+			*flags |= CLK_IS_CRITICAL;
+
+	return 0;
+}
+
 #else /* !CONFIG_OF */
 
 static inline int of_clk_add_provider(struct device_node *np,
@@ -742,6 +759,11 @@ static inline const char *of_clk_get_parent_name(struct device_node *np,
 {
 	return NULL;
 }
+static inline int of_clk_mark_if_critical(struct device_node *np, int index,
+					  unsigned long *flags)
+{
+	return 0;
+}
 #define of_clk_init(matches) \
 	{ while (0); }
 #endif /* CONFIG_OF */
-- 
1.9.1
