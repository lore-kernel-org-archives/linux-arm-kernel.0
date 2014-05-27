From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 27 May 2014 10:24:22 +0200
Subject: [PATCH v5 5/8] ASoC: fsl-ssi: Set framerate divider correctly for i2s
 master mode
In-Reply-To: <1401179065-31195-1-git-send-email-mpa@pengutronix.de>
References: <1401179065-31195-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1401179065-31195-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

In i2s master mode the fsl_ssi driver depends on someone calling
.set_tdm_slot correctly. In this mode though only a DC value of
2 is allowed, so set it in this case and no longer depend on
.set_tdm_slot.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Tested-By: Michael Grzeschik <mgr@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index b3033d9..dbcde10 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -709,6 +709,10 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
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
2.0.0.rc2
