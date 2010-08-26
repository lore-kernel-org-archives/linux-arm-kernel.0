From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 26 Aug 2010 15:28:38 +0900
Subject: [PATCH V2 12/14] ARM: S5PV310: Add various clocks
In-Reply-To: <1282804120-17241-1-git-send-email-kgene.kim@samsung.com>
References: <1282804120-17241-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1282804120-17241-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch adds various clocks for S5PV310/S5PC210.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v1:
- Fix on watchdog timer

 arch/arm/mach-s5pv310/clock.c                   |  160 ++++++++++++++++++++++-
 arch/arm/mach-s5pv310/include/mach/regs-clock.h |    1 +
 2 files changed, 160 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index eb087dd..1f9ed85 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -61,6 +61,26 @@ static int s5pv310_clksrc_mask_peril0_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKSRC_MASK_PERIL0, clk, enable);
 }
 
+static int s5pv310_clk_ip_cam_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP_CAM, clk, enable);
+}
+
+static int s5pv310_clk_ip_image_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP_IMAGE, clk, enable);
+}
+
+static int s5pv310_clk_ip_lcd0_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP_LCD0, clk, enable);
+}
+
+static int s5pv310_clk_ip_lcd1_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP_LCD1, clk, enable);
+}
+
 static int s5pv310_clk_ip_fsys_ctrl(struct clk *clk, int enable)
 {
 	return s5p_gatectrl(S5P_CLKGATE_IP_FSYS, clk, enable);
@@ -71,6 +91,11 @@ static int s5pv310_clk_ip_peril_ctrl(struct clk *clk, int enable)
 	return s5p_gatectrl(S5P_CLKGATE_IP_PERIL, clk, enable);
 }
 
+static int s5pv310_clk_ip_perir_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLKGATE_IP_PERIR, clk, enable);
+}
+
 /* Core list of CMU_CPU side */
 
 static struct clksrc_clk clk_mout_apll = {
@@ -347,6 +372,46 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv310_clk_ip_peril_ctrl,
 		.ctrlbit	= (1<<24),
 	}, {
+		.name		= "csis",
+		.id		= 0,
+		.enable		= s5pv310_clk_ip_cam_ctrl,
+		.ctrlbit	= (1 << 4),
+	}, {
+		.name		= "csis",
+		.id		= 1,
+		.enable		= s5pv310_clk_ip_cam_ctrl,
+		.ctrlbit	= (1 << 5),
+	}, {
+		.name		= "fimc",
+		.id		= 0,
+		.enable		= s5pv310_clk_ip_cam_ctrl,
+		.ctrlbit	= (1 << 0),
+	}, {
+		.name		= "fimc",
+		.id		= 1,
+		.enable		= s5pv310_clk_ip_cam_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
+		.name		= "fimc",
+		.id		= 2,
+		.enable		= s5pv310_clk_ip_cam_ctrl,
+		.ctrlbit	= (1 << 2),
+	}, {
+		.name		= "fimc",
+		.id		= 3,
+		.enable		= s5pv310_clk_ip_cam_ctrl,
+		.ctrlbit	= (1 << 3),
+	}, {
+		.name		= "fimd",
+		.id		= 0,
+		.enable		= s5pv310_clk_ip_lcd0_ctrl,
+		.ctrlbit	= (1 << 0),
+	}, {
+		.name		= "fimd",
+		.id		= 1,
+		.enable		= s5pv310_clk_ip_lcd1_ctrl,
+		.ctrlbit	= (1 << 0),
+	}, {
 		.name		= "hsmmc",
 		.id		= 0,
 		.parent		= &clk_aclk_133.clk,
@@ -376,7 +441,100 @@ static struct clk init_clocks_disable[] = {
 		.parent		= &clk_aclk_133.clk,
 		.enable		= s5pv310_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 9),
-	}
+	}, {
+		.name		= "sata",
+		.id		= -1,
+		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.ctrlbit	= (1 << 10),
+	}, {
+		.name		= "adc",
+		.id		= -1,
+		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.ctrlbit	= (1 << 15),
+	}, {
+		.name		= "watchdog",
+		.id		= -1,
+		.enable		= s5pv310_clk_ip_perir_ctrl,
+		.ctrlbit	= (1 << 14),
+	}, {
+		.name		= "usbhost",
+		.id		= -1,
+		.enable		= s5pv310_clk_ip_fsys_ctrl ,
+		.ctrlbit	= (1 << 12),
+	}, {
+		.name		= "otg",
+		.id		= -1,
+		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.ctrlbit	= (1 << 13),
+	}, {
+		.name		= "spi",
+		.id		= 0,
+		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.ctrlbit	= (1 << 16),
+	}, {
+		.name		= "spi",
+		.id		= 1,
+		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.ctrlbit	= (1 << 17),
+	}, {
+		.name		= "spi",
+		.id		= 2,
+		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.ctrlbit	= (1 << 18),
+	}, {
+		.name		= "fimg2d",
+		.id		= -1,
+		.enable		= s5pv310_clk_ip_image_ctrl,
+		.ctrlbit	= (1 << 0),
+	}, {
+		.name		= "i2c",
+		.id		= 0,
+		.parent		= &clk_aclk_100.clk,
+		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.ctrlbit	= (1 << 6),
+	}, {
+		.name		= "i2c",
+		.id		= 1,
+		.parent		= &clk_aclk_100.clk,
+		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.ctrlbit	= (1 << 7),
+	}, {
+		.name		= "i2c",
+		.id		= 2,
+		.parent		= &clk_aclk_100.clk,
+		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.ctrlbit	= (1 << 8),
+	}, {
+		.name		= "i2c",
+		.id		= 3,
+		.parent		= &clk_aclk_100.clk,
+		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.ctrlbit	= (1 << 9),
+	}, {
+		.name		= "i2c",
+		.id		= 4,
+		.parent		= &clk_aclk_100.clk,
+		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.ctrlbit	= (1 << 10),
+	}, {
+		.name		= "i2c",
+		.id		= 5,
+		.parent		= &clk_aclk_100.clk,
+		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.ctrlbit	= (1 << 11),
+	}, {
+		.name		= "i2c",
+		.id		= 6,
+		.parent		= &clk_aclk_100.clk,
+		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.ctrlbit	= (1 << 12),
+	}, {
+		.name		= "i2c",
+		.id		= 7,
+		.parent		= &clk_aclk_100.clk,
+		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.ctrlbit	= (1 << 13),
+	},
 };
 
 static struct clk init_clocks[] = {
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-clock.h b/arch/arm/mach-s5pv310/include/mach/regs-clock.h
index eda07fd..12e983c 100644
--- a/arch/arm/mach-s5pv310/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pv310/include/mach/regs-clock.h
@@ -64,6 +64,7 @@
 #define S5P_CLKGATE_IP_LCD1		S5P_CLKREG(0x0C938)
 #define S5P_CLKGATE_IP_FSYS		S5P_CLKREG(0x0C940)
 #define S5P_CLKGATE_IP_PERIL		S5P_CLKREG(0x0C950)
+#define S5P_CLKGATE_IP_PERIR		S5P_CLKREG(0x0C960)
 
 #define S5P_CLKSRC_CORE			S5P_CLKREG(0x10200)
 #define S5P_CLKDIV_CORE0		S5P_CLKREG(0x10500)
-- 
1.6.2.5
