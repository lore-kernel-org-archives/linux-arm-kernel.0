From: jason.mcmullan@netronome.com (Jason McMullan)
Date: Wed, 5 May 2010 08:54:27 -0400
Subject: [PATCH] [arm l2x0] Extend cache-l2x0 to support the 16-way PL310
	(v3)
In-Reply-To: <B393A6715F47FC43935D96EA15105EFF03B2619BAA@GEORGE.Emea.Arm.com>
References: <1272985343-5744-1-git-send-email-jason.mcmullan@netronome.com>
	<1272985343-5744-2-git-send-email-jason.mcmullan@netronome.com>
	<B393A6715F47FC43935D96EA15105EFF03B2619BAA@GEORGE.Emea.Arm.com>
Message-ID: <y2yd91d07041005050554qf0f5a2ddm499380004665a7a3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the following email from Will Deacon, and the comment period on
the list, is this patch ready to go into the ARM Linux
patch queue?

Or, Catalin, do you want to integrate these changes into your
patch set for the l2x0 first?

---------- Forwarded message ----------
From: Will Deacon <Will.Deacon@arm.com>
Date: Tue, May 4, 2010 at 7:41 PM
Subject: RE: [PATCH] [arm l2x0] Extend cache-l2x0 to support the
16-way PL310 (v3)
To: "Jason S. McMullan" <jason.mcmullan@netronome.com>


Hi Jason,

I'm out of the office for the next couple of weeks, so I'm resorting
to the web email interface.
I apologise for top-posting and also for the inevitable
confidentiality notice that will be appended
to this email.

The ?patch below looks good to me, so please feel free to add:

Acked-by: Will Deacon <will.deacon@arm.com>

to your submission.

There's a small typo [s/Assciativity/Associativity/] in the ChangeLog
that you may want to
change, but that's purely aesthetic.

Thanks,

Will

________________________________________
From: Jason S. McMullan [jason.mcmullan at netronome.com]
Sent: 04 May 2010 16:02
To: Will Deacon
Subject: [PATCH] [arm l2x0] Extend cache-l2x0 to support the 16-way PL310 (v3)

The L310 cache controller's interface is almost identical
to the L210. One major difference is that the PL310 can
have up to 16 ways.

This change uses the cache's part ID and the Assciativity
bits in the AUX_CTRL register to determine the number of ways.

Also prints out the # of ways, CACHE_ID and AUX_CTRL registers.

Signed-off-by: Jason S. McMullan <jason.mcmullan@netronome.com>
---
?arch/arm/include/asm/hardware/cache-l2x0.h | ? ?3 ++
?arch/arm/mm/cache-l2x0.c ? ? ? ? ? ? ? ? ? | ? 39 ++++++++++++++++++++++++---
?2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h
b/arch/arm/include/asm/hardware/cache-l2x0.h
index cdb9022..6bcba48 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -21,6 +21,9 @@
?#define __ASM_ARM_HARDWARE_L2X0_H

?#define L2X0_CACHE_ID ? ? ? ? ? ? ? ? ?0x000
+#define ? L2X0_CACHE_ID_PART_MASK ? ? ?(0xf << 6)
+#define ? L2X0_CACHE_ID_PART_L210 ? ? ?(1 << 6)
+#define ? L2X0_CACHE_ID_PART_L310 ? ? ?(3 << 6)
?#define L2X0_CACHE_TYPE ? ? ? ? ? ? ? ? ? ? ? ?0x004
?#define L2X0_CTRL ? ? ? ? ? ? ? ? ? ? ?0x100
?#define L2X0_AUX_CTRL ? ? ? ? ? ? ? ? ?0x104
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 21ad68b..9819869 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -27,6 +27,7 @@

?static void __iomem *l2x0_base;
?static DEFINE_SPINLOCK(l2x0_lock);
+static uint32_t l2x0_way_mask; /* Bitmask of active ways */

