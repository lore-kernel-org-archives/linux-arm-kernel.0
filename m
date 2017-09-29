From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Sep 2017 11:25:08 +0800
Subject: [PATCH 1/7] regulator: axp20x: Fix poly-phase bit offset for AXP803
 DCDC5/6
In-Reply-To: <20170929032514.31727-1-wens@csie.org>
References: <20170929032514.31727-1-wens@csie.org>
Message-ID: <20170929032514.31727-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bit offset used to check if DCDC5 and DCDC6 are tied together in
poly-phase output is wrong. It was checking against a reserved bit,
which is always false.

In reality, neither the reference design layout nor actually produced
boards tie these two buck regulators together. But we should still
fix it, just in case.

Fixes: 1dbe0ccb0631 ("regulator: axp20x-regulator: add support for AXP803")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/regulator/axp20x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index f18b36dd57dd..376a99b7cf5d 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -590,7 +590,7 @@ static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
 		case AXP803_DCDC3:
 			return !!(reg & BIT(6));
 		case AXP803_DCDC6:
-			return !!(reg & BIT(7));
+			return !!(reg & BIT(5));
 		}
 		break;
 
-- 
2.14.2
