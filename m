From: broonie@kernel.org (Mark Brown)
Date: Wed, 04 Oct 2017 12:29:07 +0100
Subject: Applied "regulator: axp20x: Fix poly-phase bit offset for AXP803
 DCDC5/6" to the regulator tree
In-Reply-To: <20170929032514.31727-2-wens@csie.org>
Message-ID: <E1dzhrP-0004X4-NL@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: axp20x: Fix poly-phase bit offset for AXP803 DCDC5/6

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 986e7b7e4991a5d3abab26f97a671512e09e4417 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 29 Sep 2017 11:25:08 +0800
Subject: [PATCH] regulator: axp20x: Fix poly-phase bit offset for AXP803
 DCDC5/6

The bit offset used to check if DCDC5 and DCDC6 are tied together in
poly-phase output is wrong. It was checking against a reserved bit,
which is always false.

In reality, neither the reference design layout nor actually produced
boards tie these two buck regulators together. But we should still
fix it, just in case.

Fixes: 1dbe0ccb0631 ("regulator: axp20x-regulator: add support for AXP803")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.14.1
