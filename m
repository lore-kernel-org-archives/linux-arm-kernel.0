From: andrew@aj.id.au (Andrew Jeffery)
Date: Thu,  3 Nov 2016 01:07:56 +1030
Subject: [PATCH v2 1/6] pinctrl-aspeed-g5: Never set SCU90[6]
In-Reply-To: <1478097481-14895-1-git-send-email-andrew@aj.id.au>
References: <1478097481-14895-1-git-send-email-andrew@aj.id.au>
Message-ID: <1478097481-14895-2-git-send-email-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a pin depending on bit 6 in SCU90 is requested for GPIO, the export
will succeed but changes to the GPIO's value will not be accepted by the
hardware. This is because the pinmux driver has misconfigured the SCU by
writing 1 to the reserved bit.

The description of SCU90[6] from the datasheet is 'Reserved, must keep
at value ?0?'. The fix is to switch pinmux from the bit-flipping macro
to explicitly configuring the .enable and .disable values to zero.

The patch has been tested on an AST2500 EVB.

Fixes: 56e57cb6c07f (pinctrl: Add pinctrl-aspeed-g5 driver)
Reported-by: Uma Yadlapati <yadlapat@us.ibm.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---

This patch should be applied for 4.9.

 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index c8c72e8259d3..87b46390b695 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -26,7 +26,7 @@
 
 #define ASPEED_G5_NR_PINS 228
 
-#define COND1		SIG_DESC_BIT(SCU90, 6, 0)
+#define COND1		{ SCU90, BIT(6), 0, 0 }
 #define COND2		{ SCU94, GENMASK(1, 0), 0, 0 }
 
 #define B14 0
-- 
2.7.4
