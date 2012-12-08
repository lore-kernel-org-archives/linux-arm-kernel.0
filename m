From: manabian@gmail.com (Joachim Eastwood)
Date: Sat,  8 Dec 2012 13:46:41 +0100
Subject: [PATCH] ASoC: atmel-ssc: make it buildable on other architectures
Message-ID: <1354970801-9185-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not very useful on non AT91/AVR32 platforms but it provides
more build coverage and prepares for ARM multiplatform.

Also fixes a truncated warning that would come when
building on a 64-bit arch.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---

Hi Mark,

Sending it to you since seem like you're the last one who
commited changes to the driver and the driver is mostly
used on ASoC.

Tested on RM9200 and build tested on x86_64.

regards
Joachim Eastwood

 drivers/misc/Kconfig     | 2 +-
 drivers/misc/atmel-ssc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b151b7c..8f59d88 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -192,7 +192,7 @@ config ICS932S401
 
 config ATMEL_SSC
 	tristate "Device driver for Atmel SSC peripheral"
-	depends on AVR32 || ARCH_AT91
+	depends on HAS_IOMEM
 	---help---
 	  This option enables device driver support for Atmel Synchronized
 	  Serial Communication peripheral (SSC).
diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index 158da5a..0cee274 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -167,7 +167,7 @@ static int ssc_probe(struct platform_device *pdev)
 
 	/* disable all interrupts */
 	clk_enable(ssc->clk);
-	ssc_writel(ssc->regs, IDR, ~0UL);
+	ssc_writel(ssc->regs, IDR, -1);
 	ssc_readl(ssc->regs, SR);
 	clk_disable(ssc->clk);
 
-- 
1.8.0
