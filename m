From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jan 2010 22:04:23 +0800
Subject: [PATCH 15/16] [ARM] pxa: add MFP_LPM_KEEP_OUTPUT flag to pin config
In-Reply-To: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
References: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1263218664-11546-16-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some pins are expected to keep their last level during suspend, and
introduce MFP_LPM_KEEP_OUTPUT for this.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h |    2 ++
 arch/arm/mach-pxa/mfp-pxa2xx.c              |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h b/arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h
index 658b28e..c54cef2 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h
+++ b/arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h
@@ -25,6 +25,8 @@
 #define MFP_DIR(x)		(((x) >> 23) & 0x1)
 
 #define MFP_LPM_CAN_WAKEUP	(0x1 << 24)
+#define MFP_LPM_KEEP_OUTPUT	(0x1 << 25)
+
 #define WAKEUP_ON_EDGE_RISE	(MFP_LPM_CAN_WAKEUP | MFP_LPM_EDGE_RISE)
 #define WAKEUP_ON_EDGE_FALL	(MFP_LPM_CAN_WAKEUP | MFP_LPM_EDGE_FALL)
 #define WAKEUP_ON_EDGE_BOTH	(MFP_LPM_CAN_WAKEUP | MFP_LPM_EDGE_BOTH)
diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index cf6b720..c98b5a8 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -328,6 +328,17 @@ static int pxa2xx_mfp_suspend(struct sys_device *d, pm_message_t state)
 {
 	int i;
 
+	/* set corresponding PGSR bit of those marked MFP_LPM_KEEP_OUTPUT */
+	for (i = 0; i < pxa_last_gpio; i++) {
+		if ((gpio_desc[i].config & MFP_LPM_KEEP_OUTPUT) &&
+		    (GPDR(i) & GPIO_bit(i))) {
+			if (GPLR(i) & GPIO_bit(i))
+				PGSR(i) |= GPIO_bit(i);
+			else
+				PGSR(i) &= ~GPIO_bit(i);
+		}
+	}
+
 	for (i = 0; i <= gpio_to_bank(pxa_last_gpio); i++) {
 
 		saved_gafr[0][i] = GAFR_L(i);
-- 
1.6.3.3
