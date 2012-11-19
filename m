From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 19 Nov 2012 10:39:53 +0100
Subject: [PATCH 1/4] pinctrl: mvebu: fix iomem pointer for dove pinctrl
In-Reply-To: <1353317996-20841-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1353317996-20841-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1353317996-20841-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There has been a change in readl/writel to require registers
addresses marked as IOMEM(). This patch takes care of this and
also replaces ORing address offsets with adding them.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Axel Lin <axel.lin@ingics.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/pinctrl/mvebu/pinctrl-dove.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-dove.c b/drivers/pinctrl/mvebu/pinctrl-dove.c
index ffe74b2..34693f6 100644
--- a/drivers/pinctrl/mvebu/pinctrl-dove.c
+++ b/drivers/pinctrl/mvebu/pinctrl-dove.c
@@ -22,22 +22,22 @@
 
 #include "pinctrl-mvebu.h"
 
-#define DOVE_SB_REGS_VIRT_BASE		0xfde00000
-#define DOVE_MPP_VIRT_BASE		(DOVE_SB_REGS_VIRT_BASE | 0xd0200)
+#define DOVE_SB_REGS_VIRT_BASE		IOMEM(0xfde00000)
+#define DOVE_MPP_VIRT_BASE		(DOVE_SB_REGS_VIRT_BASE + 0xd0200)
 #define DOVE_PMU_MPP_GENERAL_CTRL	(DOVE_MPP_VIRT_BASE + 0x10)
 #define  DOVE_AU0_AC97_SEL		BIT(16)
-#define DOVE_GLOBAL_CONFIG_1		(DOVE_SB_REGS_VIRT_BASE | 0xe802C)
+#define DOVE_GLOBAL_CONFIG_1		(DOVE_SB_REGS_VIRT_BASE + 0xe802C)
 #define  DOVE_TWSI_ENABLE_OPTION1	BIT(7)
-#define DOVE_GLOBAL_CONFIG_2		(DOVE_SB_REGS_VIRT_BASE | 0xe8030)
+#define DOVE_GLOBAL_CONFIG_2		(DOVE_SB_REGS_VIRT_BASE + 0xe8030)
 #define  DOVE_TWSI_ENABLE_OPTION2	BIT(20)
 #define  DOVE_TWSI_ENABLE_OPTION3	BIT(21)
 #define  DOVE_TWSI_OPTION3_GPIO		BIT(22)
-#define DOVE_SSP_CTRL_STATUS_1		(DOVE_SB_REGS_VIRT_BASE | 0xe8034)
+#define DOVE_SSP_CTRL_STATUS_1		(DOVE_SB_REGS_VIRT_BASE + 0xe8034)
 #define  DOVE_SSP_ON_AU1		BIT(0)
-#define DOVE_MPP_GENERAL_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE | 0xe803c)
+#define DOVE_MPP_GENERAL_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE + 0xe803c)
 #define  DOVE_AU1_SPDIFO_GPIO_EN	BIT(1)
 #define  DOVE_NAND_GPIO_EN		BIT(0)
-#define DOVE_GPIO_LO_VIRT_BASE		(DOVE_SB_REGS_VIRT_BASE | 0xd0400)
+#define DOVE_GPIO_LO_VIRT_BASE		(DOVE_SB_REGS_VIRT_BASE + 0xd0400)
 #define DOVE_MPP_CTRL4_VIRT_BASE	(DOVE_GPIO_LO_VIRT_BASE + 0x40)
 #define  DOVE_SPI_GPIO_SEL		BIT(5)
 #define  DOVE_UART1_GPIO_SEL		BIT(4)
-- 
1.7.10.4
