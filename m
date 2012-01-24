From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 24 Jan 2012 19:57:27 +0100
Subject: [PATCH] ARM: mxs: read correct values when setting up MAC
Message-ID: <1327431447-5031-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the MAC address from the second ethernet is generated from the
crypto-key (and not a customer reg) because of a wrong index to the ocotp
array.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
---

This looks clearly wrong to me; probably ocotp was a u8 somewhen in the
process? I wonder how it works for these boards. Am I missing something?

 arch/arm/mach-mxs/mach-m28evk.c  |    2 +-
 arch/arm/mach-mxs/mach-mx28evk.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-m28evk.c b/arch/arm/mach-mxs/mach-m28evk.c
index 2f27582..8d1459d 100644
--- a/arch/arm/mach-mxs/mach-m28evk.c
+++ b/arch/arm/mach-mxs/mach-m28evk.c
@@ -258,7 +258,7 @@ static int __init m28evk_fec_get_mac(void)
 	 * so hard-code DENX OUI (C0:E5:4E) here.
 	 */
 	for (i = 0; i < 2; i++) {
-		val = ocotp[i * 4];
+		val = ocotp[i];
 		mx28_fec_pdata[i].mac[0] = 0xC0;
 		mx28_fec_pdata[i].mac[1] = 0xE5;
 		mx28_fec_pdata[i].mac[2] = 0x4E;
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index fdb0a56..df318ef 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -285,7 +285,7 @@ static int __init mx28evk_fec_get_mac(void)
 	 * so hard-code Freescale OUI (00:04:9f) here.
 	 */
 	for (i = 0; i < 2; i++) {
-		val = ocotp[i * 4];
+		val = ocotp[i];
 		mx28_fec_pdata[i].mac[0] = 0x00;
 		mx28_fec_pdata[i].mac[1] = 0x04;
 		mx28_fec_pdata[i].mac[2] = 0x9f;
-- 
1.7.2.5
