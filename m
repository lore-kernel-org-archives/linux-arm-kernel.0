From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 14 May 2013 15:14:55 +0200
Subject: [PATCH] mfd: db8500-prcmu: Update stored DSI PLL divider value
Message-ID: <1368537295-23459-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Previously the DSI PLL divider rate was initialised statically and
assumed to be 1. Before the common clock framework were enabled for
ux500, a call to clk_set_rate() would always update the HW registers
no matter what the current setting was.

This patch makes sure the actual hw settings and the sw assumed
settings are matched.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Paer-Olof Haakansson <par-olof.hakansson@stericsson.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/db8500-prcmu.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 5389368..66f8097 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -1613,6 +1613,8 @@ static unsigned long dsiclk_rate(u8 n)
 
 	if (divsel == PRCM_DSI_PLLOUT_SEL_OFF)
 		divsel = dsiclk[n].divsel;
+	else
+		dsiclk[n].divsel = divsel;
 
 	switch (divsel) {
 	case PRCM_DSI_PLLOUT_SEL_PHI_4:
-- 
1.7.10
