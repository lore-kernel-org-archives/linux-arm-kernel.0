From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 30 Sep 2015 18:10:54 +0200
Subject: [PATCH 01/16] clk: at91: utmi: use pmc_read when the at91_pmc is
 available
In-Reply-To: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1443629469-15086-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91_pmc_read is a workaround to allow external drivers to acces some
registers of the PMC. There is no need for it in clk-utmi.c as we aready
have a pointer to the struct at91_pmc.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clk/at91/clk-utmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
index 30dd697b1668..ca561e90a60f 100644
--- a/drivers/clk/at91/clk-utmi.c
+++ b/drivers/clk/at91/clk-utmi.c
@@ -47,7 +47,7 @@ static int clk_utmi_prepare(struct clk_hw *hw)
 {
 	struct clk_utmi *utmi = to_clk_utmi(hw);
 	struct at91_pmc *pmc = utmi->pmc;
-	u32 tmp = at91_pmc_read(AT91_CKGR_UCKR) | AT91_PMC_UPLLEN |
+	u32 tmp = pmc_read(pmc, AT91_CKGR_UCKR) | AT91_PMC_UPLLEN |
 		  AT91_PMC_UPLLCOUNT | AT91_PMC_BIASEN;
 
 	pmc_write(pmc, AT91_CKGR_UCKR, tmp);
@@ -73,7 +73,7 @@ static void clk_utmi_unprepare(struct clk_hw *hw)
 {
 	struct clk_utmi *utmi = to_clk_utmi(hw);
 	struct at91_pmc *pmc = utmi->pmc;
-	u32 tmp = at91_pmc_read(AT91_CKGR_UCKR) & ~AT91_PMC_UPLLEN;
+	u32 tmp = pmc_read(pmc, AT91_CKGR_UCKR) & ~AT91_PMC_UPLLEN;
 
 	pmc_write(pmc, AT91_CKGR_UCKR, tmp);
 }
-- 
2.1.4
