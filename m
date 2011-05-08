From: lost.distance@yahoo.com (Paul Parsons)
Date: Sun, 08 May 2011 01:54:33 +0000
Subject: [PATCH] pxa: Fix PGSR register address calculation
Message-ID: <E1QItCc-0003up-FQ@outmx08.plus.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The file mfp-pxa2xx.c defines a macro, PGSR(), which translates a gpio bank number to a PGSR register address. The function pxa2xx_mfp_suspend() erroneously passed in a gpio number instead of a gpio bank number.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---
--- clean-2.6.39-rc6/arch/arm/mach-pxa/mfp-pxa2xx.c	2011-03-15 01:20:32.000000000 +0000
+++ linux-2.6.39-rc6/arch/arm/mach-pxa/mfp-pxa2xx.c	2011-05-08 02:09:36.706294235 +0100
@@ -347,9 +347,9 @@ static int pxa2xx_mfp_suspend(struct sys
 		if ((gpio_desc[i].config & MFP_LPM_KEEP_OUTPUT) &&
 		    (GPDR(i) & GPIO_bit(i))) {
 			if (GPLR(i) & GPIO_bit(i))
-				PGSR(i) |= GPIO_bit(i);
+				PGSR(gpio_to_bank(i)) |= GPIO_bit(i);
 			else
-				PGSR(i) &= ~GPIO_bit(i);
+				PGSR(gpio_to_bank(i)) &= ~GPIO_bit(i);
 		}
 	}
 
