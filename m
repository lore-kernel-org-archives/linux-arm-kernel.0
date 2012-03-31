From: lost.distance@yahoo.com (Paul Parsons)
Date: Sat, 31 Mar 2012 13:20:37 +0100 (BST)
Subject: [PATCH] ARM: pxa: mfp: Force gpio direction for MFP_LPM_KEEP_OUTPUT
Message-ID: <1333196437.11228.YahooMailClassic@web29011.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some MFP configurations specify MFP_LPM_KEEP_OUTPUT to preserve the gpio output
value (HIGH or LOW) during sleep mode. For example:

    GPIO72_GPIO | MFP_LPM_KEEP_OUTPUT,

Unfortunately MFP_LPM_KEEP_OUTPUT makes no special provision for setting the
sleep mode gpio direction, unlike MFP_LPM_DRIVE_HIGH and MFP_LPM_DRIVE_LOW.
Consequently MFP configurations of the form:

    GPIO<n>_GPIO | MFP_LPM_KEEP_OUTPUT,

will set the sleep mode gpio direction to INPUT.

This patch forces the sleep mode gpio direction to OUTPUT in cases where
MFP_LPM_KEEP_OUTPUT was specified. This brings MFP_LPM_KEEP_OUTPUT into line
with MFP_LPM_DRIVE_HIGH and MFP_LPM_DRIVE_LOW.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index b0a8428..3b443199 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -96,6 +96,9 @@ static int __mfp_config_gpio(unsigned gpio, unsigned long c)
 		break;
 	}
 
+	if (c & MFP_LPM_KEEP_OUTPUT)
+		is_out = 1;
+
 	if (is_out ^ gpio_desc[gpio].dir_inverted)
 		gpdr_lpm[bank] |= mask;
 	else
