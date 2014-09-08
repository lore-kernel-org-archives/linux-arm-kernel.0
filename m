From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 13:14:05 +0200
Subject: [PATCH] ASoC: simple-card: fix regression in clock rate lookup
Message-ID: <42811667.3TM1iBfezH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7c7b9cf53d284f ("ASoC: simple-card: fixup cpu_dai_name
clear case") changed the way that "sound-dai" properties are handled,
which leads to the clock frequency not being picked up from the
node that the phandle points to, as correctly identified by gcc
with this warning:

sound/soc/generic/simple-card.c: In function 'asoc_simple_card_sub_parse_of':
sound/soc/generic/simple-card.c:165:7: warning: 'node' may be used uninitialized in this function [-Wmaybe-uninitialized]

This restores the previous behavior by using the node from
of_parse_phandle_with_args() that was previously being
returned from of_parse_phandle().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index b563850c43f4..a0440bd533d5 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -116,7 +116,6 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 			      int *args_count)
 {
 	struct of_phandle_args args;
-	struct device_node *node;
 	struct clk *clk;
 	u32 val;
 	int ret;
@@ -162,7 +161,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 	} else if (!of_property_read_u32(np, "system-clock-frequency", &val)) {
 		dai->sysclk = val;
 	} else {
-		clk = of_clk_get(node, 0);
+		clk = of_clk_get(args.np, 0);
 		if (!IS_ERR(clk))
 			dai->sysclk = clk_get_rate(clk);
 	}
