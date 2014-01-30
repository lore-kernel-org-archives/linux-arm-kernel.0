From: adrienverge@gmail.com (=?UTF-8?q?Adrien=20Verg=C3=A9?=)
Date: Thu, 30 Jan 2014 11:11:08 -0500
Subject: [PATCH V3 3/5] ARM CoreSight: ETM: Rename 'comparator' to 'address
 comparator'
In-Reply-To: <1391098270-8867-1-git-send-email-adrienverge@gmail.com>
References: <1391098270-8867-1-git-send-email-adrienverge@gmail.com>
Message-ID: <1391098270-8867-4-git-send-email-adrienverge@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since there are different types of comparators, and other kinds will
be used (such as Context ID comparators), rename them properly.

Signed-off-by: Adrien Verg? <adrienverge@gmail.com>
---
 arch/arm/include/asm/hardware/coresight.h |  4 ++--
 arch/arm/kernel/etm.c                     | 19 ++++++++++---------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/hardware/coresight.h b/arch/arm/include/asm/hardware/coresight.h
index ad774f3..8c50cf6 100644
--- a/arch/arm/include/asm/hardware/coresight.h
+++ b/arch/arm/include/asm/hardware/coresight.h
@@ -95,8 +95,8 @@
 #define ETMAAT_NSONLY		(1 << 10)
 #define ETMAAT_SONLY		(2 << 10)
 
-#define ETMR_COMP_VAL(x)	(0x40 + (x) * 4)
-#define ETMR_COMP_ACC_TYPE(x)	(0x80 + (x) * 4)
+#define ETMR_ADDRCOMP_VAL(x)	(0x40 + (x) * 4)
+#define ETMR_ADDRCOMP_ACC_TYPE(x)	(0x80 + (x) * 4)
 
 /* ETM status register, "ETM Architecture", 3.3.2 */
 #define ETMR_STATUS		(0x10)
diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 7a3ee66..b3e6713 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -39,7 +39,7 @@ struct tracectx {
 	void __iomem	*etb_regs;
 	void __iomem	*etm_regs;
 	unsigned long	flags;
-	int		ncmppairs;
+	int		naddrcmppairs;
 	int		etm_portsz;
 	struct device	*dev;
 	struct clk	*emu_clk;
@@ -59,7 +59,7 @@ static int etm_setup_address_range(struct tracectx *t, int n,
 	u32 flags = ETMAAT_ARM | ETMAAT_IGNCONTEXTID | ETMAAT_NSONLY | \
 		    ETMAAT_NOVALCMP;
 
-	if (n < 1 || n > t->ncmppairs)
+	if (n < 1 || n > t->naddrcmppairs)
 		return -EINVAL;
 
 	/* comparators and ranges are numbered starting with 1 as opposed
@@ -72,12 +72,12 @@ static int etm_setup_address_range(struct tracectx *t, int n,
 		flags |= ETMAAT_IEXEC;
 
 	/* first comparator for the range */
-	etm_writel(t, flags, ETMR_COMP_ACC_TYPE(n * 2));
-	etm_writel(t, start, ETMR_COMP_VAL(n * 2));
+	etm_writel(t, flags, ETMR_ADDRCOMP_ACC_TYPE(n * 2));
+	etm_writel(t, start, ETMR_ADDRCOMP_VAL(n * 2));
 
 	/* second comparator is right next to it */
-	etm_writel(t, flags, ETMR_COMP_ACC_TYPE(n * 2 + 1));
-	etm_writel(t, end, ETMR_COMP_VAL(n * 2 + 1));
+	etm_writel(t, flags, ETMR_ADDRCOMP_ACC_TYPE(n * 2 + 1));
+	etm_writel(t, end, ETMR_ADDRCOMP_VAL(n * 2 + 1));
 
 	flags = exclude ? ETMTE_INCLEXCL : 0;
 	etm_writel(t, flags | (1 << n), ETMR_TRACEENCTRL);
@@ -478,7 +478,8 @@ static ssize_t trace_info_show(struct device *dev,
 	etm_st = etm_readl(&tracer, ETMR_STATUS);
 	etm_lock(&tracer);
 
-	return sprintf(buf, "Trace buffer len: %d\nComparator pairs: %d\n"
+	return sprintf(buf, "Trace buffer len: %d\n"
+			"Addr comparator pairs: %d\n"
 			"ETBR_WRITEADDR:\t%08x\n"
 			"ETBR_READADDR:\t%08x\n"
 			"ETBR_STATUS:\t%08x\n"
@@ -486,7 +487,7 @@ static ssize_t trace_info_show(struct device *dev,
 			"ETMR_CTRL:\t%08x\n"
 			"ETMR_STATUS:\t%08x\n",
 			datalen,
-			tracer.ncmppairs,
+			tracer.naddrcmppairs,
 			etb_wa,
 			etb_ra,
 			etb_st,
@@ -562,7 +563,7 @@ static int etm_probe(struct amba_device *dev, const struct amba_id *id)
 	/* dummy first read */
 	(void)etm_readl(&tracer, ETMMR_OSSRR);
 
-	t->ncmppairs = etm_readl(t, ETMR_CONFCODE) & 0xf;
+	t->naddrcmppairs = etm_readl(t, ETMR_CONFCODE) & 0xf;
 	etm_writel(t, 0x440, ETMR_CTRL);
 	etm_lock(t);
 
-- 
1.8.5.3
