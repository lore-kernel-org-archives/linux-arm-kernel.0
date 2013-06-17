From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 18:34:01 +0200
Subject: [PATCH v2 16/38] ARM: SAMSUNG: Compile legacy IRQ and GPIO PM code
 only with ATAGS support
In-Reply-To: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371486863-12398-17-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new Kconfig symbols, SAMSUNG_PM_GPIO and S5P_IRQ_PM that
get enabled when GPIO_SAMSUNG, PM and S5P_PM are enabled, but only if
SAMSUNG_ATAGS is selected.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/Kconfig  | 13 +++++++++++++
 arch/arm/plat-samsung/Makefile |  5 +++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index c0f0542..7b08b26 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -421,6 +421,19 @@ config S3C_DMA
 	help
 	  Internal configuration for S3C DMA core
 
+config S5P_IRQ_PM
+	bool
+	default y if S5P_PM
+	help
+	  Legacy IRQ power management for S5P platforms
+
+config SAMSUNG_PM_GPIO
+	bool
+	default y if GPIO_SAMSUNG && PM
+	help
+	  Include legacy GPIO power management code for platforms not using
+	  pinctrl-samsung driver.
+
 endif
 
 config SAMSUNG_DMADEV
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index b549ea9..6348ae2 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -52,10 +52,11 @@ obj-$(CONFIG_SAMSUNG_DMADEV)	+= dma-ops.o
 # PM support
 
 obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_PM)		+= pm-gpio.o
+obj-$(CONFIG_SAMSUNG_PM_GPIO)	+= pm-gpio.o
 obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
 
 obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
 
-obj-$(CONFIG_S5P_PM)		+= s5p-pm.o s5p-irq-pm.o
+obj-$(CONFIG_S5P_PM)		+= s5p-pm.o
+obj-$(CONFIG_S5P_IRQ_PM)	+= s5p-irq-pm.o
 obj-$(CONFIG_S5P_SLEEP)		+= s5p-sleep.o
-- 
1.8.2.1
