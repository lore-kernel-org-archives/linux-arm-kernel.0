From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 26 Sep 2011 10:43:00 +0800
Subject: [PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from
	initialization functions
In-Reply-To: <20110923205500.GW17169@n2100.arm.linux.org.uk>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<1315288107-14689-2-git-send-email-shawn.guo@linaro.org>
	<20110914084237.GC6267@n2100.arm.linux.org.uk>
	<20110915013937.GE1488@S2100-06.ap.freescale.net>
	<20110915083248.GG6267@n2100.arm.linux.org.uk>
	<CAGsJ_4xpc-8zzGkZ9LThqP7in27n6uX4LRGAf+AtoWTM4p=82w@mail.gmail.com>
	<20110917104518.GD16381@n2100.arm.linux.org.uk>
	<CAGsJ_4ysZ7C7PZ7eCLyrLuUGux2U8mVknobaJ4tRdk1g97z-dA@mail.gmail.com>
	<20110917145614.GG16381@n2100.arm.linux.org.uk>
	<CAGsJ_4xhQZUKx85+4mZLqFrAF+XmUqZp=VCRYwJyNafTUe814g@mail.gmail.com>
	<20110923205500.GW17169@n2100.arm.linux.org.uk>
Message-ID: <CAGsJ_4xpwZR-S2GjtMsi-BRb1ppc1Gh3Zebt4B8psnxB1ndg5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/24 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Sep 19, 2011 at 01:33:39PM +0800, Barry Song wrote:
>> Do you think the following is what you want?
>
> Almost. ?A couple of things:
>
> 1. Making the variables static means that folk like OMAP can't read the
> ? values at resume time from their assembly (forcing them to save and
> ? restore them, rather than using the already saved copy.)
>
> 2. It probably makes sense to make a structure out of the saved state
> ? information so that assembly code doesn't have to individually find
> ? the address of each variable. ?Instead, they can find the address of
> ? the structure (in physical memory if that's what they need) and use
> ? offsets.
>
> With (2) its probably worth adding a comment about the structure being
> used in platform code and it should only ever be appended to.
> (Alternatively, we could use the asm-offsets.h generation stuff to
> create preprocessor symbols for the offsets in the struct if we put the
> struct in a header file.)
>
 Then the incremental changes:

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h
b/arch/arm/include/asm/hardware/cache-l2x0.h
index 733606b..99f2793 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -96,6 +96,19 @@
 #ifndef __ASSEMBLY__
 extern void l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
 extern int l2x0_of_init(__u32 aux_val, __u32 aux_mask);
+
+struct l2x0_regs {
+	unsigned long aux_ctrl;
+	/*
+	 * Whether the following registers need to be saved/restored
+	 * depends on platform
+	 */
+	unsigned long tag_latency;
+	unsigned long data_latency;
+	unsigned long filter_start;
+	unsigned long filter_end;
+};
+
 #endif

 #endif
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 16baba2..b8d72a8 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -20,6 +20,7 @@
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/procinfo.h>
+#include <asm/hardware/cache-l2x0.h>
 #include <linux/kbuild.h>

 /*
@@ -92,6 +93,14 @@ int main(void)
   DEFINE(S_OLD_R0,		offsetof(struct pt_regs, ARM_ORIG_r0));
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
+#ifdef CONFIG_CACHE_L2X0
+  DEFINE(L2X0_R_AUX_CTRL,	offsetof(struct l2x0_regs, aux_ctrl));
+  DEFINE(L2X0_R_TAG_LATENCY,	offsetof(struct l2x0_regs, tag_latency));
+  DEFINE(L2X0_R_DATA_LATENCY,	offsetof(struct l2x0_regs, data_latency));
+  DEFINE(L2X0_R_FILTER_START,	offsetof(struct l2x0_regs, filter_start));
+  DEFINE(L2X0_R_FILTER_END,	offsetof(struct l2x0_regs, filter_end));
+  BLANK();
+#endif
 #ifdef CONFIG_CPU_HAS_ASID
   DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id));
   BLANK();
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 98d03fb..b44f333 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -32,8 +32,8 @@ static void __iomem *l2x0_base;
 static DEFINE_SPINLOCK(l2x0_lock);
 static uint32_t l2x0_way_mask;	/* Bitmask of active ways */
 static uint32_t l2x0_size;
-static u32 l2x0_aux_ctrl;
-static u32 l2x0_tag_latency, l2x0_data_latency, l2x0_filter_start,
l2x0_filter_end;
+
+struct l2x0_regs l2x0_saved_regs;

 struct l2x0_of_data {
 	void (*setup)(const struct device_node *, __u32 *, __u32 *);
@@ -364,7 +364,7 @@ void l2x0_init(void __iomem *base, __u32 aux_val,
__u32 aux_mask)
 		/* l2x0 controller is disabled */
 		writel_relaxed(aux, l2x0_base + L2X0_AUX_CTRL);

-		l2x0_aux_ctrl = aux;
+		l2x0_saved_regs.aux_ctrl = aux;

 		l2x0_inv_all();

@@ -457,10 +457,10 @@ static void pl310_of_setup(const struct device_node *np,

 static void __init pl310_save(void)
 {
-	l2x0_tag_latency = readl_relaxed(l2x0_base + L2X0_TAG_LATENCY_CTRL);
-	l2x0_data_latency = readl_relaxed(l2x0_base + L2X0_DATA_LATENCY_CTRL);
-	l2x0_filter_end = readl_relaxed(l2x0_base + L2X0_ADDR_FILTER_END);
-	l2x0_filter_start = readl_relaxed(l2x0_base + L2X0_ADDR_FILTER_START);
+	l2x0_saved_regs.tag_latency = readl_relaxed(l2x0_base +
L2X0_TAG_LATENCY_CTRL);
+	l2x0_saved_regs.data_latency = readl_relaxed(l2x0_base +
L2X0_DATA_LATENCY_CTRL);
+	l2x0_saved_regs.filter_end = readl_relaxed(l2x0_base + L2X0_ADDR_FILTER_END);
+	l2x0_saved_regs.filter_start = readl_relaxed(l2x0_base +
L2X0_ADDR_FILTER_START);
 }

 static void l2x0_resume(void)
@@ -469,7 +469,7 @@ static void l2x0_resume(void)
 		/* restore aux ctrl and enable l2 */
 		l2x0_unlock(readl_relaxed(l2x0_base + L2X0_CACHE_ID));

-		writel_relaxed(l2x0_aux_ctrl, l2x0_base + L2X0_AUX_CTRL);
+		writel_relaxed(l2x0_saved_regs.aux_ctrl, l2x0_base + L2X0_AUX_CTRL);

 		l2x0_inv_all();

@@ -481,10 +481,10 @@ static void pl310_resume(void)
 {
 	if (!(readl_relaxed(l2x0_base + L2X0_CTRL) & 1)) {
 		/* restore pl310 setup */
-		writel_relaxed(l2x0_tag_latency, l2x0_base + L2X0_TAG_LATENCY_CTRL);
-		writel_relaxed(l2x0_data_latency, l2x0_base + L2X0_DATA_LATENCY_CTRL);
-		writel_relaxed(l2x0_filter_end, l2x0_base + L2X0_ADDR_FILTER_END);
-		writel_relaxed(l2x0_filter_start, l2x0_base + L2X0_ADDR_FILTER_START);
+		writel_relaxed(l2x0_saved_regs.tag_latency, l2x0_base +
L2X0_TAG_LATENCY_CTRL);
+		writel_relaxed(l2x0_saved_regs.data_latency, l2x0_base +
L2X0_DATA_LATENCY_CTRL);
+		writel_relaxed(l2x0_saved_regs.filter_end, l2x0_base + L2X0_ADDR_FILTER_END);
+		writel_relaxed(l2x0_saved_regs.filter_start, l2x0_base +
L2X0_ADDR_FILTER_START);
 	}

 	l2x0_resume();

--

-barry
