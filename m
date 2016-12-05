From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 5 Dec 2016 05:23:56 +0000
Subject: [PATCH 3/3] ASoC: simple-card-utils: enable
 clocks/clock-names/clock-ranges
In-Reply-To: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
References: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87zikbuezr.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current simple-card is supporting this style for clocks

	sound {
		...
		simple-audio-card,cpu {
			sound-dai = <&xxx>;
			clocks = <&cpu_clock>;
		};
		simple-audio-card,codec {
			sound-dai = <&xxx>;
			clocks = <&codec_clock>;
		};
	};

Now, it can support this style too, because we can use
devm_get_clk_from_child() now.

	sound {
		...
		clocks = <&cpu_clock>, <&codec_clock>;
		clock-names = "cpu", "codec";
		clock-ranges;
		...
		simple-audio-card,cpu {
			sound-dai = <&xxx>;
		};
		simple-audio-card,codec {
			sound-dai = <&xxx>;
		};
	};

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../devicetree/bindings/sound/simple-card.txt      | 32 ++++++++++++++++++
 sound/soc/generic/simple-card-utils.c              | 39 +++++++++++++++++++++-
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index c7a9393..43a710b 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -86,6 +86,7 @@ Optional CPU/CODEC subnodes properties:
 					  in dai startup() and disabled with
 					  clk_disable_unprepare() in dai
 					  shutdown().
+					  see Clock Example.
 
 Example 1 - single DAI link:
 
@@ -199,3 +200,34 @@ sound {
 		clocks = ...
 	};
 };
+
+
+Clock Example 1 - clock settings on each subnode
+
+sound {
+	...
+	simple-audio-card,cpu {
+		sound-dai = <&xxx>;
+		clocks = <&cpu_clock>;
+	};
+	simple-audio-card,codec {
+		sound-dai = <&xxx>;
+		clocks = <&codec_clock>;
+	};
+};
+
+Clock Example 2 - clock settings by clocks
+
+sound {
+	...
+	clocks = <&cpu_clock>, <&codec_clock>;
+	clock-names = "cpu", "codec";
+	clock-ranges;
+	...
+	simple-audio-card,cpu {
+		sound-dai = <&xxx>;
+	};
+	simple-audio-card,codec {
+		sound-dai = <&xxx>;
+	};
+};
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 4924575..c3031a5 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -104,15 +104,52 @@ int asoc_simple_card_parse_clk(struct device *dev,
 			       struct asoc_simple_dai *simple_dai)
 {
 	struct clk *clk;
+	const char *con_id = NULL;
+	const char *port_name[] = {
+		"cpu", "codec"
+	};
 	u32 val;
 
 	/*
+	 * We can use this style if "con_id" is not NULL
+	 *
+	 * sound {
+	 *	...
+	 *	clocks = <&xxx>, <&xxx>;
+	 *	clock-names = "cpu", "codec";
+	 *	clock-ranges;
+	 *
+	 *	simple-audio-card,cpu {
+	 *		sound-dai = <&xxx>;
+	 *	};
+	 *	simple-audio-card,codec {
+	 *		sound-dai = <&xxx>;
+	 *	};
+	 * };
+	 */
+	if (of_find_property(dev->of_node, "clock-names", NULL)) {
+		int i;
+		int port_len, node_len;
+
+		for (i = 0; i < ARRAY_SIZE(port_name); i++) {
+			node_len = strlen(node->name);
+			port_len = strlen(port_name[i]);
+
+			if (0 == strncmp(node->name + node_len - port_len,
+					 port_name[i], port_len)) {
+				con_id = port_name[i];
+				break;
+			}
+		}
+	}
+
+	/*
 	 * Parse dai->sysclk come from "clocks = <&xxx>"
 	 * (if system has common clock)
 	 *  or "system-clock-frequency = <xxx>"
 	 *  or device's module clock.
 	 */
-	clk = devm_get_clk_from_child(dev, node, NULL);
+	clk = devm_get_clk_from_child(dev, node, con_id);
 	if (!IS_ERR(clk)) {
 		simple_dai->sysclk = clk_get_rate(clk);
 	} else if (!of_property_read_u32(node, "system-clock-frequency", &val)) {
-- 
1.9.1
