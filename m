From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:37:09 +0900
Subject: [PATCH 4/8] ARM: shmobile: R-Car: Make struct rcar_sysc_ch *
 parameters const
In-Reply-To: <cover.1436510166.git.horms+renesas@verge.net.au>
References: <cover.1436510166.git.horms+renesas@verge.net.au>
Message-ID: <624deb39a1c684b42569a3ec6a0fdcc74b950ed3.1436510166.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The passed struct rcar_sysc_ch is never modified, so it can be const.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-rcar.c | 16 ++++++++--------
 arch/arm/mach-shmobile/pm-rcar.h |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar.c b/arch/arm/mach-shmobile/pm-rcar.c
index a5e4c3a88ec4..b1a7f2a7f757 100644
--- a/arch/arm/mach-shmobile/pm-rcar.c
+++ b/arch/arm/mach-shmobile/pm-rcar.c
@@ -51,7 +51,7 @@
 static void __iomem *rcar_sysc_base;
 static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
 
-static int rcar_sysc_pwr_on_off(struct rcar_sysc_ch *sysc_ch,
+static int rcar_sysc_pwr_on_off(const struct rcar_sysc_ch *sysc_ch,
 				int sr_bit, int reg_offs)
 {
 	int k;
@@ -73,18 +73,18 @@ static int rcar_sysc_pwr_on_off(struct rcar_sysc_ch *sysc_ch,
 	return 0;
 }
 
-static int rcar_sysc_pwr_off(struct rcar_sysc_ch *sysc_ch)
+static int rcar_sysc_pwr_off(const struct rcar_sysc_ch *sysc_ch)
 {
 	return rcar_sysc_pwr_on_off(sysc_ch, SYSCSR_POFFENB, PWROFFCR_OFFS);
 }
 
-static int rcar_sysc_pwr_on(struct rcar_sysc_ch *sysc_ch)
+static int rcar_sysc_pwr_on(const struct rcar_sysc_ch *sysc_ch)
 {
 	return rcar_sysc_pwr_on_off(sysc_ch, SYSCSR_PONENB, PWRONCR_OFFS);
 }
 
-static int rcar_sysc_update(struct rcar_sysc_ch *sysc_ch,
-			    int (*on_off_fn)(struct rcar_sysc_ch *))
+static int rcar_sysc_update(const struct rcar_sysc_ch *sysc_ch,
+			    int (*on_off_fn)(const struct rcar_sysc_ch *))
 {
 	unsigned int isr_mask = 1 << sysc_ch->isr_bit;
 	unsigned int chan_mask = 1 << sysc_ch->chan_bit;
@@ -136,17 +136,17 @@ static int rcar_sysc_update(struct rcar_sysc_ch *sysc_ch,
 	return ret;
 }
 
-int rcar_sysc_power_down(struct rcar_sysc_ch *sysc_ch)
+int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch)
 {
 	return rcar_sysc_update(sysc_ch, rcar_sysc_pwr_off);
 }
 
-int rcar_sysc_power_up(struct rcar_sysc_ch *sysc_ch)
+int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch)
 {
 	return rcar_sysc_update(sysc_ch, rcar_sysc_pwr_on);
 }
 
-bool rcar_sysc_power_is_off(struct rcar_sysc_ch *sysc_ch)
+bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
 {
 	unsigned int st;
 
diff --git a/arch/arm/mach-shmobile/pm-rcar.h b/arch/arm/mach-shmobile/pm-rcar.h
index 06ebf00a6a5a..1b901db4a24c 100644
--- a/arch/arm/mach-shmobile/pm-rcar.h
+++ b/arch/arm/mach-shmobile/pm-rcar.h
@@ -7,9 +7,9 @@ struct rcar_sysc_ch {
 	u8 isr_bit;
 };
 
-int rcar_sysc_power_down(struct rcar_sysc_ch *sysc_ch);
-int rcar_sysc_power_up(struct rcar_sysc_ch *sysc_ch);
-bool rcar_sysc_power_is_off(struct rcar_sysc_ch *sysc_ch);
+int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch);
+int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch);
+bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch);
 void __iomem *rcar_sysc_init(phys_addr_t base);
 
 #endif /* PM_RCAR_H */
-- 
2.1.4
