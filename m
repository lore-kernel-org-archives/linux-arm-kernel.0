From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 27 Oct 2016 02:31:28 +0900
Subject: [PATCH 2/2] clk: uniphier: add clock data for cpufreq
In-Reply-To: <1477503088-26508-1-git-send-email-yamada.masahiro@socionext.com>
References: <1477503088-26508-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1477503088-26508-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Data needed for CPU-gear change (cpufreq).

Note:
At this moment, some clock data for Pro5/Pxs2 (32bit SoCs) are
a bit faked because clock rates greater than LONG_MAX (~2.15 GHz)
must be avoided on 32 bit systems.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I raised a flag in the following post:
https://www.spinics.net/lists/kernel/msg2361374.html

I have not had any comments.
Anyway, I am moving forward.
I can fix the data arrays to reflect the real
clock topology.


 drivers/clk/uniphier/clk-uniphier-sys.c | 111 ++++++++++++++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier.h     |  35 +++++++++-
 2 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index 5d02999..74ab179 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -41,6 +41,19 @@
 #define UNIPHIER_PRO4_SYS_CLK_USB3(idx, ch)				\
 	UNIPHIER_CLK_GATE("usb3" #ch, (idx), NULL, 0x2104, 16 + (ch))
 
+#define UNIPHIER_PRO5_SYS_CPUGEARS					\
+	UNIPHIER_CLK_DIV8("cpll", 2, 3, 4, 6, 8, 12, 16, 24),		\
+	UNIPHIER_CLK_DIV8("spll", 2, 3, 4, 6, 8, 12, 16, 24),		\
+	UNIPHIER_CLK_DIV8("ippll", 2, 3, 4, 6, 8, 12, 16, 24),		\
+	UNIPHIER_CLK_CPUGEAR("cpu-ca9", 32, 0x8000, 0x1f, 16,		\
+			     "cpll/2", "spll/2", "cpll/3", "spll/3",	\
+			     "cpll/4", "spll/4", "cpll/6", "spll/6",	\
+			     "cpll/8", "spll/8", "cpll/12", "spll/12",	\
+			     "cpll/16", "spll/16", "cpll/24", "spll/24"),\
+	UNIPHIER_CLK_CPUGEAR("cpu-ipp", 34, 0x8100, 0xf, 8,		\
+			     "ippll/2", "spll/2", "ippll/3", "spll/3",	\
+			     "spll/4", "spll/8", "ippll/4", "ippll/8")
+
 const struct uniphier_clk_data uniphier_sld3_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 65, 1),		/* 1597.44 MHz */
 	UNIPHIER_CLK_FACTOR("upll", -1, "ref", 6000, 512),	/* 288 MHz */
@@ -96,6 +109,8 @@
 };
 
 const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
+	UNIPHIER_CLK_FACTOR("cpll", -1, "ref", 140, 1),		/* 2800 MHz */
+	UNIPHIER_CLK_FACTOR("ippll", -1, "ref", 130, 1),	/* 2600 MHz */
 	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 120, 1),		/* 2400 MHz */
 	UNIPHIER_CLK_FACTOR("dapll1", -1, "ref", 128, 1),	/* 2560 MHz */
 	UNIPHIER_CLK_FACTOR("dapll2", -1, "ref", 144, 125),	/* 2949.12 MHz */
@@ -106,10 +121,43 @@
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),				/* PCIe, USB3 */
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
+#if 1
+	/*
+	 * TODO:
+	 * The return type of .round_rate() is "long", which is 32 bit wide on
+	 * 32 bit systems.  Clock rate greater than LONG_MAX (~ 2.15 GHz) is
+	 * treated as an error.  Needs a workaround until the problem is fixed.
+	 */
+	UNIPHIER_CLK_FACTOR("cpll/2", -1, "ref", 70, 1),
+	UNIPHIER_CLK_FACTOR("cpll/3", -1, "ref", 140, 3),
+	UNIPHIER_CLK_FACTOR("cpll/4", -1, "ref", 35, 1),
+	UNIPHIER_CLK_FACTOR("cpll/6", -1, "ref", 70, 3),
+	UNIPHIER_CLK_FACTOR("cpll/8", -1, "ref", 35, 2),
+	UNIPHIER_CLK_FACTOR("cpll/12", -1, "ref", 35, 3),
+	UNIPHIER_CLK_FACTOR("cpll/16", -1, "ref", 35, 4),
+	UNIPHIER_CLK_FACTOR("cpll/24", -1, "ref", 35, 6),
+	UNIPHIER_CLK_FACTOR("spll/2", -1, "ref", 60, 1),
+	UNIPHIER_CLK_FACTOR("spll/3", -1, "ref", 40, 1),
+	UNIPHIER_CLK_FACTOR("spll/4", -1, "ref", 30, 1),
+	UNIPHIER_CLK_FACTOR("spll/6", -1, "ref", 20, 1),
+	UNIPHIER_CLK_FACTOR("spll/8", -1, "ref", 15, 1),
+	UNIPHIER_CLK_FACTOR("spll/12", -1, "ref", 10, 1),
+	UNIPHIER_CLK_FACTOR("spll/16", -1, "ref", 15, 2),
+	UNIPHIER_CLK_FACTOR("spll/24", -1, "ref", 5, 1),
+	UNIPHIER_CLK_CPUGEAR("cpu-ca9", 32, 0x8000, 0x1f, 16,
+			     "cpll/2", "spll/2", "cpll/3", "spll/3",
+			     "cpll/4", "spll/4", "cpll/6", "spll/6",
+			     "cpll/8", "spll/8", "cpll/12", "spll/12",
+			     "cpll/16", "spll/16", "cpll/24", "spll/24"),
+#else
+	UNIPHIER_PRO5_SYS_CPUGEARS,
+#endif
 	{ /* sentinel */ }
 };
 
 const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
