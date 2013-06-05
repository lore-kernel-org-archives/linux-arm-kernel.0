From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:25:12 +0900
Subject: [PATCH 021/130] sh-pfc: r8a7778: add common PFC macro helper
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-22-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

pfc-r8a7778 will have many devices pfc support in the future,
and current pfc-r8a7778 is using pin/mux definition macro for SCIF.
The device definition style using macro is readable code IMO,
but creating new macro for each devices is not good sense.
This patch adds common SH_PFC_xx() macro for each new feature devices

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index ddbd27b..139f9dd 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -1303,15 +1303,25 @@ static struct sh_pfc_pin pinmux_pins[] = {
  */
 #define PIN_NUMBER(row, col)		(1000+((row)-1)*25+(col)-1)
 
-/* - SCIF macro ------------------------------------------------------------- */
-#define SCIF_PFC_PIN(name, args...)					\
+/* - macro */
+#define SH_PFC_PINS(name, args...) \
 	static const unsigned int name ##_pins[] = { args }
-#define SCIF_PFC_DAT(name, tx, rx)					\
-	static const unsigned int name ##_mux[]  = { tx##_MARK, rx##_MARK, }
-#define SCIF_PFC_CTR(name, cts, rts)					\
-	static const unsigned int name ##_mux[]  = { cts##_MARK, rts##_MARK, }
-#define SCIF_PFC_CLK(name, sck)					\
-	static const unsigned int name ##_mux[]  = { sck##_MARK, }
+#define SH_PFC_MUX1(name, arg1)					\
+	static const unsigned int name ##_mux[]  = { arg1##_MARK }
+#define SH_PFC_MUX2(name, arg1, arg2)					\
+	static const unsigned int name ##_mux[]  = { arg1##_MARK, arg2##_MARK, }
+#define SH_PFC_MUX3(name, arg1, arg2, arg3)					\
+	static const unsigned int name ##_mux[]  = { arg1##_MARK, arg2##_MARK,	\
+						     arg3##_MARK }
+#define SH_PFC_MUX4(name, arg1, arg2, arg3, arg4)			\
+	static const unsigned int name ##_mux[]  = { arg1##_MARK, arg2##_MARK, \
+						     arg3##_MARK, arg4##_MARK }
+
+/* - SCIF macro ------------------------------------------------------------- */
+#define SCIF_PFC_PIN(name, args...)	SH_PFC_PINS(name, args)
+#define SCIF_PFC_DAT(name, tx, rx)	SH_PFC_MUX2(name, tx, rx)
+#define SCIF_PFC_CTR(name, cts, rts)	SH_PFC_MUX2(name, cts, rts)
+#define SCIF_PFC_CLK(name, sck)		SH_PFC_MUX1(name, sck)
 
 /* - HSCIF0 ----------------------------------------------------------------- */
 SCIF_PFC_PIN(hscif0_data_a,	RCAR_GP_PIN(1, 17),	RCAR_GP_PIN(1, 18));
-- 
1.8.2.1
