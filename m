From: rwahl@gmx.de (Ronald Wahl)
Date: Wed, 10 Oct 2018 15:54:54 +0200
Subject: [PATCH resend] clk: at91: Fix division by zero in PLL recalc_rate()
Message-ID: <trinity-9c3a7e1f-73af-4a1a-b82c-cafd5aefa5e4-1539179694006@3c-app-gmx-bs12>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a982e45dc150 ("clk: at91: PLL recalc_rate() now using cached MUL
and DIV values") removed a check that prevents a division by zero. This
now causes a stacktrace when booting the kernel on a at91 platform if
the PLL DIV register contains zero. This commit reintroduces this check.

Fixes: a982e45dc150 ("clk: at91: PLL recalc_rate() now using cached...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ronald Wahl <rwahl@gmx.de>
---
 drivers/clk/at91/clk-pll.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index 72b6091eb7b9..dc7fbc796cb6 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -133,6 +133,9 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
 {
 	struct clk_pll *pll = to_clk_pll(hw);
 
+	if (!pll->div || !pll->mul)
+		return 0;
+
 	return (parent_rate / pll->div) * (pll->mul + 1);
 }
 
-- 
2.17.1
