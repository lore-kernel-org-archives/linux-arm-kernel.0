From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Aug 2017 12:21:01 +0100
Subject: Applied "spi: rockchip: configure CTRLR1 according to size and data
 frame" to the spi tree
In-Reply-To: <1502849522-10073-1-git-send-email-huibin.hong@rock-chips.com>
Message-ID: <E1dhwNh-0003iD-VL@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: configure CTRLR1 according to size and data frame

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 04b37d2d02c0a5ae2f4e59326ef6deaff18e0456 Mon Sep 17 00:00:00 2001
From: Huibin Hong <huibin.hong@rock-chips.com>
Date: Wed, 16 Aug 2017 10:12:02 +0800
Subject: [PATCH] spi: rockchip: configure CTRLR1 according to size and data
 frame

CTRLR1 is number of data frames, when rx only.
When data frame is 8 bit, CTRLR1 is len-1.
When data frame is 16 bit, CTRLR1 is (len/2)-1.

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 474033e2149e..fdcf3076681b 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -568,7 +568,13 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 
 	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
 
-	writel_relaxed(rs->len - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+	if (rs->n_bytes == 1)
+		writel_relaxed(rs->len - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+	else if (rs->n_bytes == 2)
+		writel_relaxed((rs->len / 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+	else
+		writel_relaxed((rs->len * 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_TXFTLR);
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
 
-- 
2.13.2
