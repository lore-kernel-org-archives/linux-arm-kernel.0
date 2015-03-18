From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Mar 2015 15:53:08 +0000
Subject: [PATCH 09/13] spi: atmel: use endian agnostic IO
In-Reply-To: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1426693992-31163-10-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the endian agnositc IO functions instead of the __raw ones for when
the driver is in use on big-endian systems.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Nicolas Ferre <nicolas.ferre@atmel.com> (supporter:ATMEL SPI DRIVER)
CC: Mark Brown <broonie@kernel.org> (maintainer:SPI SUBSYSTEM)
CC: linux-spi at vger.kernel.org (open list:SPI SUBSYSTEM)
---
 drivers/spi/spi-atmel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 06de340..a2f40b1 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -180,11 +180,17 @@
 	  | SPI_BF(name, value))
 
 /* Register access macros */
+#ifdef CONFIG_AVR32
 #define spi_readl(port, reg) \
 	__raw_readl((port)->regs + SPI_##reg)
 #define spi_writel(port, reg, value) \
 	__raw_writel((value), (port)->regs + SPI_##reg)
-
+#else
+#define spi_readl(port, reg) \
+	readl_relaxed((port)->regs + SPI_##reg)
+#define spi_writel(port, reg, value) \
+	writel_relaxed((value), (port)->regs + SPI_##reg)
+#endif
 /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
  * cache operations; better heuristics consider wordsize and bitrate.
  */
-- 
2.1.4
