From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 24 Oct 2012 16:25:22 +0200
Subject: [PATCH 3/5] pinctrl: dove: fix iomem and pdma clock
In-Reply-To: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
References: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
Message-ID: <1351088724-11142-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Since 3.7 readl/writel require register addresses to be const void*
instead of unsigned int. The register addresses are converted using
IOMEM() and offsets are added instead of OR'ed.
Also a workaround for the pdma clock is added, that is required as
there is still no DT clock provider available on Dove.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 drivers/pinctrl/pinctrl-dove.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-dove.c b/drivers/pinctrl/pinctrl-dove.c
index ffe74b2..70befaa 100644
--- a/drivers/pinctrl/pinctrl-dove.c
+++ b/drivers/pinctrl/pinctrl-dove.c
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
@@ -587,6 +587,12 @@ static int __devinit dove_pinctrl_probe(struct platform_device *pdev)
 	 * grab clk to make sure it is ticking.
 	 */
 	clk = devm_clk_get(&pdev->dev, NULL);
+
+	/* Currently there is no DT clock provider for pdma clock,
+	   this fallback ensures pdma clock is ticking */
+	if (IS_ERR(clk))
+		clk = clk_get_sys("dove-pdma", NULL);
+
 	if (!IS_ERR(clk))
 		clk_prepare_enable(clk);
 
-- 
1.7.10.4
