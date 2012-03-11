From: lost.distance@yahoo.com (Paul Parsons)
Date: Sun, 11 Mar 2012 13:23:42 +0000 (GMT)
Subject: [PATCH v2] pxa/hx4700: Reduce sleep mode battery discharge by 35%
Message-ID: <1331472222.71907.YahooMailClassic@web29003.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drive the two Bluetooth UART output GPIOs (GPIO43_BTUART_TXD, GPIO45_BTUART_RTS)
LOW during sleep mode instead of HIGH. This reduces sleep mode battery discharge
from approximately 46 mA to approximately 30 mA.

Signed-off-by: Oliver Winker <oliver@oli1170.net>
Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

V2:
Corrected nomenclature.
Added GPIO43_BTUART_TXD_LPM_LOW and GPIO45_BTUART_RTS_LPM_LOW to mfp-pxa27x.h

diff -uprN clean-3.3-rc6/arch/arm/mach-pxa/hx4700.c linux-3.3-rc6/arch/arm/mach-pxa/hx4700.c
--- clean-3.3-rc6/arch/arm/mach-pxa/hx4700.c	2012-03-04 01:08:09.000000000 +0000
+++ linux-3.3-rc6/arch/arm/mach-pxa/hx4700.c	2012-03-11 12:30:29.799567611 +0000
@@ -97,9 +97,9 @@ static unsigned long hx4700_pin_config[]
 
 	/* BTUART */
 	GPIO42_BTUART_RXD,
-	GPIO43_BTUART_TXD,
+	GPIO43_BTUART_TXD_LPM_LOW,
 	GPIO44_BTUART_CTS,
-	GPIO45_BTUART_RTS,
+	GPIO45_BTUART_RTS_LPM_LOW,
 
 	/* PWM 1 (Backlight) */
 	GPIO17_PWM1_OUT,
diff -uprN clean-3.3-rc6/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h linux-3.3-rc6/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
--- clean-3.3-rc6/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h	2012-03-04 01:08:09.000000000 +0000
+++ linux-3.3-rc6/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h	2012-03-11 12:32:23.728285708 +0000
@@ -158,7 +158,9 @@
 #define GPIO44_BTUART_CTS	MFP_CFG_IN(GPIO44, AF1)
 #define GPIO42_BTUART_RXD	MFP_CFG_IN(GPIO42, AF1)
 #define GPIO45_BTUART_RTS	MFP_CFG_OUT(GPIO45, AF2, DRIVE_HIGH)
+#define GPIO45_BTUART_RTS_LPM_LOW	MFP_CFG_OUT(GPIO45, AF2, DRIVE_LOW)
 #define GPIO43_BTUART_TXD	MFP_CFG_OUT(GPIO43, AF2, DRIVE_HIGH)
+#define GPIO43_BTUART_TXD_LPM_LOW	MFP_CFG_OUT(GPIO43, AF2, DRIVE_LOW)
 
 /* STUART */
 #define GPIO46_STUART_RXD	MFP_CFG_IN(GPIO46, AF2)
