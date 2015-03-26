From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 26 Mar 2015 11:45:52 +0000
Subject: [RFC 4/6] spi: atmel: use atmel_io.h to provide on-chip IO
In-Reply-To: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1427370354-21247-5-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use <linux/atmel_io.h> to provide IO accessors which work on both
AVR32 and ARM for on-chip peripherals.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Nicolas Ferre <nicolas.ferre@atmel.com> (supporter:ATMEL SPI DRIVER)
CC: Mark Brown <broonie@kernel.org> (maintainer:SPI SUBSYSTEM)
CC: linux-spi at vger.kernel.org (open list:SPI SUBSYSTEM)
CC: linux-arm-kernel at lists.infradead.org
---
 drivers/spi/spi-atmel.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index a2f40b1..f10cc75 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -25,6 +25,7 @@
 
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/atmel_io.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 
@@ -180,17 +181,11 @@
 	  | SPI_BF(name, value))
 
 /* Register access macros */
-#ifdef CONFIG_AVR32
 #define spi_readl(port, reg) \
-	__raw_readl((port)->regs + SPI_##reg)
+	atmel_oc_readl((port)->regs + SPI_##reg)
 #define spi_writel(port, reg, value) \
-	__raw_writel((value), (port)->regs + SPI_##reg)
-#else
-#define spi_readl(port, reg) \
-	readl_relaxed((port)->regs + SPI_##reg)
-#define spi_writel(port, reg, value) \
-	writel_relaxed((value), (port)->regs + SPI_##reg)
-#endif
+	atmel_oc_writel((value), (port)->regs + SPI_##reg)
+
 /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
  * cache operations; better heuristics consider wordsize and bitrate.
  */
-- 
2.1.4
