From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 14 Jun 2013 11:41:10 +0400
Subject: =?UTF-8?B?W1JGQ10gU3RhZ2luZzogaW14LWRybTogRG8gbm90IHVzZSBmcmFjdGlvbmFs?=
 =?UTF-8?B?IHBhcnQgb2YgZGl2aWRlcg==?=
Message-ID: <1371195670.904413971@f400.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Analysis of driver imx-drm led me to believe that the use fractional part of the divider is not always a good idea.
For example, for a parallel display bus connected to LVDS converter chip (DS90C363), in this case the use of
fractional part, clock will unstable and the on-chip PLL is not working properly, or rather, does not work at all.

Let me give a specific example.
ipu_crtc_mode_set 0x36314752
imx-ipuv3 40000000.ipu: clk_di_round_rate: inrate: 133000000 div: 0x00000035 outrate: 40150928 wanted: 40000000
imx-ipuv3 40000000.ipu: clk_di_round_rate: inrate: 133000000 div: 0x00000035 outrate: 40150928 wanted: 40150928
imx-ipuv3 40000000.ipu: clk_di_set_rate: inrate: 133000000 desired: 40150928 div: 0x00000035

In this case the divider is 3.5, that result to clock is incorrect. See an attached oscillogram F0000TEK.jpg.

After a patch the clocks is OK. Patch just uncomment some FSL code.
imx-ipuv3 40000000.ipu: clk_di_round_rate: inrate: 133000000 div: 0x00000040 outrate: 33250000 wanted: 40000000
imx-ipuv3 40000000.ipu: clk_di_round_rate: inrate: 133000000 div: 0x00000040 outrate: 33250000 wanted: 33250000
imx-ipuv3 40000000.ipu: clk_di_set_rate: inrate: 133000000 desired: 33250000 div: 0x00000040

See an attached oscillogram F0001TEK.jpg.

So, I want to review this from developers and wait for comments.


diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-di.c b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
index 19d777e..d424c22 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-di.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
@@ -154,22 +154,15 @@ static int ipu_di_clk_calc_div(unsigned long inrate, unsigned long outrate)
 
 	if (div < 0x10)
 		div = 0x10;
-
-#ifdef WTF_IS_THIS
-	/*
-	 * Freescale has this in their Kernel. It is neither clear what
-	 * it does nor why it does it
-	 */
-	if (div & 0x10)
-		div &= ~0x7;
 	else {
 		/* Round up divider if it gets us closer to desired pix clk */
-		if ((div & 0xC) == 0xC) {
+		if (div & 0x0f) {
 			div += 0x10;
-			div &= ~0xF;
+			/* Strip fractional part of divider */
+			div &= ~0x0f;
 		}
 	}
-#endif
+
 	return div;
 }
 
-- 
1.8.1.5

---
-------------- next part --------------
A non-text attachment was scrubbed...
Name: F0001TEK.jpg
Type: image/jpeg
Size: 23677 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130614/ed347d72/attachment-0002.jpg>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: F0000TEK.jpg
Type: image/jpeg
Size: 22554 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130614/ed347d72/attachment-0003.jpg>
