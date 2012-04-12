From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 12 Apr 2012 15:43:28 +0300
Subject: [PATCH 1/2] ARM: PXA2xx: MFP: fix bug with MFP_LPM_KEEP_OUTPUT
Message-ID: <1334234609-780-1-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pins that have MFP_LPM_KEEP_OUTPUT set and are configured for output
must retain the output state in low power mode.
Currently, the pin direction configuration is overrided with values
in gpdr_lpm[] array and do not obey the MFP_LPM_KEEP_OUTPUT setting.

Fix the above bug and add some documentation to clarify the
MFP_LPM_KEEP_OUTPUT setting purpose.

Reported-by: Paul Parsons <lost.distance@yahoo.com>
Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Tested-by: Paul Parsons <lost.distance@yahoo.com>
---
 arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h |    7 +++++++
 arch/arm/mach-pxa/mfp-pxa2xx.c              |   12 ++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h b/arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h
index c54cef2..cbf51ae 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h
+++ b/arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h
@@ -17,6 +17,7 @@
  *
  * bit     23 - Input/Output (PXA2xx specific)
  * bit     24 - Wakeup Enable(PXA2xx specific)
+ * bit     25 - Keep Output  (PXA2xx specific)
  */
 
 #define MFP_DIR_IN		(0x0 << 23)
@@ -25,6 +26,12 @@
 #define MFP_DIR(x)		(((x) >> 23) & 0x1)
 
 #define MFP_LPM_CAN_WAKEUP	(0x1 << 24)
+
+/*
+ * MFP_LPM_KEEP_OUTPUT must be specified for pins that need to
+ * retain their last output level (low or high).
+ * Note: MFP_LPM_KEEP_OUTPUT has no effect on pins configured for input.
+ */
 #define MFP_LPM_KEEP_OUTPUT	(0x1 << 25)
 
 #define WAKEUP_ON_EDGE_RISE	(MFP_LPM_CAN_WAKEUP | MFP_LPM_EDGE_RISE)
diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index b0a8428..d2373d7 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -366,14 +366,22 @@ static int pxa2xx_mfp_suspend(void)
 	}
 
 	for (i = 0; i <= gpio_to_bank(pxa_last_gpio); i++) {
-
 		saved_gafr[0][i] = GAFR_L(i);
 		saved_gafr[1][i] = GAFR_U(i);
 		saved_gpdr[i] = GPDR(i * 32);
 		saved_pgsr[i] = PGSR(i);
+	}
 
-		GPDR(i * 32) = gpdr_lpm[i];
+	/* set GPDR bits taking into account MFP_LPM_KEEP_OUTPUT */
+	for (i = 0; i < pxa_last_gpio; i++) {
+		if ((gpdr_lpm[gpio_to_bank(i)] & GPIO_bit(i)) ||
+		    ((gpio_desc[i].config & MFP_LPM_KEEP_OUTPUT) &&
+		     (saved_gpdr[gpio_to_bank(i)] & GPIO_bit(i))))
+			GPDR(i) |= GPIO_bit(i);
+		else
+			GPDR(i) &= ~GPIO_bit(i);
 	}
+
 	return 0;
 }
 
-- 
1.7.3.4