+	UNIPHIER_CLK_FACTOR("cpll", -1, "ref", 96, 1),		/* 2400 MHz */
+	UNIPHIER_CLK_FACTOR("ippll", -1, "ref", 96, 1),		/* 2400 MHz */
 	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 96, 1),		/* 2400 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 27),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
@@ -121,20 +169,70 @@
 	/* The document mentions 0x2104 bit 18, but not functional */
 	UNIPHIER_CLK_GATE("usb30-phy", 16, NULL, 0x2104, 19),
 	UNIPHIER_CLK_GATE("usb31-phy", 20, NULL, 0x2104, 20),
+#if 1
+	/*
+	 * TODO:
+	 * The return type of .round_rate() is "long", which is 32 bit wide on
+	 * 32 bit systems.  Clock rate greater than LONG_MAX (~ 2.15 GHz) is
+	 * treated as an error.  Needs a workaround until the problem is fixed.
+	 */
+	UNIPHIER_CLK_FACTOR("cpll/2", -1, "ref", 48, 1),
+	UNIPHIER_CLK_FACTOR("cpll/3", -1, "ref", 32, 1),
+	UNIPHIER_CLK_FACTOR("cpll/4", -1, "ref", 24, 1),
+	UNIPHIER_CLK_FACTOR("cpll/6", -1, "ref", 16, 1),
+	UNIPHIER_CLK_FACTOR("cpll/8", -1, "ref", 12, 1),
+	UNIPHIER_CLK_FACTOR("cpll/12", -1, "ref", 8, 1),
+	UNIPHIER_CLK_FACTOR("cpll/16", -1, "ref", 6, 1),
+	UNIPHIER_CLK_FACTOR("cpll/24", -1, "ref", 4, 1),
+	UNIPHIER_CLK_FACTOR("spll/2", -1, "ref", 48, 1),
+	UNIPHIER_CLK_FACTOR("spll/3", -1, "ref", 32, 1),
+	UNIPHIER_CLK_FACTOR("spll/4", -1, "ref", 24, 1),
+	UNIPHIER_CLK_FACTOR("spll/6", -1, "ref", 16, 1),
+	UNIPHIER_CLK_FACTOR("spll/8", -1, "ref", 12, 1),
+	UNIPHIER_CLK_FACTOR("spll/12", -1, "ref", 8, 1),
+	UNIPHIER_CLK_FACTOR("spll/16", -1, "ref", 6, 1),
+	UNIPHIER_CLK_FACTOR("spll/24", -1, "ref", 4, 1),
+	UNIPHIER_CLK_CPUGEAR("cpu-ca9", 32, 0x8000, 0x1f, 16,
+			     "cpll/2", "spll/2", "cpll/3", "spll/3",
+			     "cpll/4", "spll/4", "cpll/6", "spll/6",
+			     "cpll/8", "spll/8", "cpll/12", "spll/12",
+			     "cpll/16", "spll/16", "cpll/24", "spll/24"),
+#else
+	UNIPHIER_PRO5_SYS_CPUGEARS,
+#endif
 	{ /* sentinel */ }
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
@@ -147,5 +245,18 @@
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
index 9707b0f..849824a 100644
--- a/drivers/clk/uniphier/clk-uniphier.h
+++ b/drivers/clk/uniphier/clk-uniphier.h
@@ -75,6 +75,20 @@ struct uniphier_clk_data {
 	} data;
 };
 
+#define UNIPHIER_CLK_CPUGEAR(_name, _idx, _regbase, _mask,	\
+			     _num_parents, ...)			\
+	{							\
+		.name = (_name),				\
+		.type = UNIPHIER_CLK_TYPE_CPUGEAR,		\
+		.idx = (_idx),					\
+		.data.cpugear = {				\
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
@@ -100,6 +113,26 @@ struct uniphier_clk_data {
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
+#define UNIPHIER_CLK_DIV8(parent, div0, div1, div2, div3,	\
+			  div4, div5, div6, div7)		\
+	UNIPHIER_CLK_DIV4(parent, div0, div1, div2, div3),	\
+	UNIPHIER_CLK_DIV4(parent, div4, div5, div6, div7)
+
 struct clk_hw *uniphier_clk_register_cpugear(struct device *dev,
 					     struct regmap *regmap,
 					     const char *name,
-- 
1.9.1
