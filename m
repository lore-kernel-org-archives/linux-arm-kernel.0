From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 17 Jan 2012 15:58:51 -0200
Subject: [PATCH v2] ARM: mx28: Clear CLKGATE bit prior to changing DIV field
In-Reply-To: <1326820526-26498-1-git-send-email-fabio.estevam@freescale.com>
References: <1326820526-26498-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1326823131-27447-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX28 Reference Manual states the following about the CLKGATE bit of register HW_CLKCTRL_SAIF0:

"The DIV field can change ONLY when this clock gate bit field is low."

So clear this bit prior to writing to the DIV field as required.

This also fixes the following error during mxs-sgtl5000 probe.

[    0.660000] saif0_clk_set_rate: divider writing timeout                     
[    0.670000] mxs-sgtl5000: probe of mxs-sgtl5000.0 failed with error -110    
[    0.670000] ALSA device list:                                               
[    0.680000]   No soundcards found.  

Audio is functional after this change.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Clear CLKGATE  and DIV fields at the same time

 arch/arm/mach-mxs/clock-mx28.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 5d68e41..0bcfd97 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -475,7 +475,7 @@ static int name##_set_rate(struct clk *clk, unsigned long rate)		\
 		return -EINVAL;						\
 									\
 	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
-	reg &= ~BM_CLKCTRL_##rs##_DIV;					\
+	reg &= ~(BM_CLKCTRL_##rs##_CLKGATE | BM_CLKCTRL_##rs##_DIV);	\
 	reg |= div << BP_CLKCTRL_##rs##_DIV;				\
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
 									\
-- 
1.7.1
