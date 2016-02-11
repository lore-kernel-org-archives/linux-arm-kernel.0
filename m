From: mturquette@baylibre.com (Michael Turquette)
Date: Wed, 10 Feb 2016 16:48:53 -0800
Subject: [PATCH 3/3] clk: Provide OF helper to mark clocks as CRITICAL
In-Reply-To: <1453127331-20616-4-git-send-email-lee.jones@linaro.org>
References: <1453127331-20616-1-git-send-email-lee.jones@linaro.org>
 <1453127331-20616-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20160211004853.26445.85326@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lee Jones (2016-01-18 06:28:51)
> This call matches clocks which have been marked as critical in DT
> and sets the appropriate flag.  These flags can then be used to
> mark the clock core flags appropriately prior to registration.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/clk-provider.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index ffa0b2e..6f178b7 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -707,6 +707,23 @@ const char *of_clk_get_parent_name(struct device_node *np, int index);
>  
>  void of_clk_init(const struct of_device_id *matches);
>  

Added kerneldoc here outlining who should use this (legacy DT bindings
and no one else).

> +static inline int of_clk_mark_if_critical(struct device_node *np,
> +                                         int index, unsigned long *flags)

Moved this to clk.c, uninlined it and unstaticized it. Renamed beastly
function name to of_clk_detect_critical.

> +{
> +       struct property *prop;
> +       const __be32 *cur;
> +       uint32_t idx;
> +
> +       if (!np || !flags)
> +               return -EINVAL;
> +
> +       of_property_for_each_u32(np, "critical-clock", prop, cur, idx)

Changed property name to clock-critical to better match its siblings.

Modified patch below.

Best regards,
Mike



>From 42df0a24d3c0bfd321e867e4113214160f17fadc Mon Sep 17 00:00:00 2001
From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 18 Jan 2016 14:28:51 +0000
Subject: [PATCH 3/6] clk: Provide OF helper to mark clocks as CRITICAL

This call matches clocks which have been marked as critical in DT
and sets the appropriate flag.  These flags can then be used to
mark the clock core flags appropriately prior to registration.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
---
 drivers/clk/clk.c            | 35 +++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |  8 +++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 39f9527..5181a15 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3202,6 +3202,41 @@ static int parent_ready(struct device_node *np)
 }
 
 /**
+ * of_clk_detect_critical() - set CLK_IS_CRITICAL flag from Device Tree
+ * @np: Device node pointer associated with clock provider
+ * @index: clock index
+ * @flags: pointer to clk_core->flags
+ *
+ * Detects if the clock-critical property exists and, if so, sets the
+ * corresponding CLK_IS_CRITICAL flag.
+ *
+ * Do not use this function. It exists only for legacy Device Tree
+ * bindings, such as the one-clock-per-node style that are outdated.
+ * Those bindings typically put all clock data into .dts and the Linux
+ * driver has no clock data, thus making it impossible to set this flag
+ * correctly from the driver. Only those drivers may call
+ * of_clk_detect_critical from their setup functions.
+ *
+ * Return: error code or zero on success
+ */
+int of_clk_mark_if_critical(struct device_node *np,
+					  int index, unsigned long *flags)
+{
+	struct property *prop;
+	const __be32 *cur;
+	uint32_t idx;
+
+	if (!np || !flags)
+		return -EINVAL;
+
+	of_property_for_each_u32(np, "clock-critical", prop, cur, idx)
+		if (index == idx)
+			*flags |= CLK_IS_CRITICAL;
+
+	return 0;
+}
+
+/**
  * of_clk_init() - Scan and init clock providers from the DT
  * @matches: array of compatible values and init functions for providers.
  *
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1d986ea..d15d3cc 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -705,7 +705,8 @@ int of_clk_get_parent_count(struct device_node *np);
 int of_clk_parent_fill(struct device_node *np, const char **parents,
 		       unsigned int size);
 const char *of_clk_get_parent_name(struct device_node *np, int index);
-
+int of_clk_mark_if_critical(struct device_node *np, int index,
+			    unsigned long *flags);
 void of_clk_init(const struct of_device_id *matches);
 
 #else /* !CONFIG_OF */
@@ -742,6 +743,11 @@ static inline const char *of_clk_get_parent_name(struct device_node *np,
 {
 	return NULL;
 }
+static inline int of_clk_mark_if_critical(struct device_node *np, int index,
+					  unsigned long *flags)
+{
+	return 0;
+}
 static inline void of_clk_init(const struct of_device_id *matches) {}
 #endif /* CONFIG_OF */
 
-- 
2.1.4
