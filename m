From: broonie@kernel.org (Mark Brown)
Date: Wed, 03 Jan 2018 12:22:55 +0000
Subject: Applied "spi: sirf: account for const type of of_device_id.data" to
 the spi tree
In-Reply-To: <1514899688-27844-4-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <E1eWi4N-0003OF-1D@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: sirf: account for const type of of_device_id.data

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 9e327ce71f3894e7e6b57f5c15a0dfa5be79f44e Mon Sep 17 00:00:00 2001
From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Tue, 2 Jan 2018 14:27:59 +0100
Subject: [PATCH] spi: sirf: account for const type of of_device_id.data

This driver creates various const structures that it stores in the
data field of an of_device_id array.

Adding const to the declaration of the location that receives the
const value from the data field ensures that the compiler will
continue to check that the value is not modified.  Furthermore, the
const-discarding cast on the extraction from the data field is no
longer needed.

Done using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sirf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index bbb1a275f718..f009d76f96b1 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -1072,7 +1072,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	struct sirfsoc_spi *sspi;
 	struct spi_master *master;
 	struct resource *mem_res;
-	struct sirf_spi_comp_data *spi_comp_data;
+	const struct sirf_spi_comp_data *spi_comp_data;
 	int irq;
 	int ret;
 	const struct of_device_id *match;
@@ -1092,7 +1092,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 	sspi = spi_master_get_devdata(master);
 	sspi->fifo_full_offset = ilog2(sspi->fifo_size);
-	spi_comp_data = (struct sirf_spi_comp_data *)match->data;
+	spi_comp_data = match->data;
 	sspi->regs = spi_comp_data->regs;
 	sspi->type = spi_comp_data->type;
 	sspi->fifo_level_chk_mask = (sspi->fifo_size / 4) - 1;
-- 
2.15.1
