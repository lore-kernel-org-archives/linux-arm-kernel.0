From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 19 Aug 2013 17:05:59 +0200
Subject: [PATCH v11 6/8] ASoC: fsl-ssi: add SSIEN errata work around
In-Reply-To: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1376924761-4054-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

The chip errata for the i.MX35, Rev.2 has the following errata:

ENGcm06222: SSI:Transmission does not take place in bit length early frame sync
	    configuration

The workaround states, that TX_EN and SSI_EN bits should be set in the same
register write. As the next errata in the document (ENGcm06532) says to always
write RX_EN and TX_EN in the same register write in network mode.

Therefore include the whole write to
	CCSR_SSI_SCR_TE and CCSR_SSI_SCR_RE
into the write to
	CCSR_SSI_SCR_SSIEN

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 827af75..3af15e9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -424,15 +424,12 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 		write_ssi(0x300, &ssi->saccen);
 
 		/*
-		 * Enable SSI
+		 * Enable SSI, Transmit and Receive
 		 */
-		write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_SSIEN);
-		write_ssi(CCSR_SSI_SOR_WAIT(3), &ssi->sor);
+		write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_SSIEN |
+				CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
 
-		/*
-		 * Enable Transmit and Receive
-		 */
-		write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
+		write_ssi(CCSR_SSI_SOR_WAIT(3), &ssi->sor);
 	}
 
 	return 0;
-- 
1.8.4.rc3
