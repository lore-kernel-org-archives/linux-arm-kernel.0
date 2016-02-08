From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  8 Feb 2016 09:49:25 +0100
Subject: [PATCH] ARM: ICST: try other dividends than 1
Message-ID: <1454921365-4140-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the dawn of time the ICST code has only supported divide
by one or hang in an eternal loop. Luckily we were always dividing
by one because the reference frequency for the systems using
the ICSTs is 24MHz and the [min,max] values for the PLL input
if [10,320] MHz for ICST307 and [6,200] for ICST525, so the loop
will always terminate immediately without assigning any divisor
for the reference frequency.

But for the code to make sense, let's insert the missing i++

Reported-by: David Binderman <dcb314@hotmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: stable at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I ran into the mail David sent in december and looked closer at
this. It's not a regression in any deployed systems but it's
disturbing so let's fix it.
---
 arch/arm/common/icst.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/common/icst.c b/arch/arm/common/icst.c
index 2dc6da70ae59..3b3e58b7ba74 100644
--- a/arch/arm/common/icst.c
+++ b/arch/arm/common/icst.c
@@ -58,6 +58,7 @@ icst_hz_to_vco(const struct icst_params *p, unsigned long freq)
 
 		if (f > p->vco_min && f <= p->vco_max)
 			break;
+		i++;
 	} while (i < 8);
 
 	if (i >= 8)
-- 
2.4.3
