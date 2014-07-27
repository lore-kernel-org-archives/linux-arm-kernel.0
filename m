From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 27 Jul 2014 23:53:19 +0200
Subject: [PATCH 1/2] spi: orion: fix incorrect handling of cell-index DT
 property
In-Reply-To: <1406498000-13079-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406498000-13079-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1406498000-13079-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit f814f9ac5a81 ("spi/orion: add device tree binding"), Device
Tree support was added to the spi-orion driver. However, this commit
reads the "cell-index" property, without taking into account the fact
that DT properties are big-endian encoded.

Since most of the platforms using spi-orion with DT have apparently
not used anything but cell-index = <0>, the problem was not
visible. But as soon as one starts using cell-index = <1>, the problem
becomes clearly visible, as the master->bus_num gets a wrong value
(actually it gets the value 0, which conflicts with the first bus that
has cell-index = <0>).

This commit fixes that by using of_property_read_u32() to read the
property value, which does the appropriate endianness conversion when
needed.

Fixes: f814f9ac5a81 ("spi/orion: add device tree binding")
Cc: <stable@vger.kernel.org> # v3.6+
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/spi/spi-orion.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index d018a4a..c206a4a 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -346,8 +346,6 @@ static int orion_spi_probe(struct platform_device *pdev)
 	struct resource *r;
 	unsigned long tclk_hz;
 	int status = 0;
-	const u32 *iprop;
-	int size;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*spi));
 	if (master == NULL) {
@@ -358,10 +356,10 @@ static int orion_spi_probe(struct platform_device *pdev)
 	if (pdev->id != -1)
 		master->bus_num = pdev->id;
 	if (pdev->dev.of_node) {
-		iprop = of_get_property(pdev->dev.of_node, "cell-index",
-					&size);
-		if (iprop && size == sizeof(*iprop))
-			master->bus_num = *iprop;
+		u32 cell_index;
+		if (!of_property_read_u32(pdev->dev.of_node, "cell-index",
+					  &cell_index))
+			master->bus_num = cell_index;
 	}
 
 	/* we support only mode 0, and no options */
-- 
2.0.0
