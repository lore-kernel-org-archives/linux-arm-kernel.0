From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 28 Apr 2014 12:54:55 +0200
Subject: [PATCH v4 14/17] ASoC: fsl-ssi: Set framerate divider correctly for
 i2s master mode
In-Reply-To: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1398682498-24357-15-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

In i2s master mode the fsl_ssi driver depends on someone calling
.set_tdm_slot correctly. In this mode though only a DC value of
2 is allowed, so set it in this case and no longer depend on
.set_tdm_slot.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 5c6dc0a..01d97e2 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -686,6 +686,10 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 		case SND_SOC_DAIFMT_CBS_CFS:
 			ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_MASTER;
+			write_ssi_mask(&ssi->stccr, CCSR_SSI_SxCCR_DC_MASK,
+				CCSR_SSI_SxCCR_DC(2));
+			write_ssi_mask(&ssi->srccr, CCSR_SSI_SxCCR_DC_MASK,
+				CCSR_SSI_SxCCR_DC(2));
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
 			ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_SLAVE;
-- 
1.9.1
