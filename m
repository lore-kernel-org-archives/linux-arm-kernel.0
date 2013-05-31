From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:19:13 +0200
Subject: [PATCH 38/39] spi: pl022: use DMA by default when probing from DT
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-39-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

In the past we controlled the selection of DMA for a certain
host by a boolean switch in the platform data. Currently
there is no way to enable DMA on a PL022 probed from the
device tree. Let's default to trying to obtain DMA channels
in the DT case, and then we can always fail (and thus fall
back to PIO mode).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 371cc66f..3b24654 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2083,6 +2083,7 @@ pl022_platform_data_dt_get(struct device *dev)
 	}
 
 	pd->bus_id = -1;
+	pd->enable_dma = 1;
 	of_property_read_u32(np, "num-cs", &tmp);
 	pd->num_chipselect = tmp;
 	of_property_read_u32(np, "pl022,autosuspend-delay",
-- 
1.7.11.3
