From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 24 Nov 2016 14:57:41 +0900
Subject: [PATCH v2 3/3] clk: uniphier: add cpufreq data for LD11, LD20 SoCs
In-Reply-To: <1479967061-25975-1-git-send-email-yamada.masahiro@socionext.com>
References: <1479967061-25975-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1479967061-25975-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add more data to 64bit SoCs for the cpufreq support.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Drop clock data of 32 bit SoCs. Add 64 bit SoC data for now.

 drivers/clk/uniphier/clk-uniphier-sys.c | 32 ++++++++++++++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier.h     | 30 +++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index 5d02999..d049316 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -125,16 +125,35 @@ const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
 };
 
 const struct uniphier_clk_data uniphier_ld11_sys_clk_data[] = {
+	UNIPHIER_CLK_FACTOR("cpll", -1, "ref", 392, 5),		/* 1960 MHz */
+	UNIPHIER_CLK_FACTOR("mpll", -1, "ref", 64, 1),		/* 1600 MHz */
 	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 80, 1),		/* 2000 MHz */
+	UNIPHIER_CLK_FACTOR("vspll", -1, "ref", 80, 1),		/* 2000 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
 	UNIPHIER_LD11_SYS_CLK_STDMAC(8),			/* HSC, MIO */
 	UNIPHIER_CLK_FACTOR("usb2", -1, "ref", 24, 25),
+	/* CPU gears */
+	UNIPHIER_CLK_DIV4("cpll", 2, 3, 4, 8),
+	UNIPHIER_CLK_DIV4("mpll", 2, 3, 4, 8),
+	UNIPHIER_CLK_DIV3("spll", 3, 4, 8),
+	/* Note: both gear1 and gear4 are spll/4.  This is not a bug. */
+	UNIPHIER_CLK_CPUGEAR("cpu-ca53", 33, 0x8080, 0xf, 8,
+			     "cpll/2", "spll/4", "cpll/3", "spll/3",
+			     "spll/4", "spll/8", "cpll/4", "cpll/8"),
+	UNIPHIER_CLK_CPUGEAR("cpu-ipp", 34, 0x8100, 0xf, 8,
+			     "mpll/2", "spll/4", "mpll/3", "spll/3",
+			     "spll/4", "spll/8", "mpll/4", "mpll/8"),
 	{ /* sentinel */ }
 };
 
 const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
+	UNIPHIER_CLK_FACTOR("cpll", -1, "ref", 88, 1),		/* ARM: 2200 MHz */
+	UNIPHIER_CLK_FACTOR("gppll", -1, "ref", 52, 1),		/* Mali: 1300 MHz */
+	UNIPHIER_CLK_FACTOR("mpll", -1, "ref", 64, 1),		/* Codec: 1600 MHz */
 	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 80, 1),		/* 2000 MHz */
+	UNIPHIER_CLK_FACTOR("s2pll", -1, "ref", 88, 1),		/* IPP: 2200 MHz */
+	UNIPHIER_CLK_FACTOR("vppll", -1, "ref", 504, 5),	/* 2520 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
 	UNIPHIER_LD20_SYS_CLK_SD,
@@ -147,5 +166,18 @@ const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
 	UNIPHIER_CLK_GATE("usb30", 14, NULL, 0x210c, 14),
 	UNIPHIER_CLK_GATE("usb30-phy0", 16, NULL, 0x210c, 12),
 	UNIPHIER_CLK_GATE("usb30-phy1", 17, NULL, 0x210c, 13),
+	/* CPU gears */
+	UNIPHIER_CLK_DIV4("cpll", 2, 3, 4, 8),
+	UNIPHIER_CLK_DIV4("spll", 2, 3, 4, 8),
+	UNIPHIER_CLK_DIV4("s2pll", 2, 3, 4, 8),
+	UNIPHIER_CLK_CPUGEAR("cpu-ca72", 32, 0x8000, 0xf, 8,
+			     "cpll/2", "spll/2", "cpll/3", "spll/3",
+			     "spll/4", "spll/8", "cpll/4", "cpll/8"),
+	UNIPHIER_CLK_CPUGEAR("cpu-ca53", 33, 0x8080, 0xf, 8,
+			     "cpll/2", "spll/2", "cpll/3", "spll/3",
+			     "spll/4", "spll/8", "cpll/4", "cpll/8"),
+	UNIPHIER_CLK_CPUGEAR("cpu-ipp", 34, 0x8100, 0xf, 8,
+			     "s2pll/2", "spll/2", "s2pll/3", "spll/3",
+			     "spll/4", "spll/8", "s2pll/4", "s2pll/8"),
 	{ /* sentinel */ }
 };
diff --git a/drivers/clk/uniphier/clk-uniphier.h b/drivers/clk/uniphier/clk-uniphier.h
index 62816f8..81d7e5c 100644
--- a/drivers/clk/uniphier/clk-uniphier.h
+++ b/drivers/clk/uniphier/clk-uniphier.h
@@ -75,6 +75,20 @@ struct uniphier_clk_data {
 	};
 };
 
+#define UNIPHIER_CLK_CPUGEAR(_name, _idx, _regbase, _mask,	\
+			     _num_parents, ...)			\
+	{							\
+		.name = (_name),				\
+		.type = UNIPHIER_CLK_TYPE_CPUGEAR,		\
+		.idx = (_idx),					\
+		.cpugear = {					\
+			.parent_names = { __VA_ARGS__ },	\
+			.num_parents = (_num_parents),		\
+			.regbase = (_regbase),			\
+			.mask = (_mask)				\
+		 },						\
+	}
+
 #define UNIPHIER_CLK_FACTOR(_name, _idx, _parent, _mult, _div)	\
 	{							\
 		.name = (_name),				\
@@ -87,7 +101,6 @@ struct uniphier_clk_data {
 		},						\
 	}
 
-
 #define UNIPHIER_CLK_GATE(_name, _idx, _parent, _reg, _bit)	\
 	{							\
 		.name = (_name),				\
@@ -100,6 +113,21 @@ struct uniphier_clk_data {
 		},						\
 	}
 
+#define UNIPHIER_CLK_DIV(parent, div)				\
+	UNIPHIER_CLK_FACTOR(parent "/" #div, -1, parent, 1, div)
+
+#define UNIPHIER_CLK_DIV2(parent, div0, div1)			\
+	UNIPHIER_CLK_DIV(parent, div0),				\
+	UNIPHIER_CLK_DIV(parent, div1)
+
+#define UNIPHIER_CLK_DIV3(parent, div0, div1, div2)		\
+	UNIPHIER_CLK_DIV2(parent, div0, div1),			\
+	UNIPHIER_CLK_DIV(parent, div2)
+
+#define UNIPHIER_CLK_DIV4(parent, div0, div1, div2, div3)	\
+	UNIPHIER_CLK_DIV2(parent, div0, div1),			\
+	UNIPHIER_CLK_DIV2(parent, div2, div3)
+
 struct clk_hw *uniphier_clk_register_cpugear(struct device *dev,
 					     struct regmap *regmap,
 					     const char *name,
-- 
2.7.4
