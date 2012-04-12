From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 12 Apr 2012 15:43:29 +0300
Subject: [PATCH 2/2] ARM: PXA2xx: MFP: fix potential direction bug
In-Reply-To: <1334234609-780-1-git-send-email-grinberg@compulab.co.il>
References: <1334234609-780-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1334234609-780-2-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pins configured as input and have MFP_LPM_DRIVE_* flag set, can have a
wrong output value for some period of time (spike) during the suspend
sequence.
This can happen because the direction of the pins (GPDR) is set by
software and the output level is set by hardware (PGSR) at a later
stage.

Fix the above potential bug by setting the output levels first.
Also save the actual levels of the pins before the suspend and restore
them after the resume, but before the direction settings take place, so
the same bug as described above will not happen in the resume sequence.

Reported-by: Paul Parsons <lost.distance@yahoo.com>
Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Tested-by: Paul Parsons <lost.distance@yahoo.com>
---
No regression has been seen after this patch.

 arch/arm/mach-pxa/mfp-pxa2xx.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index d2373d7..ef0426a 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -33,6 +33,8 @@
 #define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
 #define GPLR(x)		__REG2(0x40E00000, BANK_OFF((x) >> 5))
 #define GPDR(x)		__REG2(0x40E00000, BANK_OFF((x) >> 5) + 0x0c)
+#define GPSR(x)		__REG2(0x40E00000, BANK_OFF((x) >> 5) + 0x18)
+#define GPCR(x)		__REG2(0x40E00000, BANK_OFF((x) >> 5) + 0x24)
 
 #define PWER_WE35	(1 << 24)
 
@@ -348,6 +350,7 @@ static inline void pxa27x_mfp_init(void) {}
 #ifdef CONFIG_PM
 static unsigned long saved_gafr[2][4];
 static unsigned long saved_gpdr[4];
+static unsigned long saved_gplr[4];
 static unsigned long saved_pgsr[4];
 
 static int pxa2xx_mfp_suspend(void)
@@ -369,7 +372,11 @@ static int pxa2xx_mfp_suspend(void)
 		saved_gafr[0][i] = GAFR_L(i);
 		saved_gafr[1][i] = GAFR_U(i);
 		saved_gpdr[i] = GPDR(i * 32);
+		saved_gplr[i] = GPLR(i * 32);
 		saved_pgsr[i] = PGSR(i);
+
+		GPSR(i * 32) = PGSR(i);
+		GPCR(i * 32) = ~PGSR(i);
 	}
 
 	/* set GPDR bits taking into account MFP_LPM_KEEP_OUTPUT */
@@ -392,6 +399,8 @@ static void pxa2xx_mfp_resume(void)
 	for (i = 0; i <= gpio_to_bank(pxa_last_gpio); i++) {
 		GAFR_L(i) = saved_gafr[0][i];
 		GAFR_U(i) = saved_gafr[1][i];
+		GPSR(i * 32) = saved_gplr[i];
+		GPCR(i * 32) = ~saved_gplr[i];
 		GPDR(i * 32) = saved_gpdr[i];
 		PGSR(i) = saved_pgsr[i];
 	}
-- 
1.7.3.4
