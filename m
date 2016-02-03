From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  3 Feb 2016 20:55:08 +0100
Subject: [PATCH] ARM: ICST: avoid arithmetic overflow in icst_hz()
Message-ID: <1454529308-31887-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When trying to set the ICST 307 clock to 25174000 Hz I ran into
this arithmetic error: the icst_hz_to_vco() correctly figure out
DIVIDE=2, RDW=100 and VDW=99 yielding a frequency of
25174000 Hz out of the VCO. (I replicated the icst_hz() function
in a spreadsheet to verify this.)

However, when I called icst_hz() on these VCO settings it would
instead return 4122709 Hz. This causes an error in the common
clock driver for ICST as the common clock framework will call
.round_rate() on the clock which will utilize icst_hz_to_vco()
followed by icst_hz() suggesting the erroneous frequency, and
then the clock gets set to this.

The error did not manifest in the old clock framework since
this high frequency was only used by the CLCD, which calls
clk_set_rate() without first calling clk_round_rate() and since
the old clock framework would not call clk_round_rate() before
setting the frequency, the correct values propagated into
the VCO.

After some experimenting I figured out that it was due to a simple
arithmetic overflow: the divisor for 24Mhz reference frequency
as reference becomes 24000000*2*(99+8)=0x132212400 and the "1"
in bit 32 overflows and is lost.

But introducing an explicit 64-by-32 bit do_div() and casting
the divisor into (u64) we get the right frequency back, and the
right frequency gets set.

Tested on the ARM Versatile.

Cc: stable at vger.kernel.org
Cc: linux-clk at vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/common/icst.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/icst.c b/arch/arm/common/icst.c
index 2dc6da70ae59..d3c0e69df259 100644
--- a/arch/arm/common/icst.c
+++ b/arch/arm/common/icst.c
@@ -16,7 +16,7 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
-
+#include <asm/div64.h>
 #include <asm/hardware/icst.h>
 
 /*
@@ -29,7 +29,11 @@ EXPORT_SYMBOL(icst525_s2div);
 
 unsigned long icst_hz(const struct icst_params *p, struct icst_vco vco)
 {
-	return p->ref * 2 * (vco.v + 8) / ((vco.r + 2) * p->s2div[vco.s]);
+	u64 dividend = p->ref * 2 * (u64)(vco.v + 8);
+	u32 divisor = (vco.r + 2) * p->s2div[vco.s];
+
+	do_div(dividend, divisor);
+	return (unsigned long)dividend;
 }
 
 EXPORT_SYMBOL(icst_hz);
-- 
2.4.3
