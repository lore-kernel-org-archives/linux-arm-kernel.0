From: clabbe@baylibre.com (Corentin Labbe)
Date: Fri,  7 Sep 2018 19:41:45 +0000
Subject: [PATCH RFC 3/5] coccinelle: add xxxsetbitsXX converting spatch
In-Reply-To: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
Message-ID: <1536349307-20714-4-git-send-email-clabbe@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add a spatch which convert all open coded of setbits32/clrbits32/clrsetbits32
and their 64 bits counterparts.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 scripts/coccinelle/misc/setbits.cocci | 423 ++++++++++++++++++++++++++++++++++
 1 file changed, 423 insertions(+)
 create mode 100644 scripts/coccinelle/misc/setbits.cocci

diff --git a/scripts/coccinelle/misc/setbits.cocci b/scripts/coccinelle/misc/setbits.cocci
new file mode 100644
index 000000000000..c01ab6d75eb4
--- /dev/null
+++ b/scripts/coccinelle/misc/setbits.cocci
@@ -0,0 +1,423 @@
+virtual context
+
+ at pclrsetbits32a@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- rr &= ~clear;
+- rr |= set;
+- writel(rr, reg);
++ clrsetbits32(reg, clear, set);
+
+ at pclrsetbits32b@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- rr |= set;
+- rr &= ~clear;
+- writel(rr, reg);
++ clrsetbits32(reg, clear, set);
+
+ at pclrbits32@
+identifier rr;
+expression reg;
+expression clear;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- rr &= ~clear;
+- writel(rr, reg);
++ clrbits32(reg, clear);
+
+ at psetbits32@
+identifier rr;
+expression reg;
+expression set;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- rr |= set;
+- writel(rr, reg);
++ setbits32(reg, set);
+
+ at psetbits32b@
+identifier rr;
+expression reg;
+expression set1;
+expression set2;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- rr |= set1;
+- rr |= set2;
+- writel(rr, reg);
++ setbits32(reg, set1 | set2);
+
+ at pclrsetbits64a@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+- rr &= ~clear;
+- rr |= set;
+- writeq(rr, reg);
++ clrsetbits64(reg, clear, set);
+
+ at pclrsetbits64b@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+- rr |= set;
+- rr &= ~clear;
+- writeq(rr, reg);
++ clrsetbits64(reg, clear, set);
+
+ at pclrbits64@
+identifier rr;
+expression reg;
+expression clear;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+- rr &= ~clear;
+- writeq(rr, reg);
++ clrbits64(reg, clear);
+
+ at psetbits64@
+identifier rr;
+expression reg;
+expression set;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+- rr |= set;
+- writeq(rr, reg);
++ setbits64(reg, set);
+
+@@
+expression dwmac;
+expression reg;
+expression mask;
+expression value;
+@@
+
+- meson8b_dwmac_mask_bits(dwmac, reg, mask, value);
++ clrsetbits32(dwmac->regs + reg, mask, value);
+
+ at ppclrsetbits32a@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+- u32 rr = readl(reg);
+- rr &= ~clear;
+- rr |= set;
+- writel(rr, reg);
++ clrsetbits32(reg, clear, set);
+
+ at ppclrsetbits32b@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+- u32 rr = readl(reg);
+- rr |= set;
+- rr &= ~clear;
+- writel(rr, reg);
++ clrsetbits32(reg, clear, set);
+
+ at ppclrbits32@
+identifier rr;
+expression reg;
+expression clear;
+@@
+
+- u32 rr = readl(reg);
+- rr &= ~clear;
+- writel(rr, reg);
++ clrbits32(reg, clear);
+
+ at ppsetbits32@
+identifier rr;
+expression reg;
+expression set;
+@@
+
+- u32 rr = readl(reg);
+- rr |= set;
+- writel(rr, reg);
++ setbits32(reg, set);
+
+ at ppclrsetbits64a@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+- u64 rr = readq(reg);
+- rr &= ~clear;
+- rr |= set;
+- writeq(rr, reg);
++ clrsetbits64(reg, clear, set);
+
+ at ppclrsetbits64b@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+- u64 rr = readq(reg);
+- rr |= set;
+- rr &= ~clear;
+- writeq(rr, reg);
++ clrsetbits64(reg, clear, set);
+
+ at ppclrbits64@
+identifier rr;
+expression reg;
+expression clear;
+@@
+
+- u64 rr = readq(reg);
+- rr &= ~clear;
+- writeq(rr, reg);
++ clrbits64(reg, clear);
+
+ at ppsetbits64@
+identifier rr;
+expression reg;
+expression set;
+@@
+
+- u64 rr = readq(reg);
+- rr |= set;
+- writeq(rr, reg);
++ setbits64(reg, set);
+
+ at pif_set_clr@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+  if (...)
+- rr |= set;
++ setbits32(reg, set);
+  else
+- rr &= ~clear;
++ clrbits32(reg, clear);
+- writel(rr, reg);
+
+ at pifclrset@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+  if (...)
+- rr &= ~clear;
++ clrbits32(reg, clear);
+  else
+- rr |= set;
++ setbits32(reg, set);
+- writel(rr, reg);
+
+ at pif_set_clr64@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+  if (...)
+- rr |= set;
++ setbits64(reg, set);
+  else
+- rr &= ~clear;
++ clrbits64(reg, clear);
+- writeq(rr, reg);
+
+ at pif_clr_set64@
+identifier rr;
+expression reg;
+expression set;
+expression clear;
+@@
+
+  u64 rr;
+  ...
+- rr = readq(reg);
+  if (...)
+- rr &= ~clear;
++ clrbits64(reg, clear);
+  else
+- rr |= set;
++ setbits32(reg, set);
+- writeq(rr, reg);
+
+
+ at p_setbits32_m2@
+identifier rr;
+expression reg;
+expression set;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- writel(rr | set, reg);
++ setbits32(reg, set);
+
+ at p_clrbits32_m2@
+identifier rr;
+expression reg;
+expression mask;
+@@
+
+  u32 rr;
+  ...
+- rr = readl(reg);
+- writel(rr & ~mask, reg);
++ clrbits32(reg, mask);
+
+
+ at p_setbits_oneliner@
+expression addr;
+expression set;
+@@
+- writel(readl(addr) | set, addr);
++ setbits32(addr, set);
+
+ at p_clrbits_oneliner@
+expression addr;
+expression mask;
+@@
+- writel(readl(addr) & ~mask, addr);
++ clrbits32(addr, mask);
+
+ at p_clrsetbits_oneliner_a@
+expression addr;
+expression set;
+expression mask;
+@@
+- writel(readl(addr) | set & ~mask, addr);
++ clrsetbits32(addr, mask, set);
+
+ at p_clrsetbits_oneliner_b@
+expression addr;
+expression set;
+expression mask;
+@@
+- writel(readl(addr) & ~mask | set, addr);
++ clrsetbits32(addr, mask, set);
+
+ at p_clrsetbits_oneliner_a2@
+expression addr;
+expression set;
+expression mask;
+@@
+- writel((readl(addr) | set) & ~mask, addr);
++ clrsetbits32(addr, mask, set);
+
+ at p_clrsetbits_oneliner_b2@
+expression addr;
+expression set;
+expression mask;
+@@
+- writel((readl(addr) & ~mask) | set, addr);
++ clrsetbits32(addr, mask, set);
+
+
+
+
+
+
+
+
+
+
+
+// sub optimal way to add header
+ at header1 depends on psetbits32 || pclrbits32 || pclrsetbits32a || pclrsetbits32b || psetbits64 || pclrbits64 || pclrsetbits64a || pclrsetbits64b || ppsetbits32 || ppclrbits32 || ppclrsetbits32a || ppclrsetbits32b || ppsetbits64 || ppclrbits64 || ppclrsetbits64a || ppclrsetbits64b@
+@@
+  #include <linux/io.h>
++ #include <linux/setbits.h>
+
+ at header2 depends on (psetbits32 || pclrbits32 || pclrsetbits32a || pclrsetbits32b || psetbits64 || pclrbits64 || pclrsetbits64a || pclrsetbits64b || ppsetbits32 || ppclrbits32 || ppclrsetbits32a || ppclrsetbits32b || ppsetbits64 || ppclrbits64 || ppclrsetbits64a || ppclrsetbits64b) && !header1@
+@@
+  #include <linux/interrupt.h>
++ #include <linux/setbits.h>
+
+ at header3 depends on (psetbits32 || pclrbits32 || pclrsetbits32a || pclrsetbits32b || psetbits64 || pclrbits64 || pclrsetbits64a || pclrsetbits64b || ppsetbits32 || ppclrbits32 || ppclrsetbits32a || ppclrsetbits32b || ppsetbits64 || ppclrbits64 || ppclrsetbits64a || ppclrsetbits64b) && !header2@
+@@
+  #include <linux/of.h>
++ #include <linux/setbits.h>
+
+@@
+expression base;
+expression offset;
+expression value;
+@@
+
+- mtu3_setbits(base, offset, value);
++ setbits32(base + offset, value);
+
+@@
+expression base;
+expression offset;
+expression mask;
+@@
+
+- mtu3_clrbits(base, offset, mask);
++ clrbits32(base + offset, mask);
+
-- 
2.16.4
