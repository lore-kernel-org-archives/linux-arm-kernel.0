From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 25 Mar 2015 11:27:50 +0000
Subject: [PATCH RESEND 5/7] mmc: host: dw_mmc make IO accessors endian agnostic
In-Reply-To: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427282872-10563-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1427282872-10563-6-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dw_mmc driver does not use endian agnostic IO accessors, so fix
the use of __raw reads and writes to be the relaxed versions.

This fixes the dw_mmc driver initialisation on Altera socfpga in big endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Linux MMC <linux-mmc@vger.kernel.org>
CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
CC: Dinh Nguyen <dinguyen@opensource.altera.com>
CC: Chris Ball <chris@printf.net>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: Jaehoon Chung <jh80.chung@samsung.com>
CC: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 18c4afe..46efdc5 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -171,22 +171,22 @@
 
 /* Register access macros */
 #define mci_readl(dev, reg)			\
-	__raw_readl((dev)->regs + SDMMC_##reg)
+	readl_relaxed((dev)->regs + SDMMC_##reg)
 #define mci_writel(dev, reg, value)			\
-	__raw_writel((value), (dev)->regs + SDMMC_##reg)
+	writel_relaxed((value), (dev)->regs + SDMMC_##reg)
 
 /* 16-bit FIFO access macros */
 #define mci_readw(dev, reg)			\
-	__raw_readw((dev)->regs + SDMMC_##reg)
+	readw_relaxed((dev)->regs + SDMMC_##reg)
 #define mci_writew(dev, reg, value)			\
-	__raw_writew((value), (dev)->regs + SDMMC_##reg)
+	writew_relaxed((value), (dev)->regs + SDMMC_##reg)
 
 /* 64-bit FIFO access macros */
 #ifdef readq
 #define mci_readq(dev, reg)			\
-	__raw_readq((dev)->regs + SDMMC_##reg)
+	readq_relaxed((dev)->regs + SDMMC_##reg)
 #define mci_writeq(dev, reg, value)			\
-	__raw_writeq((value), (dev)->regs + SDMMC_##reg)
+	writeq_relaxed((value), (dev)->regs + SDMMC_##reg)
 #else
 /*
  * Dummy readq implementation for architectures that don't define it.
-- 
2.1.4