?static inline void cache_wait(void __iomem *reg, unsigned long mask)
?{
@@ -108,8 +109,8 @@ static inline void l2x0_inv_all(void)

? ? ? ?/* invalidate all ways */
? ? ? ?spin_lock_irqsave(&l2x0_lock, flags);
- ? ? ? writel(0xff, l2x0_base + L2X0_INV_WAY);
- ? ? ? cache_wait(l2x0_base + L2X0_INV_WAY, 0xff);
+ ? ? ? writel(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
+ ? ? ? cache_wait(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
? ? ? ?cache_sync();
? ? ? ?spin_unlock_irqrestore(&l2x0_lock, flags);
?}
@@ -208,9 +209,37 @@ static void l2x0_flush_range(unsigned long start,
unsigned long end)
?void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
?{
? ? ? ?__u32 aux;
+ ? ? ? __u32 cache_id;
+ ? ? ? int ways;
+ ? ? ? const char *type;

? ? ? ?l2x0_base = base;

+ ? ? ? cache_id = readl(l2x0_base + L2X0_CACHE_ID);
+ ? ? ? aux = readl(l2x0_base + L2X0_AUX_CTRL);
+
+ ? ? ? /* Determine the number of ways */
+ ? ? ? switch (cache_id & L2X0_CACHE_ID_PART_MASK) {
+ ? ? ? case L2X0_CACHE_ID_PART_L310:
+ ? ? ? ? ? ? ? if (aux & (1 << 16))
+ ? ? ? ? ? ? ? ? ? ? ? ways = 16;
+ ? ? ? ? ? ? ? else
+ ? ? ? ? ? ? ? ? ? ? ? ways = 8;
+ ? ? ? ? ? ? ? type = "L310";
+ ? ? ? ? ? ? ? break;
+ ? ? ? case L2X0_CACHE_ID_PART_L210:
+ ? ? ? ? ? ? ? ways = (aux >> 13) & 0xf;
+ ? ? ? ? ? ? ? type = "L210";
+ ? ? ? ? ? ? ? break;
+ ? ? ? default:
+ ? ? ? ? ? ? ? /* Assume unknown chips have 8 ways */
+ ? ? ? ? ? ? ? ways = 8;
+ ? ? ? ? ? ? ? type = "L2x0 series";
+ ? ? ? ? ? ? ? break;
+ ? ? ? }
+
+ ? ? ? l2x0_way_mask = (1 << ways) - 1;
+
? ? ? ?/*
? ? ? ? * Check if l2x0 controller is already enabled.
? ? ? ? * If you are booting from non-secure mode
@@ -219,8 +248,6 @@ void __init l2x0_init(void __iomem *base, __u32
aux_val, __u32 aux_mask)
? ? ? ?if (!(readl(l2x0_base + L2X0_CTRL) & 1)) {

? ? ? ? ? ? ? ?/* l2x0 controller is disabled */
-
- ? ? ? ? ? ? ? aux = readl(l2x0_base + L2X0_AUX_CTRL);
? ? ? ? ? ? ? ?aux &= aux_mask;
? ? ? ? ? ? ? ?aux |= aux_val;
? ? ? ? ? ? ? ?writel(aux, l2x0_base + L2X0_AUX_CTRL);
@@ -236,5 +263,7 @@ void __init l2x0_init(void __iomem *base, __u32
aux_val, __u32 aux_mask)
? ? ? ?outer_cache.flush_range = l2x0_flush_range;
? ? ? ?outer_cache.sync = l2x0_cache_sync;

- ? ? ? printk(KERN_INFO "L2X0 cache controller enabled\n");
+ ? ? ? printk(KERN_INFO "%s cache controller enabled\n", type);
+ ? ? ? printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x\n",
+ ? ? ? ? ? ? ? ? ? ? ? ?ways, cache_id, aux);
?}
--
1.7.0.4

-- 
Jason S. McMullan
Netronome Systems, Inc.
