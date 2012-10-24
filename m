From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 24 Oct 2012 14:13:41 +0200
Subject: [PATCH 2/2] ARM: plat-nomadik: Use apb_pclock in mtu driver
In-Reply-To: <1351080821-18660-1-git-send-email-ulf.hansson@stericsson.com>
References: <1351080821-18660-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1351080821-18660-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/plat-nomadik/timer.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index 9222e55..17c690d 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -177,9 +177,15 @@ void nmdk_clksrc_reset(void)
 void __init nmdk_timer_init(void __iomem *base)
 {
 	unsigned long rate;
-	struct clk *clk0;
+	struct clk *clk0, *pclk0;
 
 	mtu_base = base;
+
+	pclk0 = clk_get_sys("mtu0", "apb_pclk");
+	BUG_ON(IS_ERR(pclk0));
+	BUG_ON(clk_prepare(pclk0) < 0);
+	BUG_ON(clk_enable(pclk0) < 0);
+
 	clk0 = clk_get_sys("mtu0", NULL);
 	BUG_ON(IS_ERR(clk0));
 	BUG_ON(clk_prepare(clk0) < 0);
-- 
1.7.10
