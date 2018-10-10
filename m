From: ronald.wahl@raritan.com (Ronald WAHL)
Date: Wed, 10 Oct 2018 10:31:31 +0000
Subject: [PATCH] clk: at91: Fix division by zero in PLL recalc_rate()
Message-ID: <fd2a1c19-8cb5-4db0-a2bb-6b0129162029@raritan.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a982e45dc150 ("clk: at91: PLL recalc_rate() now using cached MUL
and DIV values") removed a check that prevents a division by zero. This
now causes a stacktrace when booting the kernel on a at91 platform if
the PLL DIV register contains zero. This commit reintroduces this check.

Fixes: a982e45dc150 ("clk: at91: PLL recalc_rate() now using cached...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
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

+if (!pll->div || !pll->mul)
+return 0;
+
 return (parent_rate / pll->div) * (pll->mul + 1);
 }

--
2.17.1

________________________________

Ce message, ainsi que tous les fichiers joints ? ce message, peuvent contenir des informations sensibles et/ ou confidentielles ne devant pas ?tre divulgu?es. Si vous n'?tes pas le destinataire de ce message (ou que vous recevez ce message par erreur), nous vous remercions de le notifier imm?diatement ? son exp?diteur, et de d?truire ce message. Toute copie, divulgation, modification, utilisation ou diffusion, non autoris?e, directe ou indirecte, de tout ou partie de ce message, est strictement interdite.


This e-mail, and any document attached hereby, may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and destroy this e-mail. Any unauthorized, direct or indirect, copying, disclosure, distribution or other use of the material or parts thereof is strictly forbidden.
