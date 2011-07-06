From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed,  6 Jul 2011 23:52:27 +0800
Subject: [PATCH 1/3] ARM: pxa: fix PGSR register address calculation
Message-ID: <1309967549-3394-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Parsons <lost.distance@yahoo.com>

The file mfp-pxa2xx.c defines a macro, PGSR(), which translates a gpio
bank number to a PGSR register address. The function pxa2xx_mfp_suspend()
erroneously passed in a gpio number instead of a gpio bank number.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
Cc: stable at kernel.org
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/mfp-pxa2xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index 87ae312..b27544b 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -347,9 +347,9 @@ static int pxa2xx_mfp_suspend(void)
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
 
-- 
1.7.4.1
