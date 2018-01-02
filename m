From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 2 Jan 2018 19:47:52 +0800
Subject: [PATCH 10/12] clk: mediatek: switch to use dev_get_regmap() for
 MT7622 audsys
In-Reply-To: <cover.1514881870.git.ryder.lee@mediatek.com>
References: <cover.1514881870.git.ryder.lee@mediatek.com>
Message-ID: <cbdada9cdbafda2452fe171a81588ce5b0d4f688.1514881870.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the new audsys wrapper driver is in place, switch to use dev_get_regmap()
to obtain the regmap from its parent.

This patch also add missing clock data 'CLK_AUDIO_AFE_CONN'.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/clk/mediatek/clk-mt7622-aud.c  | 11 +++++++++--
 include/dt-bindings/clock/mt7622-clk.h |  3 ++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index fad7d9f..261e8d7 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -106,6 +106,7 @@
 	GATE_AUDIO1(CLK_AUDIO_INTDIR, "audio_intdir", "intdir_sel", 20),
 	GATE_AUDIO1(CLK_AUDIO_A1SYS, "audio_a1sys", "a1sys_hp_sel", 21),
 	GATE_AUDIO1(CLK_AUDIO_A2SYS, "audio_a2sys", "a2sys_hp_sel", 22),
+	GATE_AUDIO1(CLK_AUDIO_AFE_CONN, "audio_afe_conn", "a1sys_hp_sel", 23),
 	/* AUDIO2 */
 	GATE_AUDIO2(CLK_AUDIO_UL1, "audio_ul1", "a1sys_hp_sel", 0),
 	GATE_AUDIO2(CLK_AUDIO_UL2, "audio_ul2", "a1sys_hp_sel", 1),
@@ -141,12 +142,18 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 {
 	struct clk_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
+	struct regmap *regmap;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
 
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			       clk_data);
+	/* Obtain the regmap from parent - audsys wrapper */
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	mtk_clk_register_num_gates(regmap, audio_clks, ARRAY_SIZE(audio_clks),
+				   clk_data);
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 	if (r)
diff --git a/include/dt-bindings/clock/mt7622-clk.h b/include/dt-bindings/clock/mt7622-clk.h
index 3e514ed..e9d77f0 100644
--- a/include/dt-bindings/clock/mt7622-clk.h
+++ b/include/dt-bindings/clock/mt7622-clk.h
@@ -235,7 +235,8 @@
 #define CLK_AUDIO_MEM_ASRC3		43
 #define CLK_AUDIO_MEM_ASRC4		44
 #define CLK_AUDIO_MEM_ASRC5		45
-#define CLK_AUDIO_NR_CLK		46
+#define CLK_AUDIO_AFE_CONN		46
+#define CLK_AUDIO_NR_CLK		47
 
 /* SSUSBSYS */
 
-- 
1.9.1
