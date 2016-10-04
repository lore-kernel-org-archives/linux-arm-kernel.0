From: broonie@kernel.org (Mark Brown)
Date: Tue, 04 Oct 2016 11:27:17 +0200
Subject: Applied "spi: omap2-mcspi: Fix modifying platform resource data" to
 the spi tree
In-Reply-To: <1405683053-14104-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <E1brM0L-0003Zk-Qz@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: omap2-mcspi: Fix modifying platform resource data

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

>From 0142d2ee7e9f107248ebf69bd66037c536d3f6cc Mon Sep 17 00:00:00 2001
From: Vikram N <vicky773@gmail.com>
Date: Fri, 30 Sep 2016 19:53:11 +0530
Subject: [PATCH] spi: omap2-mcspi: Fix modifying platform resource data

currently during probe the resource data gets modified and device
physical address remains valid only during first load. If the module is
unloaded and loaded again, the ioremp will be done on a incorrect address
as the resource was modified during previous module load.
This patch fixes this issue.

Signed-off-by: Vikram N <vicky773@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index d5157b2222ce..3567e1dfd30d 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1391,15 +1391,13 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		goto free_master;
 	}
 
-	r->start += regs_offset;
-	r->end += regs_offset;
-	mcspi->phys = r->start;
-
 	mcspi->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(mcspi->base)) {
 		status = PTR_ERR(mcspi->base);
 		goto free_master;
 	}
+	mcspi->phys = r->start + regs_offset;
+	mcspi->base += regs_offset;
 
 	mcspi->dev = &pdev->dev;
 
-- 
2.9.3
