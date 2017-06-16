From: olivier.moysan@st.com (olivier moysan)
Date: Fri, 16 Jun 2017 14:15:33 +0200
Subject: [PATCH 6/7] ASoC: stm32: sai: fix clock management
In-Reply-To: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
References: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1497615334-7156-7-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow peripheral clock enable/disable on regmap accesses.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 97b69a3..2466af0 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -766,8 +766,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 		return PTR_ERR(base);
 
 	sai->phys_addr = res->start;
-	sai->regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					    &stm32_sai_sub_regmap_config);
+	sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "sai_ck", base,
+						&stm32_sai_sub_regmap_config);
 
 	/* Get direction property */
 	if (of_property_match_string(np, "dma-names", "tx") >= 0) {
-- 
1.9.1
