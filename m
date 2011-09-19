From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 19 Sep 2011 13:33:39 +0800
Subject: [PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from
	initialization functions
In-Reply-To: <20110917145614.GG16381@n2100.arm.linux.org.uk>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<1315288107-14689-2-git-send-email-shawn.guo@linaro.org>
	<20110914084237.GC6267@n2100.arm.linux.org.uk>
	<20110915013937.GE1488@S2100-06.ap.freescale.net>
	<20110915083248.GG6267@n2100.arm.linux.org.uk>
	<CAGsJ_4xpc-8zzGkZ9LThqP7in27n6uX4LRGAf+AtoWTM4p=82w@mail.gmail.com>
	<20110917104518.GD16381@n2100.arm.linux.org.uk>
	<CAGsJ_4ysZ7C7PZ7eCLyrLuUGux2U8mVknobaJ4tRdk1g97z-dA@mail.gmail.com>
	<20110917145614.GG16381@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4xhQZUKx85+4mZLqFrAF+XmUqZp=VCRYwJyNafTUe814g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/17 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sat, Sep 17, 2011 at 10:41:58PM +0800, Barry Song wrote:
>> for aux ctrl, it is really simple. but how about the following:
>>
>> ?393 static void __init pl310_of_setup(const struct device_node *np,
>> ?394 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __u32 *aux_val, __u32 *aux_mask)
>> ?395 {
>> ?396 ? ? ? ? u32 data[3] = { 0, 0, 0 };
>> ?397 ? ? ? ? u32 tag[3] = { 0, 0, 0 };
>> ?398 ? ? ? ? u32 filter[2] = { 0, 0 };
>> ?399
>> ?400 ? ? ? ? of_property_read_u32_array(np, "arm,tag-latency", tag,
>> ARRAY_SIZE(tag));
>> ?401 ? ? ? ? if (tag[0] && tag[1] && tag[2])
>> ?402 ? ? ? ? ? ? ? ? writel_relaxed(
>> ?403 ? ? ? ? ? ? ? ? ? ? ? ? ((tag[0] - 1) << L2X0_LATENCY_CTRL_RD_SHIFT) |
>> ?404 ? ? ? ? ? ? ? ? ? ? ? ? ((tag[1] - 1) << L2X0_LATENCY_CTRL_WR_SHIFT) |
>> ?405 ? ? ? ? ? ? ? ? ? ? ? ? ((tag[2] - 1) << L2X0_LATENCY_CTRL_SETUP_SHIFT),
>> ?406 ? ? ? ? ? ? ? ? ? ? ? ? l2x0_base + L2X0_TAG_LATENCY_CTRL);
>> ?407
>> ?408 ? ? ? ? of_property_read_u32_array(np, "arm,data-latency",
>> ?409 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?data, ARRAY_SIZE(data));
>> ?410 ? ? ? ? if (data[0] && data[1] && data[2])
>> ?411 ? ? ? ? ? ? ? ? writel_relaxed(
>> ?412 ? ? ? ? ? ? ? ? ? ? ? ? ((data[0] - 1) << L2X0_LATENCY_CTRL_RD_SHIFT) |
>> ?413 ? ? ? ? ? ? ? ? ? ? ? ? ((data[1] - 1) << L2X0_LATENCY_CTRL_WR_SHIFT) |
>> ?414 ? ? ? ? ? ? ? ? ? ? ? ? ((data[2] - 1) << L2X0_LATENCY_CTRL_SETUP_SHIFT),
>> ?415 ? ? ? ? ? ? ? ? ? ? ? ? l2x0_base + L2X0_DATA_LATENCY_CTRL);
>> ?416
>> ?417 ? ? ? ? of_property_read_u32_array(np, "arm,filter-ranges",
>> ?418 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?filter, ARRAY_SIZE(filter));
>> ?419 ? ? ? ? if (filter[0] && filter[1]) {
>> ?420 ? ? ? ? ? ? ? ? writel_relaxed(ALIGN(filter[0] + filter[1], SZ_1M),
>> ?421 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?l2x0_base + L2X0_ADDR_FILTER_END);
>> ?422 ? ? ? ? ? ? ? ? writel_relaxed((filter[0] & ~(SZ_1M - 1)) |
>> L2X0_ADDR_FILTER_EN,
>> ?423 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?l2x0_base + L2X0_ADDR_FILTER_START);
>> ?424 ? ? ? ? }
>> ?425 }
>>
>> not all l2 have all these registers. for example, it seems only prima2
>> has L2X0_ADDR_FILTER_START/END by now. and only some platforms set
>> latency too.
>
> Save them as normal. ?If there aren't the values in DT, read them in the
> above functions and save the value. ?Then...
Do you think the following is what you want?

diff --git a/arch/arm/include/asm/outercache.h
b/arch/arm/include/asm/outercache.h
index d838743..53426c6 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -34,6 +34,7 @@ struct outer_cache_fns {
 	void (*sync)(void);
 #endif
 	void (*set_debug)(unsigned long);
+	void (*resume)(void);
 };

 #ifdef CONFIG_OUTER_CACHE
@@ -74,6 +75,12 @@ static inline void outer_disable(void)
 		outer_cache.disable();
 }

