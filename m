From: chao.xie@marvell.com (Chao Xie)
Date: Mon,  7 May 2012 11:24:00 +0800
Subject: [PATCH V2 3/4] ARM: mmp: ttc_dkb: add PMIC support
In-Reply-To: <1336361041-18145-1-git-send-email-chao.xie@marvell.com>
References: <1336361041-18145-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1336361041-18145-3-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 88pm860x into ttc_dkb, and it will impact the suspend/resume
of pxa910

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/ttc_dkb.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 3fc9ed2..e8cf5ea 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/i2c/pca953x.h>
 #include <linux/gpio.h>
+#include <linux/mfd/88pm860x.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -135,8 +136,18 @@ static struct pca953x_platform_data max7312_data[] = {
 	},
 };
 
+static struct pm860x_platform_data ttc_dkb_pm8607_info = {
+	.irq_base       = IRQ_BOARD_START,
+};
+
 static struct i2c_board_info ttc_dkb_i2c_info[] = {
 	{
+		.type           = "88PM860x",
+		.addr           = 0x34,
+		.platform_data  = &ttc_dkb_pm8607_info,
+		.irq            = IRQ_PXA910_PMIC_INT,
+	},
+	{
 		.type		= "max7312",
 		.addr		= 0x23,
 		.irq		= MMP_GPIO_TO_IRQ(80),
-- 
1.7.0.4
