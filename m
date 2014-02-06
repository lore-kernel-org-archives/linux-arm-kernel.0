From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:15:26 +0900
Subject: [PATCH] ARM: shmobile: wait for MSTP clock status to toggle,
 when enabling it
In-Reply-To: <cover.1391651474.git.horms+renesas@verge.net.au>
References: <cover.1391651474.git.horms+renesas@verge.net.au>
Message-ID: <a028c6da34d434e35ba8322568c756ea97ff3c18.1391651474.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On r-/sh-mobile SoCs MSTP clocks are used by the runtime PM to dynamically
enable and disable peripheral clocks. To make sure the clock has really
started we have to read back its status register until it confirms success.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/clk/cpg.c   | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/sh_clk.h | 19 ++++++++++++-------
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index 1ebe67c..7442bc1 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -36,9 +36,47 @@ static void sh_clk_write(int value, struct clk *clk)
 		iowrite32(value, clk->mapped_reg);
 }
 
+static unsigned int r8(const void __iomem *addr)
+{
+	return ioread8(addr);
+}
+
+static unsigned int r16(const void __iomem *addr)
+{
+	return ioread16(addr);
+}
+
+static unsigned int r32(const void __iomem *addr)
+{
+	return ioread32(addr);
+}
+
 static int sh_clk_mstp_enable(struct clk *clk)
 {
 	sh_clk_write(sh_clk_read(clk) & ~(1 << clk->enable_bit), clk);
+	if (clk->status_reg) {
+		unsigned int (*read)(const void __iomem *addr);
+		int i;
+		void __iomem *mapped_status = (phys_addr_t)clk->status_reg -
+			(phys_addr_t)clk->enable_reg + clk->mapped_reg;
+
+		if (clk->flags & CLK_ENABLE_REG_8BIT)
+			read = r8;
+		else if (clk->flags & CLK_ENABLE_REG_16BIT)
+			read = r16;
+		else
+			read = r32;
+
+		for (i = 1000;
+		     (read(mapped_status) & (1 << clk->enable_bit)) && i;
+		     i--)
+			cpu_relax();
+		if (!i) {
+			pr_err("cpg: failed to enable %p[%d]\n",
+			       clk->enable_reg, clk->enable_bit);
+			return -ETIMEDOUT;
+		}
+	}
 	return 0;
 }
 
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index 60c7239..1f208b2 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -52,6 +52,7 @@ struct clk {
 	unsigned long		flags;
 
 	void __iomem		*enable_reg;
+	void __iomem		*status_reg;
 	unsigned int		enable_bit;
 	void __iomem		*mapped_reg;
 
@@ -116,22 +117,26 @@ long clk_round_parent(struct clk *clk, unsigned long target,
 		      unsigned long *best_freq, unsigned long *parent_freq,
 		      unsigned int div_min, unsigned int div_max);
 
-#define SH_CLK_MSTP(_parent, _enable_reg, _enable_bit, _flags)		\
+#define SH_CLK_MSTP(_parent, _enable_reg, _enable_bit, _status_reg, _flags) \
 {									\
 	.parent		= _parent,					\
 	.enable_reg	= (void __iomem *)_enable_reg,			\
 	.enable_bit	= _enable_bit,					\
+	.status_reg	= _status_reg,					\
 	.flags		= _flags,					\
 }
 
-#define SH_CLK_MSTP32(_p, _r, _b, _f)					\
-	SH_CLK_MSTP(_p, _r, _b, _f | CLK_ENABLE_REG_32BIT)
+#define SH_CLK_MSTP32(_p, _r, _b, _f)				\
+	SH_CLK_MSTP(_p, _r, _b, 0, _f | CLK_ENABLE_REG_32BIT)
 
-#define SH_CLK_MSTP16(_p, _r, _b, _f)					\
-	SH_CLK_MSTP(_p, _r, _b, _f | CLK_ENABLE_REG_16BIT)
+#define SH_CLK_MSTP32_STS(_p, _r, _b, _s, _f)			\
+	SH_CLK_MSTP(_p, _r, _b, _s, _f | CLK_ENABLE_REG_32BIT)
 
-#define SH_CLK_MSTP8(_p, _r, _b, _f)					\
-	SH_CLK_MSTP(_p, _r, _b, _f | CLK_ENABLE_REG_8BIT)
+#define SH_CLK_MSTP16(_p, _r, _b, _f)				\
+	SH_CLK_MSTP(_p, _r, _b, 0, _f | CLK_ENABLE_REG_16BIT)
+
+#define SH_CLK_MSTP8(_p, _r, _b, _f)				\
+	SH_CLK_MSTP(_p, _r, _b, 0, _f | CLK_ENABLE_REG_8BIT)
 
 int sh_clk_mstp_register(struct clk *clks, int nr);
 
-- 
1.8.5.2