+static inline void outer_resume(void)
+{
+	if (outer_cache.resume)
+		outer_cache.resume();
+}
+
 #else

 static inline void outer_inv_range(phys_addr_t start, phys_addr_t end)
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 0d85d22..4722707 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -32,6 +32,14 @@ static void __iomem *l2x0_base;
 static DEFINE_SPINLOCK(l2x0_lock);
 static uint32_t l2x0_way_mask;	/* Bitmask of active ways */
 static uint32_t l2x0_size;
+static u32 l2x0_aux_ctrl;
+static u32 l2x0_tag_latency, l2x0_data_latency, l2x0_filter_start,
l2x0_filter_end;
+
+struct l2x0_of_data {
+	void (*setup)(const struct device_node *,__u32 *, __u32 *);
+	void (*save)(void);
+	void (*resume)(void);
+};

 static inline void cache_wait_way(void __iomem *reg, unsigned long mask)
 {
@@ -280,7 +288,7 @@ static void l2x0_disable(void)
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }

-static void __init l2x0_unlock(__u32 cache_id)
+static void l2x0_unlock(__u32 cache_id)
 {
 	int lockregs;
 	int i;
@@ -356,6 +364,8 @@ void __init l2x0_init(void __iomem *base, __u32
aux_val, __u32 aux_mask)
 		/* l2x0 controller is disabled */
 		writel_relaxed(aux, l2x0_base + L2X0_AUX_CTRL);

+		l2x0_aux_ctrl = aux;
+
 		l2x0_inv_all();

 		/* enable L2X0 */
@@ -445,18 +455,64 @@ static void __init pl310_of_setup(const struct
device_node *np,
 	}
 }

+static void __init pl310_save(void)
+{
+	l2x0_tag_latency = readl_relaxed(l2x0_base + L2X0_TAG_LATENCY_CTRL);
+	l2x0_data_latency = readl_relaxed(l2x0_base + L2X0_DATA_LATENCY_CTRL);
+	l2x0_filter_end = readl_relaxed(l2x0_base + L2X0_ADDR_FILTER_END);
+	l2x0_filter_start = readl_relaxed(l2x0_base + L2X0_ADDR_FILTER_START);
+}
+
+static void l2x0_resume(void)
+{
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
+		/* restore aux ctrl and enable l2 */
+		l2x0_unlock(readl_relaxed(l2x0_base + L2X0_CACHE_ID));
+
+		writel_relaxed(l2x0_aux_ctrl, l2x0_base + L2X0_AUX_CTRL);
+
+		l2x0_inv_all();
+
+		writel_relaxed(1, l2x0_base + L2X0_CTRL);
+	}
+}
+
+static void pl310_resume(void)
+{
+	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
+		/* restore pl310 setup */
+		writel_relaxed(l2x0_tag_latency, l2x0_base + L2X0_TAG_LATENCY_CTRL);
+		writel_relaxed(l2x0_data_latency, l2x0_base + L2X0_DATA_LATENCY_CTRL);
+		writel_relaxed(l2x0_filter_end, l2x0_base + L2X0_ADDR_FILTER_END);
+		writel_relaxed(l2x0_filter_start, l2x0_base + L2X0_ADDR_FILTER_START);
+	}
+
+	l2x0_resume();
+}
+
+static const struct l2x0_of_data pl310_data = {
+	pl310_of_setup,
+	pl310_save,
+	pl310_resume,
+};
+
+static const struct l2x0_of_data l2x0_data = {
+	l2x0_of_setup,
+	NULL,
+	l2x0_resume,
+};
+
 static const struct of_device_id l2x0_ids[] __initconst = {
-	{ .compatible = "arm,pl310-cache", .data = pl310_of_setup },
-	{ .compatible = "arm,l220-cache", .data = l2x0_of_setup },
-	{ .compatible = "arm,l210-cache", .data = l2x0_of_setup },
+	{ .compatible = "arm,pl310-cache", .data = (void *)&pl310_data },
+	{ .compatible = "arm,l220-cache", .data = (void *)&l2x0_data },
+	{ .compatible = "arm,l210-cache", .data = (void *)&l2x0_data },
 	{}
 };

 int __init l2x0_of_init(__u32 aux_val, __u32 aux_mask)
 {
 	struct device_node *np;
-	void (*l2_setup)(const struct device_node *np,
-		__u32 *aux_val, __u32 *aux_mask);
+	struct l2x0_of_data *data;

 	np = of_find_matching_node(NULL, l2x0_ids);
 	if (!np)
@@ -465,13 +521,20 @@ int __init l2x0_of_init(__u32 aux_val, __u32 aux_mask)
 	if (!l2x0_base)
 		return -ENOMEM;

+	data = of_match_node(l2x0_ids, np)->data;
+
 	/* L2 configuration can only be changed if the cache is disabled */
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
-		l2_setup = of_match_node(l2x0_ids, np)->data;
-		if (l2_setup)
-			l2_setup(np, &aux_val, &aux_mask);
+		if (data->setup)
+			data->setup(np, &aux_val, &aux_mask);
 	}
+
+	if (data->save)
+		data->save();
+
 	l2x0_init(l2x0_base, aux_val, aux_mask);
+
+	outer_cache.resume = data->resume;
 	return 0;
 }
 #endif


-barry
