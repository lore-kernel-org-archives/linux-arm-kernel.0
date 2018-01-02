From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Tue,  2 Jan 2018 14:27:59 +0100
Subject: [PATCH 03/12] spi: sirf: account for const type of of_device_id.data
In-Reply-To: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1514899688-27844-4-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver creates various const structures that it stores in the
data field of an of_device_id array.

Adding const to the declaration of the location that receives the
const value from the data field ensures that the compiler will
continue to check that the value is not modified.  Furthermore, the
const-discarding cast on the extraction from the data field is no
longer needed.

Done using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/spi/spi-sirf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -u -p a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -1072,7 +1072,7 @@ static int spi_sirfsoc_probe(struct plat
 	struct sirfsoc_spi *sspi;
 	struct spi_master *master;
 	struct resource *mem_res;
-	struct sirf_spi_comp_data *spi_comp_data;
+	const struct sirf_spi_comp_data *spi_comp_data;
 	int irq;
 	int ret;
 	const struct of_device_id *match;
@@ -1092,7 +1092,7 @@ static int spi_sirfsoc_probe(struct plat
 	platform_set_drvdata(pdev, master);
 	sspi = spi_master_get_devdata(master);
 	sspi->fifo_full_offset = ilog2(sspi->fifo_size);
-	spi_comp_data = (struct sirf_spi_comp_data *)match->data;
+	spi_comp_data = match->data;
 	sspi->regs = spi_comp_data->regs;
 	sspi->type = spi_comp_data->type;
 	sspi->fifo_level_chk_mask = (sspi->fifo_size / 4) - 1;
