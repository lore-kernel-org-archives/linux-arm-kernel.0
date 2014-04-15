From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Tue, 15 Apr 2014 20:37:48 +0300
Subject: [RESEND PATCH 3/4] ARM: OMAP: counter-32k: raw read and write endian
 fix
In-Reply-To: <1397583469-14457-1-git-send-email-taras.kondratiuk@linaro.org>
References: <1397583469-14457-1-git-send-email-taras.kondratiuk@linaro.org>
Message-ID: <1397583469-14457-4-git-send-email-taras.kondratiuk@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>

All OMAP IP blocks expect LE data, but CPU may operate in BE mode.
Need to use endian neutral functions to read/write h/w registers.
I.e instead of __raw_read[lw] and __raw_write[lw] functions code
need to use read[lw]_relaxed and write[lw]_relaxed functions.
If the first simply reads/writes register, the second will byteswap
it if host operates in BE mode.

Changes are trivial sed like replacement of __raw_xxx functions
with xxx_relaxed variant.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
 arch/arm/plat-omap/counter_32k.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 384a776d..61b4d70 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -40,7 +40,7 @@ static void __iomem *sync32k_cnt_reg;
 
 static u64 notrace omap_32k_read_sched_clock(void)
 {
-	return sync32k_cnt_reg ? __raw_readl(sync32k_cnt_reg) : 0;
+	return sync32k_cnt_reg ? readl_relaxed(sync32k_cnt_reg) : 0;
 }
 
 /**
@@ -64,7 +64,7 @@ static void omap_read_persistent_clock(struct timespec *ts)
 	spin_lock_irqsave(&read_persistent_clock_lock, flags);
 
 	last_cycles = cycles;
-	cycles = sync32k_cnt_reg ? __raw_readl(sync32k_cnt_reg) : 0;
+	cycles = sync32k_cnt_reg ? readl_relaxed(sync32k_cnt_reg) : 0;
 
 	nsecs = clocksource_cyc2ns(cycles - last_cycles,
 					persistent_mult, persistent_shift);
@@ -95,7 +95,7 @@ int __init omap_init_clocksource_32k(void __iomem *vbase)
 	 * The 'SCHEME' bits(30-31) of the revision register is used
 	 * to identify the version.
 	 */
-	if (__raw_readl(vbase + OMAP2_32KSYNCNT_REV_OFF) &
+	if (readl_relaxed(vbase + OMAP2_32KSYNCNT_REV_OFF) &
 						OMAP2_32KSYNCNT_REV_SCHEME)
 		sync32k_cnt_reg = vbase + OMAP2_32KSYNCNT_CR_OFF_HIGH;
 	else
-- 
1.7.9.5
