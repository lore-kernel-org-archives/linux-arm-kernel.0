From: jason77.wang@gmail.com (Jason Wang)
Date: Sat, 21 Aug 2010 16:24:04 +0800
Subject: [PATCH 2/3] mx5/clock: fix clear bit fields issue in
	_clk_ccgr_disable function
In-Reply-To: <1282379045-32363-2-git-send-email-jason77.wang@gmail.com>
References: <1282379045-32363-1-git-send-email-jason77.wang@gmail.com>
	<1282379045-32363-2-git-send-email-jason77.wang@gmail.com>
Message-ID: <1282379045-32363-3-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can see MXC_CCM_CCGRx_MOD_OFF is defined as 0 while
MXC_CCM_CCGRx_CG_MASK is defined as 0x3 in crm_regs.h, here in the
_clk_ccgr_disable function, we want to clear the corresponding enable
bit fields to disable this clock, so we should choose MASK instead of
OFF otherwise clocks can't be disabled.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 arch/arm/mach-mx5/clock-mx51.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 6af69de..57c10a9 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -56,7 +56,7 @@ static void _clk_ccgr_disable(struct clk *clk)
 {
 	u32 reg;
 	reg = __raw_readl(clk->enable_reg);
-	reg &= ~(MXC_CCM_CCGRx_MOD_OFF << clk->enable_shift);
+	reg &= ~(MXC_CCM_CCGRx_CG_MASK << clk->enable_shift);
 	__raw_writel(reg, clk->enable_reg);
 
 }
-- 
1.5.6.5
