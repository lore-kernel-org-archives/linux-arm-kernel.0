From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Jun 2017 22:07:49 +0100
Subject: Applied "ASoC: rockchip: i2s: add a delay before i2s clear" to the
 asoc tree
In-Reply-To: <1496998369-30556-2-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <E1dKt2T-0000Hw-9Z@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: i2s: add a delay before i2s clear

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 5894b91d1e700f38b4157df143be1502cf08daa8 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Fri, 9 Jun 2017 16:52:46 +0800
Subject: [PATCH] ASoC: rockchip: i2s: add a delay before i2s clear

in order to guarantee i2s lrck signal integrity, when i2s stop,
need at least one lrck cycle to ensure signal integrity.

the max delay time is when lrck is 8khz, the delay time is
125us(1/8khz), using udelay(150) with a 25us margin.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 974915cb4c4f..f54843342ee2 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -116,6 +116,7 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 					   I2S_XFER_TXS_STOP |
 					   I2S_XFER_RXS_STOP);
 
+			udelay(150);
 			regmap_update_bits(i2s->regmap, I2S_CLR,
 					   I2S_CLR_TXC | I2S_CLR_RXC,
 					   I2S_CLR_TXC | I2S_CLR_RXC);
@@ -162,6 +163,7 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 					   I2S_XFER_TXS_STOP |
 					   I2S_XFER_RXS_STOP);
 
+			udelay(150);
 			regmap_update_bits(i2s->regmap, I2S_CLR,
 					   I2S_CLR_TXC | I2S_CLR_RXC,
 					   I2S_CLR_TXC | I2S_CLR_RXC);
-- 
2.11.0
