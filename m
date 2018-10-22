From: olivier.moysan@st.com (Olivier Moysan)
Date: Mon, 22 Oct 2018 17:10:46 +0200
Subject: [PATCH 2/2] ASoC: stm32: sai: fix master clock naming
In-Reply-To: <1540221046-11812-1-git-send-email-olivier.moysan@st.com>
References: <1540221046-11812-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1540221046-11812-3-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes: 8307b2afd386 ("ASoC: stm32: sai: set sai as mclk clock provider")

Fix warning issued by strncat when bound equals to source length.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 31d22abd3204..ea05cc91aa05 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -404,12 +404,11 @@ static int stm32_sai_add_mclk_provider(struct stm32_sai_sub_data *sai)
 	 * String after "_" char is stripped in parent name.
 	 */
 	p = mclk_name;
-	while (*s && *s != '_' && (i < (SAI_MCLK_NAME_LEN - 6))) {
+	while (*s && *s != '_' && (i < (SAI_MCLK_NAME_LEN - 7))) {
 		*p++ = *s++;
 		i++;
 	}
-	STM_SAI_IS_SUB_A(sai) ?
-		strncat(p, "a_mclk", 6) : strncat(p, "b_mclk", 6);
+	STM_SAI_IS_SUB_A(sai) ? strcat(p, "a_mclk") : strcat(p, "b_mclk");
 
 	mclk->hw.init = CLK_HW_INIT(mclk_name, pname, &mclk_ops, 0);
 	mclk->sai_data = sai;
-- 
2.7.4
