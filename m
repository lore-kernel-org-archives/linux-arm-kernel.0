From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 May 2016 14:47:03 +0200
Subject: [PATCH 03/20] clk: sunxi: tcon-ch1: Do not return a negative error in
 get_parent
In-Reply-To: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1463402840-17062-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

get_parent is supposed to return an unsigned 8 bit integer, so returning
-EINVAL is a bad idea.

Remove it.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sun4i-tcon-ch1.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sun4i-tcon-ch1.c b/drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
index 98a4582de56a..248585238b1c 100644
--- a/drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
+++ b/drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
@@ -85,9 +85,6 @@ static u8 tcon_ch1_get_parent(struct clk_hw *hw)
 	reg = readl(tclk->reg) >> TCON_CH1_SCLK2_MUX_SHIFT;
 	reg &= reg >> TCON_CH1_SCLK2_MUX_MASK;
 
-	if (reg >= num_parents)
-		return -EINVAL;
-
 	return reg;
 }
 
-- 
2.8.2
